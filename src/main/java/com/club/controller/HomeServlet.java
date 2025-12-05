package com.club.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.club.dao.RoomDAO;
import com.club.dao.ReservationDAO;
import com.club.dto.RoomDTO;
import com.club.dto.ReservationDTO;
import com.club.dto.UserDTO;

/**
 * 홈 화면 서블릿
 * - 선배가 만든 home.jsp UI를 그대로 쓰면서
 *   날짜/동아리별 방 목록 + 시간대별 예약 현황(타임테이블) 데이터 제공
 */
@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RoomDAO roomDao = new RoomDAO();
    private ReservationDAO reservationDao = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        UserDTO loginUser = (session != null)
                ? (UserDTO) session.getAttribute("loginUser")
                : null;

        int userClubId = (loginUser != null) ? loginUser.getClubId() : 0;

        // ===== 1. 파라미터 받기 =====
        String dateParam      = request.getParameter("reserveDate");
        String startTimeParam = request.getParameter("startTime");
        String clubIdParam    = request.getParameter("clubId");

        LocalDate targetDate;
        if (dateParam == null || dateParam.trim().isEmpty()) {
            targetDate = LocalDate.now();
        } else {
            targetDate = LocalDate.parse(dateParam);  // yyyy-MM-dd 가정
        }

        int clubId = userClubId;
        if (clubIdParam != null && !clubIdParam.isEmpty()) {
            try {
                clubId = Integer.parseInt(clubIdParam);
            } catch (NumberFormatException e) {
                // 잘못 들어오면 그냥 내 동아리로
                clubId = userClubId;
            }
        }

        String reserveDateStr = targetDate.toString();
        String startTime = (startTimeParam != null) ? startTimeParam : "";

        // JSP에서 쓸 값 그대로 세팅
        request.setAttribute("reserveDate", reserveDateStr);
        request.setAttribute("startTime", startTime);
        request.setAttribute("clubId", Integer.valueOf(clubId));

        // ===== 2. 내 동아리 방 목록(allRooms) =====
        List<RoomDTO> allRooms = new ArrayList<>();
        if (clubId > 0) {
            allRooms = roomDao.findByClubId(Integer.valueOf(clubId));
        }
        request.setAttribute("allRooms", allRooms);

        // ===== 3. 추천 공간(popularRooms) – 오늘 기준 상위 3개 =====
        List<RoomDTO> popularRooms = roomDao.findPopularRooms(reserveDateStr, 3);
        request.setAttribute("popularRooms", popularRooms);

        // ===== 4. 타임테이블용 예약 데이터 =====
        Map<Integer, List<ReservationDTO>> roomReservationMap = new HashMap<>();

        if (!allRooms.isEmpty()) {
            List<Integer> roomIds = new ArrayList<>();
            for (RoomDTO r : allRooms) {
                roomIds.add(r.getRoom_id());
            }

            // 해당 날짜 + 해당 방들에 대한 예약 전체 조회
            List<ReservationDTO> dayReservations =
                    reservationDao.findByRoomsAndDate(roomIds, targetDate);

            for (ReservationDTO rsv : dayReservations) {
                int roomId = rsv.getRoom_id();
                roomReservationMap
                        .computeIfAbsent(roomId, k -> new ArrayList<>())
                        .add(rsv);
            }
        }

        // JSP에서 방별로 꺼낼 수 있도록 맵으로 전달
        request.setAttribute("roomReservationMap", roomReservationMap);

        // ===== 5. JSP로 전달 =====
        RequestDispatcher rd = request.getRequestDispatcher("/home.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
