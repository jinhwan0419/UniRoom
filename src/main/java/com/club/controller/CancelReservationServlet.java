package com.club.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.club.dao.ReservationDAO;
import com.club.dto.UserDTO;

/**
 * 예약 취소 전용 서블릿
 * - POST /reservation/cancel
 * - 파라미터: reservationId
 * - 로그인한 사용자의 예약만 취소
 */
@WebServlet("/reservation/cancel")
public class CancelReservationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ReservationDAO reservationDao = new ReservationDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String cpath = request.getContextPath();

        // 1. 로그인 체크
        HttpSession session = request.getSession(false);
        UserDTO loginUser = (session != null) ? (UserDTO) session.getAttribute("loginUser") : null;

        if (loginUser == null) {
            response.sendRedirect(cpath + "/login.jsp");
            return;
        }

        // ★ 여기서도 네 UserDTO의 PK 메서드 이름에 맞게 수정해야 함
        int userId = loginUser.getUserId();   // 예: getUser_no(), getStudentId() 등

        // 2. 파라미터 받기
        String idParam = request.getParameter("reservationId");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(cpath + "/myReservations?cancel=0");
            return;
        }
        int reservationId = Integer.parseInt(idParam);

        // 3. DAO 호출해서 취소 처리
        boolean ok = reservationDao.cancelReservation(reservationId, userId);

        // 4. 결과에 따라 내 예약 페이지로 리다이렉트
        if (ok) {
            response.sendRedirect(cpath + "/myReservations?cancel=1");
        } else {
            response.sendRedirect(cpath + "/myReservations?cancel=0");
        }
    }
}
