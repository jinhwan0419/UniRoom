package com.club.controller;

import com.club.dao.RoomBlockDAO;
import com.club.dao.RoomDAO;
import com.club.dto.RoomBlockDTO;
import com.club.dto.RoomDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

@WebServlet("/admin/room/blocks")
public class AdminRoomBlockServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private RoomBlockDAO blockDao = new RoomBlockDAO();
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

        List<RoomBlockDTO> blockList = blockDao.findByRoomId(roomId);

        request.setAttribute("room", room);
        request.setAttribute("blockList", blockList);
        request.getRequestDispatcher("/adminRoomBlocks.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action   = request.getParameter("action");
        int roomId      = Integer.parseInt(request.getParameter("room_id"));
        String dateStr  = request.getParameter("block_date");
        String startStr = request.getParameter("start_time");
        String endStr   = request.getParameter("end_time");
        String reason   = request.getParameter("reason");
        String blockIdStr = request.getParameter("block_id");

        if ("delete".equals(action) && blockIdStr != null) {
            int blockId = Integer.parseInt(blockIdStr);
            blockDao.deleteBlock(blockId);

        } else if ("add".equals(action)) {

            RoomBlockDTO b = new RoomBlockDTO();
            b.setRoom_id(roomId);
            b.setBlock_date(Date.valueOf(dateStr));
            // "HH:mm" → "HH:mm:00"
            b.setStart_time(Time.valueOf(startStr.length() == 5 ? startStr + ":00" : startStr));
            b.setEnd_time(Time.valueOf(endStr.length() == 5 ? endStr + ":00" : endStr));
            b.setReason(reason);

            blockDao.insertBlock(b);
        }

        response.sendRedirect(request.getContextPath() + "/admin/room/blocks?roomId=" + roomId);
    }
}
