// 인기 방 Top N  → 실제론 그냥 방 목록 몇 개 가져오기
public List<RoomDTO> findPopularRooms(int limit) {
    List<RoomDTO> list = new ArrayList<>();

    // 복잡한 JOIN, rv_room_id 이런 거 전부 제거!
    String sql = "SELECT * FROM rooms ORDER BY room_id LIMIT ?";

    try (
        Connection conn = DBUtil.getConnection();
        PreparedStatement pstmt = conn.prepareStatement(sql);
    ) {
        pstmt.setInt(1, limit);

        try (ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                RoomDTO room = new RoomDTO();
                room.setRoom_id(rs.getInt("room_id"));
                room.setClub_id(rs.getInt("club_id"));
                room.setName(rs.getString("name"));
                room.setOpen_time(rs.getString("open_time"));
                room.setClose_time(rs.getString("close_time"));
                room.setNote(rs.getString("note"));
                room.setCreated_at(rs.getString("created_at"));

                list.add(room);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}
