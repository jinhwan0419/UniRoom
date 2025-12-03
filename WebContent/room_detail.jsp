<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.club.dto.RoomDTO" %>
<%@ page import="com.club.dto.ReservationDTO" %>
<%@ page import="java.util.List" %>

<%
    RoomDTO room = (RoomDTO) request.getAttribute("room");
    List<ReservationDTO> weekReservations = (List<ReservationDTO>) request.getAttribute("weekReservations");
    List<ReservationDTO> dayReservations  = (List<ReservationDTO>) request.getAttribute("dayReservations");
    String selectedDate = (String) request.getAttribute("selectedDate");
    String weekStart    = (String) request.getAttribute("weekStart");
    String weekEnd      = (String) request.getAttribute("weekEnd");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 동아리방 정보</title>

    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-900">

<!-- 상단 헤더 -->
<div class="bg-white px-4 py-3 border-b border-gray-200">
    <h1 class="text-center text-blue-600 text-lg font-medium">동아리방 정보</h1>
</div>

<div class="px-4 py-6 space-y-6">

    <!-- 1. 방 기본 정보 -->
    <div class="bg-white rounded-2xl p-4 shadow-sm border border-gray-100">
        <h2 class="text-base font-semibold mb-3"><%= room.getName() %></h2>

        <!-- note를 설명/위치 대용으로 사용 -->
        <p class="text-sm text-gray-600">
            비고: 
            <%= (room.getNote() != null && !room.getNote().isEmpty()) 
                    ? room.getNote() 
                    : "추가 정보 없음" %>
        </p>

        <p class="text-sm text-gray-600 mt-1">
            운영 시간:
            <%
                String openStr  = room.getOpen_time();   // 예: "09:00:00" 또는 "09:00"
                String closeStr = room.getClose_time();
                String openDisp  = (openStr != null && openStr.length() >= 5)  ? openStr.substring(0,5)  : "정보 없음";
                String closeDisp = (closeStr != null && closeStr.length() >= 5) ? closeStr.substring(0,5) : "정보 없음";
            %>
            <%= openDisp %> ~ <%= closeDisp %>
        </p>

        <p class="text-xs text-gray-400 mt-2">
            주간 예약 기간: <%= weekStart %> ~ <%= weekEnd %>
        </p>
    </div>

    <!-- 2. 날짜 선택 폼 -->
    <form action="<%= request.getContextPath() %>/roomDetail" method="get"
          class="bg-white rounded-2xl p-4 shadow-sm border border-gray-100 flex items-center justify-between">
        <input type="hidden" name="roomId" value="<%= room.getRoom_id() %>">

        <div>
            <label class="text-sm text-gray-600">날짜 선택</label><br>
            <input type="date" name="date" value="<%= selectedDate %>"
                   class="mt-1 border border-gray-300 rounded-lg px-3 py-1 text-sm">
        </div>

        <button type="submit"
                class="mt-4 px-4 py-2 bg-blue-600 text-white text-sm rounded-lg">
            예약 현황 보기
        </button>
    </form>

    <!-- 3. 선택한 날짜의 시간대별 타임테이블 -->
    <div class="bg-white rounded-2xl p-4 shadow-sm border border-gray-100">
        <h3 class="text-sm font-semibold mb-3">
            <%= selectedDate %> 시간대별 예약 현황
        </h3>

        <%
            // open_time / close_time이 "HH:mm" 또는 "HH:mm:ss" 기준이라고 가정
            int defaultOpenHour  = 9;
            int defaultCloseHour = 22;

            int openHour  = defaultOpenHour;
            int closeHour = defaultCloseHour;

            if (room.getOpen_time() != null && room.getOpen_time().length() >= 2) {
                try {
                    openHour = Integer.parseInt(room.getOpen_time().substring(0, 2));
                } catch (Exception e) {}
            }
            if (room.getClose_time() != null && room.getClose_time().length() >= 2) {
                try {
                    closeHour = Integer.parseInt(room.getClose_time().substring(0, 2));
                } catch (Exception e) {}
            }
        %>

        <div class="space-y-1">
            <% for (int h = openHour; h < closeHour; h++) {
                   String label = String.format("%02d:00 ~ %02d:00", h, h+1);
                   boolean reserved = false;

                   if (dayReservations != null) {
                       for (ReservationDTO r : dayReservations) {
                           int startH = r.getStartTime().toLocalTime().getHour();
                           int endH   = r.getEndTime().toLocalTime().getHour();
                           if (h >= startH && h < endH) {
                               reserved = true;
                               break;
                           }
                       }
                   }
            %>
                <div class="flex items-center justify-between px-3 py-2 rounded-lg
                            <%= reserved ? "bg-red-50" : "bg-green-50" %>">
                    <span class="text-sm font-mono"><%= label %></span>
                    <span class="text-xs font-medium
                                 <%= reserved ? "text-red-600" : "text-green-600" %>">
                        <%= reserved ? "예약됨" : "예약 가능" %>
                    </span>
                </div>
            <% } %>
        </div>
    </div>

    <!-- 4. 주간 예약 현황 (리스트) -->
    <div class="bg-white rounded-2xl p-4 shadow-sm border border-gray-100">
        <h3 class="text-sm font-semibold mb-3">주간 예약 현황</h3>

        <%
            if (weekReservations == null || weekReservations.isEmpty()) {
        %>
            <p class="text-sm text-gray-500">이번 주에는 예약이 없습니다.</p>
        <%
            } else {
        %>
            <ul class="space-y-1 text-sm">
                <% for (ReservationDTO r : weekReservations) { %>
                    <li class="flex justify-between">
                        <span><%= r.getReserveDate().toString() %></span>
                        <span>
                            <%= r.getStartTime().toString().substring(0,5) %> ~
                            <%= r.getEndTime().toString().substring(0,5) %>
                        </span>
                    </li>
                <% } %>
            </ul>
        <%
            }
        %>
    </div>

</div>

<div class="pb-10"></div>

</body>
</html>
