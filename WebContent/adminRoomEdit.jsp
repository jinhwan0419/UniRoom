<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.club.dto.RoomDTO" %>
<%
    String cpath = request.getContextPath();
    RoomDTO room = (RoomDTO) request.getAttribute("room");
    if (room == null) {
        response.sendRedirect(cpath + "/admin/rooms");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 공간 수정</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
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
        <a href="<%= cpath %>/admin/rooms" class="text-gray-500">
            <i class="fa-solid fa-chevron-left"></i>
        </a>
        <h1 class="text-lg font-semibold text-blue-600">공간 정보 수정</h1>
    </div>
</div>

<div class="px-4 py-4">
    <div class="max-w-xl mx-auto">
        <section class="bg-white rounded-xl shadow-sm border border-gray-100 p-5 space-y-4">
            <form action="<%= cpath %>/admin/room/edit" method="post" class="space-y-4">
                <input type="hidden" name="room_id" value="<%= room.getRoom_id() %>">

                <div>
                    <label class="block text-sm font-medium text-gray-800 mb-1">
                        공간 이름
                    </label>
                    <div class="text-sm text-gray-900 font-semibold">
                        <%= room.getName() %>
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-800 mb-1">
                        위치
                    </label>
                    <div class="text-sm text-gray-700">
                        <%= room.getLocation() %>
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-800 mb-1">
                        수용 인원(명)
                    </label>
                    <input type="number" name="capacity" min="1"
                           value="<%= room.getCapacity() %>"
                           class="w-40 border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
                    <div>
                        <label class="block text-sm font-medium text-gray-800 mb-1">
                            운영 시작 시간
                        </label>
                        <input type="time" name="open_time"
                               value="<%= room.getOpen_time() != null ? room.getOpen_time().toString().substring(0,5) : "" %>"
                               class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-800 mb-1">
                            운영 종료 시간
                        </label>
                        <input type="time" name="close_time"
                               value="<%= room.getClose_time() != null ? room.getClose_time().toString().substring(0,5) : "" %>"
                               class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-800 mb-1">
                        예약 단위(분)
                    </label>
                    <input type="number" name="slot_minutes" min="10" step="10"
                           value="<%= room.getSlot_minutes() %>"
                           class="w-40 border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-800 mb-1">
                        설명 / 비품 정보
                    </label>
                    <textarea name="description" rows="3"
                              class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"><%= room.getDescription() != null ? room.getDescription() : "" %></textarea>
                </div>

                <div class="flex justify-end space-x-2 pt-3 border-t border-gray-100">
                    <a href="<%= cpath %>/admin/rooms"
                       class="px-4 py-2 rounded-lg text-sm border border-gray-300 text-gray-600 bg-white">
                        취소
                    </a>
                    <button type="submit"
                            class="px-4 py-2 rounded-lg text-sm bg-blue-600 text-white font-medium hover:bg-blue-700">
                        저장
                    </button>
                </div>
            </form>
        </section>
    </div>
</div>

</body>
</html>
