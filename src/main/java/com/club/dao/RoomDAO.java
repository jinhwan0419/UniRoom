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
 * - 관리자용 전체 목록 / 수정 / 등록
 */
public class RoomDAO {

    /**
     * 특정 동아리의 방 목록 조회 (사용자용 리스트)
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

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
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
                    // 문자열 "HH:mm"
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
            "GROUP BY r.room_id, r.club_id, c.name, r.name, r.location, " +
            "         r.open_time, r.close_time, r.capacity, r.is_active " +
            "ORDER BY cnt DESC " +
            "LIMIT ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {

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
    // 기존 HomeServlet 호환용
    // =======================================
    public List<RoomDTO> findByClubId(Integer clubId) {
        int cid = (clubId == null ? 0 : clubId.intValue());
        return findRoomsByClub(cid);
    }

    /**
     * room_id 기준 방 한 개 조회 (관리자/예약 상세 등)
     */
    public RoomDTO findById(int roomId) {
        RoomDTO room = null;

        String sql =
            "SELECT r.room_id, r.club_id, r.name, r.location, r.capacity, " +
            "       r.open_time, r.close_time, r.is_active " +
            "FROM rooms r " +
            "WHERE r.room_id = ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {

            pstmt.setInt(1, roomId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    room = new RoomDTO();
                    room.setRoom_id(rs.getInt("room_id"));
                    room.setClub_id((Integer) rs.getObject("club_id"));
                    room.setName(rs.getString("name"));
                    room.setLocation(rs.getString("location"));
                    room.setCapacity(rs.getInt("capacity"));
                    room.setOpen_time(rs.getTime("open_time"));
                    room.setClose_time(rs.getTime("close_time"));
                    room.setActive(rs.getInt("is_active") == 1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return room;
    }

    /**
     * 방 전체 목록 조회 (관리자용)
     */
    public List<RoomDTO> findAll() {
        List<RoomDTO> list = new ArrayList<>();

        String sql =
            "SELECT room_id, club_id, name, location, capacity, " +
            "       open_time, close_time, is_active " +
            "FROM rooms " +
            "ORDER BY room_id DESC";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery()
        ) {
            while (rs.next()) {
                RoomDTO room = new RoomDTO();
                room.setRoom_id(rs.getInt("room_id"));
                room.setClub_id((Integer) rs.getObject("club_id"));
                room.setName(rs.getString("name"));
                room.setLocation(rs.getString("location"));
                room.setCapacity(rs.getInt("capacity"));
                room.setOpen_time(rs.getTime("open_time"));
                room.setClose_time(rs.getTime("close_time"));
                room.setActive(rs.getInt("is_active") == 1);

                list.add(room);
            }
            System.out.println("[RoomDAO.findAll] list size = " + list.size());
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * 방 기본 정보 수정 (운영시간, 예약 단위, 수용 인원, 설명)
     *  - slot_minutes, description 컬럼이 rooms 테이블에 있어야 동작
     */
    public int updateBasicInfo(RoomDTO room) {

        String sql =
            "UPDATE rooms " +
            "SET open_time = ?, close_time = ?, slot_minutes = ?, capacity = ?, description = ? " +
            "WHERE room_id = ?";

        int result = 0;

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setTime(1, room.getOpen_time());
            pstmt.setTime(2, room.getClose_time());
            pstmt.setInt(3, room.getSlot_minutes());
            pstmt.setInt(4, room.getCapacity());
            pstmt.setString(5, room.getDescription());
            pstmt.setInt(6, room.getRoom_id());

            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    /**
     * 새 공간(방) 등록
     */
    public int insertRoom(RoomDTO room) {

        String sql =
            "INSERT INTO rooms " +
            " (club_id, name, location, capacity, open_time, close_time, is_active) " +
            " VALUES (?, ?, ?, ?, ?, ?, ?)";

        int result = 0;

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            // club_id (nullable)
            if (room.getClub_id() != null) {
                pstmt.setInt(1, room.getClub_id());
            } else {
                pstmt.setNull(1, java.sql.Types.INTEGER);
            }

            pstmt.setString(2, room.getName());
            pstmt.setString(3, room.getLocation());
            pstmt.setInt(4, room.getCapacity());
            pstmt.setTime(5, room.getOpen_time());
            pstmt.setTime(6, room.getClose_time());
            pstmt.setInt(7, room.isActive() ? 1 : 0);

            result = pstmt.executeUpdate();
            System.out.println("[RoomDAO.insertRoom] result = " + result);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}
