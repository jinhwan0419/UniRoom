package com.club.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.club.dto.ClubDTO;
import com.club.util.DBUtil;

public class ClubDAO {

    // 1. club_id로 동아리 한 개 조회
    public ClubDTO findById(int clubId) {
        ClubDTO club = null;
        String sql = "SELECT * FROM clubs WHERE club_id = ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setInt(1, clubId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    club = new ClubDTO();
                    club.setClub_id(rs.getInt("club_id"));
                    club.setName(rs.getString("name"));
                    club.setIs_active(rs.getInt("is_active"));
                    club.setCreated_at(rs.getString("created_at"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return club;
    }

    // 2. 전체 동아리 목록 (관리자용)
    public List<ClubDTO> findAll() {
        List<ClubDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM clubs ORDER BY name";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
        ) {
            while (rs.next()) {
                ClubDTO club = new ClubDTO();
                club.setClub_id(rs.getInt("club_id"));
                club.setName(rs.getString("name"));
                club.setIs_active(rs.getInt("is_active"));
                club.setCreated_at(rs.getString("created_at"));
                list.add(club);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 3. 동아리 추가 (필요하면 사용)
    public int insert(ClubDTO dto) {
        int result = 0;
        String sql = "INSERT INTO clubs (name, is_active) VALUES (?, ?)";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setString(1, dto.getName());
            pstmt.setInt(2, dto.getIs_active());

            result = pstmt.executeUpdate();   // 1이면 성공
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // 4. 동아리 비활성화(삭제 대신 is_active=0)
    public int deactivate(int clubId) {
        int result = 0;
        String sql = "UPDATE clubs SET is_active = 0 WHERE club_id = ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setInt(1, clubId);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}

