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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 단순히 로그인 페이지로 포워딩
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String cpath = request.getContextPath();

        String studentId = request.getParameter("studentId");
        String pw        = request.getParameter("password");

        // 1. 빈값 체크
        if (studentId == null || studentId.trim().isEmpty()
         || pw        == null || pw.trim().isEmpty()) {

            request.setAttribute("errorMsg", "학번과 비밀번호를 입력해 주세요.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // 2. DB에서 사용자 조회 (학번 + 비밀번호)
        UserDAO userDAO = new UserDAO();
        UserDTO user = userDAO.loginByStudentId(studentId, pw);  // 🔵 아래에서 구현할 메서드

        if (user == null) {
            // 로그인 실패
            request.setAttribute("errorMsg", "학번 또는 비밀번호가 올바르지 않습니다.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // 3. 로그인 성공 → 세션에 저장
        HttpSession session = request.getSession();
        session.setAttribute("loginUser", user);   // 🔵 HomeServlet이 이 이름으로 꺼냄

        System.out.println("[LoginServlet] 로그인 성공: "
                           + user.getStudent_id() + ", clubId=" + user.getClubId());

        // 4. 홈으로 이동
        response.sendRedirect(cpath + "/home");
    }
}
