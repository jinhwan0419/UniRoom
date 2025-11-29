package com.club.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.club.dao.UserDAO;
import com.club.dto.UserDTO;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 그냥 회원가입 화면으로
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 1. 폼 값 읽기 (JSP name 값이랑 꼭 일치)
        String studentId      = request.getParameter("studentId");
        String name           = request.getParameter("name");
        String password       = request.getParameter("password");
        String passwordCheck  = request.getParameter("passwordCheck");
        String clubId         = request.getParameter("clubId");   // 지금은 안 씀 (TODO)
        String email          = null; // 현재 JSP에 이메일 필드 없으니까 일단 null

        // 디버깅용
        System.out.println("[RegisterServlet] studentId = " + studentId);
        System.out.println("[RegisterServlet] name      = " + name);
        System.out.println("[RegisterServlet] clubId    = " + clubId);

        // 2. 비밀번호 확인 체크
        if (password == null || !password.equals(passwordCheck)) {
            request.setAttribute("error", "비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 3. 학번 중복 체크
        UserDAO userDAO = new UserDAO();
        if (userDAO.existsByStudentId(studentId)) {
            request.setAttribute("error", "이미 가입된 학번입니다.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 4. DTO에 값 채우기
        UserDTO dto = new UserDTO();
        dto.setStudent_id(studentId);
        dto.setName(name);
        dto.setEmail(email);              // null 가능
        dto.setPw_hash(password);         // TODO: 나중에 해시로 변경
        dto.setRole("member");            // enum('admin','lead','manager','member') 중 하나
        dto.setIs_active(1);

        // 5. DB INSERT
        int result = userDAO.insert(dto);
        System.out.println("[RegisterServlet] insert result = " + result);

        if (result == 1) {
            // 성공 → 로그인 페이지로
            response.sendRedirect("login.jsp");
        } else {
            // 실패 → 다시 폼으로
            request.setAttribute("error", "회원가입에 실패했습니다. 잠시 후 다시 시도해주세요.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
