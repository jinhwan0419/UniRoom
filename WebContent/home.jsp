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

    <!-- ✅ 인기 예약 현황 + 타임테이블 -->
    <section class="space-y-2">
        <h2 class="text-sm font-medium text-gray-800 px-1">인기 예약 현황</h2>
        <div class="space-y-1">
            <%
                if (allRooms != null && !allRooms.isEmpty()) {
                    for (RoomDTO room : allRooms) {

                        List<ReservationDTO> roomRes = null;
                        if (roomReservationMap != null) {
                            roomRes = roomReservationMap.get(room.getRoom_id());
                        }

                        // 방 운영 시간 기준으로 타임테이블 범위 계산
                        int startHour = 9;
                        int endHour   = 22;
                        try {
                            String open  = room.getOpen_time();   // "09:00"
                            String close = room.getClose_time();  // "22:00"
                            if (open != null && open.length() >= 2) {
                                startHour = Integer.parseInt(open.substring(0, 2));
                            }
                            if (close != null && close.length() >= 2) {
                                endHour = Integer.parseInt(close.substring(0, 2));
                            }
                        } catch (Exception e) {
                            // 파싱 실패하면 기본값(9~22시) 사용
                        }
            %>
                <!-- 한 줄마다 ReservationServlet으로 바로 POST하는 폼 -->
                <form action="<%=cpath%>/ReservationServlet" method="post"
                      class="bg-white rounded-lg p-3 shadow-sm border border-gray-100">
                    <input type="hidden" name="roomId"      value="<%=room.getRoom_id()%>" />
                    <input type="hidden" name="reserveDate" value="<%=reserveDate%>" />
                    <input type="hidden" name="startTime"   value="<%=startTime%>" />
                    <input type="hidden" name="endTime"     value="<%=startTime%>" />

                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-3">
                            <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                                <i class="fa-solid fa-door-open text-blue-600 text-sm"></i>
                            </div>
                            <div class="flex-1">
                                <h3 class="text-sm font-medium"><%=room.getName()%></h3>
                                <p class="text-xs text-green-600">내 동아리 방</p>
                                <p class="text-xs text-gray-500">
                                    위치: <%=room.getLocation()%>
                                    · 운영: <%=room.getOpen_time()%> ~ <%=room.getClose_time()%>
                                </p>
                                <p class="text-xs text-gray-500">
                                    선택한 날짜: <%=reserveDate%>
                                    <% if (startTime != null && !startTime.isEmpty()) { %>
                                        · 기준 시간: <%=startTime%>
                                    <% } %>
                                </p>
                            </div>
                        </div>

                        <!-- 예약 버튼 -->
                        <button type="submit"
                                class="px-3 py-1.5 text-xs rounded-full bg-blue-600 text-white font-medium">
                            예약하기
                        </button>
                    </div>

                    <!-- 🔵 시간대별 현황 (타임테이블) -->
                    <div class="mt-3 pt-2 border-t border-gray-100">
                        <p class="text-[11px] text-gray-500 mb-1">
                            <%=reserveDate%> 시간대별 현황
                            <span class="ml-2">
                                <span class="inline-block w-2 h-2 rounded-full bg-red-300 align-middle"></span>
                                <span class="text-[10px] text-gray-500 mr-2">예약됨</span>
                                <span class="inline-block w-2 h-2 rounded-full bg-green-300 align-middle"></span>
                                <span class="text-[10px] text-gray-500">예약 가능</span>
                            </span>
                        </p>
                        <div class="flex flex-wrap gap-1">
                            <%
                                for (int h = startHour; h < endHour; h++) {
                                    boolean reserved = false;

                                    if (roomRes != null) {
                                        for (ReservationDTO rsv : roomRes) {
                                            int sh = rsv.getStart_time().getHour();
                                            int eh = rsv.getEnd_time().getHour();
                                            if (h >= sh && h < eh) {
                                                reserved = true;
                                                break;
                                            }
                                        }
                                    }

                                    String slotClass = reserved
                                            ? "bg-red-100 text-red-600 border border-red-200"
                                            : "bg-green-100 text-green-700 border border-green-200";

                                    String label = (h < 10 ? "0" + h : String.valueOf(h)) + ":00";
                            %>
                                <span class="px-2 py-1 rounded-full text-[11px] <%=slotClass%>">
                                    <%=label%>
                                </span>
                            <%
                                } // end for h
                            %>
                        </div>
                    </div>
                </form>
            <%
                    } // end for rooms
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
