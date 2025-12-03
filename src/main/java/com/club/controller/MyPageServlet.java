package com.club.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.club.dao.UserDAO;
import com.club.dao.ReservationDAO;
import com.club.dto.UserDTO;
import com.club.dto.ReservationDTO;

@WebServlet("/profile")
public class MyPageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 패널티 제한 기준 (예: 10점 이상이면 예약 제한)
    private static final int PENALTY_LIMIT = 10;

    private UserDAO userDAO = new UserDAO();
    private ReservationDAO reservationDAO = new ReservationDAO();

    public MyPageServlet() {
        super();
    }

    // GET : 마이페이지 진입 (내 정보 + 내 예약 + 패널티 현황 조회)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // 로그인 안 되어 있으면 로그인 페이지로
        if (session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 세션에 저장된 로그인 사용자
        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        int userId = loginUser.getUser_id();   // ★ getUserId() 말고 getUser_id()

        // DB에서 최신 사용자 정보 가져오기
        UserDTO user = userDAO.findById(userId);   // ★ findByUserId가 아니라 findById

        // 내 예약 내역
        List<ReservationDTO> myReservations = reservationDAO.findByMemberId(userId);

        // 패널티 점수 & 예약 제한 여부
        int penaltyPoint = userDAO.getPenaltyPoint(userId);  // ★ this.getPenaltyPoint() 아님
        boolean isBlocked = (penaltyPoint >= PENALTY_LIMIT);

        // JSP에서 사용할 데이터 세팅
        request.setAttribute("user", user);
        request.setAttribute("myReservations", myReservations);
        request.setAttribute("penaltyPoint", penaltyPoint);
        request.setAttribute("isBlocked", isBlocked);
        request.setAttribute("penaltyLimit", PENALTY_LIMIT);

        // 마이페이지 JSP로 포워드
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }

    // POST : 개인정보 수정 (이름, 이메일만)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        int userId = loginUser.getUser_id();

        // mypage.jsp의 input name 기준
        String name = request.getParameter("name");     // 예: <input name="name">
        String email = request.getParameter("email");   // 예: <input name="email">
        // phone 컬럼이 DB에 없으니까 여기서는 안 씀

        UserDTO dto = new UserDTO();
        dto.setUser_id(userId);   // ★ setUserId() 말고 setUser_id()
        dto.setName(name);        // ★ setUserName() 말고 setName()
        dto.setEmail(email);

        int result = userDAO.updateUser(dto);

        if (result > 0) {
            // 세션에 있는 정보도 갱신
            loginUser.setName(name);
            loginUser.setEmail(email);
            session.setAttribute("loginUser", loginUser);

            // 다시 마이페이지로
            response.sendRedirect("profile");
        } else {
            request.setAttribute("errorMsg", "개인정보 수정에 실패했습니다.");
            doGet(request, response);
        }
    }
}
