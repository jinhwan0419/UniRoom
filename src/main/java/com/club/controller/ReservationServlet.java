package com.club.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        UserDTO loginUser = (session != null) ? (UserDTO) session.getAttribute("loginUser") : null;

        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // 1. 파라미터 받기
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            String reserveDate = request.getParameter("reserveDate"); // yyyy-MM-dd
            String start = request.getParameter("startTime");         // HH:mm or HH:mm:ss
            String end   = request.getParameter("endTime");           // 일단 start와 동일하게 들어오는 상태

            if (reserveDate == null || reserveDate.trim().isEmpty()) {
                reserveDate = LocalDate.now().toString();
            }

            // 2. 시간 파싱
            LocalDate date = LocalDate.parse(reserveDate);

            // HH:mm 또는 HH:mm:ss 둘 다 처리
            LocalTime startTime;
            if (start == null || start.isEmpty()) {
                // 기본 09:00
                startTime = LocalTime.of(9, 0);
            } else {
                if (start.length() == 5) { // "HH:mm"
                    startTime = LocalTime.parse(start);
                } else {
                    startTime = LocalTime.parse(start.substring(0, 5));
                }
            }

            LocalTime endTime;
            if (end != null && !end.isEmpty()) {
                if (end.length() == 5) {
                    endTime = LocalTime.parse(end);
                } else {
                    endTime = LocalTime.parse(end.substring(0, 5));
                }
            } else {
                // endTime이 비어 있으면 기본적으로 1시간 뒤로
                endTime = startTime.plusHours(1);
            }

            LocalDateTime startDateTime = LocalDateTime.of(date, startTime);
            LocalDateTime endDateTime   = LocalDateTime.of(date, endTime);

            Timestamp startTs = Timestamp.valueOf(startDateTime);
            Timestamp endTs   = Timestamp.valueOf(endDateTime);

            // 3. DAO 호출
            ReservationDAO reservationDAO = new ReservationDAO();
            reservationDAO.createReservation(roomId, loginUser.getUser_id(), startTs, endTs);

            // 4. 다시 홈으로 (필터 유지하고 싶으면 reserveDate/startTime도 같이 넘겨줌)
            String redirectUrl = request.getContextPath()
                                + "/home?reserveDate=" + reserveDate
                                + "&startTime=" + start;
            response.sendRedirect(redirectUrl);

        } catch (Exception e) {
            e.printStackTrace();
            // 에러 나면 일단 홈으로 돌려보내기
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
