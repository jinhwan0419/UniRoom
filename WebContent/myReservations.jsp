<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <!-- 상태 필터 -->
    <div class="flex space-x-2 text-xs">
        <!-- TODO(DB): 각각 탭 선택 시 상태별 필터링 -->
        <button class="px-3 py-1 rounded-full bg-blue-600 text-white font-medium">진행 중</button>
        <button class="px-3 py-1 rounded-full bg-gray-100 text-gray-600">예약됨</button>
        <button class="px-3 py-1 rounded-full bg-gray-100 text-gray-600">완료됨</button>
        <button class="px-3 py-1 rounded-full bg-gray-100 text-gray-600">취소됨</button>
    </div>

    <!-- 예약 카드 리스트 -->
    <section class="space-y-3">
        <!-- TODO(DB): 여기 반복문으로 사용자 예약 목록 출력 -->
        <!-- 카드 1 : 진행 중 -->
        <a href="reservation.jsp" class="block bg-white rounded-xl p-4 border-l-4 border-blue-600 shadow-sm">
            <div class="flex justify-between items-start mb-2">
                <h3 class="font-semibold text-gray-900 text-sm">로보틱스 동아리실</h3>
                <span class="text-xs bg-green-100 text-green-800 px-2 py-1 rounded-full">진행 중</span>
            </div>
            <p class="text-sm text-gray-600 mb-2">오늘 12:00 - 14:00</p>
            <p class="text-xs text-gray-400 mb-2">예약 번호: R-202503-001</p>
            <div class="flex space-x-2 text-xs">
                <button class="flex-1 py-2 bg-gray-100 text-gray-700 rounded-lg">연장 요청</button>
                <button class="flex-1 py-2 bg-red-100 text-red-700 rounded-lg">취소하기</button>
            </div>
        </a>

        <!-- 카드 2 : 예약됨 -->
        <a href="reservation.jsp" class="block bg-white rounded-xl p-4 shadow-sm">
            <div class="flex justify-between items-start mb-2">
                <h3 class="font-semibold text-gray-900 text-sm">밴드 연습실</h3>
                <span class="text-xs bg-blue-100 text-blue-800 px-2 py-1 rounded-full">예약됨</span>
            </div>
            <p class="text-sm text-gray-600 mb-2">내일 18:00 - 20:00</p>
            <p class="text-xs text-gray-400 mb-2">예약 번호: R-202503-002</p>
            <div class="flex space-x-2 text-xs">
                <button class="flex-1 py-2 bg-gray-100 text-gray-700 rounded-lg">시간 변경</button>
                <button class="flex-1 py-2 bg-red-100 text-red-700 rounded-lg">취소하기</button>
            </div>
        </a>

        <!-- 카드 3 : 완료됨 -->
        <div class="bg-white rounded-xl p-4 shadow-sm">
            <div class="flex justify-between items-start mb-2">
                <h3 class="font-semibold text-gray-900 text-sm">게임개발실</h3>
                <span class="text-xs bg-gray-100 text-gray-600 px-2 py-1 rounded-full">이용 완료</span>
            </div>
            <p class="text-sm text-gray-600 mb-2">2025-03-01 14:00 - 16:00</p>
            <p class="text-xs text-gray-400 mb-2">노쇼 기록 없음</p>
            <div class="text-right text-xs text-gray-400">예약 번호: R-202503-003</div>
        </div>
    </section>
</main>

<!-- 하단 네비게이션 : 내 예약 활성 -->
<nav class="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 px-4 py-2">
    <div class="flex justify-around">
        <a href="home.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-solid fa-house text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">홈</span>
        </a>

        <a href="myReservations.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-calendar text-blue-600 text-lg"></i>
            <span class="text-xs text-blue-600 font-medium">내 예약</span>
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
