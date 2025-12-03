package com.club.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.club.dto.UserDTO;
import com.club.util.DBUtil;

/**
 * users 테이블 전담 DAO
 *  - 로그인
 *  - 회원 조회/가입
 *  - 패널티 관리
 *  - 개인정보 수정
 *  - 역할(role) 변경 (관리자용)
 */
public class UserDAO {

	// 1. 로그인 (학번 + 비번)
	public UserDTO login(String studentId, String pwHash) {
	    UserDTO user = null;

	    // 1단계: 일단 학번으로만 사용자 찾기
	    String sql = "SELECT * FROM users WHERE student_id = ?";

	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        System.out.println("[UserDAO.login] 시도: " + studentId + " / " + pwHash);

	        pstmt.setString(1, studentId);

	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                String dbPw = rs.getString("pw_hash");
	                int isActive = rs.getInt("is_active");
	                String role = rs.getString("role");

	                System.out.println("[UserDAO.login] DB 값 pw=" + dbPw + ", is_active=" + isActive + ", role=" + role);

	                // ① 비밀번호 일치 확인
	                if (!dbPw.equals(pwHash)) {
	                    System.out.println("[UserDAO.login] 비밀번호 불일치");
	                    return null;
	                }

	                // ② 활성 상태 체크 (0이면 로그인 막기)
	                if (isActive == 0) {
	                    System.out.println("[UserDAO.login] 비활성 계정(is_active=0)");
	                    return null;
	                }

	                // 여기까지 통과하면 로그인 성공
	                user = mapRowToUser(rs);
	                System.out.println("[UserDAO.login] 로그인 성공! user_id=" + user.getUser_id() + ", role=" + user.getRole());
	            } else {
	                System.out.println("[UserDAO.login] 해당 학번의 사용자 없음");
	            }
	        }
	    } catch (Exception e) {
	        System.out.println("[UserDAO.login] 예외 발생");
	        e.printStackTrace();
	    }

	    return user; // null이면 로그인 실패
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
                    user = mapRowToUser(rs);
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

        // role이 비어있으면 기본값 member로
        String role = dto.getRole();
        if (role == null || role.trim().isEmpty()) {
            role = "member"; // enum('admin','lead','manager','member') 중 기본
        }

        // is_active 기본값 1로
        int isActive = dto.getIs_active();
        if (isActive != 0 && isActive != 1) {
            isActive = 1;
        }

        String sql = "INSERT INTO users " +
                     " (name, student_id, email, pw_hash, role, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getName());
            pstmt.setString(2, dto.getStudent_id());
            pstmt.setString(3, dto.getEmail());
            pstmt.setString(4, dto.getPw_hash());
            pstmt.setString(5, role);
            pstmt.setInt(6, isActive);

            result = pstmt.executeUpdate(); // 1이면 성공
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

    // 5. 패널티 점수 조회
    public int getPenaltyPoint(int userId) {
        int penalty = 0;
        String sql = "SELECT penalty_point FROM users WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    penalty = rs.getInt("penalty_point");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return penalty;
    }

    // 6. 개인정보 수정 (이름 / 이메일)
    public int updateUser(UserDTO dto) {
        int result = 0;
        String sql = "UPDATE users SET name = ?, email = ? WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getName());
            pstmt.setString(2, dto.getEmail());
            pstmt.setInt(3, dto.getUser_id());

            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // 7. 패널티 점수 추가 (노쇼나 규정 위반 등)
    public int addPenalty(int userId, int addPoint) {
        int result = 0;
        String sql = "UPDATE users " +
                     "SET penalty_point = penalty_point + ? " +
                     "WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, addPoint);
            pstmt.setInt(2, userId);

            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // 8. 역할(role) 변경 (관리자/총동연이 회장 권한 부여/회수할 때)
    public int updateRole(int userId, String role) {
        int result = 0;
        String sql = "UPDATE users SET role = ? WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, role);   // 'admin', 'lead', 'manager', 'member' 중 하나
            pstmt.setInt(2, userId);

            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // 공통: ResultSet → UserDTO 매핑
    private UserDTO mapRowToUser(ResultSet rs) throws Exception {
        UserDTO user = new UserDTO();

        user.setUser_id(rs.getInt("user_id"));
        user.setName(rs.getString("name"));
        user.setStudent_id(rs.getString("student_id"));
        user.setEmail(rs.getString("email"));
        user.setPw_hash(rs.getString("pw_hash"));
        user.setRole(rs.getString("role"));
        user.setIs_active(rs.getInt("is_active"));
        user.setCreated_at(rs.getString("created_at"));
        // penalty_point도 DTO에 있으면 같이 세팅
        try {
            int penalty = rs.getInt("penalty_point");
            user.setPenalty_point(penalty);
        } catch (Exception ignore) {
            // 컬럼 없으면 무시
        }

        return user;
    }
}
