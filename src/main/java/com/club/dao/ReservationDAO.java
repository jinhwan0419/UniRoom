package com.club.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

import com.club.dto.ReservationDTO;
import com.club.util.DBUtil;

public class ReservationDAO {

    // 1. 예약 중복 체크
    // 같은 방(room_id), 같은 날짜(reserve_date)에서
    // 시간이 겹치는 예약이 있는지 확인
    public boolean isDuplicated(int roomId, Date reserveDate, Time startTime, Time endTime) {
        String sql = 
            "SELECT COUNT(*) " +
            "FROM reservations " +
            "WHERE room_id = ? " +
            "  AND reserve_date = ? " +
            "  AND status = 'ACTIVE' " +
            "  AND NOT (end_time <= ? OR start_time >= ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomId);
            pstmt.setDate(2, reserveDate);
            pstmt.setTime(3, startTime);  // end_time <= newStart
            pstmt.setTime(4, endTime);    // start_time >= newEnd

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0; // 하나라도 있으면 중복
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 2. 예약 INSERT
    public int insert(ReservationDTO dto) {
        String sql = "INSERT INTO reservations " +
                     "(member_id, room_id, reserve_date, start_time, end_time, status) " +
                     "VALUES (?, ?, ?, ?, ?, 'ACTIVE')";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, dto.getMemberId());
            pstmt.setInt(2, dto.getRoomId());
            pstmt.setDate(3, dto.getReserveDate());
            pstmt.setTime(4, dto.getStartTime());
            pstmt.setTime(5, dto.getEndTime());

            return pstmt.executeUpdate(); // 1이면 성공
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 3. 내 예약 목록 조회
    public List<ReservationDTO> findByMemberId(int memberId) {
        List<ReservationDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM reservations " +
                     "WHERE member_id = ? " +
                     "ORDER BY reserve_date DESC, start_time DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, memberId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ReservationDTO r = new ReservationDTO();
                    r.setId(rs.getInt("id"));
                    r.setMemberId(rs.getInt("member_id"));
                    r.setRoomId(rs.getInt("room_id"));
                    r.setReserveDate(rs.getDate("reserve_date"));
                    r.setStartTime(rs.getTime("start_time"));
                    r.setEndTime(rs.getTime("end_time"));
                    r.setStatus(rs.getString("status"));
                    list.add(r);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 4. 예약 취소 (상태 변경 버전)
    public int cancel(int reservationId, int memberId) {
        String sql = "UPDATE reservations " +
                     "SET status = 'CANCELLED' " +
                     "WHERE id = ? AND member_id = ? AND status = 'ACTIVE'";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, reservationId);
            pstmt.setInt(2, memberId);

            return pstmt.executeUpdate(); // 1이면 성공
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // === 참고: 진짜 삭제 버전이 필요하면 이거 사용 ===
    public int delete(int reservationId, int memberId) {
        String sql = "DELETE FROM reservations WHERE id = ? AND member_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, reservationId);
            pstmt.setInt(2, memberId);

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
