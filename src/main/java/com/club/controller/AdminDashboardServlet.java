package com.club.controller;

import com.club.dto.UserDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserDTO loginUser = (session == null) ? null : (UserDTO) session.getAttribute("loginUser");

        // TODO: 나중에 권한 체크 (SUPER_ADMIN, CLUB_ADMIN) 넣기

        // 일단은 그냥 대시보드 JSP로 포워드
        request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
    }
}
