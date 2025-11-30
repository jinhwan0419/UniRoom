package com.club.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.club.dao.ReservationDAO;
import com.club.dto.ReservationDTO;

@WebServlet("/reservation")
public class ReservationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                listMyReservations(request, response);
                break;
            case "cancel":
                cancelReservation(request, response);
                break;
            case "form":
                showReserveForm(request, response);
                break;
            default:
                listMyReservations(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "insert":
                insertReservation(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/home");
                break;
        }
    }

    // 세션에서 userId 얻기 + 로그인 체크
    private Integer getLoginUserId(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return null;
        }
        Object uid = session.getAttribute("userId");
        if (uid == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return null;
        }
        return (Integer) uid;
    }

    // ▶ 예약 폼 보여주기
    private void showReserveForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer memberId = getLoginUserId(request, response);
        if (memberId == null) return; // 로그인 안 된 경우 이미 redirect 됨

        // 여기서 roomId, 날짜 같은 파라미터 그대로 JSP에 넘김
        request.getRequestDispatcher("reservation.jsp")
               .forward(request, response);
    }

    // ▶ 내 예약 목록 조회
    private void listMyReservations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer memberId = getLoginUserId(request, response);
        if (memberId == null) return;

        List<ReservationDTO> list = reservationDAO.findByMemberId(memberId);
        request.setAttribute("reservations", list);

        request.getRequestDispatcher("myReservations.jsp")
               .forward(request, response);
    }

    // ▶ 예약 등록
    private void insertReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer memberId = getLoginUserId(request, response);
        if (memberId == null) return;

        try {
            request.setCharacterEncoding("UTF-8");

            int roomId = Integer.parseInt(request.getParameter("roomId"));

            Date reserveDate = Date.valueOf(request.getParameter("reserveDate"));
            Time startTime = Time.valueOf(request.getParameter("startTime") + ":00");
            Time endTime   = Time.valueOf(request.getParameter("endTime") + ":00");

            boolean duplicated = reservationDAO.isDuplicated(roomId, reserveDate, startTime, endTime);
            if (duplicated) {
                request.setAttribute("error", "이미 해당 시간에 예약이 존재합니다.");
                request.getRequestDispatcher("reservation.jsp")
                       .forward(request, response);
                return;
            }

            ReservationDTO dto = new ReservationDTO();
            dto.setMemberId(memberId);
            dto.setRoomId(roomId);
            dto.setReserveDate(reserveDate);
            dto.setStartTime(startTime);
            dto.setEndTime(endTime);

            int result = reservationDAO.insert(dto);

            if (result == 1) {
                response.sendRedirect(request.getContextPath() + "/reservation?action=list");
            } else {
                request.setAttribute("error", "예약 저장에 실패했습니다.");
                request.getRequestDispatcher("reservation.jsp")
                       .forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "예약 처리 중 오류가 발생했습니다.");
            request.getRequestDispatcher("reservation.jsp")
                   .forward(request, response);
        }
    }

    // ▶ 예약 취소
    private void cancelReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer memberId = getLoginUserId(request, response);
        if (memberId == null) return;

        int reservationId = Integer.parseInt(request.getParameter("id"));

        reservationDAO.cancel(reservationId, memberId);

        response.sendRedirect(request.getContextPath() + "/reservation?action=list");
    }
}
