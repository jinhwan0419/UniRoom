package com.club.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
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
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public HomeServlet() { super(); }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 0. 로그인 유저 확인 (로그인 안 돼 있으면 로그인 페이지로 보냄)
        HttpSession session = request.getSession(false);
        String cpath = request.getContextPath();
        if (session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        int userClubId = loginUser.getClubId();   // ✅ 내 동아리 ID

        // 1. 필터 파라미터 받기
        String reserveDate = request.getParameter("reserveDate");
        String startTime   = request.getParameter("startTime");
        String clubIdParam = request.getParameter("clubId");

        // 날짜 기본값: 오늘
        if (reserveDate == null || reserveDate.trim().isEmpty()) {
            reserveDate = LocalDate.now().toString();
        }

        if (startTime == null) {
            startTime = "";
        }

        // clubId: 파라미터가 없으면 "내 동아리 ID"로 고정
        int clubId = userClubId;
        try {
            if (clubIdParam != null && !clubIdParam.trim().isEmpty()) {
                clubId = Integer.parseInt(clubIdParam);
            }
        } catch (NumberFormatException e) {
            clubId = userClubId;
        }

        // 2. 방 목록 불러오기
        RoomDAO roomDAO = new RoomDAO();
        List<RoomDTO> allRooms     = roomDAO.findAllRooms();
        List<RoomDTO> popularRooms = roomDAO.findPopularRooms(3);

        // 3. 내 동아리 방만 남기기 (clubId = 내 동아리)
        List<RoomDTO> filteredAll = new ArrayList<>();
        for (RoomDTO r : allRooms) {
            if (r.getClubId() == clubId) {
                filteredAll.add(r);
            }
        }
        allRooms = filteredAll;

        List<RoomDTO> filteredPopular = new ArrayList<>();
        for (RoomDTO r : popularRooms) {
            if (r.getClubId() == clubId) {
                filteredPopular.add(r);
            }
        }
        popularRooms = filteredPopular;

        // 4. JSP로 넘길 데이터 세팅
        request.setAttribute("reserveDate",  reserveDate);
        request.setAttribute("startTime",    startTime);
        request.setAttribute("clubId",       clubId);
        request.setAttribute("popularRooms", popularRooms);
        request.setAttribute("allRooms",     allRooms);

        // 홈 화면으로
        RequestDispatcher rd = request.getRequestDispatcher("/home.jsp");
        rd.forward(request, response);
    }
}
