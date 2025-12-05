package com.club.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.club.dao.ClubDAO;
import com.club.dao.RoomDAO;
import com.club.dao.ReservationDAO;
import com.club.dto.ClubDTO;
import com.club.dto.RoomDTO;
import com.club.dto.ReservationDTO;

@WebServlet("/user/home")
public class UserHomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ClubDAO clubDao = new ClubDAO();
    private RoomDAO roomDao = new RoomDAO();
    private ReservationDAO reservationDao = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. 동아리 목록
        List<ClubDTO> clubList = clubDao.findAllActiveClubs();
        request.setAttribute("clubList", clubList);

        // 2. 파라미터
        String dateParam = request.getParameter("date");
        String clubIdParam = request.getParameter("clubId");
        String timeParam = request.getParameter("time");

        LocalDate targetDate;
        if (dateParam == null || dateParam.isEmpty()) {
            targetDate = LocalDate.now();
        } else {
            targetDate = LocalDate.parse(dateParam); // yyyy-MM-dd
        }

        Integer clubId = null;
        if (clubIdParam != null && !clubIdParam.isEmpty()) {
            try {
                clubId = Integer.parseInt(clubIdParam);
            } catch (NumberFormatException e) {
                clubId = null;
            }
        }

        request.setAttribute("selectedDate", targetDate.toString());
        request.setAttribute("selectedClubId", clubId);
        request.setAttribute("selectedTime", timeParam);

        // 3. 방 목록
        int clubIdForRooms = (clubId != null ? clubId : 0);
        List<RoomDTO> roomList = roomDao.findRoomsByClub(clubIdForRooms);
        request.setAttribute("roomList", roomList);

        // 4. 추천 공간
        List<RoomDTO> popularRooms = roomDao.findPopularRooms(targetDate.toString(), 3);
        request.setAttribute("popularRooms", popularRooms);

        // 5. 예약 현황
        List<ReservationDTO> reservationList = new ArrayList<>();
        if (!roomList.isEmpty()) {
            List<Integer> roomIds = new ArrayList<>();
            for (RoomDTO r : roomList) roomIds.add(r.getRoom_id());
            reservationList = reservationDao.findByRoomsAndDate(roomIds, targetDate);
        }
        request.setAttribute("reservationList", reservationList);

        // 6. JSP로 포워드 (WebContent/userHome.jsp)
        request.getRequestDispatcher("/userHome.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
