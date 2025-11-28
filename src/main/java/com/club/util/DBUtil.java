package com.club.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {

    // DB 연결을 얻어오는 메서드
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // MySQL 드라이버 로드
            Class.forName("com.mysql.cj.jdbc.Driver");

            // DB 접속 정보
            String url = "jdbc:mysql://localhost:3306/club_reservation?serverTimezone=Asia/Seoul&characterEncoding=UTF-8";
            String user = "root";          // 네 MySQL 아이디
            String password = "Yoonseo31@";   // 네 MySQL 비밀번호

            conn = DriverManager.getConnection(url, user, password);
        } catch (Exception e) {
            e.printStackTrace();  // 나중에 로그로 바꿔도 됨
        }
        return conn;
    }
}
