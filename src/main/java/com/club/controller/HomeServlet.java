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
 *  - 오늘 / 주간 / 내 예약 / 동아리 탭 중 기본은 "오늘"
 *  - 상단 추천 공간(인기 방)도 여기서 조회
 */
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public HomeServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. 로그인 세션 확인 (없으면 로그인 페이지로)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. 어떤 탭인지(view 파라미터) - 기본값 today
        String view = request.getParameter("view");
        if (view == null || view.isEmpty()) {
            view = "today";    // today / week / my / club 예상
        }

        // 3. 오늘 날짜 (JSP에서 표시용)
        LocalDate today = LocalDate.now();
        request.setAttribute("today", today);
        request.setAttribute("view", view);

        // 4. 추천 공간(인기 방 Top N) 조회
        RoomDAO roomDAO = new RoomDAO();
        List<RoomDTO> popularRooms = roomDAO.findPopularRooms(5); // Top 5
        request.setAttribute("popularRooms", popularRooms);

        // TODO: view 값에 따라 "내 예약", "주간" 데이터도 나중에 여기서 채워주면 됨

        // 5. home.jsp로 포워딩
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 지금은 GET만 사용, 필요하면 나중에 구현
        doGet(request, response);
    }
}
