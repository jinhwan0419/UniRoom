<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.club.dto.RoomDTO" %>
<%@ page import="com.club.dto.RoomBlockDTO" %>
<%
    String cpath = request.getContextPath();
    RoomDTO room = (RoomDTO) request.getAttribute("room");
    List<RoomBlockDTO> blockList = (List<RoomBlockDTO>) request.getAttribute("blockList");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>UniRoom - 이용 제한 설정</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'Pretendard', sans-serif; }
        ::-webkit-scrollbar { display: none; }
    </style>
</head>
<body class="bg-gray-50 text-gray-900">

<div class="bg-white px-4 py-3 border-b border-gray-200 flex items-center justify-between">
    <div class="flex items-center space-x-2">
        <a href="<%= cpath %>/admin/rooms" class="text-gray-500">
            <i class="fa-solid fa-chevron-left"></i>
        </a>
        <h1 class="text-lg font-semibold text-blue-600">이용 제한 설정</h1>
    </div>
</div>

<div class="px-4 py-4">
    <div class="max-w-xl mx-auto space-y-4">

        <!-- 방 정보 -->
        <section class="bg-white rounded-xl shadow-sm border border-gray-100 p-4">
            <p class="text-sm font-semibold text-gray-900"><%= room.getName() %></p>
            <p class="text-xs text-gray-500 mt-1">
                위치: <%= room.getLocation() %> · 수용 <%= room.getCapacity() %>명
            </p>
        </section>

        <!-- 새 차단 구간 등록 -->
        <section class="bg-white rounded-xl shadow-sm border border-gray-100 p-4 space-y-3">
            <h2 class="text-sm font-semibold text-gray-800">새 이용 제한 구간 등록</h2>

            <form action="<%= cpath %>/admin/room/blocks" method="post" class="space-y-3">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="room_id" value="<%= room.getRoom_id() %>">

                <div>
                    <label class="block text-xs font-medium text-gray-700 mb-1">날짜</label>
                    <input type="date" name="block_date"
                           class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm">
                </div>

                <div class="grid grid-cols-2 gap-3">
                    <div>
                        <label class="block text-xs font-medium text-gray-700 mb-1">시작 시간</label>
                        <input type="time" name="start_time"
                               class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm">
                    </div>
                    <div>
                        <label class="block text-xs font-medium text-gray-700 mb-1">종료 시간</label>
                        <input type="time" name="end_time"
                               class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm">
                    </div>
                </div>

                <div>
                    <label class="block text-xs font-medium text-gray-700 mb-1">사유 (선택)</label>
                    <input type="text" name="reason"
                           class="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm"
                           placeholder="예) 동아리 정기회의, 시설 점검 등">
                </div>

                <div class="flex justify-end">
                    <button type="submit"
                            class="px-4 py-2 rounded-lg text-sm bg-red-500 text-white font-medium hover:bg-red-600">
                        제한 구간 추가
                    </button>
                </div>
            </form>
        </section>

        <!-- 기존 차단 구간 목록 -->
        <section class="bg-white rounded-xl shadow-sm border border-gray-100 p-4 space-y-2">
            <h2 class="text-sm font-semibold text-gray-800 mb-1">등록된 이용 제한 구간</h2>

            <%
                if (blockList == null || blockList.isEmpty()) {
            %>
                <p class="text-xs text-gray-400">등록된 제한 구간이 없습니다.</p>
            <%
                } else {
                    for (RoomBlockDTO b : blockList) {
            %>
                <div class="flex items-center justify-between text-xs py-1 border-b border-gray-100 last:border-0">
                    <div>
                        <p class="text-gray-800">
                            <%= b.getBlock_date() %> ·
                            <%= b.getStart_time() %> ~ <%= b.getEnd_time() %>
                        </p>
                        <p class="text-gray-500">
                            <%= b.getReason() != null ? b.getReason() : "" %>
                        </p>
                    </div>
                    <form action="<%= cpath %>/admin/room/blocks" method="post"
                          onsubmit="return confirm('이 제한 구간을 삭제할까요?');">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="room_id" value="<%= room.getRoom_id() %>">
                        <input type="hidden" name="block_id" value="<%= b.getBlock_id() %>">
                        <button type="submit"
                                class="px-3 py-1 rounded-lg bg-gray-100 text-gray-600">
                            삭제
                        </button>
                    </form>
                </div>
            <%
                    }
                }
            %>
        </section>
    </div>
</div>

</body>
</html>
