package com.club.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;

import com.club.util.DBUtil;

public class ReservationDAO {

    // ✅ 예약 생성 – ReservationServlet에서 사용
    public int createReservation(int roomId, int userId,
                                 Timestamp startTime, Timestamp endTime) {

        String sql =
            "INSERT INTO reservations (room_id, user_id, start_time, end_time, status) " +
            "VALUES (?, ?, ?, ?, 'BOOKED')";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomId);
            pstmt.setInt(2, userId);
            pstmt.setTimestamp(3, startTime);
            pstmt.setTimestamp(4, endTime);

            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}
