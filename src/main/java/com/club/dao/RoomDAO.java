package com.club.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.club.dto.RoomDTO;
import com.club.util.DBUtil;

public class RoomDAO {

    // 공통 매핑 함수
    private RoomDTO mapRow(ResultSet rs) throws Exception {
        RoomDTO room = new RoomDTO();
        room.setRoom_id(rs.getInt("room_id"));

        // DB 컬럼 이름에 따라 둘 중 하나만 실제로 쓰일 거야
        try {
            room.setRoom_name(rs.getString("room_name"));
        } catch (Exception e) {
            room.setRoom_name(rs.getString("name"));
        }

        try { room.setLocation(rs.getString("location")); } catch (Exception e) {}
        try { room.setCapacity(rs.getInt("capacity")); }   catch (Exception e) {}
        // description 필드 없는 DTO 때문에 에러 나서 완전 제거

        return room;
    }

    // 1) 전체 방 조회 (있어도 되고, 안 써도 됨)
    public List<RoomDTO> findAll() {
        List<RoomDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM rooms ORDER BY room_id";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 2) clubId 기준 방 조회 – HomeServlet에서 사용
    public List<RoomDTO> findByClubId(Integer clubId) {
        List<RoomDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM rooms WHERE club_id = ? ORDER BY room_id";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, clubId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
