package com.club.dto;

public class UserDTO {
    private int user_id;
    private String name;
    private String email;
    private String pw_hash;
    private String role;
    private int is_active;
    private String created_at;

    public UserDTO() {}

    public int getUser_id() { return user_id; }
    public void setUser_id(int user_id) { this.user_id = user_id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPw_hash() { return pw_hash; }
    public void setPw_hash(String pw_hash) { this.pw_hash = pw_hash; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public int getIs_active() { return is_active; }
    public void setIs_active(int is_active) { this.is_active = is_active; }

    public String getCreated_at() { return created_at; }
    public void setCreated_at(String created_at) { this.created_at = created_at; }
}
