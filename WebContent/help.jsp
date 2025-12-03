<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>도움말 - UniRoom</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-50 text-gray-900">

    <!-- 상단 헤더 -->
    <div class="bg-white px-4 py-3 border-b border-gray-200 text-center text-blue-600 font-semibold text-lg">
        도움말
    </div>

    <main class="px-4 py-6 space-y-6">
        
        <!-- 섹션 1: 자주 묻는 질문 -->
        <section>
            <h2 class="text-lg font-bold mb-3">자주 묻는 질문 (FAQ)</h2>

            <div class="space-y-4">

                <div class="bg-white p-4 rounded-xl shadow-sm">
                    <h3 class="font-semibold">❓ 예약은 어떻게 하나요?</h3>
                    <p class="text-sm text-gray-600 mt-1">
                        날짜와 시간을 선택한 후, 원하는 동아리실을 선택하여 예약 버튼을 누르면 됩니다.
                    </p>
                </div>

                <div class="bg-white p-4 rounded-xl shadow-sm">
                    <h3 class="font-semibold">❓ 예약 취소는 언제까지 가능한가요?</h3>
                    <p class="text-sm text-gray-600 mt-1">
                        예약 시간 2시간 전까지만 취소 가능합니다.
                        이후 취소하지 않으면 노쇼(No-Show)로 기록됩니다.
                    </p>
                </div>

                <div class="bg-white p-4 rounded-xl shadow-sm">
                    <h3 class="font-semibold">❓ 패널티는 어떻게 적용되나요?</h3>
                    <p class="text-sm text-gray-600 mt-1">
                        2시간 전 취소를 하지 않고 나타나지 않으면 자동 패널티가 부여됩니다.
                    </p>
                </div>

            </div>
        </section>


        <!-- 섹션 2: 예약 규정 -->
        <section>
            <h2 class="text-lg font-bold mb-3">예약 규정 안내</h2>

            <ul class="list-disc pl-6 text-sm text-gray-700 space-y-1">
                <li>1인 하루 최대 2시간 예약 가능</li>
                <li>동시간대 중복 예약 불가</li>
                <li>3회 노쇼 시 일정 기간 예약 제한</li>
            </ul>
        </section>

    </main>

</body>
</html>
