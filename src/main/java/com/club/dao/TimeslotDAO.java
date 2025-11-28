package com.club.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.club.dto.TimeslotDTO;
import com.club.util.DBUtil;

public class TimeslotDAO {

    // 1. room_id + date 기준으로 해당 날짜의 모든 타임슬롯 가져오기
    public List<TimeslotDTO> findByRoomAndDate(int roomId, String date) {
        List<TimeslotDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM timeslots WHERE room_id = ? AND date = ? ORDER BY start_time";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, roomId);
            pstmt.setString(2, date);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    TimeslotDTO slot = new TimeslotDTO();
                    slot.setTimeslot_id(rs.getInt("timeslot_id"));
                    slot.setRoom_id(rs.getInt("room_id"));
                    slot.setDate(rs.getString("date"));
                    slot.setStart_time(rs.getString("start_time"));
                    slot.setEnd_time(rs.getString("end_time"));
                    slot.setCreated_at(rs.getString("created_at"));
                    list.add(slot);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 2. 특정 타임슬롯 1개 조회 (예약할 때 등)
    public TimeslotDTO findById(int timeslotId) {
        TimeslotDTO slot = null;

        String sql = "SELECT * FROM timeslots WHERE timeslot_id = ?";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, timeslotId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    slot = new TimeslotDTO();
                    slot.setTimeslot_id(rs.getInt("timeslot_id"));
                    slot.setRoom_id(rs.getInt("room_id"));
                    slot.setDate(rs.getString("date"));
                    slot.setStart_time(rs.getString("start_time"));
                    slot.setEnd_time(rs.getString("end_time"));
                    slot.setCreated_at(rs.getString("created_at"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return slot;
    }

    // 3. 타임슬롯 새로 추가 (관리자용, 시간대 정의)
    public int insert(TimeslotDTO dto) {
        int result = 0;

        String sql = "INSERT INTO timeslots (room_id, date, start_time, end_time) VALUES (?, ?, ?, ?)";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, dto.getRoom_id());
            pstmt.setString(2, dto.getDate());
            pstmt.setString(3, dto.getStart_time());
            pstmt.setString(4, dto.getEnd_time());

            result = pstmt.executeUpdate();  // 1이면 성공
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}
