package com.club.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.club.dao.RoomDAO;
import com.club.dto.RoomDTO;
import com.club.dto.UserDTO;

@WebServlet("/home")
public class UserHomeServlet extends HttpServlet {   // 🔥 클래스 이름 UserHomeServlet 으로!

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserDTO loginUser = (session != null) ? (UserDTO) session.getAttribute("loginUser") : null;

        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // ---- 필터 파라미터 처리 ----
        String reserveDate = request.getParameter("reserveDate");
        String startTime   = request.getParameter("startTime");
        String clubIdParam = request.getParameter("clubId");

        int userClubId = loginUser.getClubId();
        Integer clubId;

        if (clubIdParam != null && !clubIdParam.trim().isEmpty()) {
            try {
                clubId = Integer.parseInt(clubIdParam);
            } catch (NumberFormatException e) {
                clubId = userClubId;
            }
        } else {
            clubId = userClubId;
        }

        if (reserveDate == null || reserveDate.trim().isEmpty()) {
            reserveDate = LocalDate.now().toString();
        }
        if (startTime == null) {
            startTime = "";
        }

        // ---- 방 목록 조회 ----
        RoomDAO roomDAO = new RoomDAO();
        List<RoomDTO> allRooms = roomDAO.findByClubId(clubId);

        List<RoomDTO> popularRooms = allRooms;

        // JSP에 전달
        request.setAttribute("reserveDate", reserveDate);
        request.setAttribute("startTime", startTime);
        request.setAttribute("clubId", clubId);
        request.setAttribute("allRooms", allRooms);
        request.setAttribute("popularRooms", popularRooms);

        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }
}
