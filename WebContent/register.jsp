<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 회원가입</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        * { font-family: 'Pretendard', sans-serif; }
        ::-webkit-scrollbar { display: none; }
    </style>
</head>

<body class="bg-gray-50">

<!-- Header -->
<div class="bg-white px-4 py-3 border-b border-gray-200 flex items-center">
    <a href="login.jsp" class="text-blue-600 text-lg mr-3">
        <i class="fa-solid fa-chevron-left"></i>
    </a>
    <h1 class="text-lg font-semibold text-gray-900">회원가입</h1>
</div>

<div class="px-4 py-6 space-y-6">

    <!-- 회원가입 폼 -->
    <form action="register" method="post" class="space-y-5">


        <!-- 학번 -->
        <div>
            <label class="block text-gray-700 text-sm font-medium mb-1">학번</label>
            <input type="text" name="studentId" placeholder="학번을 입력하세요"
                class="w-full px-3 py-3 border rounded-lg focus:ring-2 focus:ring-blue-500" required>
        </div>

        <!-- 이름 -->
        <div>
            <label class="block text-gray-700 text-sm font-medium mb-1">이름</label>
            <input type="text" name="name" placeholder="이름을 입력하세요"
                class="w-full px-3 py-3 border rounded-lg focus:ring-2 focus:ring-blue-500" required>
        </div>

        <!-- 비밀번호 -->
        <div>
            <label class="block text-gray-700 text-sm font-medium mb-1">비밀번호</label>
            <input type="password" name="password" placeholder="비밀번호 입력"
                class="w-full px-3 py-3 border rounded-lg focus:ring-2 focus:ring-blue-500" required>
        </div>

        <!-- 비밀번호 확인 -->
        <div>
            <label class="block text-gray-700 text-sm font-medium mb-1">비밀번호 확인</label>
            <input type="password" name="passwordCheck" placeholder="비밀번호 다시 입력"
                class="w-full px-3 py-3 border rounded-lg focus:ring-2 focus:ring-blue-500" required>
        </div>

        <!-- 동아리 선택 -->
        <div>
            <label class="block text-gray-700 text-sm font-medium mb-1">소속 동아리</label>

            <!-- TODO(DB):
                 clubs 테이블에서 모든 동아리 목록 SELECT 후 option 반복 출력
            -->
            <select name="clubId" class="w-full px-3 py-3 border rounded-lg focus:ring-2 focus:ring-blue-500">
                <option value="">동아리 선택</option>
                <option value="1">로보틱스</option>
                <option value="2">밴드</option>
                <option value="3">게임개발</option>
            </select>
        </div>

        <!-- 회원가입 버튼 -->
        <button type="submit" class="w-full bg-blue-600 text-white py-3 rounded-lg font-medium hover:bg-blue-700">
            회원가입
        </button>
    </form>

</div>

</body>
</html>
