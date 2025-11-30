package com.club.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.club.dto.RoomDTO;
import com.club.util.DBUtil;

public class RoomDAO {

    // 공통: ResultSet 한 줄을 RoomDTO로 변환하는 메서드
    private RoomDTO mapRoom(ResultSet rs) throws Exception {
        RoomDTO room = new RoomDTO();
        room.setRoom_id(rs.getInt("room_id"));
        room.setClub_id(rs.getInt("club_id"));
        room.setName(rs.getString("name"));
        room.setOpen_time(rs.getString("open_time"));   // time 타입을 문자열로
        room.setClose_time(rs.getString("close_time")); // 마찬가지
        room.setNote(rs.getString("note"));
        room.setCreated_at(rs.getString("created_at"));
        return room;
    }

    /**
     * 1. 특정 club_id 로 방 1개 조회
     *    - 동아리당 방이 하나라고 가정
     */
    public RoomDTO findByClubId(int clubId) {
        RoomDTO room = null;

        String sql = "SELECT room_id, club_id, name, open_time, close_time, note, created_at "
                   + "FROM rooms "
                   + "WHERE club_id = ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, clubId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    room = mapRoom(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return room;
    }

    /**
     * 2. 전체 방 목록 조회
     */
    public List<RoomDTO> findAllRooms() {
        List<RoomDTO> list = new ArrayList<>();

        String sql = "SELECT room_id, club_id, name, open_time, close_time, note, created_at "
                   + "FROM rooms "
                   + "ORDER BY room_id";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
        ) {
            while (rs.next()) {
                RoomDTO room = mapRoom(rs);
                list.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * 3. room_id 로 방 1개 조회
     */
    public RoomDTO findById(int roomId) {
        RoomDTO room = null;

        String sql = "SELECT room_id, club_id, name, open_time, close_time, note, created_at "
                   + "FROM rooms "
                   + "WHERE room_id = ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, roomId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    room = mapRoom(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return room;
    }

    /**
     * 4. 인기 방 Top N
     *    - reservations 테이블의 예약 횟수 기준으로 정렬
     *    - 지금 화면에서는 "추천 공간" 같은 곳에 쓸 수 있음
     *    - 동아리당 방이 하나여도, 단순히 "예약이 많이 된 방 순서"라서 써도 됨
     */
    public List<RoomDTO> findPopularRooms(int limit) {
        List<RoomDTO> list = new ArrayList<>();

        String sql =
            "SELECT " +
            "   r.room_id, r.club_id, r.name, r.open_time, r.close_time, r.note, r.created_at, " +
            "   COUNT(rv.id) AS reservation_count " +
            "FROM rooms r " +
            "LEFT JOIN reservations rv " +
            "   ON r.room_id = rv.room_id " +
            "GROUP BY " +
            "   r.room_id, r.club_id, r.name, r.open_time, r.close_time, r.note, r.created_at " +
            "ORDER BY reservation_count DESC, r.room_id ASC " +
            "LIMIT ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, limit);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    RoomDTO room = mapRoom(rs);
                    // 필요하면 여기서 reservation_count를 DTO에 넣을 수도 있음
                    // 예: room.setReservation_count(rs.getInt("reservation_count"));
                    list.add(room);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
