<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.club.dto.UserDTO" %>
<%
    // -----------------------------
    // 로그인 체크 + 유저 정보 가져오기
    // -----------------------------
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("loginUser") == null) {
        // 로그인 안 되어 있으면 로그인 페이지로
        response.sendRedirect("login.jsp");
        return;
    }

    // 세션에 저장된 로그인 사용자 정보
    UserDTO loginUser = (UserDTO) sessionObj.getAttribute("loginUser");

    // 마이페이지 서블릿에서 넘긴 패널티/제한 정보 (없으면 null일 수 있음)
    Integer penaltyPoint = (Integer) request.getAttribute("penaltyPoint");
    Integer penaltyLimit = (Integer) request.getAttribute("penaltyLimit");
    Boolean isBlocked    = (Boolean) request.getAttribute("isBlocked");

    if (penaltyPoint == null) penaltyPoint = 0;
    if (penaltyLimit == null) penaltyLimit = 0;
    if (isBlocked == null)    isBlocked = false;

    // TODO: 동아리 이름, 프로필 이미지 경로는 필요 시 request.setAttribute(...)로 받아서 사용
    String clubName = (String) request.getAttribute("clubName");
    if (clubName == null) clubName = "소속 동아리 미지정";
%>
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

    <!-- 프로필 이미지 & 기본 정보 -->
    <div class="text-center mb-6">
        <div class="w-24 h-24 mx-auto mb-3">
            <!-- TODO: 프로필 이미지 경로를 DB에서 가져오면 src를 동적으로 변경 -->
            <img src="https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-3.jpg"
                 alt="Profile"
                 class="w-full h-full rounded-full object-cover">
        </div>

        <!-- 로그인한 사용자 이름 -->
        <h2 class="text-lg font-semibold text-gray-900"><%= loginUser.getName() %></h2>

        <!-- 동아리 이름 (없으면 기본 문구) -->
        <p class="text-sm text-gray-600"><%= clubName %></p>

        <!-- 패널티 / 예약 제한 안내 (있을 때만 표시) -->
        <div class="mt-3 text-sm">
            <span class="inline-block px-3 py-1 rounded-full 
                          <%= isBlocked ? "bg-red-50 text-red-600" : "bg-green-50 text-green-600" %>">
                패널티: <%= penaltyPoint %>점
                <% if (penaltyLimit > 0) { %>
                    / 기준: <%= penaltyLimit %>점
                <% } %>
                <% if (isBlocked) { %>
                    · 현재 예약 제한 상태
                <% } else { %>
                    · 예약 가능
                <% } %>
            </span>
        </div>
    </div>

    <!-- 메뉴 카드 -->
    <div class="space-y-4">

        <!-- 예약 내역 -->
        <!-- TODO: myReservations.jsp 대신 /myReservations 서블릿 등을 사용해도 됨 -->
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
	<a href="<%= request.getContextPath() %>/LoginServlet" 
   		class="block bg-white rounded-xl p-4 border border-gray-100">
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
