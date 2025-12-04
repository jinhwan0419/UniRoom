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
 * - 방 상세 조회
 * - 전체 방 조회
 * - 인기 방 목록
 * - 방 등록(총동연 관리자 전용)
 */
public class RoomDAO {

    /**
     * 1. room_id 기준으로 방 상세 조회
     *    - 예약 폼에서 방 이름/정원/위치 보여줄 때 사용
     */
    public RoomDTO findById(int roomId) {
        RoomDTO room = null;
        String sql = "SELECT * FROM rooms WHERE room_id = ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, roomId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    room = new RoomDTO();
                    room.setRoom_id(rs.getInt("room_id"));
                    room.setRoom_name(rs.getString("room_name"));
                    room.setCapacity(rs.getInt("capacity"));
                    room.setLocation(rs.getString("location"));
                    room.setClubId(rs.getInt("club_id"));  // 어떤 동아리 방인지
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return room;
    }

    /**
     * 2. 전체 방 목록 조회
     *    - 홈 화면에서 모든 방을 불러올 때 사용
     *    - 필요 시 clubId 필터링은 Service/Servlet에서 처리
     */
    public List<RoomDTO> findAllRooms() {
        List<RoomDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM rooms ORDER BY room_id";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
        ) {
            while (rs.next()) {
                RoomDTO room = new RoomDTO();
                room.setRoom_id(rs.getInt("room_id"));
                room.setRoom_name(rs.getString("room_name"));
                room.setCapacity(rs.getInt("capacity"));
                room.setLocation(rs.getString("location"));
                room.setClubId(rs.getInt("club_id"));

                list.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * 3. 인기 방 Top N 조회
     *    - 진짜 기준(예약 수 등)이 생기면 ORDER BY만 변경
     *    - 지금은 임시로 capacity 큰 순 + room_id 순
     */
    public List<RoomDTO> findPopularRooms(int limit) {
        List<RoomDTO> list = new ArrayList<>();
        String sql =
            "SELECT * FROM rooms " +
            "ORDER BY capacity DESC, room_id ASC " +
            "LIMIT ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, limit);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    RoomDTO room = new RoomDTO();
                    room.setRoom_id(rs.getInt("room_id"));
                    room.setRoom_name(rs.getString("room_name"));
                    room.setCapacity(rs.getInt("capacity"));
                    room.setLocation(rs.getString("location"));
                    room.setClubId(rs.getInt("club_id"));

                    list.add(room);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * 4. 동아리 방 등록 (총동연 관리자 전용)
     *    - club_id : 어떤 동아리의 방인지 지정
     *    - room_name : 방 이름(예: 로보틱스실)
     *    - capacity : 정원
     *    - location : 위치 (학생회관 3층 등)
     */
    public int insertRoom(RoomDTO room) {
        int result = 0;

        String sql =
            "INSERT INTO rooms (club_id, room_name, capacity, location) " +
            "VALUES (?, ?, ?, ?)";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, room.getClubId());         // 동아리 ID
            pstmt.setString(2, room.getRoom_name());   // 방 이름
            pstmt.setInt(3, room.getCapacity());       // 정원
            pstmt.setString(4, room.getLocation());    // 위치

            result = pstmt.executeUpdate();            // 성공하면 1 리턴
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}
