package com.club.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {

    private static final String URL =
        "jdbc:mysql://localhost:3306/uniroom1?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Seoul";
        //                    ▲ 여기 DB 이름 uniroom1 로!!

    private static final String USER = "root";        // 네 MySQL 아이디
    private static final String PASSWORD = "Yoonseo31@"; // 네 MySQL 비번

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("DB 연결 실패", e);
        }
    }
}
