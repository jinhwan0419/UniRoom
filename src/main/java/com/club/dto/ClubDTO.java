package com.club.dto;

/**
 * 동아리 정보를 담는 DTO
 * - clubs 테이블과 1:1 매핑
 *   club_id    : PK
 *   name       : 동아리 이름
 *   is_active  : 활성 여부 (1=활성, 0=비활성)
 *   created_at : 생성 시각 (문자열로만 보관)
 */
public class ClubDTO {
    private int club_id;
    private String name;
    private int is_active;
    private String created_at;

    public ClubDTO() {}

    public int getClub_id() {
        return club_id;
    }

    public void setClub_id(int club_id) {
        this.club_id = club_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getIs_active() {
        return is_active;
    }

    public void setIs_active(int is_active) {
        this.is_active = is_active;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }
}
