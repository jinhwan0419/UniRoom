<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.club.dto.RoomDTO" %>
<%@ page import="com.club.dto.UserDTO" %>

<%
    String cpath = request.getContextPath();

    // 로그인 유저 (HomeServlet에서 이미 체크했지만 JSP에서도 꺼내서 사용)
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

    <!-- 추천 공간 : UI는 그대로 두고, 여기서는 단순 안내용만 사용 -->
    <section class="space-y-2">
        <h2 class="text-sm font-medium text-gray-800 px-1">추천 공간</h2>
        <div class="flex space-x-2 overflow-x-auto">
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

    <!-- ✅ 필터 : 이건 "예약 정보" 입력 역할도 같이 함 -->
    <section>
        <form action="<%=cpath%>/home" method="get" class="flex space-x-2">
            <!-- 날짜 -->
            <input type="date"
                   name="reserveDate"
                   value="<%=reserveDate%>"
                   class="flex-1 bg-white border border-gray-200 rounded-lg px-3 py-2 text-sm" />

            <!-- 동아리 선택 : 내 동아리로 고정 (disable + hidden) -->
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

    <!-- ✅ 인기 예약 현황 : 여기서 바로 "내 동아리 방" 예약 -->
    <section class="space-y-2">
        <h2 class="text-sm font-medium text-gray-800 px-1">인기 예약 현황</h2>
        <div class="space-y-1">
            <%
                if (allRooms != null && !allRooms.isEmpty()) {
                    // 내 동아리 방 리스트 (보통 1개일 것)
                    for (RoomDTO room : allRooms) {
            %>
                <!-- 한 줄마다 ReservationServlet으로 바로 POST하는 폼 -->
                <form action="<%=cpath%>/ReservationServlet" method="post"
                      class="bg-white rounded-lg p-3 shadow-sm border border-gray-100">
                    <input type="hidden" name="roomId"      value="<%=room.getRoom_id()%>" />
                    <input type="hidden" name="reserveDate" value="<%=reserveDate%>" />
                    <input type="hidden" name="startTime"   value="<%=startTime%>" />
                    <!-- 끝 시간은 여기선 1시간 후로 쓰고 싶으면 나중에 서버에서 계산하거나,
                         예약폼을 한 번 더 보여주고 싶으면 endTime도 화면에 따로 input으로 만들어줘. -->
                    <input type="hidden" name="endTime"     value="<%=startTime%>" />

                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-3">
                            <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                                <i class="fa-solid fa-robot text-blue-600 text-sm"></i>
                            </div>
                            <div class="flex-1">
                                <h3 class="text-sm font-medium"><%=room.getRoom_name()%></h3>
                                <p class="text-xs text-green-600">내 동아리 방</p>
                                <p class="text-xs text-gray-500">
                                    선택한 날짜: <%=reserveDate%>
                                    <% if (startTime != null && !startTime.isEmpty()) { %>
                                        · 시작 <%=startTime%>
                                    <% } %>
                                </p>
                            </div>
                        </div>

                        <!-- 🔵 여기 버튼 = 바로 예약하기 -->
                        <button type="submit"
                                class="px-3 py-1.5 text-xs rounded-full bg-blue-600 text-white font-medium">
                            예약하기
                        </button>
                    </div>
                </form>
            <%
                    }
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
<nav class="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 px-4 py-2">
    <div class="flex justify-around">
        <a href="<%=cpath%>/home" class="flex flex-col items-center space-y-1">
            <i class="fa-solid fa-house text-blue-600 text-lg"></i>
            <span class="text-xs text-blue-600 font-medium">홈</span>
        </a>
        <a href="myReservations.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-calendar text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">내 예약</span>
        </a>
        <a href="notifications.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-bell text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">알림</span>
        </a>
        <a href="profile.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-user text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">프로필</span>
        </a>
    </div>
</nav>

</body>
</html>
