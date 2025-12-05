package com.club.controller;

import com.club.dao.RoomDAO;
import com.club.dto.RoomDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/room/edit")
public class AdminRoomEditServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private RoomDAO roomDao = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String roomIdStr = request.getParameter("roomId");
        if (roomIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/rooms");
            return;
        }

        int roomId = Integer.parseInt(roomIdStr);
        RoomDTO room = roomDao.findById(roomId);
        if (room == null) {
            response.sendRedirect(request.getContextPath() + "/admin/rooms");
            return;
        }

        request.setAttribute("room", room);
        request.getRequestDispatcher("/adminRoomEdit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        int roomId = Integer.parseInt(request.getParameter("room_id"));
        String capacityStr = request.getParameter("capacity");
        String openStr     = request.getParameter("open_time");
        String closeStr    = request.getParameter("close_time");
        String slotStr     = request.getParameter("slot_minutes");
        String desc        = request.getParameter("description");

        int capacity    = (capacityStr == null || capacityStr.isEmpty()) ? 0 : Integer.parseInt(capacityStr);
        int slotMinutes = (slotStr == null || slotStr.isEmpty()) ? 60 : Integer.parseInt(slotStr);

        RoomDTO room = roomDao.findById(roomId);
        if (room == null) {
            response.sendRedirect(request.getContextPath() + "/admin/rooms");
            return;
        }

        room.setCapacity(capacity);
        room.setSlot_minutes(slotMinutes);
        room.setDescription(desc);
        room.setOpen_time(openStr);     // RoomDTO가 문자열→Time으로 변환해 줌
        room.setClose_time(closeStr);

        int result = roomDao.updateBasicInfo(room);
        System.out.println("[AdminRoomEditServlet] update result = " + result);

        response.sendRedirect(request.getContextPath() + "/admin/rooms");
    }
}
