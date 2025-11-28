package com.club.dto;

public class TimeslotDTO {
    private int timeslot_id;
    private int room_id;
    private String date;
    private String start_time;
    private String end_time;
    private String created_at;

    public TimeslotDTO() {}

    public int getTimeslot_id() {
        return timeslot_id;
    }

    public void setTimeslot_id(int timeslot_id) {
        this.timeslot_id = timeslot_id;
    }

    public int getRoom_id() {
        return room_id;
    }

    public void setRoom_id(int room_id) {
        this.room_id = room_id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getStart_time() {
        return start_time;
    }

    public void setStart_time(String start_time) {
        this.start_time = start_time;
    }

    public String getEnd_time() {
        return end_time;
    }

    public void setEnd_time(String end_time) {
        this.end_time = end_time;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }
}

