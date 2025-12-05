package com.club.dto;

import java.sql.Date;
import java.sql.Time;

public class RoomBlockDTO {

    private int block_id;
    private int room_id;
    private Date block_date;
    private Time start_time;
    private Time end_time;
    private String reason;

    public int getBlock_id() {
        return block_id;
    }

    public void setBlock_id(int block_id) {
        this.block_id = block_id;
    }

    public int getRoom_id() {
        return room_id;
    }

    public void setRoom_id(int room_id) {
        this.room_id = room_id;
    }

    public Date getBlock_date() {
        return block_date;
    }

    public void setBlock_date(Date block_date) {
        this.block_date = block_date;
    }

    public Time getStart_time() {
        return start_time;
    }

    public void setStart_time(Time start_time) {
        this.start_time = start_time;
    }

    public Time getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Time end_time) {
        this.end_time = end_time;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }
}
