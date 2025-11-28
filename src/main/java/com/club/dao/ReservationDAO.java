package com.club.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.club.dto.ReservationDTO;
import com.club.util.DBUtil;

public class ReservationDAO {

    // 1. 예약 생성 (예약하기)
    public int insert(ReservationDTO dto) {
        int result = 0;

        String sql = "INSERT INTO reservations (user_id, timeslot_id, status) VALUES (?, ?, 'reserved')";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, dto.getUser_id());
            pstmt.setInt(2, dto.getTimeslot_id());

            result = pstmt.executeUpdate(); // 1이면 성공
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // 2. 특정 유저의 모든 예약 목록 (마이페이지용)
    public List<ReservationDTO> findByUser(int userId) {
        List<ReservationDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM reservations WHERE user_id = ? ORDER BY created_at DESC";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ReservationDTO dto = new ReservationDTO();
                    dto.setId(rs.getInt("id"));
                    dto.setUser_id(rs.getInt("user_id"));
                    dto.setTimeslot_id(rs.getInt("timeslot_id"));
                    dto.setStatus(rs.getString("status"));
                    dto.setCreated_at(rs.getString("created_at"));
                    list.add(dto);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 3. 특정 타임슬롯에 예약이 이미 있는지 확인 (중복 예약 방지용)
    public boolean existsByTimeslot(int timeslotId) {
        boolean exists = false;

        String sql = "SELECT COUNT(*) AS cnt FROM reservations WHERE timeslot_id = ? AND status = 'reserved'";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, timeslotId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int cnt = rs.getInt("cnt");
                    exists = (cnt > 0);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return exists;
    }

    // 4. 예약 취소 (status를 cancelled로 변경)
    public int cancel(int reservationId) {
        int result = 0;

        String sql = "UPDATE reservations SET status = 'cancelled' WHERE id = ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, reservationId);

            result = pstmt.executeUpdate(); // 1이면 성공
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // 5. 노쇼 처리 (status를 noshow로 변경)
    public int markNoShow(int reservationId) {
        int result = 0;

        String sql = "UPDATE reservations SET status = 'noshow' WHERE id = ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, reservationId);

            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}

