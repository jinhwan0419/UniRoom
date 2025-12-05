package com.club.controller;

import com.club.dao.RoomDAO;
import com.club.dto.RoomDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/rooms")
public class AdminRoomListServlet extends HttpServlet {

    private RoomDAO roomDao = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<RoomDTO> roomList = roomDao.findAll();
        System.out.println("[AdminRoomListServlet] roomList size = " + roomList.size());

        request.setAttribute("roomList", roomList);
        request.getRequestDispatcher("/adminRooms.jsp").forward(request, response);
    }
}

