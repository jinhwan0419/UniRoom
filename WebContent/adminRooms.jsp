<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.club.dto.RoomDTO" %>
<%
    String cpath = request.getContextPath();
    List<RoomDTO> roomList = (List<RoomDTO>) request.getAttribute("roomList");
%>

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
        <a href="<%= cpath %>/adminDashboard.jsp" class="text-blue-600 text-lg">
            <i class="fa-solid fa-chevron-left"></i>
        </a>
        <h1 class="text-lg font-semibold text-gray-900">공간 관리</h1>
    </div>
    <a href="<%= cpath %>/home" class="text-xs text-gray-500">
        사용자 화면
    </a>
</div>

<div class="px-4 py-4 space-y-4">

    <!-- 상단 설명 + 새 공간 등록 버튼 -->
    <section class="flex items-center justify-between">
        <p class="text-sm text-gray-600">
            동아리실 / 연습실 / 회의실 등의 사용 가능 공간을 관리합니다.
        </p>
        <a href="<%= cpath %>/adminRoomForm.jsp"
           class="inline-flex items-center px-3 py-2 bg-blue-600 text-white text-xs rounded-lg hover:bg-blue-700">
            <i class="fa-solid fa-plus mr-1"></i> 새 공간 등록
        </a>
    </section>

    <!-- 필터 영역 (지금은 UI만) -->
    <section class="bg-white rounded-xl p-3 shadow-sm border border-gray-100 space-y-2">
        <div class="flex space-x-2">
            <!-- 동아리 필터 -->
            <select class="flex-1 border border-gray-200 rounded-lg px-3 py-2 text-sm">
                <option>전체 동아리</option>
                <%-- TODO: clubs 테이블에서 동아리 목록 출력 --%>
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
    <%
        if (roomList != null && !roomList.isEmpty()) {
            for (RoomDTO r : roomList) {
    %>
        <div class="bg-white rounded-xl p-4 shadow-sm border border-gray-100">
            <div class="flex items-start justify-between">
                <div>
                    <h2 class="text-sm font-semibold text-gray-900"><%= r.getName() %></h2>
                    <p class="text-xs text-gray-500 mt-1">위치: <%= r.getLocation() %></p>
                    <p class="text-xs text-gray-500">수용 인원: 최대 <%= r.getCapacity() %>명</p>
                </div>
                <div class="flex flex-col items-end space-y-1">
                    <span class="text-xs px-2 py-1 rounded-full
                        <%= r.isActive() ? "bg-green-100 text-green-700" : "bg-red-100 text-red-700" %>">
                        <%= r.isActive() ? "사용 가능" : "비활성" %>
                    </span>
                    <span class="text-[10px] text-gray-400 mt-1">room_id: <%= r.getRoom_id() %></span>
                </div>
            </div>

            <!-- 카드 하단 버튼 -->
            <div class="flex space-x-2 mt-3">
                <a href="<%= cpath %>/admin/room/edit?roomId=<%= r.getRoom_id() %>"
                   class="flex-1 text-xs py-2 rounded-lg bg-gray-100 text-gray-800 text-center">
                    수정
                </a>
                <a href="<%= cpath %>/admin/room/blocks?roomId=<%= r.getRoom_id() %>"
                   class="flex-1 text-xs py-2 rounded-lg bg-red-50 text-red-600 text-center">
                    이용 제한 설정
                </a>
            </div>
        </div>
    <%
            } // end for
        } else {
    %>
        <div class="bg-white rounded-xl p-4 shadow-sm border border-gray-100 text-center text-sm text-gray-500">
            등록된 공간이 없습니다. "새 공간 등록" 버튼을 눌러 공간을 추가하세요.
        </div>
    <%
        }
    %>
    </section>

</div>

</body>
</html>
