package com.club.dto;

public class PenaltyDTO {
    private int penalty_id;
    private int user_id;
    private String reason;
    private int points;
    private String created_at;

    public PenaltyDTO() {}

    public int getPenalty_id() {
        return penalty_id;
    }

    public void setPenalty_id(int penalty_id) {
        this.penalty_id = penalty_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }
}
