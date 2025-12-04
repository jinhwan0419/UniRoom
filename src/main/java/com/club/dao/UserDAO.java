package com.club.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.club.dto.UserDTO;
import com.club.util.DBUtil;

public class UserDAO {

    // 1. 로그인 (학번 + 비번)
    public UserDTO login(String studentId, String pwHash) {
        UserDTO user = null;

        String sql = "SELECT * FROM users WHERE student_id = ? AND pw_hash = ? AND is_active = 1";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, studentId);
            pstmt.setString(2, pwHash);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = new UserDTO();
                    user.setUser_id(rs.getInt("user_id"));
                    user.setName(rs.getString("name"));
                    user.setStudent_id(rs.getString("student_id"));
                    user.setEmail(rs.getString("email"));
                    user.setPw_hash(rs.getString("pw_hash"));
                    user.setRole(rs.getString("role"));
                    user.setIs_active(rs.getInt("is_active"));
                    user.setCreated_at(rs.getString("created_at"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user; // null이면 로그인 실패, 아니면 성공
    }

    // 2. user_id로 사용자 1명 조회
    public UserDTO findById(int userId) {
        UserDTO user = null;
        String sql = "SELECT * FROM users WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = new UserDTO();
                    user.setUser_id(rs.getInt("user_id"));
                    user.setName(rs.getString("name"));
                    user.setStudent_id(rs.getString("student_id"));
                    user.setEmail(rs.getString("email"));
                    user.setPw_hash(rs.getString("pw_hash"));
                    user.setRole(rs.getString("role"));
                    user.setIs_active(rs.getInt("is_active"));
                    user.setCreated_at(rs.getString("created_at"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    // 3. 새 사용자 등록 (회원가입)
    public int insert(UserDTO dto) {
        int result = 0;
        String sql = "INSERT INTO users (name, student_id, email, pw_hash, role, is_active) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getName());
            pstmt.setString(2, dto.getStudent_id());
            pstmt.setString(3, dto.getEmail());
            pstmt.setString(4, dto.getPw_hash());
            pstmt.setString(5, dto.getRole());
            pstmt.setInt(6, dto.getIs_active());

            result = pstmt.executeUpdate(); // 1이면 성공, 0이면 실패
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // 4. 학번 중복 여부 확인 (회원가입용)
    public boolean existsByStudentId(String studentId) {
        boolean exists = false;
        String sql = "SELECT COUNT(*) FROM users WHERE student_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, studentId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    exists = (rs.getInt(1) > 0); // 1개 이상 있으면 true
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return exists;
    }
    public UserDTO loginByStudentId(String studentId, String password) {
        UserDTO user = null;

        String sql = "SELECT * FROM users WHERE student_id = ? AND pw_hash = ?"; 
        // ⚠️ 비밀번호 컬럼명이 다르면 pw_hash 대신 실제 컬럼명으로 바꿔야 함.
        //     비밀번호를 해시 안 쓰고 plain text로 저장했다면 그대로 비교됨.

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setString(1, studentId);
            pstmt.setString(2, password);   // 나중에 해시 쓰면 여기서 변환

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = new UserDTO();
                    user.setUser_id(rs.getInt("user_id"));
                    user.setName(rs.getString("name"));
                    user.setStudent_id(rs.getString("student_id"));
                    user.setEmail(rs.getString("email"));
                    user.setPw_hash(rs.getString("pw_hash"));
                    user.setRole(rs.getString("role"));
                    user.setIs_active(rs.getInt("is_active"));
                    user.setCreated_at(rs.getString("created_at"));
                    user.setClubId(rs.getInt("club_id"));   // 🔵 동아리 ID 까지 세팅
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

}
