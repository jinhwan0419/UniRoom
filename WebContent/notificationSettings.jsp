<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String cpath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 알림 설정</title>

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
    <h1 class="flex-1 text-center text-blue-600 text-lg font-medium">알림 설정</h1>
    <div class="w-6"></div>
</div>

<main class="px-4 py-4 pb-24 space-y-4">

    <section class="bg-white rounded-xl shadow-sm border border-gray-100 p-4">
        <h2 class="text-sm font-semibold text-gray-900 mb-2">예약 알림 방식</h2>

        <div class="flex items-center justify-between py-2 border-b border-gray-100">
            <div>
                <p class="text-sm text-gray-800">예약 시작 20분 전 알림</p>
                <p class="text-[11px] text-gray-500 mt-1">
                    모든 예약은 시작 20분 전에 &quot;알림&quot; 탭에 자동으로 표시됩니다.
                </p>
            </div>
            <span class="text-xs px-2 py-1 rounded-full bg-blue-50 text-blue-600">기본 ON</span>
        </div>

        <p class="mt-3 text-[11px] text-gray-500">
            현재 버전에서는 알림 방식이 고정되어 있으며, 예약 시작 20분 전 알림만 제공됩니다.
            알림 내역은 하단의 <strong>알림</strong> 탭에서 확인할 수 있습니다.
        </p>
    </section>

</main>

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
        <a href="<%=cpath%>/notifications" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-bell text-blue-600 text-lg"></i>
            <span class="text-blue-600 font-medium">알림</span>
        </a>
        <a href="<%=cpath%>/profile" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-user text-gray-400 text-lg"></i>
            <span class="text-gray-400">프로필</span>
        </a>
    </div>
</footer>

</body>
</html>
