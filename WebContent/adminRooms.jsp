<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 공간 관리</title>

    <!-- Tailwind -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- FontAwesome -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
    <!-- Pretendard -->
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        * { font-family: 'Pretendard', sans-serif; }
        ::-webkit-scrollbar { display: none; }
    </style>
</head>

<body class="bg-gray-50 text-gray-900">

<!-- 상단 헤더 -->
<div class="bg-white px-4 py-3 border-b border-gray-200 flex items-center justify-between">
    <div class="flex items-center space-x-2">
        <a href="adminDashboard.jsp" class="text-blue-600 text-lg">
            <i class="fa-solid fa-chevron-left"></i>
        </a>
        <h1 class="text-lg font-semibold text-gray-900">공간 관리</h1>
    </div>
    <a href="home.jsp" class="text-xs text-gray-500">
        사용자 화면
    </a>
</div>

<div class="px-4 py-4 space-y-4">

    <%-- TODO(백엔드/DB팀)
        1. 관리자인지 권한 체크 (role == 'ADMIN' 또는 'STAFF')
        2. rooms 테이블에서 전체 공간 목록 조회
        3. clubs와 JOIN해서 동아리 이름 표시
        4. 검색/필터 조건(동아리, 사용여부)에 따라 WHERE 조건 적용
    --%>

    <!-- 상단 설명 + 새 공간 등록 버튼 -->
    <section class="flex items-center justify-between">
        <p class="text-sm text-gray-600">
            동아리실 / 연습실 / 회의실 등의 사용 가능 공간을 관리합니다.
        </p>
        <a href="adminRoomForm.jsp"
           class="inline-flex items-center px-3 py-2 bg-blue-600 text-white text-xs rounded-lg hover:bg-blue-700">
            <i class="fa-solid fa-plus mr-1"></i> 새 공간 등록
        </a>
    </section>

    <!-- 필터 영역 -->
    <section class="bg-white rounded-xl p-3 shadow-sm border border-gray-100 space-y-2">
        <div class="flex space-x-2">
            <!-- 동아리 필터 -->
            <select class="flex-1 border border-gray-200 rounded-lg px-3 py-2 text-sm">
                <option>전체 동아리</option>
                <%-- TODO(DB): clubs 테이블에서 동아리 목록 반복 출력 --%>
                <option>로보틱스</option>
                <option>밴드</option>
                <option>게임개발</option>
            </select>

            <!-- 상태 필터 -->
            <select class="w-32 border border-gray-200 rounded-lg px-3 py-2 text-sm">
                <option>전체 상태</option>
                <option>사용 가능</option>
                <option>비활성</option>
            </select>
        </div>
        <button class="w-full bg-gray-100 text-gray-700 text-xs py-2 rounded-lg">
            필터 적용
        </button>
    </section>

    <!-- 공간 목록 리스트 -->
    <section class="space-y-2">

        <%-- TODO(DB):
            rooms + clubs JOIN 결과를 반복문으로 출력
            예) for (RoomDTO room : roomList) { ... }
        --%>

        <!-- 예시 카드 1 -->
        <div class="bg-white rounded-xl p-4 shadow-sm border border-gray-100">
            <div class="flex items-start justify-between">
                <div>
                    <h2 class="text-sm font-semibold text-gray-900">로보틱스 동아리실</h2>
                    <p class="text-xs text-gray-500 mt-1">소속: 로보틱스 동아리</p>
                    <p class="text-xs text-gray-500">수용 인원: 최대 12명</p>
                    <p class="text-xs text-gray-500">비품: 프로젝터, 화이트보드, Wi-Fi</p>
                </div>
                <div class="flex flex-col items-end space-y-1">
                    <span class="text-xs px-2 py-1 rounded-full bg-green-100 text-green-700">사용 가능</span>
                    <span class="text-[10px] text-gray-400 mt-1">room_id: 1</span>
                </div>
            </div>

            <div class="flex space-x-2 mt-3">
                <a href="adminRoomForm.jsp?roomId=1"
                   class="flex-1 text-xs py-2 rounded-lg bg-gray-100 text-gray-800 text-center">
                    수정
                </a>
                <button class="flex-1 text-xs py-2 rounded-lg bg-red-100 text-red-700">
                    비활성 처리
                </button>
            </div>
        </div>

        <!-- 예시 카드 2 -->
        <div class="bg-white rounded-xl p-4 shadow-sm border border-gray-100">
            <div class="flex items-start justify-between">
                <div>
                    <h2 class="text-sm font-semibold text-gray-900">밴드 연습실</h2>
                    <p class="text-xs text-gray-500 mt-1">소속: 밴드 동아리</p>
                    <p class="text-xs text-gray-500">수용 인원: 최대 8명</p>
                    <p class="text-xs text-gray-500">비품: 앰프, 드럼, 마이크</p>
                </div>
                <div class="flex flex-col items-end space-y-1">
                    <span class="text-xs px-2 py-1 rounded-full bg-red-100 text-red-700">비활성</span>
                    <span class="text-[10px] text-gray-400 mt-1">room_id: 2</span>
                </div>
            </div>

            <div class="flex space-x-2 mt-3">
                <a href="adminRoomForm.jsp?roomId=2"
                   class="flex-1 text-xs py-2 rounded-lg bg-gray-100 text-gray-800 text-center">
                    수정
                </a>
                <button class="flex-1 text-xs py-2 rounded-lg bg-green-100 text-green-700">
                    다시 활성화
                </button>
            </div>
        </div>

    </section>

</div>

</body>
</html>
