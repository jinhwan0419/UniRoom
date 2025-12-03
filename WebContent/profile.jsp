<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // TODO(DB팀):
    // 세션에서 로그인 사용자 정보 가져오기
    // String userName = (String) session.getAttribute("userName");
    // String clubName = (String) session.getAttribute("clubName");
    // String role = (String) session.getAttribute("role"); // USER / ADMIN 등
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 프로필</title>

    <!-- Tailwind -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- FontAwesome -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <!-- Pretendard -->
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        ::-webkit-scrollbar { display: none; }
        * { font-family: 'Pretendard', sans-serif; }
    </style>
</head>

<body class="bg-gray-50 text-gray-900">

<!-- 간단 상태바 -->
<div class="bg-black text-white text-xs py-1 px-4 flex justify-between items-center">
    <span>9:41</span>
    <div class="flex items-center space-x-1">
        <i class="fa-solid fa-signal text-xs"></i>
        <i class="fa-solid fa-wifi text-xs"></i>
        <i class="fa-solid fa-battery-three-quarters text-xs"></i>
    </div>
</div>

<!-- Header -->
<div class="bg-white px-4 py-3 border-b border-gray-200">
    <h1 class="text-center text-blue-600 text-lg font-medium">프로필</h1>
</div>

<div class="px-4 py-6 pb-24"><%-- pb-24: 하단 네비와 겹치지 않게 여백 --%>

    <%-- TODO(DB팀):
        1. session에서 userName, clubName 가져와서 아래 텍스트 대체
        2. 프로필 이미지 URL 있으면 동적으로 교체
    --%>

    <!-- 프로필 영역 -->
    <div class="text-center mb-6">
        <div class="w-20 h-20 mx-auto mb-3">
            <img src="https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-3.jpg"
                 alt="Profile"
                 class="w-full h-full rounded-full object-cover">
        </div>
        <h2 class="text-lg font-semibold text-gray-900">김동아</h2>
        <p class="text-sm text-gray-600">로보틱스 동아리</p>
    </div>

    <!-- 메뉴 카드들 -->
    <div class="space-y-4">

        <!-- 예약 관련 메뉴 -->
        <div class="bg-white rounded-xl overflow-hidden shadow-sm border border-gray-100">

            <!-- 예약 내역 -->
            <a href="myReservations.jsp" class="flex items-center justify-between px-4 py-3 border-b border-gray-100">
                <div class="flex items-center space-x-3">
                    <i class="fa-solid fa-calendar text-blue-600"></i>
                    <span class="text-gray-900 text-sm">예약 내역</span>
                </div>
                <i class="fa-solid fa-chevron-right text-gray-400 text-xs"></i>
            </a>

            <!-- 즐겨찾는 공간 (추후 기능) -->
            <a href="#" class="flex items-center justify-between px-4 py-3 border-b border-gray-100">
                <div class="flex items-center space-x-3">
                    <i class="fa-solid fa-heart text-blue-600"></i>
                    <span class="text-gray-900 text-sm">즐겨찾는 공간</span>
                </div>
                <i class="fa-solid fa-chevron-right text-gray-400 text-xs"></i>
            </a>

            <!-- 알림 설정 (추후 기능) -->
            <a href="#" class="flex items-center justify-between px-4 py-3">
                <div class="flex items-center space-x-3">
                    <i class="fa-solid fa-bell text-blue-600"></i>
                    <span class="text-gray-900 text-sm">알림 설정</span>
                </div>
                <i class="fa-solid fa-chevron-right text-gray-400 text-xs"></i>
            </a>

        </div>

        <!-- 도움말 / 앱 정보 / 로그아웃 / 관리자 -->
        <div class="bg-white rounded-xl overflow-hidden shadow-sm border border-gray-100">

            <!-- 도움말 -->
            <a href="help.jsp" class="flex items-center justify-between px-4 py-3 border-b border-gray-100">
                <div class="flex items-center space-x-3">
                    <i class="fa-solid fa-question-circle text-blue-600"></i>
                    <span class="text-gray-900 text-sm">도움말</span>
                </div>
                <i class="fa-solid fa-chevron-right text-gray-400 text-xs"></i>
            </a>

            <!-- 앱 정보 -->
            <a href="appInfo.jsp" class="flex items-center justify-between px-4 py-3 border-b border-gray-100">
                <div class="flex items-center space-x-3">
                    <i class="fa-solid fa-info-circle text-blue-600"></i>
                    <span class="text-gray-900 text-sm">앱 정보</span>
                </div>
                <i class="fa-solid fa-chevron-right text-gray-400 text-xs"></i>
            </a>

            <!-- 관리자 대시보드 (테스트용 메뉴) -->
            <%-- TODO(DB팀): role이 ADMIN/STAFF일 때만 이 메뉴가 보이도록 처리 --%>
            <a href="adminDashboard.jsp" class="flex items-center justify-between px-4 py-3 border-b border-gray-100">
                <div class="flex items-center space-x-3">
                    <i class="fa-solid fa-toolbox text-blue-600"></i>
                    <span class="text-gray-900 text-sm">관리자 대시보드</span>
                </div>
                <i class="fa-solid fa-chevron-right text-gray-400 text-xs"></i>
            </a>

            <!-- 로그아웃 -->
            <a href="logout.jsp" class="flex items-center justify-between px-4 py-3">
                <div class="flex items-center space-x-3">
                    <i class="fa-solid fa-sign-out-alt text-red-600"></i>
                    <span class="text-red-600 text-sm">로그아웃</span>
                </div>
                <i class="fa-solid fa-chevron-right text-gray-400 text-xs"></i>
            </a>

        </div>

    </div>

</div>

<!-- 하단 네비게이션 -->
<div class="fixed bottom-0 left-0 right-0 bg-white border-top border-gray-200 px-4 py-2 border-t">
    <div class="flex justify-around">
        <!-- 홈 -->
        <a href="home.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-solid fa-house text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">홈</span>
        </a>
        <!-- 내 예약 -->
        <a href="myReservations.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-calendar text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">예약</span>
        </a>
        <!-- 알림 (현재는 예약 상세로 연결) -->
        <a href="reservation.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-bell text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">알림</span>
        </a>
        <!-- 프로필(활성) -->
        <a href="profile.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-user text-blue-600 text-lg"></i>
            <span class="text-xs text-blue-600 font-medium">프로필</span>
        </a>
    </div>
</div>

</body>
</html>
