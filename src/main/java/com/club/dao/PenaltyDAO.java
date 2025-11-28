package com.club.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.club.dto.PenaltyDTO;
import com.club.util.DBUtil;

public class PenaltyDAO {

    // 1. 패널티 한 건 추가 (노쇼 발생 시)
    public int insert(PenaltyDTO dto) {
        int result = 0;

        String sql = "INSERT INTO penalties (user_id, reason, points, created_at) "
                   + "VALUES (?, ?, ?, NOW())";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, dto.getUser_id());
            pstmt.setString(2, dto.getReason());
            pstmt.setInt(3, dto.getPoints());

            result = pstmt.executeUpdate();   // 1이면 성공
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // 2. 특정 유저의 패널티 전체 조회 (마이페이지용)
    public List<PenaltyDTO> findByUserId(int userId) {
        List<PenaltyDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM penalties WHERE user_id = ? ORDER BY created_at DESC";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    PenaltyDTO dto = new PenaltyDTO();
                    dto.setPenalty_id(rs.getInt("penalty_id"));
                    dto.setUser_id(rs.getInt("user_id"));
                    dto.setReason(rs.getString("reason"));
                    dto.setPoints(rs.getInt("points"));
                    dto.setCreated_at(rs.getString("created_at"));
                    list.add(dto);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 3. 특정 유저의 패널티 총점 조회 (예약 제한 여부 판단용)
    public int getTotalPointsByUser(int userId) {
        int total = 0;

        String sql = "SELECT IFNULL(SUM(points), 0) AS total_points "
                   + "FROM penalties WHERE user_id = ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt("total_points");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }
}

