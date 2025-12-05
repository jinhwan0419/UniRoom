<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String cpath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 동아리실 상세</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;500;600;700&display=swap"
          rel="stylesheet">

    <style>
        * { font-family: 'Pretendard', sans-serif; }
        ::-webkit-scrollbar { display: none; }
    </style>
</head>
<body class="bg-gray-50 text-gray-900 min-h-screen">
<div class="max-w-3xl mx-auto px-4 py-4">

    <!-- 헤더 -->
    <div class="flex items-center justify-between mb-4">
        <button onclick="history.back()" class="p-2 -ml-2">
            <i class="fa-solid fa-arrow-left text-gray-600"></i>
        </button>
        <div class="text-base font-semibold">동아리실 상세</div>
        <div class="w-6"></div>
    </div>

    <!-- 동아리실 정보 카드 -->
    <div class="bg-white rounded-2xl shadow-sm p-4 mb-4">
        <div class="flex items-start gap-3">
            <div class="w-10 h-10 rounded-full bg-indigo-50 flex items-center justify-center mt-1">
                <i class="fa-solid fa-music text-indigo-500"></i>
            </div>
            <div class="flex-1">
                <div class="text-xs text-gray-500 mb-1">
                    ${room.clubName}
                </div>
                <div class="text-lg font-semibold mb-1">
                    ${room.roomName}
                </div>
                <div class="text-xs text-gray-500 mb-1">
                    위치: ${room.location}
                </div>
                <div class="text-xs text-gray-500">
                    운영 시간: ${room.openTime} ~ ${room.closeTime} · 수용 인원: ${room.capacity}명
                </div>
            </div>
        </div>
    </div>

    <!-- 날짜 선택 -->
    <form method="get" action="<%= cpath %>/room/detail"
          class="bg-white rounded-2xl shadow-sm p-4 mb-4 flex items-center gap-3">
        <input type="hidden" name="roomId" value="${room.roomId}">
        <div class="flex-1">
            <label class="block text-xs text-gray-500 mb-1">예약 날짜</label>
            <input type="date" name="date" value="${date}"
                   class="w-full border border-gray-200 rounded-xl px-3 py-2 text-sm
                          focus:outline-none focus:ring-1 focus:ring-indigo-500 focus:border-indigo-500">
        </div>
        <button type="submit"
                class="mt-5 px-4 py-2 rounded-xl bg-indigo-500 text-white text-sm font-medium">
            날짜 변경
        </button>
    </form>

    <!-- 타임테이블 -->
    <div class="bg-white rounded-2xl shadow-sm p-4 mb-24">
        <div class="flex items-center justify-between mb-3">
            <div class="text-sm font-semibold">
                ${date} 시간대별 현황
            </div>
            <div class="flex items-center gap-2 text-xs text-gray-500">
                <span class="inline-flex items-center gap-1">
                    <span class="w-3 h-3 rounded-full bg-emerald-100"></span> 예약 가능
                </span>
                <span class="inline-flex items-center gap-1">
                    <span class="w-3 h-3 rounded-full bg-gray-100"></span> 예약 불가
                </span>
            </div>
        </div>

        <div class="grid grid-cols-4 gap-2">
            <c:forEach var="slot" items="${timeSlots}">
                <c:choose>
                 <c:when test="${slot.status eq 'AVAILABLE'}">
    <form method="post" action="<%= cpath %>/ReservationServlet">
        <input type="hidden" name="roomId" value="${room.roomId}">
        <input type="hidden" name="date"   value="${date}">
        <input type="hidden" name="time"   value="${slot.time}">
        <button type="submit"
                class="w-full text-xs py-2 rounded-xl bg-emerald-50 text-emerald-700 hover:bg-emerald-100">
            ${slot.time}
        </button>
    </form>
</c:when>



                    <c:otherwise>
                        <button type="button"
                                class="w-full text-xs py-2 rounded-xl bg-gray-100 text-gray-400 cursor-not-allowed">
                            ${slot.time}
                        </button>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </div>

</div>
</body>
</html>
