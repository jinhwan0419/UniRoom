<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%
    String cpath = request.getContextPath();
    String errorMsg = (String) request.getAttribute("errorMsg");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 로그인</title>

    <!-- Tailwind CSS -->
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
<body class="bg-gray-50">

<!-- Header -->
<div class="bg-white px-4 py-3 border-b border-gray-200">
    <h1 class="text-blue-600 text-lg font-semibold text-center">UniRoom</h1>
</div>

<!-- Login Page -->
<main class="px-4 py-6 space-y-6">

    <!-- Logo -->
    <div class="text-center py-8">
        <div class="w-16 h-16 bg-blue-600 rounded-2xl mx-auto mb-4 flex items-center justify-center">
            <i class="fa-solid fa-door-open text-white text-2xl"></i>
        </div>
        <h2 class="text-xl font-bold text-gray-900 mb-2">UniRoom에 오신 걸 환영합니다</h2>
        <p class="text-gray-600 text-sm">동아리실 예약이 이제 더 쉬워졌습니다</p>
    </div>

    <%-- 🔴 로그인 실패 메시지 (없으면 안 보임) --%>
    <% if (errorMsg != null) { %>
        <div class="mb-2 text-sm text-red-600 bg-red-50 border border-red-200 px-3 py-2 rounded-lg">
            <i class="fa-solid fa-circle-exclamation mr-1"></i> <%=errorMsg%>
        </div>
    <% } %>

    <!-- 로그인 폼 -->
    <form action="<%=cpath%>/LoginServlet" method="post" class="space-y-4">
        <!-- 학번 -->
        <div>
            <label class="block text-gray-700 text-sm font-medium mb-2">학번</label>
            <input type="text" name="studentId" placeholder="학번을 입력하세요"
                   class="w-full px-3 py-3 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500" required>
        </div>

        <!-- 비밀번호 -->
        <div>
            <label class="block text-gray-700 text-sm font-medium mb-2">비밀번호</label>
            <input type="password" name="password" placeholder="비밀번호를 입력하세요"
                   class="w-full px-3 py-3 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500" required>
        </div>

        <!-- 로그인 버튼 -->
        <button type="submit"
                class="w-full bg-blue-600 text-white py-3 rounded-lg font-medium hover:bg-blue-700">
            로그인
        </button>
    </form>

    <!-- Social Login (UI용) -->
    <div class="space-y-3 mt-6">
        <div class="relative">
            <div class="absolute inset-0 flex items-center">
                <div class="w-full border-t border-gray-300"></div>
            </div>
            <div class="relative flex justify-center text-sm">
                <span class="px-2 bg-gray-50 text-gray-500">또는</span>
            </div>
        </div>

        <button class="w-full bg-yellow-400 text-gray-900 py-3 rounded-lg font-medium flex items-center justify-center space-x-2">
            <i class="fa-solid fa-comment text-lg"></i>
            <span>카카오로 로그인</span>
        </button>

        <button class="w-full bg-white border border-gray-200 text-gray-900 py-3 rounded-lg font-medium flex items-center justify-center space-x-2">
            <i class="fa-brands fa-google text-lg text-red-500"></i>
            <span>Google로 로그인</span>
        </button>
    </div>

</main>

</body>
</html>
