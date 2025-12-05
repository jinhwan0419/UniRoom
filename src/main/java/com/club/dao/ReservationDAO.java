package com.club.dao;

import com.club.dto.TimeSlotDTO;
import com.club.dto.ReservationDTO;
import com.club.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 예약 관련 DAO
 * - 날짜/방별 예약 현황 조회
 * - 예약 생성
 * - 사용자별 예약 내역 조회
 */
public class ReservationDAO {

    /**
     * 특정 날짜 + 특정 방 목록에 대한 예약 조회
     * (타임테이블, 인기 예약 현황 등에 사용)
     */
	// ======================= 내 예약 목록 조회 =======================
	public List<ReservationDTO> findByUser(int userId) {

	    List<ReservationDTO> list = new ArrayList<>();

	    String sql =
	        "SELECT r.reservation_id, r.room_id, r.user_id, r.date, r.time, rm.name AS room_name " +
	        "FROM reservations r " +
	        "JOIN rooms rm ON r.room_id = rm.room_id " +
	        "WHERE r.user_id = ? " +
	        "ORDER BY r.date DESC, r.time DESC";

	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, userId);

	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                ReservationDTO dto = new ReservationDTO();
	                dto.setReservation_id(rs.getInt("reservation_id"));
	                dto.setRoom_id(rs.getInt("room_id"));
	                dto.setUser_id(rs.getInt("user_id"));

	                // DB 컬럼 date → DTO의 reserve_date
	                dto.setReserve_date(rs.getDate("date").toLocalDate());

	                // DB 컬럼 time → start_time, end_time(+1시간) 으로 매핑
	                LocalTime start = rs.getTime("time").toLocalTime();
	                dto.setStart_time(start);
	                dto.setEnd_time(start.plusHours(1));

	                // status 컬럼 없으면 화면용으로 RESERVED 고정
	                dto.setStatus("RESERVED");

	                dto.setRoom_name(rs.getString("room_name"));

	                list.add(dto);
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}


    /**
     * 사용자 전체 예약 내역 조회 (내 예약 화면)
     */
   

    /**
     * 예약 생성 (Timestamp 기준, 필요시 사용)
     */
    public void createReservation(int roomId, int userId, Timestamp start, Timestamp end) {

        LocalDate date = start.toLocalDateTime().toLocalDate();
        Time startTime = Time.valueOf(start.toLocalDateTime().toLocalTime());
        Time endTime   = Time.valueOf(end.toLocalDateTime().toLocalTime());

        String sql =
            "INSERT INTO reservations " +
            " (room_id, user_id, reserve_date, start_time, end_time, status) " +
            "VALUES (?, ?, ?, ?, ?, 'RESERVED')";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomId);
            pstmt.setInt(2, userId);
            pstmt.setDate(3, java.sql.Date.valueOf(date));
            pstmt.setTime(4, startTime);
            pstmt.setTime(5, endTime);

            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 방 + 날짜 기준 시간대 현황 (타임테이블)
     * 09~21시 기준, 예약 있으면 BOOKED, 없으면 AVAILABLE
     */
    public List<TimeSlotDTO> getTimeSlotsByRoomAndDate(int roomId, LocalDate date) {
        List<TimeSlotDTO> list = new ArrayList<>();

        int startHour = 9;
        int endHour   = 21;

        String sql = "SELECT start_time FROM reservations " +
                     "WHERE room_id = ? AND reserve_date = ? AND status = 'RESERVED'";

        List<String> booked = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomId);
            pstmt.setString(2, date.toString());

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    String timeStr = rs.getTime("start_time").toLocalTime().toString(); // HH:MM:ss
                    booked.add(timeStr.substring(0,5)); // HH:MM
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        for (int h = startHour; h <= endHour; h++) {
            String t = String.format("%02d:00", h);
            String status = booked.contains(t) ? "BOOKED" : "AVAILABLE";
            list.add(new TimeSlotDTO(t, status));
        }

        return list;
    }

    // === 중복 예약 체크 후 예약 생성 ===
    // 예약 가능하면 true, 겹치면 false 리턴
    public boolean createReservationChecked(int userId,
                                            int roomId,
                                            LocalDate date,
                                            LocalTime startTime,
                                            LocalTime endTime) {

        // 1. 겹치는 예약 있는지 확인
        String checkSql = "SELECT COUNT(*) AS cnt " +
                          "FROM reservations " +
                          "WHERE room_id = ? AND reserve_date = ? " +
                          "AND NOT (end_time <= ? OR start_time >= ?) " +
                          "AND status = 'RESERVED'";

        // 2. 실제 예약 INSERT
        String insertSql = "INSERT INTO reservations " +
                           " (user_id, room_id, reserve_date, start_time, end_time, status) " +
                           "VALUES (?, ?, ?, ?, ?, 'RESERVED')";

        try (Connection conn = DBUtil.getConnection()) {

            // 겹침 체크
            try (PreparedStatement pstmt = conn.prepareStatement(checkSql)) {
                pstmt.setInt(1, roomId);
                pstmt.setString(2, date.toString());
                pstmt.setTime(3, Time.valueOf(startTime));
                pstmt.setTime(4, Time.valueOf(endTime));

                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        int cnt = rs.getInt("cnt");
                        if (cnt > 0) {
                            return false;   // 이미 겹치는 예약 있음
                        }
                    }
                }
            }

            // 예약 INSERT
            try (PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
                pstmt.setInt(1, userId);
                pstmt.setInt(2, roomId);
                pstmt.setDate(3, java.sql.Date.valueOf(date));
                pstmt.setTime(4, Time.valueOf(startTime));
                pstmt.setTime(5, Time.valueOf(endTime));

                int result = pstmt.executeUpdate();
                return result > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 예약 취소 (status 컬럼 사용 버전)
     */
    public boolean cancelReservation(int reservationId, int userId) {

        String sql = "UPDATE reservations " +
                     "SET status = 'CANCELED' " +
                     "WHERE reservation_id = ? AND user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, reservationId);
            pstmt.setInt(2, userId);

            int result = pstmt.executeUpdate();
            return result > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<ReservationDTO> findByRoomsAndDate(List<Integer> roomIds, LocalDate date) {

        List<ReservationDTO> list = new ArrayList<>();

        if (roomIds == null || roomIds.isEmpty()) {
            return list;
        }

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT r.reservation_id, r.room_id, r.user_id, r.date, r.time ")
           .append("FROM reservations r ")
           .append("WHERE r.date = ? AND r.room_id IN (");

        for (int i = 0; i < roomIds.size(); i++) {
            sql.append("?");
            if (i < roomIds.size() - 1) sql.append(",");
        }
        sql.append(")");

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql.toString());
        ) {
            pstmt.setDate(1, java.sql.Date.valueOf(date));

            for (int i = 0; i < roomIds.size(); i++) {
                pstmt.setInt(i + 2, roomIds.get(i));
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ReservationDTO dto = new ReservationDTO();
                    dto.setReservation_id(rs.getInt("reservation_id"));
                    dto.setRoom_id(rs.getInt("room_id"));
                    dto.setUser_id(rs.getInt("user_id"));
                    dto.setDate(rs.getDate("date"));      // ✅ 수정
                    dto.setTime(rs.getTime("time"));      // ✅ 수정

                    list.add(dto);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


}
