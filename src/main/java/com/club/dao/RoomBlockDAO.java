package com.club.dao;

import com.club.dto.RoomBlockDTO;
import com.club.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomBlockDAO {

    // 해당 방의 차단 구간 목록
    public List<RoomBlockDTO> findByRoomId(int roomId) {
        List<RoomBlockDTO> list = new ArrayList<>();

        String sql =
            "SELECT block_id, room_id, block_date, start_time, end_time, reason " +
            "FROM room_blocks " +
            "WHERE room_id = ? " +
            "ORDER BY block_date DESC, start_time";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setInt(1, roomId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    RoomBlockDTO b = new RoomBlockDTO();
                    b.setBlock_id(rs.getInt("block_id"));
                    b.setRoom_id(rs.getInt("room_id"));
                    b.setBlock_date(rs.getDate("block_date"));
                    b.setStart_time(rs.getTime("start_time"));
                    b.setEnd_time(rs.getTime("end_time"));
                    b.setReason(rs.getString("reason"));
                    list.add(b);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 차단 구간 추가
    public int insertBlock(RoomBlockDTO block) {
        String sql =
            "INSERT INTO room_blocks " +
            " (room_id, block_date, start_time, end_time, reason) " +
            " VALUES (?, ?, ?, ?, ?)";

        int result = 0;

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setInt(1, block.getRoom_id());
            pstmt.setDate(2, block.getBlock_date());
            pstmt.setTime(3, block.getStart_time());
            pstmt.setTime(4, block.getEnd_time());
            pstmt.setString(5, block.getReason());

            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // 차단 구간 삭제
    public int deleteBlock(int blockId) {
        String sql = "DELETE FROM room_blocks WHERE block_id = ?";
        int result = 0;

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setInt(1, blockId);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}
