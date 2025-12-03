<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

    <!-- 로그인 폼 -->
    <!-- TODO(백엔드/DB):
         1. loginProcess.jsp 또는 LoginServlet으로 POST 방식 처리
         2. users 테이블에서 studentId / password 검증
         3. 세션 생성(session.setAttribute)
         4. 로그인 실패 시 메시지 출력
    -->
    <form action="LoginServlet" method="post" class="space-y-4">

		<!-- 회원가입으로 이동 -->
		<div class="text-center mt-4">
   			 <a href="register.jsp"
      	 class="text-blue-600 hover:text-blue-800 text-sm font-medium">
        회원가입 하기 →
    		</a>
		</div>
		
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
        <!-- TODO(DB):
             로그인 성공 시 → home.jsp로 redirect
             실패 시 → login.jsp로 되돌리기
        -->
        <button type="submit"
                class="w-full bg-blue-600 text-white py-3 rounded-lg font-medium hover:bg-blue-700">
            로그인
        </button>

    </form>

    <!-- Social Login (UI용) -->
    <!-- TODO(DB): 나중에 필요하면 OAuth 연동 가능 / 현재는 UI만 -->
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
