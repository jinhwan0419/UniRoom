<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 동아리 목록</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <script> window.FontAwesomeConfig = { autoReplaceSvg: 'nest'};</script>
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

<!-- 상태바 (데모용 하드코딩) -->
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

<main class="px-3 py-3 pb-24 space-y-4">

    <!-- 상단 탭 : 오늘 / 주간 / 내 예약 / 동아리 (여기서는 동아리 활성) -->
    <section class="bg-white rounded-lg p-1 shadow-sm border border-gray-100">
        <div class="flex space-x-1 text-sm">
            <a href="home.jsp"
               class="flex-1 text-center py-2 px-3 text-gray-600 rounded-md">
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
            <button type="button"
                    class="flex-1 text-center py-2 px-3 font-medium text-blue-600 bg-blue-50 rounded-md">
                동아리
            </button>
        </div>
    </section>

    <!-- 필터 영역 -->
    <section class="bg-white rounded-xl p-3 shadow-sm border border-gray-100 space-y-3">
        <div class="flex items-center justify-between">
            <h2 class="text-sm font-semibold text-gray-900">동아리 목록</h2>
            <!-- TODO(DB): 전체 동아리 개수 표시 -->
            <span class="text-xs text-gray-400">총 4개 동아리 (샘플)</span>
        </div>

        <div class="flex flex-wrap gap-2 text-xs">
            <!-- TODO(DB): 실제 카테고리/정렬 조건과 연동 -->
            <button class="px-3 py-1 rounded-full bg-blue-600 text-white font-medium">
                전체
            </button>
            <button class="px-3 py-1 rounded-full bg-gray-100 text-gray-700">
                공학 계열
            </button>
            <button class="px-3 py-1 rounded-full bg-gray-100 text-gray-700">
                예체능
            </button>
            <button class="px-3 py-1 rounded-full bg-gray-100 text-gray-700">
                학술
            </button>
            <button class="px-3 py-1 rounded-full bg-gray-100 text-gray-700">
                인기 순
            </button>
        </div>
    </section>

    <!-- 동아리 카드 리스트 -->
    <section class="space-y-3">
        <%-- 
            TODO(DB)
            - 아래 카드 하나가 "동아리 1개"에 해당하는 UI.
            - spaces / clubs 테이블을 조회해서 forEach 로 반복 렌더링.
            - 각 카드 클릭 시 해당 동아리 전용 예약 페이지(예: reservation.jsp?clubId=XXX)로 이동하도록 수정 가능.
        --%>

        <!-- 로보틱스 동아리 -->
        <a href="reservation.jsp" class="block bg-white rounded-xl p-4 shadow-sm border border-gray-100">
            <div class="flex items-start space-x-3">
                <div class="w-10 h-10 rounded-xl bg-blue-100 flex items-center justify-center">
                    <i class="fa-solid fa-robot text-blue-600 text-lg"></i>
                </div>
                <div class="flex-1 space-y-1">
                    <div class="flex items-center justify-between">
                        <h3 class="text-sm font-semibold text-gray-900">로보틱스 동아리</h3>
                        <span class="text-[11px] px-2 py-0.5 rounded-full bg-green-50 text-green-700">
                            예약 가능
                        </span>
                    </div>
                    <p class="text-xs text-gray-600">
                        공학관 지하 1층 · 로봇 제작 및 자율주행 프로젝트 진행
                    </p>
                    <div class="flex flex-wrap gap-2 text-[11px] text-gray-500">
                        <span class="px-2 py-0.5 bg-gray-50 rounded-full">
                            최대 12명
                        </span>
                        <span class="px-2 py-0.5 bg-gray-50 rounded-full">
                            오늘 12시~14시 비어 있음
                        </span>
                    </div>
                </div>
            </div>
        </a>

        <!-- 밴드 동아리 -->
        <a href="reservation.jsp" class="block bg-white rounded-xl p-4 shadow-sm border border-gray-100">
            <div class="flex items-start space-x-3">
                <div class="w-10 h-10 rounded-xl bg-purple-100 flex items-center justify-center">
                    <i class="fa-solid fa-music text-purple-600 text-lg"></i>
                </div>
                <div class="flex-1 space-y-1">
                    <div class="flex items-center justify-between">
                        <h3 class="text-sm font-semibold text-gray-900">밴드 동아리</h3>
                        <span class="text-[11px] px-2 py-0.5 rounded-full bg-yellow-50 text-yellow-700">
                            피크타임 혼잡
                        </span>
                    </div>
                    <p class="text-xs text-gray-600">
                        학생회관 지하 2층 · 드럼 / 앰프 / 방음 완비 연습실
                    </p>
                    <div class="flex flex-wrap gap-2 text-[11px] text-gray-500">
                        <span class="px-2 py-0.5 bg-gray-50 rounded-full">
                            최대 8명
                        </span>
                        <span class="px-2 py-0.5 bg-gray-50 rounded-full">
                            18시 이후 예약 가능
                        </span>
                    </div>
                </div>
            </div>
        </a>

        <!-- 게임개발 동아리 -->
        <a href="reservation.jsp" class="block bg-white rounded-xl p-4 shadow-sm border border-gray-100">
            <div class="flex items-start space-x-3">
                <div class="w-10 h-10 rounded-xl bg-red-100 flex items-center justify-center">
                    <i class="fa-solid fa-gamepad text-red-500 text-lg"></i>
                </div>
                <div class="flex-1 space-y-1">
                    <div class="flex items-center justify-between">
                        <h3 class="text-sm font-semibold text-gray-900">게임개발 동아리</h3>
                        <span class="text-[11px] px-2 py-0.5 rounded-full bg-green-50 text-green-700">
                            예약 가능
                        </span>
                    </div>
                    <p class="text-xs text-gray-600">
                        공학관 3층 · Unity / Unreal 기반 게임 개발 스터디
                    </p>
                    <div class="flex flex-wrap gap-2 text-[11px] text-gray-500">
                        <span class="px-2 py-0.5 bg-gray-50 rounded-full">
                            최대 16명
                        </span>
                        <span class="px-2 py-0.5 bg-gray-50 rounded-full">
                            이번 주 31회 사용
                        </span>
                    </div>
                </div>
            </div>
        </a>

        <!-- 회의/세미나 동아리 -->
        <a href="reservation.jsp" class="block bg-white rounded-xl p-4 shadow-sm border border-gray-100">
            <div class="flex items-start space-x-3">
                <div class="w-10 h-10 rounded-xl bg-green-100 flex items-center justify-center">
                    <i class="fa-solid fa-users text-green-600 text-lg"></i>
                </div>
                <div class="flex-1 space-y-1">
                    <div class="flex items-center justify-between">
                        <h3 class="text-sm font-semibold text-gray-900">세미나 동아리</h3>
                        <span class="text-[11px] px-2 py-0.5 rounded-full bg-gray-100 text-gray-700">
                            일부 시간 마감
                        </span>
                    </div>
                    <p class="text-xs text-gray-600">
                        도서관 지하 세미나실 · 스터디 / 발표 / 회의용
                    </p>
                    <div class="flex flex-wrap gap-2 text-[11px] text-gray-500">
                        <span class="px-2 py-0.5 bg-gray-50 rounded-full">
                            최대 20명
                        </span>
                        <span class="px-2 py-0.5 bg-gray-50 rounded-full">
                            이번 주 35회 사용
                        </span>
                    </div>
                </div>
            </div>
        </a>
    </section>
</main>

<!-- 하단 네비게이션 : 홈 섹션으로 간주 → 홈 아이콘 활성 -->
<nav class="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 px-4 py-2">
    <div class="flex justify-around">
        <a href="home.jsp" class="flex flex-col items-center space-y-1">
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
