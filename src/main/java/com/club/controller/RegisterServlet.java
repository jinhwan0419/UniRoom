package com.club.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.club.dao.UserDAO;
import com.club.dto.UserDTO;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDao = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String cpath = request.getContextPath();

        String studentId = request.getParameter("studentId");
        String name      = request.getParameter("name");
        String password  = request.getParameter("password");
        String confirm   = request.getParameter("confirmPassword");
        String clubIdStr = request.getParameter("clubId");
        String role      = request.getParameter("role");  // USER / ADMIN 등

        // 기본 검증
        if (studentId == null || studentId.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || name == null || name.trim().isEmpty()
                || confirm == null || !password.equals(confirm)) {

            request.setAttribute("errorMsg", "학번이 비어 있거나 비밀번호 확인이 일치하지 않습니다.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        int clubId = 0;
        try {
            clubId = Integer.parseInt(clubIdStr);
        } catch (Exception e) {
            clubId = 0;
        }

        // DTO 구성
        UserDTO dto = new UserDTO();
        dto.setStudentId(studentId);
        dto.setName(name);
        dto.setPassword(password);
        dto.setClubId(clubId);
        dto.setRole(role != null ? role : "USER");

        int result = userDao.insertUser(dto);   // ← 반환값을 int로 받기

        if (result <= 0) {   // 0 이면 실패, 1 이상이면 성공이라고 가정
            request.setAttribute("errorMsg", "회원가입에 실패했습니다. (중복 학번 또는 서버 오류)");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        } else {
            response.sendRedirect(cpath + "/login.jsp");
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/register.jsp");
    }
}
