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
import com.club.util.SHA256;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String studentId = request.getParameter("student_id");
        String password = request.getParameter("password");
        String pwHash = SHA256.hash(password);

        UserDAO userDAO = new UserDAO();
        UserDTO user = userDAO.login(studentId, pwHash);

        if (user == null) {
            request.setAttribute("error", "학번 또는 비밀번호가 올바르지 않습니다.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("loginUser", user);

        // 👉 지금은 그냥 사용자 홈으로 보낸다
        response.sendRedirect(request.getContextPath() + "/home");
    }
}
