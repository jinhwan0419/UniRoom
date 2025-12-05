package com.club.dto;

import java.sql.Time;

public class RoomDTO {

    // 기본 필드
    private int room_id;
    private String name;
    private String location;
    private int capacity;

    private Time open_time;
    private Time close_time;

    private int slot_minutes;     // 예약 단위(분)
    private String description;   // 비품/설명

    private Integer club_id;      // 소속 동아리 ID
    private String club_name;     // 소속 동아리 이름

    private boolean active;       // 사용 가능 여부 (true=사용, false=비활성)


    // ====== room_id 관련 (예전 이름, 새 이름 둘 다 지원) ======

    public int getRoom_id() {
        return room_id;
    }

    public void setRoom_id(int room_id) {
        this.room_id = room_id;
    }

    // 예전 코드에서 쓰는 이름 대응
    public int getRoomId() {
        return room_id;
    }

    public void setRoomId(int roomId) {
        this.room_id = roomId;
    }


    // ====== 이름(name) 관련 ======

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // 예전 코드용 별칭
    public String getRoomName() {
        return name;
    }

    public void setRoomName(String roomName) {
        this.name = roomName;
    }


    // ====== 위치/수용 인원 ======

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }


    // ====== 운영 시간 (Time + String 둘 다 받기) ======

    public Time getOpen_time() {
        return open_time;
    }

    public void setOpen_time(Time open_time) {
        this.open_time = open_time;
    }

    public void setOpen_time(String openTimeStr) {
        this.open_time = parseTime(openTimeStr);
    }

    public Time getClose_time() {
        return close_time;
    }

    public void setClose_time(Time close_time) {
        this.close_time = close_time;
    }

    public void setClose_time(String closeTimeStr) {
        this.close_time = parseTime(closeTimeStr);
    }

    // 예전 코드에서 getOpenTime(), setOpenTime(String) 이런 이름 쓸 수 있어서 alias 제공
    public Time getOpenTime() {
        return open_time;
    }

    public void setOpenTime(String openTimeStr) {
        this.open_time = parseTime(openTimeStr);
    }

    public void setOpenTime(Time t) {
        this.open_time = t;
    }

    public Time getCloseTime() {
        return close_time;
    }

    public void setCloseTime(String closeTimeStr) {
        this.close_time = parseTime(closeTimeStr);
    }

    public void setCloseTime(Time t) {
        this.close_time = t;
    }


    // ====== 예약 단위(분) ======

    public int getSlot_minutes() {
        return slot_minutes;
    }

    public void setSlot_minutes(int slot_minutes) {
        this.slot_minutes = slot_minutes;
    }


    // ====== 설명/비품 ======

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }


    // ====== 동아리 정보 ======

    public Integer getClub_id() {
        return club_id;
    }

    public void setClub_id(Integer club_id) {
        this.club_id = club_id;
    }

    public String getClub_name() {
        return club_name;
    }

    public void setClub_name(String club_name) {
        this.club_name = club_name;
    }

    // CamelCase alias
    public String getClubName() {
        return club_name;
    }

    public void setClubName(String clubName) {
        this.club_name = clubName;
    }


    // ====== 활성/비활성 여부 ======

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }


    // ====== 내부 유틸: "HH:mm" / "HH:mm:ss" → Time 변환 ======

    private Time parseTime(String s) {
        if (s == null || s.isEmpty()) {
            return null;
        }
        String val = s.trim();
        // "09:00" 처럼 분까지만 있으면 초 추가
        if (val.length() == 5) {
            val = val + ":00";
        }
        return Time.valueOf(val);
    }
}
