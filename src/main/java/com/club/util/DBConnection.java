package com.club.util;   // 네가 만든 패키지 이름이랑 똑같이!

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static Connection conn;

    // DB 연결 정보
    private static final String URL =
            "jdbc:mysql://localhost:3306/club_reservation?useSSL=false&serverTimezone=Asia/Seoul&characterEncoding=UTF-8";
    private static final String USER = "root";          // MySQL 아이디
    private static final String PASSWORD = "Yoonseo31@"; // 👉 네가 MySQL 설치할 때 만든 root 비번

    // 외부에서 객체 못 만들게 private 생성자
    private DBConnection() {}

    // 어디서든 호출해서 Connection 얻어오는 메서드
    public static Connection getConnection() throws SQLException {
        try {
            if (conn == null || conn.isClosed()) {
                // 드라이버 로딩 (JDBC 드라이버 .jar 추가했으니까 이게 성공해야 정상)
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("✅ MySQL 연결 성공!");
            }
        } catch (ClassNotFoundException e) {
            System.out.println("❌ JDBC 드라이버를 찾을 수 없습니다.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("❌ MySQL 연결 실패...");
            e.printStackTrace();
            throw e;       // 위로 다시 던져서 어디서든 에러 확인 가능
        }

        return conn;
    }
}
