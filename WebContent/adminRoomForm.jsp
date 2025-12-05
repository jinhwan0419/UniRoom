<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String cpath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 새 공간 등록</title>

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

<!-- 상단 헤더 (대시보드 스타일 맞춤) -->
<div class="bg-white px-4 py-3 border-b border-gray-200 flex items-center justify-between">
    <div class="flex items-center space-x-2">
        <a href="<%= cpath %>/admin/rooms" class="text-gray-500">
            <i class="fa-solid fa-chevron-left"></i>
        </a>
        <h1 class="text-lg font-semibold text-blue-600">새 공간 등록</h1>
    </div>
    <a href="<%= cpath %>/admin/dashboard" class="text-sm text-gray-500">
        관리자 대시보드
    </a>
</div>

<!-- 메인 컨텐츠 -->
<div class="px-4 py-4">
    <div class="max-w-xl mx-auto">

        <!-- 안내 텍스트 카드 -->
        <section class="mb-4">
            <div class="bg-blue-50 border border-blue-100 rounded-xl p-3 flex space-x-3">
                <div class="w-8 h-8 rounded-lg bg-blue-100 flex items-center justify-center">
                    <i class="fa-solid fa-building text-blue-600 text-sm"></i>
                </div>
                <div class="text-xs text-gray-600 leading-relaxed">
                    새로 등록하는 공간은 동아리실, 연습실, 회의실 등 학교 내에서
                    예약 가능한 모든 공간을 의미합니다. 운영 시간과 예약 단위를
                    정확히 설정해 두면 타임테이블에서 바로 적용됩니다.
                </div>
            </div>
        </section>

        <!-- 입력 폼 카드 -->
        <section class="bg-white rounded-xl shadow-sm border border-gray-100 p-5 space-y-4">
            <form action="<%= cpath %>/admin/room/new" method="post" class="space-y-4">

                <!-- 이름 -->
                <div>
                    <label class="block text-sm font-medium text-gray-800 mb-1">
                        공간 이름 <span class="text-red-500">*</span>
                    </label>
                    <input type="text" name="name"
                           class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                           placeholder="예) 로보틱스 동아리실" required>
                </div>

                <!-- 위치 -->
                <div>
                    <label class="block text-sm font-medium text-gray-800 mb-1">
                        위치 <span class="text-red-500">*</span>
                    </label>
                    <input type="text" name="location"
                           class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                           placeholder="예) 학생회관 3층 302호" required>
                </div>

                <!-- 수용 인원 -->
                <div>
                    <label class="block text-sm font-medium text-gray-800 mb-1">
                        수용 인원(명) <span class="text-red-500">*</span>
                    </label>
                    <input type="number" name="capacity" min="1"
                           class="w-40 border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                           placeholder="예) 12" required>
                </div>

                <!-- 운영 시간 -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
                    <div>
                        <label class="block text-sm font-medium text-gray-800 mb-1">
                            운영 시작 시간 <span class="text-red-500">*</span>
                        </label>
                        <input type="time" name="open_time"
                               class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                               required>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-800 mb-1">
                            운영 종료 시간 <span class="text-red-500">*</span>
                        </label>
                        <input type="time" name="close_time"
                               class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                               required>
                    </div>
                </div>

                <!-- 예약 단위 -->
                <div>
                    <label class="block text-sm font-medium text-gray-800 mb-1">
                        예약 단위(분) <span class="text-red-500">*</span>
                    </label>
                    <input type="number" name="slot_minutes" min="10" step="10" value="60"
                           class="w-40 border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <p class="mt-1 text-xs text-gray-500">
                        예: 60분으로 설정하면 10:00, 11:00, 12:00 단위로 예약 가능
                    </p>
                </div>

                <!-- 설명 -->
                <div>
                    <label class="block text-sm font-medium text-gray-800 mb-1">
                        설명 / 비품 정보
                    </label>
                    <textarea name="description" rows="3"
                              class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                              placeholder="예) 프로젝터, 화이트보드, 마이크 구비 등"></textarea>
                </div>

                <!-- 동아리 -->
                <div>
                    <label class="block text-sm font-medium text-gray-800 mb-1">
                        소속 동아리 ID
                    </label>
                    <input type="number" name="club_id"
                           class="w-40 border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                           placeholder="예) 1">
                    <p class="mt-1 text-xs text-gray-500">
                        추후 clubs 테이블과 JOIN하여 동아리 이름으로 선택하도록 개선 가능.
                    </p>
                </div>

                <!-- 버튼 영역 -->
                <div class="flex justify-end space-x-2 pt-3 border-t border-gray-100">
                    <a href="<%= cpath %>/admin/rooms"
                       class="px-4 py-2 rounded-lg text-sm border border-gray-300 text-gray-600 bg-white">
                        취소
                    </a>
                    <button type="submit"
                            class="px-4 py-2 rounded-lg text-sm bg-blue-600 text-white font-medium hover:bg-blue-700">
                        등록
                    </button>
                </div>

            </form>
        </section>

    </div>
</div>

</body>
</html>
