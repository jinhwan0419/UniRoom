package com.club.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.club.dao.ClubDAO;
import com.club.dao.RoomDAO;
import com.club.dto.ClubDTO;
import com.club.dto.RoomDTO;
import com.club.dto.UserDTO;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminDashboardServlet() {
        super();
    }

    // GET : 관리자 대시보드 화면 열기
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String cpath = request.getContextPath();

        // 1. 로그인 + 권한 체크 (총동연만 접근)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect(cpath + "/login.jsp");
            return;
        }

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        String role = loginUser.getRole();

        // DB 기준 role 매핑:
        // member  → 일반 사용자
        // admin   → 총동연(최상위 관리자)
        // manager → 동아리 회장 (보조 관리자)

        // 🔵 총동연만 접근 허용하고 싶으면:
        if (role == null || !role.equalsIgnoreCase("admin")) {
            // role이 null 이거나 'admin' 이 아니면 접근 불가
            response.sendRedirect(cpath + "/home");
            return;
        }


        // 2. 동아리 / 방 목록 불러오기
        ClubDAO clubDAO = new ClubDAO();
        RoomDAO roomDAO = new RoomDAO();

        List<ClubDTO> clubs = clubDAO.findAll();      // 모든 동아리
        List<RoomDTO> rooms = roomDAO.findAllRooms(); // 모든 방

        request.setAttribute("clubs", clubs);
        request.setAttribute("rooms", rooms);

        // POST 이후 redirect로 넘어온 메시지 처리
        String msg = request.getParameter("msg");
        if (msg != null && !msg.isEmpty()) {
            request.setAttribute("msg", msg);
        }

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/adminDashboard.jsp");
        rd.forward(request, response);
    }

    // POST : 동아리 등록 or 방 등록 처리
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String cpath = request.getContextPath();

        String action = request.getParameter("action");  // "createClub" / "createRoom"
        String msg = "ok";

        try {
            if ("createClub".equals(action)) {
                // === 동아리 등록 ===
                String name = request.getParameter("clubName");

                if (name == null || name.trim().isEmpty()) {
                    msg = "동아리 이름은 필수입니다.";
                } else {
                    ClubDTO club = new ClubDTO();
                    club.setName(name);
                    club.setIs_active(1);   // 기본값: 활성 동아리

                    ClubDAO clubDAO = new ClubDAO();
                    int result = clubDAO.insert(club);   // ⚠ 기존에 있던 insert() 사용

                    if (result == 0) {
                        msg = "동아리 등록에 실패했습니다.";
                    } else {
                        msg = "동아리가 성공적으로 등록되었습니다.";
                    }
                }

            } else if ("createRoom".equals(action)) {
                // === 동아리 방 등록 ===
                String roomName    = request.getParameter("roomName");
                String capacityStr = request.getParameter("capacity");
                String location    = request.getParameter("location");
                String clubIdStr   = request.getParameter("clubId");

                int clubId = 0;
                int capacity = 0;

                try {
                    clubId = Integer.parseInt(clubIdStr);
                    capacity = Integer.parseInt(capacityStr);
                } catch (NumberFormatException e) {
                    msg = "정원 또는 동아리 ID가 잘못되었습니다.";
                }

                if (roomName == null || roomName.trim().isEmpty()) {
                    msg = "방 이름은 필수입니다.";
                } else if (clubId == 0) {
                    msg = "동아리를 선택해 주세요.";
                } else if ("정원 또는 동아리 ID가 잘못되었습니다.".equals(msg)) {
                    // 위에서 이미 메시지 세팅됨 → 그대로 유지
                } else {
                    RoomDTO room = new RoomDTO();
                    room.setRoom_name(roomName);
                    room.setCapacity(capacity);
                    room.setLocation(location);
                    room.setClubId(clubId);

                    RoomDAO roomDAO = new RoomDAO();
                    int result = roomDAO.insertRoom(room);

                    if (result == 0) {
                        msg = "동아리 방 등록에 실패했습니다.";
                    } else {
                        msg = "동아리 방이 성공적으로 등록되었습니다.";
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            msg = "오류가 발생했습니다.";
        }

        // 다시 대시보드로 리다이렉트 (메시지 전달)
        response.sendRedirect(
            cpath + "/admin/dashboard?msg=" + URLEncoder.encode(msg, "UTF-8")
        );
    }
}
