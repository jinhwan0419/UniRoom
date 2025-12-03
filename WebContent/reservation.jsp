<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 예약 상세</title>
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
<header class="bg-white px-4 py-3 border-b border-gray-100 flex items-center space-x-2">
    <button onclick="history.back()" class="text-gray-500 mr-2">
        <i class="fa-solid fa-chevron-left"></i>
    </button>
    <h1 class="text-lg font-semibold text-gray-900">예약 상세</h1>
</header>

<main class="px-4 py-4 pb-24 space-y-4">
    <!-- 상단 이미지 -->
    <section class="h-48 bg-gray-200 rounded-xl overflow-hidden">
        <!-- TODO(DB): 동아리실별 실제 이미지 경로 바인딩 -->
        <img class="w-full h-full object-cover"
             src="https://storage.googleapis.com/uxpilot-auth.appspot.com/4127b161ce-fecf84a66c2db42a2320.png"
             alt="club room image"/>
    </section>

    <!-- 공간 정보 -->
    <section class="bg-white rounded-xl p-4 space-y-3 shadow-sm">
        <!-- TODO(DB): roomId 파라미터로 해당 공간 정보 조회해서 채우기 -->
        <h2 class="text-lg font-bold text-gray-900">로보틱스 동아리실</h2>

        <div class="flex flex-wrap items-center gap-3 text-sm text-gray-600">
            <div class="flex items-center space-x-1">
                <i class="fa-solid fa-users text-blue-600"></i>
                <span>최대 12명</span>
            </div>
            <div class="flex items-center space-x-1">
                <i class="fa-solid fa-wifi text-blue-600"></i>
                <span>무선 인터넷</span>
            </div>
            <div class="flex items-center space-x-1">
                <i class="fa-solid fa-tv text-blue-600"></i>
                <span>프로젝터</span>
            </div>
        </div>

        <p class="text-xs text-gray-500">
            위치: 공학관 지하 1층 · 로보틱스 동아리 전용 공간
        </p>
    </section>

    <!-- 날짜/시간 선택 -->
    <section class="bg-white rounded-xl p-4 shadow-sm space-y-3">
        <h3 class="font-semibold text-gray-900 mb-1">날짜 / 시간 선택</h3>

        <!-- 날짜 선택 -->
        <div>
            <label class="text-xs text-gray-500 block mb-1">날짜</label>
            <!-- TODO(DB): 캘린더 위젯 및 예약 불가일 처리 -->
            <input type="date"
                   class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                   value="">
        </div>

        <!-- 시간 선택 -->
        <div>
            <label class="text-xs text-gray-500 block mb-2">시간대 선택</label>
            <!-- TODO(DB): timeslots 테이블과 연동해서 사용 가능/불가 표시 -->
            <div class="grid grid-cols-3 gap-2 text-sm">
                <button class="py-2 px-3 border border-gray-200 rounded-lg hover:bg-blue-50 hover:border-blue-300">
                    10:00
                </button>
                <button class="py-2 px-3 border border-gray-200 rounded-lg hover:bg-blue-50 hover:border-blue-300">
                    11:00
                </button>
                <button class="py-2 px-3 bg-blue-600 text-white rounded-lg">
                    12:00
                </button>
                <button class="py-2 px-3 bg-blue-600 text-white rounded-lg">
                    13:00
                </button>
                <button class="py-2 px-3 border border-gray-200 rounded-lg hover:bg-blue-50 hover:border-blue-300">
                    14:00
                </button>
                <button class="py-2 px-3 border border-gray-200 rounded-lg hover:bg-blue-50 hover:border-blue-300">
                    15:00
                </button>
            </div>
        </div>

        <!-- 인원수 -->
        <div>
            <label class="text-xs text-gray-500 block mb-1">인원 수</label>
            <!-- TODO(DB): 최대 수용 인원과 검증 -->
            <input type="number" min="1" max="12" value="4"
                   class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
        </div>
    </section>

    <!-- 안내 문구 -->
    <section class="text-xs text-gray-500 space-y-1">
        <p>· 예약 시간 2시간 미만 남은 경우 취소가 제한될 수 있습니다.</p>
        <p>· 노쇼 발생 시 자동으로 패널티가 부여됩니다.</p>
    </section>

    <!-- 예약 버튼 -->
    <!-- TODO(DB): 클릭 시 ReservationServlet 등으로 POST 요청 보내기 -->
    <button class="w-full bg-blue-600 text-white py-3 rounded-xl font-medium shadow-sm">
        선택한 시간으로 예약하기
    </button>
</main>

<!-- 하단 네비게이션 : 특정 탭 활성 X (전부 회색) -->
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
