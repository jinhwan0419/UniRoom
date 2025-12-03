<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.club.dto.RoomDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 홈</title>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- FontAwesome 아이콘 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

    <!-- Pretendard 폰트 -->
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        ::-webkit-scrollbar { display: none; }
        * { font-family: 'Pretendard', sans-serif; }
    </style>
</head>

<body class="bg-gray-50 text-gray-900">
<%
    // 컨텍스트 경로 (예: /UniRoom1)
    String cpath = request.getContextPath();

    // HomeServlet에서 넘겨준 데이터 꺼내기
    List<String> dateList       = (List<String>) request.getAttribute("dateList");     // 날짜 리스트
    List<RoomDTO> roomList      = (List<RoomDTO>) request.getAttribute("roomList");    // 동아리방 리스트
    List<String> timeList       = (List<String>) request.getAttribute("timeList");     // 시간 리스트
    List<RoomDTO> popularRooms  = (List<RoomDTO>) request.getAttribute("popularRooms");// 인기 방 리스트
    Object todayObj             = request.getAttribute("today");                       // LocalDate today
    String todayStr             = (todayObj != null) ? todayObj.toString() : java.time.LocalDate.now().toString();
%>

<!-- Header -->
<div class="bg-white px-4 py-3 border-b border-gray-200 flex items-center justify-between">
    <!-- 왼쪽 여백용 (제목 가운데 맞추려고 빈 div) -->
    <div class="w-6"></div>

    <!-- 가운데 앱 타이틀 -->
    <h1 class="text-blue-600 text-lg font-medium text-center flex-1">UniRoom</h1>

    <!-- 오른쪽 프로필 아이콘 (마이페이지로 이동) -->
    <a href="<%= cpath %>/profile" class="text-gray-500">
        <i class="fa-solid fa-user-circle text-xl"></i>
    </a>
</div>


<div class="px-3 py-3 space-y-3">

    <!-- ✅ 추천 공간 영역 -->
    <div class="space-y-2">
        <h2 class="text-sm font-medium text-gray-800 px-1">추천 공간</h2>

        <div class="flex space-x-2 overflow-x-auto">
            <%
                // popularRooms 리스트가 있으면 반복 출력
                if (popularRooms != null && !popularRooms.isEmpty()) {
                    for (RoomDTO room : popularRooms) {
            %>
                <!-- 방 하나 카드 -->
                <a href="<%= cpath %>/roomDetail?roomId=<%= room.getRoom_id() %>"
                   class="min-w-[200px] bg-white rounded-lg p-3 shadow-sm border border-gray-100 block">
                    <div class="flex items-center space-x-2 mb-2">
                        <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                            <i class="fa-solid fa-robot text-blue-600 text-sm"></i>
                        </div>
                        <div class="flex-1">
                            <h3 class="text-sm font-medium"><%= room.getName() %></h3>
                            <!-- 운영 시간 간단 표시 -->
                            <p class="text-xs text-gray-500">
                                <% 
                                    String o = room.getOpen_time();
                                    String c = room.getClose_time();
                                    if (o != null && o.length() >= 5 && c != null && c.length() >= 5) {
                                %>
                                    오늘 <%= o.substring(0,5) %> ~ <%= c.substring(0,5) %> 사용 가능
                                <%  } else { %>
                                    운영 시간 정보 없음
                                <%  } %>
                            </p>
                        </div>
                    </div>
                </a>
            <%
                    }
                } else {
            %>
                <!-- 인기 방이 없을 때 예시 카드 하나 -->
                <div class="min-w-[200px] bg-white rounded-lg p-3 shadow-sm border border-gray-100">
                    <div class="flex items-center space-x-2 mb-2">
                        <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                            <i class="fa-solid fa-robot text-blue-600 text-sm"></i>
                        </div>
                        <div class="flex-1">
                            <h3 class="text-sm font-medium">등록된 공간이 없습니다</h3>
                            <p class="text-xs text-gray-500">관리자가 동아리방을 등록하면 표시됩니다.</p>
                        </div>
                    </div>
                </div>
            <%
                }
            %>
        </div>
    </div>

    <!-- 상단 탭 -->
    <div class="bg-white rounded-lg p-1 shadow-sm border border-gray-100">
        <div class="flex space-x-1">
            <!-- 현재는 today만 활성화, 나머지는 UI용 -->
            <button class="flex-1 py-2 px-3 text-sm font-medium text-blue-600 bg-blue-50 rounded-md">오늘</button>
            <button class="flex-1 py-2 px-3 text-sm text-gray-600">주간</button>

            <!-- 내 예약 탭: 내 예약 목록 페이지로 이동 (나중에 myReservations 서블릿으로 바꿔도 OK) -->
            <a href="<%= cpath %>/reservation?action=list"
               class="flex-1 py-2 px-3 text-sm text-gray-600 text-center rounded-md">
                내 예약
            </a>

            <button class="flex-1 py-2 px-3 text-sm text-gray-600">동아리</button>
        </div>
    </div>

    <!-- ✅ 필터 영역 (날짜 / 동아리 / 시간) -->
    <!-- 지금은 선택만 하는 UI이고, 나중에 이 값을 이용해 예약 폼이나 검색으로 연결하면 됨 -->
    <div class="flex space-x-2">
        <!-- 날짜 선택 드롭다운 -->
        <select name="reserveDate"
                class="flex-1 bg-white border border-gray-200 rounded-lg px-3 py-2 text-sm">
            <option value="">날짜 선택</option>
            <%
                if (dateList != null) {
                    for (String d : dateList) {
            %>
                <option value="<%= d %>" <%= d.equals(todayStr) ? "selected" : "" %>><%= d %></option>
            <%
                    }
                }
            %>
        </select>

        <!-- 동아리(방) 선택 드롭다운 -->
        <select name="roomId"
                class="flex-1 bg-white border border-gray-200 rounded-lg px-3 py-2 text-sm">
            <option value="">동아리 선택</option>
            <%
                if (roomList != null) {
                    for (RoomDTO r : roomList) {
            %>
                <option value="<%= r.getRoom_id() %>"><%= r.getName() %></option>
            <%
                    }
                }
            %>
        </select>

        <!-- 시간 선택 드롭다운 -->
        <select name="startTime"
                class="flex-1 bg-white border border-gray-200 rounded-lg px-3 py-2 text-sm">
            <option value="">시간</option>
            <%
                if (timeList != null) {
                    for (String t : timeList) {
            %>
                <option value="<%= t %>"><%= t %></option>
            <%
                    }
                }
            %>
        </select>
    </div>

    <!-- ✅ 인기 예약 현황 영역 -->
    <h2 class="text-sm font-medium text-gray-800 px-1 mt-3">인기 예약 현황</h2>

    <div class="space-y-1">
        <%
            // 여기서는 popularRooms를 재사용해서 "이번 주 사용량" 같은 느낌으로 보여줘도 됨.
            if (popularRooms != null && !popularRooms.isEmpty()) {
                for (RoomDTO room : popularRooms) {
        %>
            <div class="bg-white rounded-lg p-3 shadow-sm border border-gray-100">
                <div class="flex items-center justify-between">
                    <div class="flex items-center space-x-3">
                        <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                            <i class="fa-solid fa-robot text-blue-600"></i>
                        </div>
                        <div>
                            <h3 class="text-sm font-medium"><%= room.getName() %></h3>
                            <!-- 상태는 일단 '사용 가능'로 고정, 나중에 현재 시간 기준으로 계산 가능 -->
                            <p class="text-xs text-green-600">사용 가능</p>
                            <!-- 예약 횟수는 RoomDTO에 별도 필드가 없으니, 지금은 설명 텍스트만 -->
                            <p class="text-xs text-gray-500">인기 공간</p>
                        </div>
                    </div>
                    <button class="w-6 h-6 text-gray-400">
                        <i class="fa-regular fa-star text-sm"></i>
                    </button>
                </div>
            </div>
        <%
                }
            } else {
        %>
            <!-- 인기 예약 데이터가 없을 때 -->
            <div class="bg-white rounded-lg p-3 shadow-sm border border-gray-100">
                <p class="text-sm text-gray-500">아직 예약 데이터가 없습니다.</p>
            </div>
        <%
            }
        %>
    </div>

</div>

</body>
</html>
