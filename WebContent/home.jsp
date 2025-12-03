<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <!-- 상단 탭 : 오늘 / 주간 / 내 예약 / 동아리 -->
    <section class="bg-white rounded-lg p-1 shadow-sm border border-gray-100">
        <div class="flex space-x-1 text-sm">
            <!-- 오늘 (현재 화면) -->
            <a href="home.jsp"
               class="flex-1 text-center py-2 px-3 font-medium text-blue-600 bg-blue-50 rounded-md">
                오늘
            </a>

            <!-- 주간 : 아직 기능 없음 → 비활성/준비중 표시 -->
            <button type="button"
                    class="flex-1 text-center py-2 px-3 text-gray-400 bg-gray-50 rounded-md cursor-not-allowed">
                주간(준비 중)
            </button>

            <!-- 내 예약으로 이동 -->
            <a href="myReservations.jsp"
               class="flex-1 text-center py-2 px-3 text-gray-600 rounded-md">
                내 예약
            </a>

            <!-- 동아리 목록(추후 DB연동) -->
            <a href="clubs.jsp"
               class="flex-1 text-center py-2 px-3 text-gray-600 rounded-md">
                동아리
            </a>
        </div>
    </section>

    <!-- 추천 공간 캐러셀 -->
    <section class="space-y-2">
        <h2 class="text-sm font-medium text-gray-800 px-1">추천 공간</h2>
        <div class="flex space-x-2 overflow-x-auto">
            <!-- TODO(DB): 실제 추천 로직과 이미지/텍스트를 DB에서 가져오기 -->
            <a href="reservation.jsp" class="min-w-[200px] bg-white rounded-lg p-3 shadow-sm border border-gray-100">
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

            <a href="reservation.jsp" class="min-w-[200px] bg-white rounded-lg p-3 shadow-sm border border-gray-100">
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

    <!-- 필터 -->
    <section class="flex space-x-2">
        <!-- TODO(DB): 실제 날짜/동아리/시간 필터와 연동 -->
        <select class="flex-1 bg-white border border-gray-200 rounded-lg px-3 py-2 text-sm">
            <option>날짜 선택</option>
        </select>
        <select class="flex-1 bg-white border border-gray-200 rounded-lg px-3 py-2 text-sm">
            <option>동아리 선택</option>
        </select>
        <select class="flex-1 bg-white border border-gray-200 rounded-lg px-3 py-2 text-sm">
            <option>시간</option>
        </select>
    </section>

    <!-- 인기 예약 현황 -->
    <section class="space-y-2">
        <h2 class="text-sm font-medium text-gray-800 px-1">인기 예약 현황</h2>
        <div class="space-y-1">
            <!-- 카드 1 -->
            <a href="reservation.jsp" class="block bg-white rounded-lg p-3 shadow-sm border border-gray-100">
                <div class="flex items-center justify-between">
                    <div class="flex items-center space-x-3">
                        <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                            <i class="fa-solid fa-robot text-blue-600 text-sm"></i>
                        </div>
                        <div class="flex-1">
                            <h3 class="text-sm font-medium">로보틱스실</h3>
                            <p class="text-xs text-green-600">사용 가능</p>
                            <p class="text-xs text-gray-500">이번 주 42회 사용</p>
                        </div>
                    </div>
                    <button class="w-6 h-6 text-gray-400">
                        <i class="fa-regular fa-star text-sm"></i>
                    </button>
                </div>
            </a>

            <!-- 카드 2 -->
            <a href="reservation.jsp" class="block bg-white rounded-lg p-3 shadow-sm border border-gray-100">
                <div class="flex items-center justify-between">
                    <div class="flex items-center space-x-3">
                        <div class="w-10 h-10 bg-purple-100 rounded-lg flex items-center justify-center">
                            <i class="fa-solid fa-music text-purple-600 text-sm"></i>
                        </div>
                        <div class="flex-1">
                            <h3 class="text-sm font-medium">밴드 연습실</h3>
                            <p class="text-xs text-red-500">예약됨</p>
                            <p class="text-xs text-gray-500">이번 주 28회 사용</p>
                        </div>
                    </div>
                    <button class="w-6 h-6 text-gray-400">
                        <i class="fa-regular fa-star text-sm"></i>
                    </button>
                </div>
            </a>

            <!-- 카드 3 -->
            <a href="reservation.jsp" class="block bg-white rounded-lg p-3 shadow-sm border border-gray-100">
                <div class="flex items-center justify-between">
                    <div class="flex items-center space-x-3">
                        <div class="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center">
                            <i class="fa-solid fa-users text-green-600 text-sm"></i>
                        </div>
                        <div class="flex-1">
                            <h3 class="text-sm font-medium">회의실 A</h3>
                            <p class="text-xs text-yellow-600">이용 중</p>
                            <p class="text-xs text-gray-500">이번 주 35회 사용</p>
                        </div>
                    </div>
                    <button class="w-6 h-6 text-gray-400">
                        <i class="fa-solid fa-star text-yellow-400 text-sm"></i>
                    </button>
                </div>
            </a>
        </div>
    </section>
</main>

<!-- 하단 네비게이션 : 홈 활성 -->
<nav class="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 px-4 py-2">
    <div class="flex justify-around">
        <!-- 홈 (활성) -->
        <a href="home.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-solid fa-house text-blue-600 text-lg"></i>
            <span class="text-xs text-blue-600 font-medium">홈</span>
        </a>

        <!-- 내 예약 -->
        <a href="myReservations.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-calendar text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">내 예약</span>
        </a>

        <!-- 알림 -->
        <a href="notifications.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-bell text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">알림</span>
        </a>

        <!-- 프로필 -->
        <a href="profile.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-user text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">프로필</span>
        </a>
    </div>
</nav>

</body>
</html>
