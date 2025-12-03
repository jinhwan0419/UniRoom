<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 패널티 관리</title>

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
        <h1 class="text-lg font-semibold text-gray-900">패널티 관리</h1>
    </div>
    <a href="home.jsp" class="text-xs text-gray-500">
        사용자 화면
    </a>
</div>

<div class="px-4 py-4 space-y-4">

    <%-- TODO(백엔드/DB팀)
        1. 관리자 권한 확인 (role == 'ADMIN' or 'MANAGER')
        2. penalties(또는 no_show_log) + users JOIN해서
           - 학번, 이름, 소속 동아리, 노쇼 횟수, 현재 상태(정상 / 제한) 조회
        3. 검색/정렬 조건 적용 (학번, 이름, 동아리, 상태 등)
    --%>

    <!-- 설명 영역 -->
    <section class="bg-white rounded-xl p-4 shadow-sm border border-gray-100">
        <h2 class="text-sm font-semibold text-gray-900 mb-2">노쇼 / 패널티 정책</h2>
        <ul class="list-disc pl-5 text-xs text-gray-600 space-y-1">
            <li>예약 시간 2시간 전까지 취소하지 않고 나타나지 않으면 노쇼로 기록됩니다.</li>
            <li>노쇼가 일정 횟수 이상 누적되면 예약 제한 상태가 됩니다.</li>
            <li>필요 시 관리자가 패널티를 해제하거나 조정할 수 있습니다.</li>
        </ul>
    </section>

    <!-- 필터 영역 -->
    <section class="bg-white rounded-xl p-3 shadow-sm border border-gray-100 space-y-2">
        <div class="flex space-x-2">
            <input type="text" placeholder="학번 또는 이름 검색"
                   class="flex-1 border border-gray-200 rounded-lg px-3 py-2 text-sm">

            <select class="w-28 border border-gray-200 rounded-lg px-2 py-2 text-xs">
                <option>전체 상태</option>
                <option>정상</option>
                <option>경고</option>
                <option>제한</option>
            </select>
        </div>
        <button class="w-full bg-gray-100 text-gray-700 text-xs py-2 rounded-lg">
            필터 적용
        </button>
    </section>

    <!-- 패널티 목록 -->
    <section class="space-y-2">

        <%-- TODO(DB):
            penalties 요약 결과를 for문으로 반복 출력
            예시 컬럼:
              - student_id, name, club_name
              - no_show_count, status(OK/WARN/BLOCK)
        --%>

        <!-- 예시 카드 1: 경고 상태 -->
        <div class="bg-white rounded-xl p-4 shadow-sm border border-gray-100">
            <div class="flex items-start justify-between">
                <div>
                    <p class="text-sm font-semibold text-gray-900">20201234 김학생</p>
                    <p class="text-xs text-gray-500 mt-1">소속: 로보틱스 동아리</p>
                    <p class="text-xs text-gray-500">노쇼 횟수: <span class="font-semibold text-red-600">2회</span></p>
                    <p class="text-[11px] text-gray-400 mt-1">
                        최근 노쇼: 2025-03-01 · 2025-03-05
                    </p>
                </div>
                <div class="flex flex-col items-end space-y-1">
                    <span class="text-xs px-2 py-1 rounded-full bg-orange-100 text-orange-700">경고</span>
                    <span class="text-[10px] text-gray-400 mt-1">user_id: 10</span>
                </div>
            </div>

            <div class="flex space-x-2 mt-3">
                <button class="flex-1 text-xs py-2 rounded-lg bg-gray-100 text-gray-800">
                    상세 이력
                </button>
                <button class="flex-1 text-xs py-2 rounded-lg bg-green-100 text-green-700">
                    패널티 일부 해제
                </button>
            </div>
        </div>

        <!-- 예시 카드 2: 예약 제한 상태 -->
        <div class="bg-white rounded-xl p-4 shadow-sm border border-gray-100">
            <div class="flex items-start justify-between">
                <div>
                    <p class="text-sm font-semibold text-gray-900">20194567 박밴드</p>
                    <p class="text-xs text-gray-500 mt-1">소속: 밴드 동아리</p>
                    <p class="text-xs text-gray-500">노쇼 횟수: <span class="font-semibold text-red-600">3회</span></p>
                    <p class="text-[11px] text-gray-400 mt-1">
                        예약 제한 해제 예정일: 2025-04-01
                    </p>
                </div>
                <div class="flex flex-col items-end space-y-1">
                    <span class="text-xs px-2 py-1 rounded-full bg-red-100 text-red-700">예약 제한</span>
                    <span class="text-[10px] text-gray-400 mt-1">user_id: 12</span>
                </div>
            </div>

            <div class="flex space-x-2 mt-3">
                <button class="flex-1 text-xs py-2 rounded-lg bg-gray-100 text-gray-800">
                    상세 이력
                </button>
                <button class="flex-1 text-xs py-2 rounded-lg bg-blue-100 text-blue-700">
                    예약 제한 해제
                </button>
            </div>
        </div>

        <!-- 예시 카드 3: 정상 상태 -->
        <div class="bg-white rounded-xl p-4 shadow-sm border border-gray-100">
            <div class="flex items-start justify-between">
                <div>
                    <p class="text-sm font-semibold text-gray-900">20207890 이개발</p>
                    <p class="text-xs text-gray-500 mt-1">소속: 게임개발 동아리</p>
                    <p class="text-xs text-gray-500">노쇼 횟수: <span class="font-semibold text-gray-700">0회</span></p>
                </div>
                <div class="flex flex-col items-end space-y-1">
                    <span class="text-xs px-2 py-1 rounded-full bg-green-100 text-green-700">정상</span>
                    <span class="text-[10px] text-gray-400 mt-1">user_id: 15</span>
                </div>
            </div>

            <div class="flex space-x-2 mt-3">
                <button class="flex-1 text-xs py-2 rounded-lg bg-gray-100 text-gray-800">
                    상세 이력
                </button>
                <button class="flex-1 text-xs py-2 rounded-lg bg-gray-200 text-gray-400 cursor-not-allowed">
                    조치 없음
                </button>
            </div>
        </div>

    </section>

</div>

</body>
</html>
