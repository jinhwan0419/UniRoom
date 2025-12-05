<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.club.dto.ReservationDTO" %>

<%
    String cpath = request.getContextPath();
    List<ReservationDTO> list =
        (List<ReservationDTO>) request.getAttribute("reservations");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 내 예약</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <script> window.FontAwesomeConfig = { autoReplaceSvg: 'nest'};</script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;500;600;700&display=swap"
          rel="stylesheet">
    <style>
        ::-webkit-scrollbar { display: none; }
        * { font-family: 'Pretendard', sans-serif; }
    </style>
</head>
<body class="bg-gray-50 text-gray-900">

<!-- 상태바 -->
<div class="bg-black text-white text-xs py-1 px-4 flex justify-between items-center">
    <span>9:41</span>
    <div class="flex items-center space-x-1">
        <i class="fa-solid fa-signal text-xs"></i>
        <i class="fa-solid fa-wifi text-xs"></i>
        <i class="fa-solid fa-battery-three-quarters text-xs"></i>
    </div>
</div>

<!-- 상단 타이틀 -->
<header class="bg-white px-4 py-3 border-b border-gray-100 flex items-center space-x-2">
    <button onclick="history.back()" class="text-gray-500 mr-2">
        <i class="fa-solid fa-chevron-left"></i>
    </button>
    <h1 class="text-lg font-semibold text-gray-900">내 예약</h1>
</header>

<main class="px-4 py-4 pb-24 space-y-4">

    <!-- 상태 필터 (UI만, 실제 필터링은 추후 구현 가능) -->
    <div class="flex space-x-2 text-xs">
        <button class="px-3 py-1 rounded-full bg-blue-600 text-white font-medium">전체</button>
        <button class="px-3 py-1 rounded-full bg-gray-100 text-gray-600">예약됨</button>
        <button class="px-3 py-1 rounded-full bg-gray-100 text-gray-600">노쇼</button>
        <button class="px-3 py-1 rounded-full bg-gray-100 text-gray-600">취소됨</button>
    </div>

    <!-- 예약 카드 리스트 -->
    <section class="space-y-3">

        <% if (list == null || list.isEmpty()) { %>
            <!-- 예약이 하나도 없을 때 -->
            <div class="bg-white rounded-xl p-4 shadow-sm text-xs text-gray-500">
                현재 예약된 일정이 없습니다.
            </div>
        <% } else { %>

            <% for (ReservationDTO rsv : list) {

                String status = rsv.getStatus();         // RESERVED / CANCELED / NOSHOW ...
                String badgeText;
                String badgeClass;

                if ("RESERVED".equals(status)) {
                	
                    badgeText = "예약됨";
                    badgeClass = "bg-blue-100 text-blue-800";
                } else if ("CANCELED".equals(status)) {
                    badgeText = "취소됨";
                    badgeClass = "bg-gray-100 text-gray-500";
                } else if ("NOSHOW".equals(status)) {
                    badgeText = "노쇼";
                    badgeClass = "bg-red-100 text-red-700";
                } else {
                    badgeText = status;
                    badgeClass = "bg-gray-100 text-gray-600";
                }

            %>
                <div class="bg-white rounded-xl p-4 shadow-sm border border-gray-100">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="font-semibold text-gray-900 text-sm">
                            <%= rsv.getRoom_name() != null ? rsv.getRoom_name() : "동아리방" %>
                        </h3>
                        <span class="text-xs px-2 py-1 rounded-full <%= badgeClass %>">
                            <%= badgeText %>
                        </span>
                    </div>

                    <p class="text-sm text-gray-600 mb-1">
                        <%= rsv.getReserve_date() %>
                        &nbsp;
                        <%= rsv.getStart_time() %> ~ <%= rsv.getEnd_time() %>
                    </p>

                    <p class="text-xs text-gray-400 mb-2">
                        예약 번호: R-<%= rsv.getReservation_id() %>
                    </p>

                    <div class="flex space-x-2 text-xs">
                        <% if ("RESERVED".equals(status)) { %>
                            <!-- RESERVED 상태에서만 취소 버튼 보이게 -->
                            <form action="<%=cpath%>/myReservations" method="post" class="flex-1">
                                <input type="hidden" name="reservationId"
                                       value="<%= rsv.getReservation_id() %>">
                                <button type="submit"
                                        class="w-full py-2 bg-red-100 text-red-700 rounded-lg">
                                    취소하기
                                </button>
                            </form>
                        <% } else { %>
                            <div class="w-full py-2 text-center rounded-lg bg-gray-50 text-gray-400">
                                변경/취소 불가
                            </div>
                        <% } %>
                    </div>
                </div>
            <% } %>

        <% } %>

    </section>
</main>

<!-- 하단 네비게이션 : 내 예약 활성 -->
<nav class="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 px-4 py-2">
    <div class="flex justify-around">
        <!-- 홈 -->
        <a href="<%=cpath%>/home" class="flex flex-col items-center space-y-1">
            <i class="fa-solid fa-house text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">홈</span>
        </a>

        <!-- 내 예약(현재 페이지) -->
        <a href="<%=cpath%>/myReservations" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-calendar text-blue-600 text-lg"></i>
            <span class="text-xs text-blue-600 font-medium">내 예약</span>
        </a>

        <!-- 알림 -->
        <a href="<%=cpath%>/notifications" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-bell text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">알림</span>
        </a>

        <!-- 프로필 -->
        <a href="<%=cpath%>/profile" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-user text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">프로필</span>
        </a>
    </div>
</nav>

</body>
</html>
