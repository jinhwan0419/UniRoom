package com.club.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * /superAdmin/* 으로 시작하는 URL은
 *  - admin
 * 만 접근 가능하게 막는 필터
 */
@WebFilter("/superAdmin/*")
public class SuperAdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        String role = null;
        if (session != null) {
            role = (String) session.getAttribute("role");
        }

        // admin만 통과
        if (role == null || !role.equals("admin")) {
            res.sendRedirect(req.getContextPath() + "/noAuth.jsp");
            return;
        }

        chain.doFilter(request, response);
    }
}
