package com.club.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 로그인 처리용 서블릿
 * - GET  : 로그인 페이지로 이동
 * - POST : 로그인 폼 처리 (지금은 하드코딩, 나중에 UserDAO로 교체 예정)
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    /**
     * GET 요청이 들어오면 그냥 로그인 페이지로 보내기
     * 예) /LoginServlet 직접 치고 들어오는 경우
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect("login.jsp");
    }

    /**
     * 로그인 폼 처리 (POST)
     * 1. 파라미터 읽기 (studentId, password)
     * 2. 하드코딩으로 아이디/비번 체크
     * 3. 성공 -> 세션에 정보 저장 후 home으로 이동
     * 4. 실패 -> 에러메시지와 함께 다시 login.jsp로 포워딩
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 1. 로그인 폼에서 보낸 값 읽기
        String studentId = request.getParameter("studentId");
        String password  = request.getParameter("password");

        // 2. 하드코딩 계정 (나중에 UserDAO로 교체)
        boolean loginOk = false;
        String userName = null;   // 화면에서 쓸 사용자 이름(선택사항)

        // 예시 계정 1
        if ("20250001".equals(studentId) && "1234".equals(password)) {
            loginOk = true;
            userName = "테스트1";
        }
        // 예시 계정 2 (원하면 팀원 학번/이름으로 바꿔서 추가)
        else if ("20250002".equals(studentId) && "1234".equals(password)) {
            loginOk = true;
            userName = "테스트2";
        }

        // 3. 로그인 성공 처리
        if (loginOk) {
            // 세션 가져오기 (없으면 새로 생성)
            HttpSession session = request.getSession(true);

            // HomeServlet에서 쓰는 세션 키와 맞춰줌
            session.setAttribute("loginId", studentId);   // 로그인한 학번
            session.setAttribute("loginName", userName);  // 이름(선택)

            // TODO: 나중에 여기서 마지막 로그인 시간, 권한(role) 등 추가 가능

            // 홈 화면으로 이동
            response.sendRedirect("home");
        }
        // 4. 로그인 실패 처리
        else {
            // 에러 메시지와, 사용자가 입력한 학번을 다시 실어보냄
            request.setAttribute("error", "학번 또는 비밀번호가 올바르지 않습니다.");
            request.setAttribute("studentId", studentId);

            // 다시 로그인 페이지로 포워딩 (URL은 그대로 /LoginServlet 이지만 화면은 login.jsp)
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
