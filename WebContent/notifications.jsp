<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 알림</title>
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

<!-- 상단 헤더 -->
<header class="bg-white px-4 py-3 border-b border-gray-100">
    <h1 class="text-lg font-semibold text-gray-900 text-center">알림</h1>
</header>

<main class="px-4 py-4 pb-24 space-y-4">
    <!-- 알림 필터 (전체 / 예약 / 패널티 등) -->
    <div class="flex space-x-2 text-xs">
        <!-- TODO(DB): 클릭 시 type별 필터링 -->
        <button class="px-3 py-1 rounded-full bg-blue-600 text-white font-medium">전체</button>
        <button class="px-3 py-1 rounded-full bg-gray-100 text-gray-600">예약</button>
        <button class="px-3 py-1 rounded-full bg-gray-100 text-gray-600">패널티</button>
        <button class="px-3 py-1 rounded-full bg-gray-100 text-gray-600">공지</button>
    </div>

    <!-- 알림 리스트 -->
    <section class="space-y-3 text-sm">
        <!-- TODO(DB): notifications 테이블에서 최신순으로 조회 후 반복 출력 -->

        <!-- 알림 1 : 예약 임박 -->
        <a href="myReservations.jsp"
           class="block bg-white rounded-xl p-4 shadow-sm border border-blue-100">
            <div class="flex justify-between items-center mb-1">
                <h2 class="font-semibold text-gray-900">예약 시간 2시간 전 안내</h2>
                <span class="text-[10px] text-gray-400">오늘 10:00</span>
            </div>
            <p class="text-gray-700">
                오늘 12:00에 예약된 <span class="font-medium">로보틱스 동아리실</span> 이용 시간이 다가오고 있습니다.
                이용이 어려운 경우 지금 취소하지 않으면 패널티가 부여될 수 있습니다.
            </p>
        </a>

        <!-- 알림 2 : 패널티 경고 -->
        <a href="profile.jsp"
           class="block bg-white rounded-xl p-4 shadow-sm border border-red-100">
            <div class="flex justify-between items-center mb-1">
                <h2 class="font-semibold text-gray-900">노쇼 패널티 1회 부여</h2>
                <span class="text-[10px] text-gray-400">어제 18:30</span>
            </div>
            <p class="text-gray-700">
                어제 18:00 - 20:00 밴드 연습실 예약에 미입실하여 노쇼로 처리되었습니다.
                현재 누적 패널티는 <span class="font-semibold text-red-500">1회</span>입니다.
            </p>
        </a>

        <!-- 알림 3 : 시스템 공지 -->
        <div class="bg-white rounded-xl p-4 shadow-sm border border-gray-100">
            <div class="flex justify-between items-center mb-1">
                <h2 class="font-semibold text-gray-900">정기 점검 안내</h2>
                <span class="text-[10px] text-gray-400">2025-03-01 09:00</span>
            </div>
            <p class="text-gray-700">
                3월 5일(수) 02:00 ~ 04:00 동안 UniRoom 시스템 정기 점검이 예정되어 있습니다.
                점검 시간 동안은 예약 생성 및 변경이 제한됩니다.
            </p>
        </div>
    </section>
</main>

<!-- 하단 네비게이션 : 알림 활성 -->
<nav class="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 px-4 py-2">
    <div class="flex justify-around">
        <a href="home.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-solid fa-house text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">홈</span>
        </a>

        <a href="myReservations.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-calendar text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">내 예약</span>
        </a>

        <a href="notifications.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-bell text-blue-600 text-lg"></i>
            <span class="text-xs text-blue-600 font-medium">알림</span>
        </a>

        <a href="profile.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-user text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">프로필</span>
        </a>
    </div>
</nav>

</body>
</html>
