<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.club.dto.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String cpath = request.getContextPath();

    List<ClubDTO> clubList = (List<ClubDTO>) request.getAttribute("clubList");
    List<RoomDTO> popularRooms = (List<RoomDTO>) request.getAttribute("popularRooms");
    List<ReservationDTO> reservationList = (List<ReservationDTO>) request.getAttribute("reservationList");

    String selectedDate = (String) request.getAttribute("selectedDate");
    Integer selectedClubId = (Integer) request.getAttribute("selectedClubId");
    String selectedTime = (String) request.getAttribute("selectedTime");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 오늘</title>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- FontAwesome -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
    <!-- Pretendard -->
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        * { font-family: 'Pretendard', sans-serif; }
        ::-webkit-scrollbar { display: none; }
    </style>
</head>

<body class="bg-gray-50 text-gray-900">

<!-- 상단 헤더 + 탭 (선배 UI 비슷하게) -->
<header class="bg-white border-b border-gray-200">
    <div class="max-w-5xl mx-auto px-4 py-3 flex items-center justify-between">
        <div class="text-lg font-semibold">UniRoom</div>
        <nav class="flex space-x-6 text-sm">
            <!-- 오늘 탭 활성 -->
            <a href="<%=cpath%>/user/home" class="font-semibold text-blue-600">오늘</a>
            <a href="<%=cpath%>/user/week" class="text-gray-400">주간(준비 중)</a>
            <a href="<%=cpath%>/user/my-reservations" class="text-gray-400">내 예약</a>
            <a href="<%=cpath%>/club/list" class="text-gray-400">동아리</a>
        </nav>
    </div>
</header>

<main class="max-w-5xl mx-auto px-4 py-4">

    <!-- 1. 추천 공간 (상단 카드 한 개) -->
    <section class="mb-6">
        <h2 class="text-lg font-semibold mb-2">추천 공간</h2>

        <div class="bg-white rounded-2xl shadow-sm p-4 flex items-center">
            <div class="w-12 h-12 rounded-2xl bg-blue-50 flex items-center justify-center mr-4">
                <i class="fa-solid fa-door-open text-xl text-blue-500"></i>
            </div>

            <div class="flex-1">
                <% if (popularRooms != null && !popularRooms.isEmpty()) { 
                       RoomDTO r = popularRooms.get(0); %>
                    <p class="text-sm font-semibold text-gray-900">
                        [<%= r.getClub_name() %>] <%= r.getName() %>
                    </p>
                    <p class="text-xs text-gray-500 mt-1">
                        위치: <%= r.getLocation() %> · 수용 인원: <%= r.getCapacity() %>명
                    </p>
                    <p class="text-[11px] text-gray-400 mt-1">
                        오늘 예약이 많은 인기 공간입니다.
                    </p>
                <% } else { %>
                    <p class="text-sm text-gray-500">등록된 공간이 없습니다.</p>
                <% } %>
            </div>
        </div>
    </section>

    <!-- 2. 필터 영역 (날짜 / 동아리 / 시간대 + 버튼) -->
    <section class="mb-4">
        <form method="get" action="<%=cpath%>/user/home"
              class="bg-white rounded-2xl shadow-sm p-4 flex flex-wrap items-center gap-3">

            <!-- 날짜 선택 -->
            <div class="flex-1 min-w-[140px]">
                <label class="block text-xs text-gray-500 mb-1">날짜</label>
                <div class="flex items-center border rounded-xl px-3 py-2">
                    <input type="date" name="date"
                           value="<%= selectedDate != null ? selectedDate : "" %>"
                           class="flex-1 text-sm focus:outline-none">
                </div>
            </div>

            <!-- 동아리 선택 -->
            <div class="flex-1 min-w-[160px]">
                <label class="block text-xs text-gray-500 mb-1">동아리 선택</label>
                <div class="border rounded-xl px-3 py-2">
                    <select name="clubId" class="w-full text-sm focus:outline-none bg-transparent">
                        <option value="">전체 동아리</option>
                        <% if (clubList != null) {
                               for (ClubDTO c : clubList) {
                                   boolean selected = (selectedClubId != null && selectedClubId == c.getClub_id());
                        %>
                            <option value="<%=c.getClub_id()%>" <%= selected ? "selected" : "" %>>
                                <%= c.getName() %>
                            </option>
                        <%     }
                           } %>
                    </select>
                </div>
            </div>

            <!-- 시간대 (선택) -->
            <div class="flex-1 min-w-[120px]">
                <label class="block text-xs text-gray-500 mb-1">시간대 (선택)</label>
                <div class="flex items-center border rounded-xl px-3 py-2 space-x-2">
                    <i class="fa-regular fa-clock text-gray-400 text-sm"></i>
                    <input type="time" name="time"
                           value="<%= selectedTime != null ? selectedTime : "" %>"
                           class="flex-1 text-sm focus:outline-none">
                </div>
            </div>

            <!-- 필터 적용 버튼 -->
            <div class="flex items-end">
                <button type="submit"
                        class="px-5 py-2 rounded-xl bg-blue-600 text-white text-sm font-semibold">
                    필터 적용
                </button>
            </div>
        </form>
    </section>

    <!-- 3. 인기 예약 현황 (선배 UI에 있던 테이블 영역만) -->
    <section class="mb-4">
        <h2 class="text-lg font-semibold mb-2">인기 예약 현황</h2>

        <div class="bg-white rounded-2xl shadow-sm p-4 text-sm">
            <% if (reservationList == null || reservationList.isEmpty()) { %>
                <p class="text-gray-500">
                    아직 선택한 조건에 해당하는 예약이 없습니다.
                </p>
            <% } else { %>
                <table class="w-full text-xs">
                    <thead>
                        <tr class="text-gray-500 border-b">
                            <th class="py-2 text-left">동아리방</th>
                            <th class="py-2 text-left">날짜</th>
                            <th class="py-2 text-left">시간대</th>
                            <th class="py-2 text-left">예약자</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (ReservationDTO rsv : reservationList) { %>
                            <tr class="border-b last:border-0">
                                <td class="py-2">
                                    <%= rsv.getRoom_name() %>
                                </td>
                                <td class="py-2">
                                    <%= rsv.getReserve_date().toString() %>
                                </td>
                                <td class="py-2">
                                    <%= rsv.getStart_time().toString() %> ~ <%= rsv.getEnd_time().toString() %>
                                </td>
                                <td class="py-2">
                                    <%= rsv.getUser_name() %>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>
    </section>

</main>

<!-- 하단 네비 (선배 거 그대로 쓰면 됨, 대충 형태만 맞춰둘게) -->
<footer class="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200">
    <div class="max-w-5xl mx-auto px-4 py-2 flex justify-between text-xs">
        <a href="<%=cpath%>/user/home" class="flex flex-col items-center text-blue-600">
            <i class="fa-solid fa-house mb-1"></i>
            <span>홈</span>
        </a>
        <a href="<%=cpath%>/user/my-reservations" class="flex flex-col items-center text-gray-400">
            <i class="fa-regular fa-calendar-check mb-1"></i>
            <span>내 예약</span>
        </a>
        <a href="<%=cpath%>/user/notifications" class="flex flex-col items-center text-gray-400">
            <i class="fa-regular fa-bell mb-1"></i>
            <span>알림</span>
        </a>
        <a href="<%=cpath%>/user/profile" class="flex flex-col items-center text-gray-400">
            <i class="fa-regular fa-user mb-1"></i>
            <span>프로필</span>
        </a>
    </div>
</footer>

</body>
</html>
