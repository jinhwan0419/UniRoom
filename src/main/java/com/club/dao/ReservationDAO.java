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

    // 5. 진짜 삭제 (필요하면 사용)
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

    // 6. 특정 회원의 노쇼 횟수 조회 (마이페이지 패널티 현황에 활용 가능)
    public int countNoShowByMemberId(int memberId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM reservations " +
                     "WHERE member_id = ? AND status = 'NOSHOW'";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, memberId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    // 7. 예약을 노쇼 상태로 변경 (관리자/배치에서 사용)
    public int markNoShow(int reservationId, int memberId) {
        String sql = "UPDATE reservations " +
                     "SET status = 'NOSHOW' " +
                     "WHERE id = ? AND member_id = ? AND status = 'ACTIVE'";

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

    // 8. 특정 방의 특정 주간 예약 목록 (공간 정보 -> 주간 예약 현황용)
    public List<ReservationDTO> findByRoomAndWeek(int roomId, Date startDate, Date endDate) {
        List<ReservationDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM reservations " +
                     "WHERE room_id = ? " +
                     "  AND reserve_date BETWEEN ? AND ? " +
                     "  AND status = 'ACTIVE' " +
                     "ORDER BY reserve_date ASC, start_time ASC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomId);
            pstmt.setDate(2, startDate);
            pstmt.setDate(3, endDate);

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

    // 9. 특정 방의 특정 날짜 예약 목록 (타임테이블용)
    public List<ReservationDTO> findByRoomAndDate(int roomId, Date reserveDate) {
        List<ReservationDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM reservations " +
                     "WHERE room_id = ? " +
                     "  AND reserve_date = ? " +
                     "  AND status = 'ACTIVE' " +
                     "ORDER BY start_time ASC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomId);
            pstmt.setDate(2, reserveDate);

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
}
