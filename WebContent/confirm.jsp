<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 예약 완료</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        * { font-family: 'Pretendard', sans-serif; }
        ::-webkit-scrollbar { display: none; }
    </style>
</head>

<body class="bg-gray-50 flex items-center justify-center min-h-screen">

<div class="bg-white rounded-xl shadow-lg p-8 w-80 text-center">

    <!-- 체크 아이콘 -->
    <div class="w-16 h-16 mx-auto mb-3 flex items-center justify-center bg-blue-100 rounded-full">
        <i class="fa-solid fa-check text-blue-600 text-3xl"></i>
    </div>

    <h2 class="text-xl font-semibold text-gray-900 mb-2">예약이 완료되었습니다!</h2>

    <!-- TODO(DB):
        reservationInsert.jsp 또는 예약 서블릿에서
        날짜/시간/공간명을 파라미터로 전달하여 표시하도록 수정
    -->
    <p class="text-sm text-gray-600 mb-6">
        예약 번호: 2025-00123<br>
        오늘 12:00 - 14:00
    </p>

    <!-- 버튼 1 -->
    <a href="home.jsp"
       class="block w-full bg-blue-600 text-white py-3 rounded-lg font-medium hover:bg-blue-700 mb-2">
        홈으로 가기
    </a>

    <!-- 버튼 2 -->
    <a href="myReservations.jsp"
       class="block w-full bg-gray-100 text-gray-700 py-3 rounded-lg font-medium hover:bg-gray-200">
        내 예약 확인하기
    </a>

</div>

</body>
</html>
