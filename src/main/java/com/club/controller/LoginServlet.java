package com.club.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.club.dao.UserDAO;
import com.club.dto.UserDTO;

/**
 * 로그인 처리용 서블릿
 *  - GET : 로그아웃 처리 후 로그인 페이지로 이동
 *  - POST : 로그인 처리
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDAO userDAO = new UserDAO();

    public LoginServlet() {
        super();
    }

    /**
     * GET : 로그아웃 후 로그인 페이지로 이동
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // 세션 종료 = 로그아웃
        }

        response.sendRedirect("login.jsp");
    }

    /**
     * POST : 로그인 처리
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 1. 폼 데이터
        String studentId = request.getParameter("studentId");
        String password = request.getParameter("password");

        // 2. 현재는 비밀번호 평문 → 나중에 암호화 변경 가능
        String pwHash = password;

        // 3. 로그인 검증
        UserDTO user = userDAO.login(studentId, pwHash);

        // 4. 성공/실패 처리
        if (user != null) {
            // ===== 로그인 성공 =====
            HttpSession session = request.getSession(true);

            // 통째로 저장
            session.setAttribute("loginUser", user);

            // 개별 정보 저장
            session.setAttribute("loginId", user.getStudent_id());
            session.setAttribute("loginName", user.getName());
            session.setAttribute("role", user.getRole());
            session.setAttribute("userId", user.getUser_id());

            // ★ 역할 분기 시작
            String role = user.getRole();

            if ("admin".equals(role)) {
                // 총동아리연합회 관리자
                response.sendRedirect("superAdmin/main.jsp");
                return;
            } 
            else if ("manager".equals(role) || "lead".equals(role)) {
                // 동아리 회장 (보조 관리자)
                response.sendRedirect("clubAdmin/main.jsp");
                return;
            } 
            else {
                // 일반 사용자
                response.sendRedirect("home");
                return;
            }

        } else {
            // ===== 로그인 실패 =====
            request.setAttribute("error", "학번 또는 비밀번호가 올바르지 않습니다.");
            request.setAttribute("studentId", studentId); // 입력 값 유지
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
