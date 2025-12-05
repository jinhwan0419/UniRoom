package com.club.dao;

import java.time.LocalDate;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.club.dto.PenaltySummaryDTO;
import com.club.util.DBUtil;

/**
 * 패널티(노쇼) 관련 DAO
 * - 관리자 패널티 목록
 * - 사용자별 패널티 요약
 */
public class PenaltyDAO {

    /**
     * 패널티 요약 목록 조회 (관리자 화면용)
     * @param keyword 학번/이름 검색어 (null 또는 "" 이면 전체)
     */
    public List<PenaltySummaryDTO> findPenaltySummary(String keyword) {

        List<PenaltySummaryDTO> list = new ArrayList<>();

        String baseSql =
            "SELECT u.user_id, u.student_id, u.name, c.name AS club_name, " +
            "       COUNT(p.id) AS no_show_count, " +
            "       MAX(p.start_date) AS last_no_show_date, " +
            "       MAX(p.end_date)   AS block_end_date " +
            "FROM users u " +
            "LEFT JOIN penalties p ON u.user_id = p.user_id " +
            "LEFT JOIN clubs c ON u.club_id = c.club_id ";

        String where = "";
        if (keyword != null && !keyword.trim().isEmpty()) {
            where = "WHERE u.student_id LIKE ? OR u.name LIKE ? ";
        }

        String groupOrder =
            "GROUP BY u.user_id, u.student_id, u.name, c.name " +
            "ORDER BY no_show_count DESC, u.student_id ASC";

        String sql = baseSql + where + groupOrder;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            if (keyword != null && !keyword.trim().isEmpty()) {
                String like = "%" + keyword.trim() + "%";
                pstmt.setString(1, like);
                pstmt.setString(2, like);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    PenaltySummaryDTO dto = new PenaltySummaryDTO();
                    dto.setUserId(rs.getInt("user_id"));
                    dto.setStudentId(rs.getString("student_id"));
                    dto.setUserName(rs.getString("name"));
                    dto.setClubName(rs.getString("club_name"));
                    dto.setNoShowCount(rs.getInt("no_show_count"));

                    java.sql.Date last = rs.getDate("last_no_show_date");
                    java.sql.Date block = rs.getDate("block_end_date");
                    if (last != null) dto.setLastNoShowDate(last.toLocalDate());
                    if (block != null) dto.setBlockEndDate(block.toLocalDate());

                    list.add(dto);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * 특정 사용자 1명의 패널티 요약 조회
     */
    public PenaltySummaryDTO findByUserId(int userId) {

        PenaltySummaryDTO dto = null;

        String sql =
            "SELECT u.user_id, u.student_id, u.name, c.name AS club_name, " +
            "       COUNT(p.id) AS no_show_count, " +
            "       MAX(p.start_date) AS last_no_show_date, " +
            "       MAX(p.end_date)   AS block_end_date " +
            "FROM users u " +
            "LEFT JOIN penalties p ON u.user_id = p.user_id " +
            "LEFT JOIN clubs c ON u.club_id = c.club_id " +
            "WHERE u.user_id = ? " +
            "GROUP BY u.user_id, u.student_id, u.name, c.name";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    dto = new PenaltySummaryDTO();
                    dto.setUserId(rs.getInt("user_id"));
                    dto.setStudentId(rs.getString("student_id"));
                    dto.setUserName(rs.getString("name"));
                    dto.setClubName(rs.getString("club_name"));
                    dto.setNoShowCount(rs.getInt("no_show_count"));

                    java.sql.Date last = rs.getDate("last_no_show_date");
                    java.sql.Date block = rs.getDate("block_end_date");
                    if (last != null) dto.setLastNoShowDate(last.toLocalDate());
                    if (block != null) dto.setBlockEndDate(block.toLocalDate());
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return dto;
    }
    public void insertNoShowPenalty(int userId, LocalDate startDate, LocalDate endDate) {

        String sql =
            "INSERT INTO penalties (user_id, reason, start_date, end_date) " +
            "VALUES (?, 'NO_SHOW', ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            pstmt.setDate(2, java.sql.Date.valueOf(startDate));
            pstmt.setDate(3, java.sql.Date.valueOf(endDate));

            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
