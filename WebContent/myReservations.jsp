<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 내 예약</title>

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
<div class="bg-white px-4 py-3 border-b border-gray-200 flex items-center">
    <a href="home.jsp" class="text-blue-600 text-lg mr-3">
        <i class="fa-solid fa-chevron-left"></i>
    </a>
    <h1 class="text-lg font-semibold text-gray-900">내 예약</h1>
</div>

<div class="px-4 py-4 space-y-4">

    <!-- 상단 필터 -->
    <div class="flex space-x-2 mb-2">
        <button class="px-3 py-1 bg-blue-600 text-white rounded-full text-xs">진행 중</button>
        <button class="px-3 py-1 bg-gray-200 text-gray-700 rounded-full text-xs">예약됨</button>
        <button class="px-3 py-1 bg-gray-200 text-gray-700 rounded-full text-xs">완료됨</button>
        <button class="px-3 py-1 bg-gray-200 text-gray-700 rounded-full text-xs">취소됨</button>
    </div>

    <!-- TODO(백엔드/DB):
        1. session에 저장된 user_id로 예약 목록 조회
        2. 상태(진행중, 예정, 완료, 취소)별 SQL 조건 처리
        3. 반복문으로 예약 카드 출력
    -->

    <!-- 예시 예약 카드 1 -->
    <div class="bg-white rounded-xl p-4 border-l-4 border-blue-600">
        <div class="flex justify-between items-start mb-2">
            <h3 class="font-semibold text-gray-900">로보틱스 동아리실</h3>
            <span class="text-xs bg-green-100 text-green-800 px-2 py-1 rounded-full">진행 중</span>
        </div>
        <p class="text-sm text-gray-600 mb-2">오늘 12:00 - 14:00</p>

        <div class="flex space-x-2">
            <button class="flex-1 py-2 bg-gray-100 text-gray-700 rounded-lg text-xs">연장하기</button>
            <button class="flex-1 py-2 bg-red-100 text-red-700 rounded-lg text-xs">취소하기</button>
        </div>
    </div>

    <!-- 예시 예약 카드 2 -->
    <div class="bg-white rounded-xl p-4 border-l-4 border-gray-400">
        <div class="flex justify-between items-start mb-2">
            <h3 class="font-semibold text-gray-900">밴드 연습실</h3>
            <span class="text-xs bg-blue-100 text-blue-800 px-2 py-1 rounded-full">예약됨</span>
        </div>
        <p class="text-sm text-gray-600 mb-2">내일 18:00 - 20:00</p>

        <button class="w-full py-2 bg-gray-100 text-gray-700 rounded-lg text-xs">시간 변경</button>
    </div>

    <!-- 예시 예약 카드 3 -->
    <div class="bg-white rounded-xl p-4 border-l-4 border-yellow-500">
        <div class="flex justify-between items-start mb-2">
            <h3 class="font-semibold text-gray-900">게임개발실</h3>
            <span class="text-xs bg-yellow-100 text-yellow-800 px-2 py-1 rounded-full">완료됨</span>
        </div>
        <p class="text-sm text-gray-600 mb-2">지난주 15:00 - 17:00</p>
        <button class="w-full py-2 bg-gray-100 text-gray-700 rounded-lg text-xs">다시 예약하기</button>
    </div>

    <!-- 예시 예약 카드 4 -->
    <div class="bg-white rounded-xl p-4 border-l-4 border-red-500">
        <div class="flex justify-between items-start mb-2">
            <h3 class="font-semibold text-gray-900">미술실</h3>
            <span class="text-xs bg-red-100 text-red-800 px-2 py-1 rounded-full">취소됨</span>
        </div>
        <p class="text-sm text-gray-600 mb-2">오늘 10:00 예약 취소됨</p>
    </div>

</div>

<div class="pb-10"></div>

</body>
</html>
