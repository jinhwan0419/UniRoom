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
 * - GET  : 로그인 페이지로 이동
 * - POST : 로그인 폼 처리 (UserDAO 사용)
 */
@WebServlet("/LoginServlet")   // login.jsp에서 action="LoginServlet" 이면 OK
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    // GET: 그냥 로그인 페이지로
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect("login.jsp");
    }

    // POST: 로그인 처리
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 1. 폼에서 값 읽기
        String studentId = request.getParameter("studentId");
        String password  = request.getParameter("password");

        // 2. 비밀번호 해시 (지금은 그냥 평문 사용)
        String pwHash = password;

        // 3. DB에서 사용자 조회
        UserDAO userDAO = new UserDAO();
        UserDTO user = userDAO.login(studentId, pwHash);

        // 4. 로그인 성공 / 실패 분기
        if (user != null) {
            // 성공
            HttpSession session = request.getSession(true);

            // 기본 정보 세션에 저장
            session.setAttribute("loginId", user.getStudent_id());  // 학번
            session.setAttribute("loginName", user.getName());      // 이름
            session.setAttribute("role", user.getRole());           // 권한 (STUDENT / CLUB_LEADER / UNION_ADMIN)
            session.setAttribute("userId", user.getUser_id());      // PK (필요할 때 사용)

            // 홈으로 이동
            response.sendRedirect("home");
        } else {
            // 실패
            request.setAttribute("error", "학번 또는 비밀번호가 올바르지 않습니다.");
            request.setAttribute("studentId", studentId); // 입력했던 학번 다시 보여주기
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
