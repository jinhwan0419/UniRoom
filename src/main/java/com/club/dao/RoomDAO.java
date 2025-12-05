package com.club.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.club.dto.RoomDTO;
import com.club.util.DBUtil;

/**
 * rooms 테이블 접근 DAO
 * - 방 기본 정보 조회
 * - 동아리별 방 목록 조회
 * - 인기(추천) 방 목록 조회
 */
public class RoomDAO {

    /**
     * 특정 동아리의 방 목록 조회
     * @param clubId 동아리 ID (0 또는 음수면 전체)
     */
    public List<RoomDTO> findRoomsByClub(int clubId) {

        List<RoomDTO> list = new ArrayList<>();

        String baseSql =
            "SELECT r.room_id, r.club_id, c.name AS club_name, r.name, " +
            "       r.location, DATE_FORMAT(r.open_time, '%H:%i') AS open_time, " +
            "       DATE_FORMAT(r.close_time, '%H:%i') AS close_time, " +
            "       r.capacity, r.is_active " +
            "FROM rooms r " +
            "JOIN clubs c ON r.club_id = c.club_id " +
            "WHERE r.is_active = 1 ";

        String orderBy = " ORDER BY c.name, r.name";

        String sql;
        if (clubId > 0) {
            sql = baseSql + " AND r.club_id = ? " + orderBy;
        } else {
            sql = baseSql + orderBy;
        }

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            if (clubId > 0) {
                pstmt.setInt(1, clubId);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    RoomDTO room = new RoomDTO();
                    room.setRoom_id(rs.getInt("room_id"));
                    room.setClub_id(rs.getInt("club_id"));
                    room.setClub_name(rs.getString("club_name"));
                    room.setName(rs.getString("name"));
                    room.setLocation(rs.getString("location"));
                    room.setOpen_time(rs.getString("open_time"));
                    room.setClose_time(rs.getString("close_time"));
                    room.setCapacity(rs.getInt("capacity"));
                    room.setActive(rs.getInt("is_active") == 1);

                    list.add(room);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * 오늘 기준 인기 방(추천 공간) 상위 N개
     */
    public List<RoomDTO> findPopularRooms(String dateStr, int limit) {

        List<RoomDTO> list = new ArrayList<>();

        String sql =
            "SELECT r.room_id, r.club_id, c.name AS club_name, r.name, r.location, " +
            "       DATE_FORMAT(r.open_time, '%H:%i') AS open_time, " +
            "       DATE_FORMAT(r.close_time, '%H:%i') AS close_time, " +
            "       r.capacity, r.is_active, COUNT(res.reservation_id) AS cnt " +
            "FROM rooms r " +
            "JOIN clubs c ON r.club_id = c.club_id " +
            "LEFT JOIN reservations res " +
            "       ON r.room_id = res.room_id " +
            "      AND res.reserve_date = ? " +
            "      AND res.status = 'RESERVED' " +
            "WHERE r.is_active = 1 " +
            "GROUP BY r.room_id, r.club_id, c.name, r.name, r.location, r.open_time, r.close_time, r.capacity, r.is_active " +
            "ORDER BY cnt DESC " +
            "LIMIT ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dateStr);
            pstmt.setInt(2, limit);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    RoomDTO room = new RoomDTO();
                    room.setRoom_id(rs.getInt("room_id"));
                    room.setClub_id(rs.getInt("club_id"));
                    room.setClub_name(rs.getString("club_name"));
                    room.setName(rs.getString("name"));
                    room.setLocation(rs.getString("location"));
                    room.setOpen_time(rs.getString("open_time"));
                    room.setClose_time(rs.getString("close_time"));
                    room.setCapacity(rs.getInt("capacity"));
                    room.setActive(rs.getInt("is_active") == 1);
                    list.add(room);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =======================================
    // 기존 HomeServlet 호환용 메서드
    // - HomeServlet 에서 roomDao.findByClubId(Integer) 호출
    // =======================================
    public List<RoomDTO> findByClubId(Integer clubId) {
        // null 이면 전체, 아니면 해당 동아리만
        int cid = (clubId == null ? 0 : clubId.intValue());
        return findRoomsByClub(cid);
    }
}
