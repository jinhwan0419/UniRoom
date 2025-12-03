package com.club.controller;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.List;

import com.club.dao.RoomDAO;
import com.club.dao.ReservationDAO;
import com.club.dto.RoomDTO;
import com.club.dto.ReservationDTO;

@WebServlet("/roomDetail")
public class RoomDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private RoomDAO roomDAO = new RoomDAO();
    private ReservationDAO reservationDAO = new ReservationDAO();

    public RoomDetailServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. 어떤 방인지 (roomId) 필수
        String roomIdParam = request.getParameter("roomId");
        if (roomIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "roomId가 필요합니다.");
            return;
        }
        int roomId = Integer.parseInt(roomIdParam);

        // 2. 기준 날짜 (없으면 오늘)
        String dateParam = request.getParameter("date");   // yyyy-MM-dd
        LocalDate baseDate = (dateParam == null || dateParam.isEmpty())
                           ? LocalDate.now()
                           : LocalDate.parse(dateParam);

        // 3. 주간 범위 계산 (월요일~일요일 식으로 잡고 싶으면 여기서 조정)
        LocalDate weekStart = baseDate.minusDays(baseDate.getDayOfWeek().getValue() - 1); // 월요일
        LocalDate weekEnd   = weekStart.plusDays(6); // 일요일

        Date sqlWeekStart = Date.valueOf(weekStart);
        Date sqlWeekEnd   = Date.valueOf(weekEnd);
        Date sqlSelected  = Date.valueOf(baseDate);

        // 4. 방 정보
        RoomDTO room = roomDAO.findById(roomId);
        if (room == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "해당 방을 찾을 수 없습니다.");
            return;
        }

        // 5. 주간 예약 목록
        List<ReservationDTO> weekReservations =
                reservationDAO.findByRoomAndWeek(roomId, sqlWeekStart, sqlWeekEnd);

        // 6. 선택한 날짜 예약 목록 (타임테이블용)
        List<ReservationDTO> dayReservations =
                reservationDAO.findByRoomAndDate(roomId, sqlSelected);

        // 7. JSP에서 사용할 데이터 세팅
        request.setAttribute("room", room);
        request.setAttribute("weekReservations", weekReservations);
        request.setAttribute("dayReservations", dayReservations);
        request.setAttribute("selectedDate", baseDate.toString()); // yyyy-MM-dd
        request.setAttribute("weekStart", weekStart.toString());
        request.setAttribute("weekEnd", weekEnd.toString());

        // room_detail.jsp로 포워드
        request.getRequestDispatcher("/room_detail.jsp").forward(request, response);
    }
}
