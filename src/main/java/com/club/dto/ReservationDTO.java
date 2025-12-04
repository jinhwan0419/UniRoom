package com.club.dto;

public class ReservationDTO {

    private int reservation_id;  // PK
    private int user_id;         // 예약자
    private int room_id;         // 방
    private String reserve_date; // "2025-12-04"
    private String start_time;   // "10:00"
    private String end_time;     // "12:00"

    public ReservationDTO() {}

    public int getReservation_id() { return reservation_id; }
    public void setReservation_id(int reservation_id) { this.reservation_id = reservation_id; }

    public int getUser_id() { return user_id; }
    public void setUser_id(int user_id) { this.user_id = user_id; }

    public int getRoom_id() { return room_id; }
    public void setRoom_id(int room_id) { this.room_id = room_id; }

    public String getReserve_date() { return reserve_date; }
    public void setReserve_date(String reserve_date) { this.reserve_date = reserve_date; }

    public String getStart_time() { return start_time; }
    public void setStart_time(String start_time) { this.start_time = start_time; }

    public String getEnd_time() { return end_time; }
    public void setEnd_time(String end_time) { this.end_time = end_time; }
}
