package com.club.dao;

import java.sql.*;
import com.club.dto.UserDTO;
import com.club.util.DBUtil;

public class UserDAO {

    // 1. 로그인
	public UserDTO login(String studentId, String pw) {

	    UserDTO user = null;

	    String sql = "SELECT * FROM users " +
	                 "WHERE student_id = ? " +
	                 "  AND pw_hash = ? " +
	                 "  AND is_active = 1";

	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, studentId);
	        pstmt.setString(2, pw);

	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                user = new UserDTO();
	                user.setUser_id(rs.getInt("user_id"));
	                user.setStudent_id(rs.getString("student_id"));
	                user.setName(rs.getString("name"));
	                user.setEmail(rs.getString("email"));
	                user.setPw_hash(rs.getString("pw_hash"));
	                user.setRole(rs.getString("role"));
	                user.setClub_id(rs.getInt("club_id"));
	                user.setIs_active(rs.getInt("is_active"));
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return user;
	}


    // 2. 회원가입
    public int insertUser(UserDTO user) {
        String sql = "INSERT INTO users " +
                     " (student_id, name, email, pw_hash, role, club_id) " +
                     " VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getStudent_id());
            pstmt.setString(2, user.getName());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPw_hash());
            pstmt.setString(5, user.getRole());
            pstmt.setInt(6, user.getClub_id());

            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("회원가입 INSERT 중 에러");
            return 0;
        }
    }
    
}
