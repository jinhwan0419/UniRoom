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

/**
 * 홈 화면 컨트롤러
 * - 로그인 체크
 * - DB에서 방 목록, 인기 방 목록 조회
 * - home.jsp로 데이터 전달
 */
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // DAO 객체(필요하면 생성자에서 받아서 써도 되지만 지금은 단순하게)
    private RoomDAO roomDAO = new RoomDAO();

    public HomeServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 1. 로그인 여부 체크 (세션에 loginId가 있다고 가정)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginId") == null) {
            // 로그인이 안 되어 있으면 로그인 페이지로 보냄
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. 날짜 파라미터 처리 (필터로 쓸 예정, 일단 오늘 날짜 기본값)
        String dateParam = request.getParameter("date");
        LocalDate selectedDate;

        if (dateParam == null || dateParam.isEmpty()) {
            selectedDate = LocalDate.now();
        } else {
            // 날짜 형식: 2025-11-29 이런 식이라고 가정
            selectedDate = LocalDate.parse(dateParam);
        }

        // 3. 방 목록 / 인기 방 목록 조회
        // 전체 방 목록 (동아리방 리스트)
        List<RoomDTO> rooms = roomDAO.findAllRooms();

        // 인기 방 Top 5 (예약 수 기준, RoomDAO에서 구현)
        List<RoomDTO> popularRooms = roomDAO.findPopularRooms(5);

        // 4. JSP에서 사용할 데이터 setAttribute
        request.setAttribute("rooms", rooms);                 // 전체 방 리스트
        request.setAttribute("popularRooms", popularRooms);   // 인기 방 리스트
        request.setAttribute("selectedDate", selectedDate);   // 선택된 날짜 (오늘 기본)

        // 5. home.jsp로 포워딩
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // POST 요청도 동일하게 처리 (필터 폼 submit용으로 활용 가능)
        doGet(request, response);
    }
}
