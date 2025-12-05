package com.club.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.club.dto.ClubDTO;
import com.club.util.DBUtil;

/**
 * clubs 테이블 접근용 DAO
 * - 동아리 단일 조회 / 전체 조회 / 추가 / 비활성화(삭제 대신) 기능 제공
 */
public class ClubDAO {

    /**
     * 1. club_id로 동아리 한 개 조회
     *    - 주로: 상세 화면, FK로 연결된 레코드 조회할 때 사용
     */
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

    /**
     * 2. 전체 동아리 목록 (관리자용)
     *    - is_active 상관 없이 모든 동아리를 가져옴
     *    - 총동연이 전체 목록 확인할 때 사용
     */
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

    /**
     * 3. 활성 상태(is_active = 1)인 동아리 목록
     *    - 일반 사용자 / 동아리방 등록용 콤보박스 등에 사용
     *    - 비활성 동아리는 숨기고 싶을 때 이 메서드를 사용
     */
    public List<ClubDTO> findActive() {
        List<ClubDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM clubs WHERE is_active = 1 ORDER BY name";

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

    /**
     * 4. 동아리 추가
     *    - 총동연이 새로운 동아리를 등록할 때 사용
     *    - dto.is_active 값을 1로 넣으면 활성 상태, 0이면 비활성 상태로 생성
     */
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

    /**
     * 5. 동아리 비활성화 (삭제 대신 is_active = 0 으로 처리)
     *    - 실제 데이터를 지우지 않고, 서비스에서만 숨기고 싶을 때 사용
     */
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

    /**
     * 6. 홈 화면용 편의 메서드
     *    - 활성 동아리 목록을 홈 화면에 보여줄 때 사용
     */
    public List<ClubDTO> getAllClubs() {
        // 필요하면 findAll()으로 바꿔도 됨
        return findActive();
    }
}
