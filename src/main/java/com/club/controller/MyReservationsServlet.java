package com.club.controller;

import com.club.dao.ReservationDAO;
import com.club.dto.ReservationDTO;
import com.club.dto.UserDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/MyReservations")
public class MyReservationsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDao = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 로그인 체크 (세션에서 사용자 꺼내기)
        HttpSession session = request.getSession(false);
        UserDTO loginUser = (session == null) ? null : (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            // 로그인 안 되어 있으면 로그인 페이지로
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = loginUser.getUser_id();

        // 내 예약 목록 조회
        List<ReservationDTO> list = reservationDao.findByUser(userId);

        request.setAttribute("reservationList", list);

        // 👉 여기 경로는 네가 실제로 만든 JSP 경로에 맞춰서 변경
        // 예) /user/my_reservations.jsp, /user/reservations.jsp 등
        request.getRequestDispatcher("/user/reservations.jsp").forward(request, response);
    }
}
