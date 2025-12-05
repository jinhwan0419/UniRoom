package com.club.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.club.dao.ReservationDAO;
import com.club.dto.UserDTO;

@WebServlet("/ReservationServlet")
public class ReservationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDao = new ReservationDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String cpath = request.getContextPath();

        // 1. 로그인 유저 확인
        HttpSession session = request.getSession(false);
        UserDTO loginUser = (session != null) ? (UserDTO) session.getAttribute("loginUser") : null;
        if (loginUser == null) {
            response.sendRedirect(cpath + "/login.jsp");
            return;
        }

        int userId = loginUser.getUserId();   // ★ UserDTO PK getter에 맞게

        // 2. 폼 파라미터 읽기 (room_detail.jsp에서 오는 그대로)
        String roomIdStr = request.getParameter("roomId");
        String dateStr   = request.getParameter("date");
        String timeStr   = request.getParameter("time");

        System.out.println("[ReservationServlet] roomIdStr=" + roomIdStr +
                ", dateStr=" + dateStr + ", timeStr=" + timeStr);

        // 3. 필수값 체크 (null / 빈문자 방지 : Java8 호환)
        if (roomIdStr == null || roomIdStr.trim().equals("") ||
            dateStr   == null || dateStr.trim().equals("")   ||
            timeStr   == null || timeStr.trim().equals("")) {

            System.out.println("[ReservationServlet] 잘못된 파라미터로 인한 실패");
            response.sendRedirect(cpath + "/home?error=badParam");
            return;
        }

        int roomId = Integer.parseInt(roomIdStr);
        LocalDate date  = LocalDate.parse(dateStr);      // "2025-12-06"
        LocalTime start = LocalTime.parse(timeStr);      // "09:00"
        LocalTime end   = start.plusHours(1);            // 1시간 사용 기준

        // 4. 중복 체크 + 예약 생성 (DB 컬럼: date, time 사용)
        boolean ok = reservationDao.createReservationChecked(
                userId, roomId, date, start, end
        );

        // 5. 결과에 따라 이동
        if (ok) {
            // 성공 → 내 예약 화면
            response.sendRedirect(cpath + "/myReservations");
        } else {
            // 겹치는 예약 → 다시 상세 페이지로
            response.sendRedirect(
                    cpath + "/room/detail?roomId=" + roomId +
                    "&date=" + dateStr +
                    "&error=duplicate"
            );
        }
    }
}
