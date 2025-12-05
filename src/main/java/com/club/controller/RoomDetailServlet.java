package com.club.controller;

import com.club.dto.TimeSlotDTO;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.club.dao.RoomDAO;
import com.club.dao.ReservationDAO;
import com.club.dto.RoomDTO;
import com.club.dto.TimeSlotDTO;

@WebServlet("/room/detail")
public class RoomDetailServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RoomDAO roomDao = new RoomDAO();
    private ReservationDAO reservationDao = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String roomIdParam = request.getParameter("roomId");
        String dateParam   = request.getParameter("date");

        if (roomIdParam == null || roomIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/home");
            return;
        }

        int roomId = Integer.parseInt(roomIdParam);

        LocalDate date;
        if (dateParam == null || dateParam.trim().isEmpty()) {
            date = LocalDate.now();
        } else {
            date = LocalDate.parse(dateParam); // yyyy-MM-dd
        }

        RoomDTO room = roomDao.findById(roomId);
        List<TimeSlotDTO> timeSlots = reservationDao.getTimeSlotsByRoomAndDate(roomId, date);

        request.setAttribute("room", room);
        request.setAttribute("date", date.toString());
        request.setAttribute("timeSlots", timeSlots);

        request.getRequestDispatcher("/room_detail.jsp")
        .forward(request, response);

    }
}
