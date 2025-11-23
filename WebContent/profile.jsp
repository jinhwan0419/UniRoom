<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 프로필</title>

    <!-- Tailwind -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- FontAwesome -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

    <!-- Pretendard -->
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        ::-webkit-scrollbar { display: none; }
        * { font-family: 'Pretendard', sans-serif; }
    </style>
</head>

<body class="bg-gray-50 text-gray-900">

<!-- Header -->
<div class="bg-white px-4 py-3 border-b border-gray-200">
    <h1 class="text-center text-blue-600 text-lg font-medium">프로필</h1>
</div>

<div class="px-4 py-6">

    <!-- TODO(DB):
        1. session에서 로그인된 user_id 가져오기
        2. users 테이블에서 사용자 정보 조회
        3. 동아리 소속 정보 JOIN해서 가져오기
        4. 프로필 사진 경로 로드
    -->

    <!-- 프로필 이미지 -->
    <div class="text-center mb-6">
        <div class="w-24 h-24 mx-auto mb-3">
            <img src="https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-3.jpg"
                 alt="Profile"
                 class="w-full h-full rounded-full object-cover">
        </div>

        <h2 class="text-lg font-semibold text-gray-900">김동아</h2>
        <p class="text-sm text-gray-600">로보틱스 동아리</p>
    </div>

    <!-- 메뉴 카드 -->
    <div class="space-y-4">

        <!-- 예약 내역 -->
        <a href="myReservations.jsp" class="block bg-white rounded-xl p-4 border border-gray-100">
            <div class="flex items-center justify-between">
                <div class="flex items-center space-x-3">
                    <i class="fa-solid fa-calendar text-blue-600"></i>
                    <span class="text-gray-900">예약 내역</span>
                </div>
                <i class="fa-solid fa-chevron-right text-gray-400"></i>
            </div>
        </a>

        <!-- 즐겨찾는 공간 -->
        <a href="#" class="block bg-white rounded-xl p-4 border border-gray-100">
            <div class="flex items-center justify-between">
                <div class="flex items-center space-x-3">
                    <i class="fa-solid fa-heart text-blue-600"></i>
                    <span class="text-gray-900">즐겨찾는 공간</span>
                </div>
                <i class="fa-solid fa-chevron-right text-gray-400"></i>
            </div>
        </a>

        <!-- 알림 설정 -->
        <a href="#" class="block bg-white rounded-xl p-4 border border-gray-100">
            <div class="flex items-center justify-between">
                <div class="flex items-center space-x-3">
                    <i class="fa-solid fa-bell text-blue-600"></i>
                    <span class="text-gray-900">알림 설정</span>
                </div>
                <i class="fa-solid fa-chevron-right text-gray-400"></i>
            </div>
        </a>

        <!-- 도움말 -->
        <a href="#" class="block bg-white rounded-xl p-4 border border-gray-100">
            <div class="flex items-center justify-between">
                <div class="flex items-center space-x-3">
                    <i class="fa-solid fa-question-circle text-blue-600"></i>
                    <span class="text-gray-900">도움말</span>
                </div>
                <i class="fa-solid fa-chevron-right text-gray-400"></i>
            </div>
        </a>

        <!-- 앱 정보 -->
        <a href="#" class="block bg-white rounded-xl p-4 border border-gray-100">
            <div class="flex items-center justify-between">
                <div class="flex items-center space-x-3">
                    <i class="fa-solid fa-info-circle text-blue-600"></i>
                    <span class="text-gray-900">앱 정보</span>
                </div>
                <i class="fa-solid fa-chevron-right text-gray-400"></i>
            </div>
        </a>

        <!-- 로그아웃 -->
        <!-- TODO(DB): session.invalidate() 후 login.jsp로 redirect -->
        <a href="logout.jsp" class="block bg-white rounded-xl p-4 border border-gray-100">
            <div class="flex items-center justify-between">
                <div class="flex items-center space-x-3">
                    <i class="fa-solid fa-sign-out-alt text-red-600"></i>
                    <span class="text-red-600">로그아웃</span>
                </div>
                <i class="fa-solid fa-chevron-right text-gray-400"></i>
            </div>
        </a>

    </div>

</div>

<div class="pb-16"></div>

</body>
</html>
