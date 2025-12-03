package com.club.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
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
 *  - 기본 탭: 오늘(view=today)
 *  - 상단 추천 공간(인기 방)
 *  - 날짜 / 동아리 / 시간 선택 드롭다운에 들어갈 데이터 세팅
 */
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // RoomDAO는 여러 번 쓸 거라 필드로 하나 만들어둠
    private RoomDAO roomDAO = new RoomDAO();

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

        // 2. 어떤 탭인지(view 파라미터) - 기본값: today
        //    예: today / week / my / club
        String view = request.getParameter("view");
        if (view == null || view.isEmpty()) {
            view = "today";
        }

        // 3. 오늘 날짜 (JSP에서 표시용)
        LocalDate today = LocalDate.now();
        request.setAttribute("today", today);
        request.setAttribute("view", view);

        // 4. 추천 공간(인기 방 Top N) 조회
        List<RoomDTO> popularRooms = roomDAO.findPopularRooms(5); // Top 5
        request.setAttribute("popularRooms", popularRooms);

        // 5. 날짜 선택용 리스트 (오늘 포함 7일치)
        List<String> dateList = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            LocalDate d = today.plusDays(i);
            dateList.add(d.toString());   // "yyyy-MM-dd" 형식
        }
        request.setAttribute("dateList", dateList);

        // 6. 동아리 선택용 방 목록 (rooms 테이블 전체)
        List<RoomDTO> roomList = roomDAO.findAllRooms();
        request.setAttribute("roomList", roomList);

        // 7. 시간 선택용 리스트 (예: 09:00 ~ 21:00, 1시간 단위)
        List<String> timeList = new ArrayList<>();
        for (int h = 9; h <= 21; h++) {
            timeList.add(String.format("%02d:00", h));
        }
        request.setAttribute("timeList", timeList);

        // TODO: 나중에 view 값이 "week" / "my" / "club" 일 때
        //       주간 예약 데이터, 내 예약 데이터 등을 여기서 추가로 세팅해주면 됨.

        // 8. home.jsp로 포워딩
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 지금은 GET과 동일하게 동작
        doGet(request, response);
    }
}
