package com.club.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.club.dto.ClubDTO;
import com.club.util.DBUtil;

/**
 * 동아리 관련 DAO
 * - 전체 동아리 목록 조회 (동아리 선택 드롭다운)
 */
public class ClubDAO {

    /**
     * 활성화된 동아리 전체 조회
     */
    public List<ClubDTO> findAllActiveClubs() {
        List<ClubDTO> list = new ArrayList<>();

        String sql = "SELECT club_id, name, category, is_active " +
                     "FROM clubs WHERE is_active = 1 ORDER BY name ASC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                ClubDTO dto = new ClubDTO();
                dto.setClub_id(rs.getInt("club_id"));
                dto.setName(rs.getString("name"));
                dto.setCategory(rs.getString("category"));
                dto.setActive(rs.getInt("is_active") == 1);

                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================================
    // 기존 ClubsServlet 호환용 메서드
    // - ClubsServlet 에서 clubDao.findAll() 을 호출할 때 사용
    // ================================
    public List<ClubDTO> findAll() {
        // 그냥 활성 동아리 전체 반환
        return findAllActiveClubs();
    }
}
