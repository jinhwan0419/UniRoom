package com.club.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.club.dao.ReservationDAO;
import com.club.dto.ReservationDTO;
import com.club.dto.UserDTO;

@WebServlet("/notifications")
public class NotificationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDao = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String cpath = request.getContextPath();

        HttpSession session = request.getSession(false);
        UserDTO loginUser = (session != null)
                ? (UserDTO) session.getAttribute("loginUser")
                : null;

        if (loginUser == null) {
            response.sendRedirect(cpath + "/login.jsp");
            return;
        }

        int userId = loginUser.getUserId();

        // 1. 내 전체 예약 내역 가져오기
        List<ReservationDTO> all = reservationDao.findByUser(userId);

        // 2. 현재 시간 ~ 20분 후 사이에 시작하는 예약만 필터링
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime limit = now.plusMinutes(20);

        List<ReservationDTO> upcoming = new ArrayList<>();

        if (all != null) {
            for (ReservationDTO rsv : all) {
                if (rsv.getReserve_date() == null || rsv.getStart_time() == null) continue;

                LocalDateTime start = LocalDateTime.of(
                        rsv.getReserve_date(),
                        rsv.getStart_time()
                );

                if (!start.isBefore(now) && !start.isAfter(limit)) {
                    // now <= start <= now+20분
                    upcoming.add(rsv);
                }
            }
        }

        request.setAttribute("upcomingReservations", upcoming);
        request.getRequestDispatcher("/notifications.jsp").forward(request, response);
    }
}
