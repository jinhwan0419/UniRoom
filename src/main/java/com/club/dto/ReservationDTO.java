package com.club.dto;

import java.sql.Time;
import java.sql.Date;

public class ReservationDTO {
    private int id;
    private int memberId;
    private int roomId;
    private Date reserveDate;
    private Time startTime;
    private Time endTime;
    private String status;

    // Getter / Setter
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getMemberId() {
        return memberId;
    }
    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public int getRoomId() {
        return roomId;
    }
    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public Date getReserveDate() {
        return reserveDate;
    }
    public void setReserveDate(Date reserveDate) {
        this.reserveDate = reserveDate;
    }

    public Time getStartTime() {
        return startTime;
    }
    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }
    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
}
