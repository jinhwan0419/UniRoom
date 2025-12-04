package com.club.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.club.dto.ReservationDTO;
import com.club.util.DBUtil;

public class ReservationDAO {

    // 예약 저장
    public int insertReservation(ReservationDTO reservation) {
        String sql = "INSERT INTO reservations " +
                     "(user_id, room_id, reserve_date, start_time, end_time) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            pstmt.setInt(1, reservation.getUser_id());
            pstmt.setInt(2, reservation.getRoom_id());
            pstmt.setString(3, reservation.getReserve_date());
            pstmt.setString(4, reservation.getStart_time());
            pstmt.setString(5, reservation.getEnd_time());

            return pstmt.executeUpdate();   // 1 이상이면 성공
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
