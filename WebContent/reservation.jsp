<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String cpath = request.getContextPath();

    // 홈에서 넘어온 값들
    String roomIdParam      = request.getParameter("roomId");
    String reserveDateParam = request.getParameter("reserveDate");
    String startTimeParam   = request.getParameter("startTime");

    int roomId = 0;
    try { roomId = Integer.parseInt(roomIdParam); } catch(Exception e) {}

    String today = java.time.LocalDate.now().toString();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 예약하기</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">
    <style>
        ::-webkit-scrollbar { display: none; }
        * { font-family: 'Pretendard', sans-serif; }
    </style>
</head>
<body class="bg-gray-50 text-gray-900">

<!-- 헤더 -->
<div class="bg-white px-4 py-3 border-b border-gray-200 flex items-center justify-between">
    <button type="button" onclick="history.back()" class="text-gray-500 text-sm">
        <i class="fa-solid fa-chevron-left mr-1"></i> 뒤로
    </button>
    <h1 class="text-blue-600 text-base font-semibold">동아리방 예약</h1>
    <span class="w-6"></span>
</div>

<div class="max-w-md mx-auto mt-6 bg-white shadow-md rounded-xl p-6">
    <h2 class="text-lg font-semibold mb-4">예약 정보 입력</h2>

    <%
        String errorMsg = (String) request.getAttribute("errorMsg");
        if (errorMsg != null) {
    %>
        <div class="mb-4 text-sm text-red-600 bg-red-50 border border-red-200 px-3 py-2 rounded-lg">
            <i class="fa-solid fa-circle-exclamation mr-1"></i> <%= errorMsg %>
        </div>
    <%
        }
    %>

    <form action="<%=cpath%>/ReservationServlet" method="post" class="space-y-4">
        <!-- 어떤 방을 예약하는지 -->
        <input type="hidden" name="roomId" value="<%=roomId%>">

        <!-- 날짜 -->
        <div>
            <label class="block text-sm font-medium mb-1">예약 날짜</label>
            <input type="date"
                   name="reserveDate"
                   value="<%= (reserveDateParam != null && !reserveDateParam.trim().isEmpty()) 
                            ? reserveDateParam : today %>"
                   required
                   class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm
                          focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>

        <!-- 시작 / 종료 시간 -->
        <div class="grid grid-cols-2 gap-4">
            <div>
                <label class="block text-sm font-medium mb-1">시작 시간</label>
                <input type="time"
                       name="startTime"
                       value="<%= (startTimeParam != null ? startTimeParam : "") %>"
                       required
                       class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm
                              focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
                <label class="block text-sm font-medium mb-1">종료 시간</label>
                <input type="time"
                       name="endTime"
                       required
                       class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm
                              focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
        </div>

        <button type="submit"
                class="w-full mt-4 bg-blue-600 text-white text-sm font-semibold py-2.5 rounded-lg
                       hover:bg-blue-700 transition">
            예약하기
        </button>
    </form>
</div>

</body>
</html>
