<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%
    request.setCharacterEncoding("UTF-8");
    String cpath = request.getContextPath();
    // 서블릿에서 setAttribute("error", ...)로 넣으니까 그걸 읽음
    String errorMsg = (String) request.getAttribute("error");
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

    <%-- 🔴 로그인 실패 메시지 표시 --%>
    <% if (errorMsg != null) { %>
        <div class="mb-2 text-sm text-red-600 bg-red-50 border border-red-200 px-3 py-2 rounded-lg">
            <i class="fa-solid fa-circle-exclamation mr-1"></i> <%= errorMsg %>
        </div>
    <% } %>

    <!-- 로그인 폼 -->
    <form action="<%=cpath%>/login" method="post" class="space-y-4">

       <!-- 학번 -->
    <div class="mb-4">
        <label for="studentId" class="text-sm text-gray-600">학번</label>
        <input type="text" id="studentId" name="studentId"
               class="w-full border rounded-lg px-3 py-2 text-sm"
               placeholder="학번을 입력하세요">
    </div>

    <!-- 비밀번호 -->
    <div class="mb-4">
        <label for="password" class="text-sm text-gray-600">비밀번호</label>
        <input type="password" id="password" name="password"
               class="w-full border rounded-lg px-3 py-2 text-sm"
               placeholder="비밀번호를 입력하세요">
    </div>

        <!-- 로그인 버튼 -->
        <button type="submit"
                class="w-full bg-blue-600 text-white py-3 rounded-lg font-medium hover:bg-blue-700">
            로그인
        </button>
    </form>

    <!-- 회원가입 링크 -->
    <div class="mt-4 text-center">
        <%-- ★ signup.jsp 가 아니라 /register 서블릿으로 이동 --%>
        <a href="<%=cpath%>/register"
           class="text-sm text-blue-500 font-semibold">
            아직 계정이 없나요? 회원가입
        </a>
    </div>
	
</main>

</body>
</html>
