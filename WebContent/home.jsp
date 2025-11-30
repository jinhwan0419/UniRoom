<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 홈</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        ::-webkit-scrollbar { display: none; }
        * { font-family: 'Pretendard', sans-serif; }
    </style>
</head>

<body class="bg-gray-50 text-gray-900">
<%
    String cpath = request.getContextPath();
    String today = java.time.LocalDate.now().toString();   // 오늘 날짜 (YYYY-MM-DD)
%>

<!-- Header -->
<div class="bg-white px-4 py-3 border-b border-gray-100">
    <h1 class="text-center text-blue-600 text-lg font-medium">UniRoom</h1>
</div>

<div class="px-3 py-3 space-y-3">

    <!-- 추천 공간 -->
    <!-- TODO(DB): 
         1. reservations 테이블 기반 인기 공간 SELECT
         2. 다음 1~2개 추천 공간을 반복문으로 출력
    -->
    <div class="space-y-2">
        <h2 class="text-sm font-medium text-gray-800 px-1">추천 공간</h2>

       <div class="flex space-x-2 overflow-x-auto">
    <!-- 반복문 자리 -->
    <a href="<%=cpath%>/reservation?action=form&roomId=1&reserveDate=<%=today%>"
       class="min-w-[200px] bg-white rounded-lg p-3 shadow-sm border border-gray-100 block">
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
</div>

    </div>

    <!-- 상단 탭 -->
   <div class="bg-white rounded-lg p-1 shadow-sm border border-gray-100">
    <div class="flex space-x-1">
        <button class="flex-1 py-2 px-3 text-sm font-medium text-blue-600 bg-blue-50 rounded-md">오늘</button>
        <button class="flex-1 py-2 px-3 text-sm text-gray-600">주간</button>

        <!-- 내 예약 탭: 리스트로 이동 -->
        <a href="<%=cpath%>/reservation?action=list"
           class="flex-1 py-2 px-3 text-sm text-gray-600 text-center rounded-md">
            내 예약
        </a>

        <button class="flex-1 py-2 px-3 text-sm text-gray-600">동아리</button>
    </div>
</div>

    <!-- 필터 -->
    <!-- TODO(DB):
         1. 날짜 필터 → 달력 또는 서버 날짜 리스트 출력
         2. 동아리 선택 → clubs 테이블 불러오기
         3. 시간 선택 → periods 테이블 불러오기
    -->
    <div class="flex space-x-2">
        <select class="flex-1 bg-white border border-gray-200 rounded-lg px-3 py-2 text-sm">
            <option>날짜 선택</option>
        </select>
        <select class="flex-1 bg-white border border-gray-200 rounded-lg px-3 py-2 text-sm">
            <option>동아리 선택</option>
        </select>
        <select class="flex-1 bg-white border border-gray-200 rounded-lg px-3 py-2 text-sm">
            <option>시간</option>
        </select>
    </div>

    <!-- 인기 예약 현황 -->
    <h2 class="text-sm font-medium text-gray-800 px-1 mt-3">인기 예약 현황</h2>

    <!-- TODO(DB):
         1. 이번 주 예약 count 많은 순으로 rooms 목록 출력
         2. 상태(예약됨/사용중/사용가능)는 서버에서 판단해서 출력
         3. 반복문으로 카드 리스트 출력
    -->
    <div class="space-y-1">

        <!-- 반복문 예시 -->
        <div class="bg-white rounded-lg p-3 shadow-sm border border-gray-100">
            <div class="flex items-center justify-between">
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                        <i class="fa-solid fa-robot text-blue-600"></i>
                    </div>
                    <div>
                        <h3 class="text-sm font-medium">로보틱스실</h3>
                        <p class="text-xs text-green-600">사용 가능</p>
                        <p class="text-xs text-gray-500">이번 주 42회 사용</p>
                    </div>
                </div>
                <button class="w-6 h-6 text-gray-400">
                    <i class="fa-regular fa-star text-sm"></i>
                </button>
            </div>
        </div>

    </div>

</div>

</body>
</html>
