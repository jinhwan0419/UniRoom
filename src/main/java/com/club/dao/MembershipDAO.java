package com.club.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.club.dto.MembershipDTO;
import com.club.util.DBUtil;

public class MembershipDAO {

    // 1. 특정 유저가 속한 동아리 목록 (user_id -> memberships 목록)
    public List<MembershipDTO> findByUserId(int userId) {
        List<MembershipDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM memberships WHERE user_id = ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    MembershipDTO dto = new MembershipDTO();
                    dto.setUser_id(rs.getInt("user_id"));
                    dto.setClub_id(rs.getInt("club_id"));
                    dto.setRole(rs.getString("role"));
                    dto.setJoined_at(rs.getString("joined_at"));
                    list.add(dto);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 2. 특정 동아리에 속한 멤버 목록 (club_id -> memberships 목록)
    public List<MembershipDTO> findByClubId(int clubId) {
        List<MembershipDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM memberships WHERE club_id = ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, clubId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    MembershipDTO dto = new MembershipDTO();
                    dto.setUser_id(rs.getInt("user_id"));
                    dto.setClub_id(rs.getInt("club_id"));
                    dto.setRole(rs.getString("role"));
                    dto.setJoined_at(rs.getString("joined_at"));
                    list.add(dto);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 3. 멤버십 추가 (사용자를 동아리에 넣기)
    public int insert(MembershipDTO dto) {
        int result = 0;

        String sql = "INSERT INTO memberships (user_id, club_id, role, joined_at) "
                   + "VALUES (?, ?, ?, NOW())";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, dto.getUser_id());
            pstmt.setInt(2, dto.getClub_id());
            pstmt.setString(3, dto.getRole());

            result = pstmt.executeUpdate(); // 1이면 성공
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // 4. 멤버십 삭제 (동아리 탈퇴 처리)
    public int delete(int userId, int clubId) {
        int result = 0;

        String sql = "DELETE FROM memberships WHERE user_id = ? AND club_id = ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, userId);
            pstmt.setInt(2, clubId);

            result = pstmt.executeUpdate();  // 1이면 성공
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}

