package com.club.dto;

import java.time.LocalDate;

public class PenaltySummaryDTO {

    private int userId;
    private String studentId;
    private String userName;
    private String clubName;
    private int noShowCount;
    private LocalDate lastNoShowDate;
    private LocalDate blockEndDate;

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public String getStudentId() {
        return studentId;
    }
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
    public String getClubName() {
        return clubName;
    }
    public void setClubName(String clubName) {
        this.clubName = clubName;
    }
    public int getNoShowCount() {
        return noShowCount;
    }
    public void setNoShowCount(int noShowCount) {
        this.noShowCount = noShowCount;
    }
    public LocalDate getLastNoShowDate() {
        return lastNoShowDate;
    }
    public void setLastNoShowDate(LocalDate lastNoShowDate) {
        this.lastNoShowDate = lastNoShowDate;
    }
    public LocalDate getBlockEndDate() {
        return blockEndDate;
    }
    public void setBlockEndDate(LocalDate blockEndDate) {
        this.blockEndDate = blockEndDate;
    }
}
