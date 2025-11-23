<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 예약 상세</title>

    <!-- Tailwind -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- FontAwesome -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

    <!-- Pretendard -->
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        ::-webkit-scrollbar { display: none; }
        * { font-family: 'Pretendard', sans-serif; }
    </style>
</head>

<body class="bg-gray-50 text-gray-900">

<!-- ▣ Header -->
<div class="bg-white px-4 py-3 border-b border-gray-200 flex items-center">
    <a href="home.jsp" class="text-blue-600 text-lg mr-3">
        <i class="fa-solid fa-chevron-left"></i>
    </a>
    <h1 class="text-lg font-semibold text-gray-900">예약 상세</h1>
</div>

<!-- 컨테이너 -->
<div class="px-4 py-4 space-y-4">

    <!-- ▣ DB 작업 구간 -->
    <!-- TODO(백엔드/DB):
        1. room_id 파라미터로 해당 공간 정보 조회
        2. 동아리실 이름, 수용인원, 비품, 이미지 URL을 DB에서 로드
        3. 예약 가능 시간대 목록도 DB에서 로드
    -->

    <!-- 동아리실 이미지 -->
    <div class="h-48 bg-gray-200 rounded-xl overflow-hidden">
        <img class="w-full h-full object-cover"
             src="https://storage.googleapis.com/uxpilot-auth.appspot.com/4127b161ce-fecf84a66c2db42a2320.png"
             alt="room image">
    </div>

    <!-- 공간 정보 -->
    <div class="bg-white rounded-xl p-4 space-y-3">
        <h3 class="text-lg font-bold text-gray-900">로보틱스 동아리실</h3>

        <!-- 편의 정보 -->
        <div class="flex items-center space-x-4 text-sm text-gray-600">

            <div class="flex items-center space-x-1">
                <i class="fa-solid fa-users text-blue-600"></i>
                <span>최대 12명</span>
            </div>

            <div class="flex items-center space-x-1">
                <i class="fa-solid fa-wifi text-blue-600"></i>
                <span>Wi-Fi</span>
            </div>

            <div class="flex items-center space-x-1">
                <i class="fa-solid fa-tv text-blue-600"></i>
                <span>프로젝터</span>
            </div>
        </div>
    </div>

    <!-- 시간 선택 -->
    <div class="bg-white rounded-xl p-4">
        <h4 class="font-semibold text-gray-900 mb-3">시간 선택</h4>

        <!-- TODO(백엔드/DB팀):  
             타임슬롯 테이블(periods)에서 해당 날짜의 예약 가능/불가 정보 불러오기
        -->

        <div class="grid grid-cols-3 gap-2">

            <!-- 사용 가능 시간 -->
            <button class="py-2 px-3 border border-gray-200 rounded-lg text-sm hover:bg-blue-50">
                09:00
            </button>

            <button class="py-2 px-3 border border-gray-200 rounded-lg text-sm hover:bg-blue-50">
                10:00
            </button>

            <!-- 선택된 시간 -->
            <button class="py-2 px-3 bg-blue-600 text-white rounded-lg text-sm">
                11:00
            </button>

            <button class="py-2 px-3 border border-gray-200 rounded-lg text-sm hover:bg-blue-50">
                12:00
            </button>

            <!-- 예약 불가 상태 예시 -->
            <button class="py-2 px-3 bg-gray-200 text-gray-400 rounded-lg text-sm cursor-not-allowed">
                13:00
            </button>

        </div>
    </div>

    <!-- 예약 버튼 -->
    <!-- TODO(DB/백엔드):
        클릭 시 reservationInsert.jsp or 예약 서블릿으로 POST 요청
        해당 room_id, user_id, 날짜, 시간 전달 → DB insert 
    -->
    <button class="w-full bg-blue-600 text-white py-3 rounded-xl font-medium">
        선택한 시간으로 예약하기
    </button>

</div>

<div class="pb-10"></div>

</body>
</html>
