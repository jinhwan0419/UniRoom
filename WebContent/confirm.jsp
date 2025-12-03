<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // TODO(DB팀):
    // request 파라미터나 세션에서 방/시간/날짜 정보 가져와서
    // "어떤 동아리실을 언제 예약했는지"를 실제로 표시
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 예약 완료</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

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

<!-- 상태바 -->
<div class="bg-black text-white text-xs py-1 px-4 flex justify-between items-center">
    <span>9:41</span>
    <div class="flex items-center space-x-1">
        <i class="fa-solid fa-signal text-xs"></i>
        <i class="fa-solid fa-wifi text-xs"></i>
        <i class="fa-solid fa-battery-three-quarters text-xs"></i>
    </div>
</div>

<!-- 헤더 -->
<div class="bg-white px-4 py-3 border-b border-gray-200 flex items-center">
    <a href="home.jsp" class="text-blue-600 text-lg mr-3">
        <i class="fa-solid fa-chevron-left"></i>
    </a>
    <h1 class="text-lg font-semibold text-gray-900">예약 완료</h1>
</div>

<main class="px-4 py-6 space-y-5">

    <!-- 완료 아이콘 + 메시지 -->
    <section class="text-center space-y-3">
        <div class="w-16 h-16 mx-auto rounded-full bg-blue-100 flex items-center justify-center">
            <i class="fa-solid fa-check text-blue-600 text-2xl"></i>
        </div>
        <h2 class="text-xl font-bold text-gray-900">예약이 완료되었습니다</h2>
        <p class="text-sm text-gray-600">
            로보틱스 동아리실<br>
            오늘 12:00 - 14:00
        </p>
        <%-- TODO(DB팀): 실제 예약한 공간 이름 / 날짜 / 시간으로 치환 --%>
    </section>

    <!-- 요약 정보 -->
    <section class="bg-white rounded-xl p-4 shadow-sm border border-gray-100 space-y-2 text-sm text-gray-700">
        <div class="flex justify-between">
            <span class="text-gray-500">공간</span>
            <span class="font-medium">로보틱스 동아리실</span>
        </div>
        <div class="flex justify-between">
            <span class="text-gray-500">날짜</span>
            <span class="font-medium">2025-03-10</span>
        </div>
        <div class="flex justify-between">
            <span class="text-gray-500">시간</span>
            <span class="font-medium">12:00 - 14:00</span>
        </div>
        <div class="flex justify-between">
            <span class="text-gray-500">예약자</span>
            <span class="font-medium">20201234 김학생</span>
        </div>
        <%-- TODO(DB팀): 위 항목들 실제 데이터 연동 --%>
    </section>

    <!-- 버튼 두 개: 홈 / 내 예약 -->
    <section class="space-y-2">
        <a href="home.jsp"
           class="block w-full text-center bg-blue-600 text-white py-3 rounded-lg font-medium">
            홈으로 돌아가기
        </a>
        <a href="myReservations.jsp"
           class="block w-full text-center bg-gray-100 text-gray-800 py-3 rounded-lg text-sm">
            내 예약 확인하기
        </a>
    </section>

</main>

<!-- 하단 네비게이션 -->
<div class="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 px-4 py-2">
    <div class="flex justify-around">
        <a href="home.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-solid fa-house text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">홈</span>
        </a>
        <a href="myReservations.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-calendar text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">예약</span>
        </a>
        <a href="reservation.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-bell text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">알림</span>
        </a>
        <a href="profile.jsp" class="flex flex-col items-center space-y-1">
            <i class="fa-regular fa-user text-gray-400 text-lg"></i>
            <span class="text-xs text-gray-400">프로필</span>
        </a>
    </div>
</div>

<div class="pb-20"></div>

</body>
</html>
