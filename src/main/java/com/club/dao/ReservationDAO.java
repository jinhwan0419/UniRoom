package com.club.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.club.dto.ReservationDTO;
import com.club.util.DBUtil;

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
    public List<ReservationDTO> findByRoomsAndDate(List<Integer> roomIds, LocalDate date) {

        List<ReservationDTO> list = new ArrayList<>();

        if (roomIds == null || roomIds.isEmpty()) {
            return list;
        }

        StringBuilder inClause = new StringBuilder();
        inClause.append("(");
        for (int i = 0; i < roomIds.size(); i++) {
            if (i > 0) inClause.append(",");
            inClause.append("?");
        }
        inClause.append(")");

        String sql =
            "SELECT rsv.reservation_id, rsv.room_id, rsv.user_id, rsv.reserve_date, " +
            "       rsv.start_time, rsv.end_time, rsv.status, " +
            "       u.name AS user_name, rm.name AS room_name " +
            "FROM reservations rsv " +
            "JOIN users u ON rsv.user_id = u.user_id " +
            "JOIN rooms rm ON rsv.room_id = rm.room_id " +
            "WHERE rsv.reserve_date = ? " +
            "  AND rsv.room_id IN " + inClause.toString() + " " +
            "  AND rsv.status = 'RESERVED' " +
            "ORDER BY rsv.room_id, rsv.start_time";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, date.toString());

            int idx = 2;
            for (Integer roomId : roomIds) {
                pstmt.setInt(idx++, roomId);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ReservationDTO dto = new ReservationDTO();
                    dto.setReservation_id(rs.getInt("reservation_id"));
                    dto.setRoom_id(rs.getInt("room_id"));
                    dto.setUser_id(rs.getInt("user_id"));
                    dto.setReserve_date(rs.getDate("reserve_date").toLocalDate());
                    dto.setStart_time(rs.getTime("start_time").toLocalTime());
                    dto.setEnd_time(rs.getTime("end_time").toLocalTime());
                    dto.setStatus(rs.getString("status"));
                    dto.setUser_name(rs.getString("user_name"));
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
     * 사용자 전체 예약 내역 조회 (마이페이지에서 사용할 수 있음)
     */
    public List<ReservationDTO> findByUser(int userId) {

        List<ReservationDTO> list = new ArrayList<>();

        String sql =
            "SELECT rsv.reservation_id, rsv.room_id, rsv.user_id, rsv.reserve_date, " +
            "       rsv.start_time, rsv.end_time, rsv.status, " +
            "       rm.name AS room_name " +
            "FROM reservations rsv " +
            "JOIN rooms rm ON rsv.room_id = rm.room_id " +
            "WHERE rsv.user_id = ? " +
            "ORDER BY rsv.reserve_date DESC, rsv.start_time DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ReservationDTO dto = new ReservationDTO();
                    dto.setReservation_id(rs.getInt("reservation_id"));
                    dto.setRoom_id(rs.getInt("room_id"));
                    dto.setUser_id(rs.getInt("user_id"));
                    dto.setReserve_date(rs.getDate("reserve_date").toLocalDate());
                    dto.setStart_time(rs.getTime("start_time").toLocalTime());
                    dto.setEnd_time(rs.getTime("end_time").toLocalTime());
                    dto.setStatus(rs.getString("status"));
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
     * 예약 생성 (시작/종료 Timestamp 기준)
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
}
