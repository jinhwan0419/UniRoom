<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 관리자 대시보드</title>

    <!-- Tailwind -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- FontAwesome -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
    <!-- Pretendard -->
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        * { font-family: 'Pretendard', sans-serif; }
        ::-webkit-scrollbar { display: none; }
    </style>
</head>

<body class="bg-gray-50 text-gray-900">

<!-- 상단 헤더 -->
<div class="bg-white px-4 py-3 border-b border-gray-200 flex items-center justify-between">
    <h1 class="text-lg font-semibold text-blue-600">관리자 대시보드</h1>
    <a href="home.jsp" class="text-sm text-gray-500">
        <i class="fa-solid fa-arrow-left mr-1"></i>사용자 화면
    </a>
</div>

<div class="px-4 py-4 space-y-5">

    <%-- TODO(백엔드/DB팀)
        1. 관리자인지 확인 (세션의 role == 'ADMIN' 또는 'MANAGER')
        2. 오늘 예약 수, 이번 주 예약 수, 사용 중인 공간 수 조회
        3. 최근 예약 목록, 노쇼/패널티 상위 사용자 목록 조회
    --%>

    <!-- 상단 요약 카드들 -->
    <section class="grid grid-cols-1 md:grid-cols-3 gap-3">

        <!-- 오늘 예약 건수 -->
        <div class="bg-white rounded-xl p-4 shadow-sm flex items-center space-x-3">
            <div class="w-10 h-10 rounded-lg bg-blue-100 flex items-center justify-center">
                <i class="fa-solid fa-calendar-check text-blue-600"></i>
            </div>
            <div>
                <p class="text-xs text-gray-500">오늘 예약</p>
                <%-- TODO: 오늘 예약 건수 동적 출력 --%>
                <p class="text-lg font-bold">12건</p>
            </div>
        </div>

        <!-- 이번 주 예약 -->
        <div class="bg-white rounded-xl p-4 shadow-sm flex items-center space-x-3">
            <div class="w-10 h-10 rounded-lg bg-green-100 flex items-center justify-center">
                <i class="fa-solid fa-calendar-week text-green-600"></i>
            </div>
            <div>
                <p class="text-xs text-gray-500">이번 주 예약</p>
                <%-- TODO: 이번 주 예약 건수 동적 출력 --%>
                <p class="text-lg font-bold">48건</p>
            </div>
        </div>

        <!-- 현재 사용 중 공간 -->
        <div class="bg-white rounded-xl p-4 shadow-sm flex items-center space-x-3">
            <div class="w-10 h-10 rounded-lg bg-yellow-100 flex items-center justify-center">
                <i class="fa-solid fa-door-open text-yellow-600"></i>
            </div>
            <div>
                <p class="text-xs text-gray-500">현재 사용 중인 공간</p>
                <%-- TODO: 현재 진행 중인 예약 수 동적 출력 --%>
                <p class="text-lg font-bold">3개</p>
            </div>
        </div>

    </section>

    <!-- 오늘 예약 목록 -->
    <section class="bg-white rounded-xl p-4 shadow-sm">
        <div class="flex items-center justify-between mb-3">
            <h2 class="text-sm font-semibold text-gray-800">오늘 예약 목록</h2>
            <a href="#" class="text-xs text-blue-600">전체 보기</a>
        </div>

        <%-- TODO(DB):
            오늘 날짜 기준 reservations + users + rooms JOIN해서
            최근 순 / 시간 순으로 5~10개 조회해서 반복 출력
        --%>

        <div class="space-y-2 text-sm">

            <!-- 예시 아이템 -->
            <div class="flex items-center justify-between py-2 border-b border-gray-100">
                <div>
                    <p class="font-medium text-gray-900">로보틱스 동아리실</p>
                    <p class="text-xs text-gray-500">10:00 - 12:00 · 20201234 김학생</p>
                </div>
                <span class="text-xs px-2 py-1 rounded-full bg-green-100 text-green-700">진행 예정</span>
            </div>

            <div class="flex items-center justify-between py-2 border-b border-gray-100">
                <div>
                    <p class="font-medium text-gray-900">밴드 연습실</p>
                    <p class="text-xs text-gray-500">13:00 - 15:00 · 20194567 박밴드</p>
                </div>
                <span class="text-xs px-2 py-1 rounded-full bg-blue-100 text-blue-700">예약됨</span>
            </div>

            <div class="flex items-center justify-between py-2">
                <div>
                    <p class="font-medium text-gray-900">게임개발실</p>
                    <p class="text-xs text-gray-500">16:00 - 18:00 · 20207890 이개발</p>
                </div>
                <span class="text-xs px-2 py-1 rounded-full bg-yellow-100 text-yellow-700">사용 중</span>
            </div>

        </div>
    </section>

    <!-- 노쇼/패널티 요약 -->
    <section class="bg-white rounded-xl p-4 shadow-sm">
        <div class="flex items-center justify-between mb-3">
            <h2 class="text-sm font-semibold text-gray-800">노쇼 / 패널티 현황</h2>
            <a href="adminPenalties.jsp" class="text-xs text-blue-600">자세히 보기</a>
        </div>

        <%-- TODO(DB):
            penalties 테이블 기준으로 최근 노쇼 사용자 TOP N 조회
        --%>

        <div class="space-y-2 text-sm">

            <div class="flex items-center justify-between py-1">
                <div>
                    <p class="font-medium text-gray-900">20201234 김학생</p>
                    <p class="text-xs text-gray-500">노쇼 2회 · 일시: 2025-03-01, 2025-03-05</p>
                </div>
                <span class="text-xs px-2 py-1 rounded-full bg-red-100 text-red-700">주의</span>
            </div>

            <div class="flex items-center justify-between py-1">
                <div>
                    <p class="font-medium text-gray-900">20194567 박밴드</p>
                    <p class="text-xs text-gray-500">노쇼 3회 · 예약 제한</p>
                </div>
                <span class="text-xs px-2 py-1 rounded-full bg-red-200 text-red-800">제한</span>
            </div>

        </div>
    </section>

    <!-- 관리 메뉴 이동 -->
    <section class="grid grid-cols-2 gap-3">
        <a href="adminRooms.jsp" class="bg-white rounded-xl p-4 shadow-sm flex flex-col items-center justify-center space-y-2">
            <i class="fa-solid fa-door-open text-blue-600 text-xl"></i>
            <span class="text-sm font-medium text-gray-800">공간 관리</span>
        </a>

        <a href="adminPenalties.jsp" class="bg-white rounded-xl p-4 shadow-sm flex flex-col items-center justify-center space-y-2">
            <i class="fa-solid fa-user-slash text-red-500 text-xl"></i>
            <span class="text-sm font-medium text-gray-800">패널티 관리</span>
        </a>
    </section>

</div>

</body>
</html>
