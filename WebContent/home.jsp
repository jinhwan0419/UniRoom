<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.club.dto.RoomDTO" %>
<%@ page import="com.club.dto.UserDTO" %>
<%@ page import="com.club.dto.ReservationDTO" %>

<%
    String cpath = request.getContextPath();

    // 로그인 유저
    UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
    int userClubId = (loginUser != null) ? loginUser.getClubId() : 0;

    // HomeServlet에서 넘겨준 값들
    String reserveDate = (String) request.getAttribute("reserveDate");
    String startTime   = (String) request.getAttribute("startTime");
    Integer clubIdObj  = (Integer) request.getAttribute("clubId");
    int clubId = (clubIdObj != null) ? clubIdObj : userClubId;

    if (reserveDate == null || reserveDate.trim().isEmpty()) {
        reserveDate = java.time.LocalDate.now().toString();
    }
    if (startTime == null) {
        startTime = "";
    }

    List<RoomDTO> popularRooms = (List<RoomDTO>) request.getAttribute("popularRooms");
    List<RoomDTO> allRooms     = (List<RoomDTO>) request.getAttribute("allRooms");

    Map<Integer, List<ReservationDTO>> roomReservationMap =
        (Map<Integer, List<ReservationDTO>>) request.getAttribute("roomReservationMap");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 홈</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <script> window.FontAwesomeConfig = { autoReplaceSvg: 'nest'};</script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">
    <style>
        ::-webkit-scrollbar { display: none; }
        * { font-family: 'Pretendard', sans-serif; }
    </style>
</head>
<body class="bg-gray-50 text-gray-900">

<!-- iOS 느낌 상태바 (데모용 하드코딩) -->
<div class="bg-black text-white text-xs py-1 px-4 flex justify-between items-center">
    <span>9:41</span>
    <div class="flex items-center space-x-1">
        <i class="fa-solid fa-signal text-xs"></i>
        <i class="fa-solid fa-wifi text-xs"></i>
        <i class="fa-solid fa-battery-three-quarters text-xs"></i>
    </div>
</div>

<!-- 상단 로고 -->
<header class="bg-white px-4 py-3 border-b border-gray-100">
    <h1 class="text-center text-blue-600 text-lg font-medium">UniRoom</h1>
</header>

<main class="px-3 py-3 pb-24 space-y-3">
    <!-- 상단 탭 -->
    <section class="bg-white rounded-lg p-1 shadow-sm border border-gray-100">
        <div class="flex space-x-1 text-sm">
            <a href="<%=cpath%>/home"
               class="flex-1 text-center py-2 px-3 font-medium text-blue-600 bg-blue-50 rounded-md">
                오늘
            </a>
            <button type="button"
                    class="flex-1 text-center py-2 px-3 text-gray-400 bg-gray-50 rounded-md cursor-not-allowed">
                주간(준비 중)
            </button>
            <a href="myReservations.jsp"
               class="flex-1 text-center py-2 px-3 text-gray-600 rounded-md">
                내 예약
            </a>
            <a href="clubs.jsp"
               class="flex-1 text-center py-2 px-3 text-gray-600 rounded-md">
                동아리
            </a>
        </div>
    </section>

    <!-- 추천 공간 : UI는 선배 것 유지 -->
    <section class="space-y-2">
        <h2 class="text-sm font-medium text-gray-800 px-1">추천 공간</h2>
        <div class="flex space-x-2 overflow-x-auto">
            <%-- 여기 popularRooms 로 실제 데이터 보여주고 싶으면 아래 더 손볼 수 있음.
                지금은 선배가 만든 샘플 카드 그대로 둠. --%>
            <a class="min-w-[200px] bg-white rounded-lg p-3 shadow-sm border border-gray-100">
                <div class="flex items-center space-x-2 mb-2">
                    <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                        <i class="fa-solid fa-robot text-blue-600 text-sm"></i>
                    </div>
                    <div class="flex-1">
                        <h3 class="text-sm font-medium">로보틱스 동아리실</h3>
                        <p class="text-xs text-gray-500">오늘 12시~14시 사용 가능</p>
                    </div>
                </div>
            </a>

            <a class="min-w-[200px] bg-white rounded-lg p-3 shadow-sm border border-gray-100">
                <div class="flex items-center space-x-2 mb-2">
                    <div class="w-8 h-8 bg-purple-100 rounded-lg flex items-center justify-center">
                        <i class="fa-solid fa-music text-purple-600 text-sm"></i>
                    </div>
                    <div class="flex-1">
                        <h3 class="text-sm font-medium">밴드 연습실</h3>
                        <p class="text-xs text-gray-500">18시 이후 예약 가능</p>
                    </div>
                </div>
            </a>
        </div>
    </section>

    <!-- 필터 : 날짜 / 동아리(내 동아리 고정) / 시작시간 -->
    <section>
        <form action="<%=cpath%>/home" method="get" class="flex space-x-2">
            <!-- 날짜 -->
            <input type="date"
                   name="reserveDate"
                   value="<%=reserveDate%>"
                   class="flex-1 bg-white border border-gray-200 rounded-lg px-3 py-2 text-sm" />

            <!-- 동아리 선택 : 내 동아리명 표시만 -->
            <select class="flex-1 bg-white border border-gray-200 rounded-lg px-3 py-2 text-sm" disabled>
                <option>
                    <% if (userClubId == 1) { %>로보틱스 동아리<% }
                       else if (userClubId == 2) { %>밴드 동아리<% }
                       else if (userClubId == 3) { %>회의 동아리<% }
                       else { %>동아리 선택<% } %>
                </option>
            </select>
            <input type="hidden" name="clubId" value="<%=userClubId%>" />

            <!-- 시작 시간 -->
            <input type="time"
                   name="startTime"
                   value="<%=startTime%>"
                   class="flex-1 bg-white border border-gray-200 rounded-lg px-3 py-2 text-sm" />

            <button type="submit"
                    class="bg-blue-600 text-white text-sm px-4 rounded-full whitespace-nowrap">
                필터 적용
            </button>
        </form>
    </section>

        <!-- ✅ 인기 예약 현황: 카드 클릭하면 동아리실 상세(타임테이블)로 이동 -->
    <section class="space-y-2">
               <h2 class="text-sm font-medium text-gray-800 px-1">인기 예약 현황</h2>
        <div class="space-y-1">
            <%
                if (allRooms != null && !allRooms.isEmpty()) {
                    for (RoomDTO room : allRooms) {
            %>
                <!-- 카드 전체 클릭 시 /room/detail 로 이동 -->
                <a href="<%=cpath%>/room/detail?roomId=<%=room.getRoom_id()%>&date=<%=reserveDate%>"
                   class="block bg-white rounded-lg p-3 shadow-sm border border-gray-100 hover:shadow-md transition">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-3">
                            <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                                <i class="fa-solid fa-door-open text-blue-600 text-sm"></i>
                            </div>
                            <div class="flex-1">
                                <!-- 방 이름 -->
                                <h3 class="text-sm font-medium"><%=room.getName()%></h3>
                                <p class="text-xs text-green-600">내 동아리 방</p>
                                <p class="text-xs text-gray-500">
                                    위치: <%=room.getLocation()%>
                                    · 운영: <%=room.getOpen_time()%> ~ <%=room.getClose_time()%>
                                </p>
                                <p class="text-xs text-gray-500">
                                    선택한 날짜: <%=reserveDate%>
                                </p>
                            </div>
                        </div>
                        <span class="px-3 py-1.5 text-xs rounded-full bg-blue-600 text-white font-medium">
                            예약하기
                        </span>
                    </div>
                </a>
            <%
                    } // end for
                } else {
            %>

                <div class="text-xs text-gray-400 px-1">
                    아직 내 동아리 방 정보가 없습니다.
                </div>
            <%
                }
            %>
        </div>
    </section>
    
</main>

<!-- 하단 네비게이션 -->
<nav class="fixed bottom-0 left-0 right-0 border-t border-gray-200 bg-white">
    <div class="max-w-3xl mx-auto flex justify-around py-2 text-xs">
        <!-- 홈 (현재 화면이니까 파란색) -->
        <a href="<%= cpath %>/user/home"
           class="flex flex-col items-center gap-1 text-indigo-500">
            <i class="fa-solid fa-house text-lg"></i>
            <span>홈</span>
        </a>

        <!-- 내 예약 -->
        <a href="<%= cpath %>/user/reservations"
           class="flex flex-col items-center gap-1 text-gray-400">
            <i class="fa-regular fa-calendar-check text-lg"></i>
            <span>예약</span>
        </a>

        <!-- 알림 -->
        <a href="<%= cpath %>/notifications"
           class="flex flex-col items-center gap-1 text-gray-400">
            <i class="fa-regular fa-bell text-lg"></i>
            <span>알림</span>
        </a>

        <!-- 프로필 -->
        <a href="<%= cpath %>/mypage"
           class="flex flex-col items-center gap-1 text-gray-400">
            <i class="fa-regular fa-user text-lg"></i>
            <span>프로필</span>
        </a>
    </div>
</nav>


</body>
</html>
