package com.club.dto;

import java.time.LocalDate;
import java.time.LocalTime;

/**
 * 예약 정보 DTO
 * - 날짜/시간대별 예약 현황 표현
 */
public class ReservationDTO {

    private int reservation_id;
    private int room_id;
    private int user_id;
    private LocalDate reserve_date;
    private LocalTime start_time;
    private LocalTime end_time;
    private String status;

    // 화면 표시용
    private String user_name;
    private String room_name;

    public int getReservation_id() {
        return reservation_id;
    }

    public void setReservation_id(int reservation_id) {
        this.reservation_id = reservation_id;
    }

    public int getRoom_id() {
        return room_id;
    }

    public void setRoom_id(int room_id) {
        this.room_id = room_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public LocalDate getReserve_date() {
        return reserve_date;
    }

    public void setReserve_date(LocalDate reserve_date) {
        this.reserve_date = reserve_date;
    }

    public LocalTime getStart_time() {
        return start_time;
    }

    public void setStart_time(LocalTime start_time) {
        this.start_time = start_time;
    }

    public LocalTime getEnd_time() {
        return end_time;
    }

    public void setEnd_time(LocalTime end_time) {
        this.end_time = end_time;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getRoom_name() {
        return room_name;
    }

    public void setRoom_name(String room_name) {
        this.room_name = room_name;
    }
}
