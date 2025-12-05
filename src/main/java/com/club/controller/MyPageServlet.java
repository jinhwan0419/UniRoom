package com.club.controller;

import com.club.dto.UserDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/mypage")
public class MyPageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserDTO loginUser = (session == null) ? null : (UserDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 마이페이지에서 쓸 유저 정보 넘기기
        request.setAttribute("user", loginUser);

        // 👉 이것도 네가 만든 마이페이지 JSP 실제 경로로 고치면 됨
        request.getRequestDispatcher("/user/mypage.jsp").forward(request, response);
    }
}
