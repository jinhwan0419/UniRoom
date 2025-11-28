package com.club.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.club.dto.RoomDTO;
import com.club.util.DBUtil;

/**
 * rooms 테이블 관리 DAO
 * - 방 단건 조회
 * - 동아리별 방 조회
 * - 전체 방 목록
 * - 인기 방 Top N
 * - 방 정보 수정
 */
public class RoomDAO {

    /**
     * 1. 특정 club_id로 방 정보 가져오기
     *    - 동아리마다 방 1개라는 전제
     */
    public RoomDTO findByClubId(int clubId) {
        RoomDTO room = null;
        String sql = "SELECT * FROM rooms WHERE club_id = ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setInt(1, clubId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    room = mapRowToRoom(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return room;
    }

    /**
     * 2. 모든 방 리스트 (관리자/홈 화면 공용)
     */
    public List<RoomDTO> findAll() {
        List<RoomDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM rooms";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
        ) {

            while (rs.next()) {
                RoomDTO room = mapRowToRoom(rs);
                list.add(room);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * 3. 방 정보 수정
     *    - 운영시간, 이름, 비고 등 변경
     *    - return 1 이면 성공
     */
    public int update(RoomDTO dto) {
        int result = 0;

        String sql = "UPDATE rooms "
                   + "SET name = ?, open_time = ?, close_time = ?, note = ? "
                   + "WHERE room_id = ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setString(1, dto.getName());
            pstmt.setString(2, dto.getOpen_time());
            pstmt.setString(3, dto.getClose_time());
            pstmt.setString(4, dto.getNote());
            pstmt.setInt(5, dto.getRoom_id());

            result = pstmt.executeUpdate(); // 1이면 성공
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // ----------------------------------------------------------------------
    // 🔽 홈 화면 / 예약 기능에서 사용할 추가 메서드들
    // ----------------------------------------------------------------------

    /**
     * 4. 홈 화면용 전체 방 목록
     *    - 그냥 findAll() 재사용
     */
    public List<RoomDTO> findAllRooms() {
        return findAll();
    }

    /**
     * 5. room_id 기준 방 하나 상세 조회
     */
    public RoomDTO findById(int roomId) {
        RoomDTO room = null;
        String sql = "SELECT * FROM rooms WHERE room_id = ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setInt(1, roomId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    room = mapRowToRoom(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return room;
    }

    /**
     * 6. 인기 방 Top N 조회
     *    - reservations 테이블 기준으로 예약이 많은 순 정렬
     *    - reservations(reservation_id, room_id, ...) 구조라고 가정
     *    - 컬럼명이 다르면 COUNT 부분만 맞게 수정하면 됨
     */
    public List<RoomDTO> findPopularRooms(int limit) {
        List<RoomDTO> list = new ArrayList<>();

        String sql =
            "SELECT r.* " +
            "FROM rooms r " +
            "LEFT JOIN reservations rv ON r.room_id = rv.room_id " +
            "GROUP BY r.room_id " +
            "ORDER BY COUNT(rv.reservation_id) DESC " +  // rv.id 면 거기로 바꾸기
            "LIMIT ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setInt(1, limit);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    RoomDTO room = mapRowToRoom(rs);
                    list.add(room);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ----------------------------------------------------------------------
    // 공통: ResultSet → RoomDTO 매핑 메서드
    // ----------------------------------------------------------------------
    private RoomDTO mapRowToRoom(ResultSet rs) throws Exception {
        RoomDTO room = new RoomDTO();
        room.setRoom_id(rs.getInt("room_id"));
        room.setClub_id(rs.getInt("club_id"));
        room.setName(rs.getString("name"));
        room.setOpen_time(rs.getString("open_time"));
        room.setClose_time(rs.getString("close_time"));
        room.setNote(rs.getString("note"));
        room.setCreated_at(rs.getString("created_at"));
        return room;
    }
}
