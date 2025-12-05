package com.club.controller;

import com.club.dao.RoomDAO;
import com.club.dto.RoomDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/room/new")
public class AdminRoomCreateServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private RoomDAO roomDao = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 그냥 등록 폼으로 forward
        request.getRequestDispatcher("/adminRoomForm.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name        = request.getParameter("name");
        String location    = request.getParameter("location");
        String capacityStr = request.getParameter("capacity");
        String openStr     = request.getParameter("open_time");   // "09:00"
        String closeStr    = request.getParameter("close_time");  // "22:00"
        String slotStr     = request.getParameter("slot_minutes");
        String desc        = request.getParameter("description");
        String clubIdStr   = request.getParameter("club_id");

        int capacity = (capacityStr == null || capacityStr.isEmpty())
                ? 0 : Integer.parseInt(capacityStr);

        // slot_minutes / description 은 나중에 테이블에 추가할 때 쓰고
        // 일단은 DTO 안에만 저장해 둠
        int slotMinutes = (slotStr == null || slotStr.isEmpty())
                ? 60 : Integer.parseInt(slotStr);

        RoomDTO room = new RoomDTO();
        room.setName(name);
        room.setLocation(location);
        room.setCapacity(capacity);
        room.setSlot_minutes(slotMinutes);
        room.setDescription(desc);
        room.setActive(true);

        // 문자열 -> Time (RoomDTO가 "09:00" → "09:00:00" 처리)
        room.setOpen_time(openStr);
        room.setClose_time(closeStr);

        if (clubIdStr != null && !clubIdStr.isEmpty()) {
            room.setClub_id(Integer.parseInt(clubIdStr));
        }

        int result = roomDao.insertRoom(room);
        System.out.println("[AdminRoomCreateServlet] insert result = " + result);

        response.sendRedirect(request.getContextPath() + "/admin/rooms");
    }

}
