package com.club.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.club.dao.ReservationDAO;
import com.club.dao.RoomDAO;
import com.club.dto.ReservationDTO;
import com.club.dto.RoomDTO;
import com.club.dto.UserDTO;

@WebServlet("/ReservationServlet")
public class ReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ReservationServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String cpath = request.getContextPath();

        // 1. 로그인 체크
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect(cpath + "/login.jsp");
            return;
        }
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

        // 2. 파라미터 받기
        String roomIdParam = request.getParameter("roomId");
        String reserveDate = request.getParameter("reserveDate");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");

        int roomId = 0;
        try {
            roomId = Integer.parseInt(roomIdParam);
        } catch (Exception e) {
            roomId = 0;
        }

        // 3. 기본 유효성 검사 (Java 8용: isBlank 대신 직접 체크)
        if (roomId == 0 ||
            isNullOrBlank(reserveDate) ||
            isNullOrBlank(startTime) ||
            isNullOrBlank(endTime)) {

            request.setAttribute("errorMsg", "예약 정보가 올바르지 않습니다.");
            request.getRequestDispatcher("/reservation.jsp?roomId=" + roomId)
                   .forward(request, response);
            return;
        }

        // 4. 동아리 제한 로직 (자기 동아리 방만 예약 가능)
        try {
            RoomDAO roomDAO = new RoomDAO();
            RoomDTO room = roomDAO.findById(roomId);

            if (room == null) {
                request.setAttribute("errorMsg", "존재하지 않는 방입니다.");
                request.getRequestDispatcher("/reservation.jsp?roomId=" + roomId)
                       .forward(request, response);
                return;
            }

            // ★ 핵심: 방의 clubId와 유저의 clubId가 같아야 예약 가능
            if (room.getClubId() != loginUser.getClubId()) {
                request.setAttribute("errorMsg", "자신의 동아리 방만 예약할 수 있습니다.");
                request.getRequestDispatcher("/reservation.jsp?roomId=" + roomId)
                       .forward(request, response);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "방 정보를 확인하는 중 오류가 발생했습니다.");
            request.getRequestDispatcher("/reservation.jsp?roomId=" + roomId)
                   .forward(request, response);
            return;
        }

        // 5. DTO에 담기
        ReservationDTO reservation = new ReservationDTO();

        int userId = loginUser.getUser_id();  // UserDTO에 맞게 사용
        reservation.setUser_id(userId);
        reservation.setRoom_id(roomId);
        reservation.setReserve_date(reserveDate);
        reservation.setStart_time(startTime);
        reservation.setEnd_time(endTime);

        // 6. DB 저장
        ReservationDAO reservationDAO = new ReservationDAO();
        int result = reservationDAO.insertReservation(reservation);

        if (result > 0) {
            // 성공 시 마이페이지나 목록으로 이동
            response.sendRedirect(cpath + "/mypage.jsp");
        } else {
            request.setAttribute("errorMsg", "예약 저장에 실패했습니다. 다시 시도해 주세요.");
            request.getRequestDispatcher("/reservation.jsp?roomId=" + roomId)
                   .forward(request, response);
        }
    }

    // Java 8용 문자열 공백 체크 유틸
    private boolean isNullOrBlank(String s) {
        return (s == null || s.trim().isEmpty());
    }
}
