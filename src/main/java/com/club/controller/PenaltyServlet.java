package com.club.controller;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.club.dao.PenaltyDAO;
import com.club.dto.PenaltySummaryDTO;
import com.club.dto.UserDTO;

@WebServlet("/penalty")
public class PenaltyServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private PenaltyDAO penaltyDao = new PenaltyDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String cpath = request.getContextPath();

        HttpSession session = request.getSession(false);
        UserDTO loginUser = (session != null)
                ? (UserDTO) session.getAttribute("loginUser")
                : null;

        if (loginUser == null) {
            response.sendRedirect(cpath + "/login.jsp");
            return;
        }

        int userId = loginUser.getUserId();

        // 내 패널티 요약 정보
        PenaltySummaryDTO summary = penaltyDao.findByUserId(userId);

        boolean isBlocked = false;
        if (summary != null && summary.getBlockEndDate() != null) {
            LocalDate today = LocalDate.now();
            isBlocked = !summary.getBlockEndDate().isBefore(today); // blockEnd >= today 면 제한 중
        }

        request.setAttribute("penaltySummary", summary);
        request.setAttribute("isBlocked", isBlocked);

        request.getRequestDispatcher("/penalty.jsp").forward(request, response);
    }
}
