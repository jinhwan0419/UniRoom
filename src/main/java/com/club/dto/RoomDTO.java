package com.club.dto;

public class RoomDTO {

    private int room_id;      // rooms PK
    private String room_name;
    private int capacity;
    private String location;

    // rooms 테이블의 club_id 컬럼과 연결
    private int clubId;

    public RoomDTO() {}

    public int getRoom_id() { return room_id; }
    public void setRoom_id(int room_id) { this.room_id = room_id; }

    public String getRoom_name() { return room_name; }
    public void setRoom_name(String room_name) { this.room_name = room_name; }

    public int getCapacity() { return capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public int getClubId() { return clubId; }
    public void setClubId(int clubId) { this.clubId = clubId; }
}
