package com.club.dto;

public class UserDTO {

    private int user_id;
    private String student_id;
    private String name;
    private String email;
    private String pw_hash;
    private String role;
    private int is_active;
    private String studentId;
    private String password;


    // 동아리 ID (DB 컬럼명이 club_id 라고 가정)
    private Integer club_id;

    public int getUser_id() {
        return user_id;
    }
    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getStudent_id() {
        return student_id;
    }
    public void setStudent_id(String student_id) {
        this.student_id = student_id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPw_hash() {
        return pw_hash;
    }
    public void setPw_hash(String pw_hash) {
        this.pw_hash = pw_hash;
    }

    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }

    public int getIs_active() {
        return is_active;
    }
    public void setIs_active(int is_active) {
        this.is_active = is_active;
    }

    // ----- club_id 관련 -----

    // DB 컬럼 이름 기준(getClub_id / setClub_id)
    public Integer getClub_id() {
        return club_id;
    }
    public void setClub_id(Integer club_id) {
        this.club_id = club_id;
    }

    // 기존 코드 호환용 (HomeServlet, home.jsp 에서 사용 중)
    public Integer getClubId() {
        return club_id;
    }
    public void setClubId(Integer clubId) {
        this.club_id = clubId;
    }
 // ===== 여기서부터 새로 추가 =====

    public String getStudentId() {
        // 필드 이름이 studentId가 아니라 student_id, stdId 같은 거면
        // 이 return 부분만 실제 필드 이름으로 바꿔줘.
        return studentId;
    }

    public void setStudentId(String studentId) {
        // 위와 마찬가지로 왼쪽 this.studentId 부분을 실제 필드 이름으로.
        this.studentId = studentId;
    }

    public void setPassword(String password) {
        // 패스워드 필드 이름이 pwd, userPwd 등이라면 여기만 바꾸면 됨.
        this.password = password;
    }
    public int getUserId() {
        return user_id;
    }

    public void setUserId(int userId) {
        this.user_id = userId;
    }


}
