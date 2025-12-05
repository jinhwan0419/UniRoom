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

    private static final long serialVersionUID = 1L;

    private final ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        UserDTO loginUser = (session != null)
                ? (UserDTO) session.getAttribute("loginUser")
                : null;

        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            int userId = loginUser.getUser_id();

            int roomId = Integer.parseInt(request.getParameter("roomId"));
            String reserveDateStr = request.getParameter("reserveDate");
            String startTimeStr = request.getParameter("startTime");
            String endTimeStr = request.getParameter("endTime");

            if (reserveDateStr == null || reserveDateStr.isEmpty()) {
                reserveDateStr = LocalDate.now().toString();
            }
            if (startTimeStr == null || startTimeStr.isEmpty()) {
                startTimeStr = "09:00";
            }
            if (endTimeStr == null || endTimeStr.isEmpty()) {
                // 기본 1시간 후
                LocalTime start = LocalTime.parse(startTimeStr);
                endTimeStr = start.plusHours(1).toString();
            }

            LocalDate date = LocalDate.parse(reserveDateStr);
            LocalTime start = LocalTime.parse(startTimeStr);
            LocalTime end = LocalTime.parse(endTimeStr);

            Timestamp startTs = Timestamp.valueOf(LocalDateTime.of(date, start));
            Timestamp endTs = Timestamp.valueOf(LocalDateTime.of(date, end));

            reservationDAO.createReservation(userId, roomId, startTs, endTs);

            // 예약 후 다시 홈으로
            String redirectUrl = String.format("%s/home?reserveDate=%s&startTime=%s",
                    request.getContextPath(), reserveDateStr, startTimeStr);

            response.sendRedirect(redirectUrl);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
