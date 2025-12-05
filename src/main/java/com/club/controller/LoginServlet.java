package com.club.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.club.dao.UserDAO;
import com.club.dto.UserDTO;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDao = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String studentId = request.getParameter("studentId");  // ← name="studentId"
        String password  = request.getParameter("password");  // ← name="password"

        System.out.println("로그인 시도: " + studentId + " / " + password);

        UserDTO user = userDao.login(studentId, password);

        if (user == null) {
            request.setAttribute("errorMsg", "학번 또는 비밀번호가 올바르지 않습니다.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("loginUser", user);

        String cpath = request.getContextPath();
        response.sendRedirect(cpath + "/home");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doPost(req, resp);
    }
}
