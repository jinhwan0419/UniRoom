<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.club.dto.PenaltySummaryDTO" %>

<%
    String cpath = request.getContextPath();
    PenaltySummaryDTO ps = (PenaltySummaryDTO) request.getAttribute("penaltySummary");
    Boolean blockedObj = (Boolean) request.getAttribute("isBlocked");
    boolean isBlocked = (blockedObj != null) ? blockedObj : false;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 패널티 / 예약 제한</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@300;400;500;600;700&display=swap" rel="stylesheet">

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

<!-- 헤더 -->
<div class="bg-white px-4 py-3 border-b border-gray-200 flex items-center">
    <button onclick="history.back()" class="text-gray-500 text-lg mr-2">
        <i class="fa-solid fa-chevron-left"></i>
    </button>
    <h1 class="flex-1 text-center text-blue-600 text-lg font-medium">패널티 / 예약 제한</h1>
    <div class="w-6"></div>
</div>

<main class="px-4 py-4 pb-24 space-y-4">

    <!-- 요약 카드 -->
    <section class="bg-white rounded-xl shadow-sm border border-gray-100 p-4">
        <div class="flex items-center space-x-3 mb-2">
            <div class="w-9 h-9 rounded-full bg-purple-100 flex items-center justify-center">
                <i class="fa-solid fa-triangle-exclamation text-purple-600"></i>
            </div>
            <h2 class="text-sm font-semibold text-gray-900">패널티 요약</h2>
        </div>

        <% if (ps == null || ps.getNoShowCount() == 0) { %>
            <p class="text-sm text-gray-600">
                현재 등록된 패널티가 없습니다.
            </p>
            <p class="mt-2 text-xs text-gray-500">
                예약 노쇼 없이 정상적으로 이용 중입니다.
            </p>
        <% } else { %>
            <p class="text-sm text-gray-800">
                누적 패널티 횟수:
                <span class="font-semibold"><%= ps.getNoShowCount() %></span> 회
            </p>
            <p class="mt-1 text-xs text-gray-600">
                마지막 노쇼 날짜:
                <%= ps.getLastNoShowDate() != null ? ps.getLastNoShowDate().toString() : "-" %><br/>
                예약 제한 종료일:
                <%= ps.getBlockEndDate() != null ? ps.getBlockEndDate().toString() : "-" %>
            </p>

            <% if (isBlocked) { %>
                <div class="mt-3 p-3 rounded-lg bg-red-50 border border-red-200">
                    <p class="text-xs text-red-700 font-semibold">
                        현재 예약 제한 상태입니다.
                    </p>
                    <p class="text-[11px] text-red-600 mt-1">
                        제한 종료일까지 새로운 예약이 불가능합니다. 반복된 노쇼는 다른 이용자에게 피해를 줄 수 있습니다.
                    </p>
                </div>
            <% } else { %>
                <div class="mt-3 p-3 rounded-lg bg-green-50 border border-green-200">
                    <p class="text-xs text-green-700 font-semibold">
                        현재 예약 제한은 없습니다.
                    </p>
                    <p class="text-[11px] text-green-600 mt-1">
                        다만 노쇼가 일정 횟수 이상 누적될 경우 일정 기간 예약이 제한될 수 있습니다.
                    </p>
                </div>
            <% } %>
        <% } %>
    </section>

    <!-- 설명 카드 (보고서용 설명 텍스트) -->
    <section class="bg-white rounded-xl shadow-sm border border-gray-100 p-4">
        <h3 class="text-sm font-semibold text-gray-900 mb-2">패널티 정책 안내</h3>
        <ul class="text-xs text-gray-600 space-y-1 list-disc pl-4">
            <li>예약 시간까지 입실하지 않거나 무단 취소 시 노쇼 패널티가 1회 부여됩니다.</li>
            <li>패널티가 일정 횟수 이상 누적되면 일정 기간 동안 신규 예약이 제한됩니다.</li>
            <li>제한 기간과 기준 횟수는 동아리방 운영 정책에 따라 조정 가능합니다.</li>
        </ul>
    </section>

</main>

<!-- 하단 네비 (프로필로 돌아가기 편하게) -->
<footer class="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 px-4 py-2">
    <div class="flex justify-around text-xs">
        <a href="<%=cpath%>/home" class="flex flex-col items-center space-y-1">
            <i class="fa-solid fa-house text-gray-400 text-lg"></i>
            <span class="text-gray-400">홈</span>
        </a>
        <a href="myReservations.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-calendar text-gray-400 text-lg"></i>
            <span class="text-gray-400">예약</span>
        </a>
        <a href="reservation.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-bell text-gray-400 text-lg"></i>
            <span class="text-gray-400">알림</span>
        </a>
        <a href="<%=cpath%>/profile" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-user text-blue-600 text-lg"></i>
            <span class="text-blue-600 font-medium">프로필</span>
        </a>
    </div>
</footer>

</body>
</html>
