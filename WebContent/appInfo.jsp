<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>앱 정보 - UniRoom</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-50 text-gray-900">

    <!-- 상단 헤더 -->
    <div class="bg-white px-4 py-3 border-b border-gray-200 text-center text-blue-600 font-semibold text-lg">
        앱 정보
    </div>

    <main class="px-4 py-6 space-y-6">

        <section class="bg-white p-5 rounded-xl shadow-sm">
            <h2 class="text-lg font-bold mb-2">UniRoom 정보</h2>

            <p class="text-sm text-gray-700">
                버전: <span class="font-semibold">1.0.0</span>
            </p>
            <p class="text-sm text-gray-700 mt-1">
                개발 팀: <span class="font-semibold">Team UniRoom</span>
            </p>
            <p class="text-sm text-gray-700 mt-1">
                개발 날짜: 2025. 10 ~ 2025. 12
            </p>
        </section>

        <section class="bg-white p-5 rounded-xl shadow-sm">
            <h2 class="text-lg font-bold mb-2">사용 기술</h2>

            <ul class="list-disc pl-6 text-sm text-gray-700 space-y-1">
                <li>Java 17 (JSP / Servlet)</li>
                <li>Apache Tomcat 9</li>
                <li>MySQL 8.0 + JDBC</li>
                <li>HTML / CSS / Tailwind CSS</li>
                <li>JavaScript (UI 인터랙션)</li>
            </ul>
        </section>

        <section class="bg-white p-5 rounded-xl shadow-sm">
            <h2 class="text-lg font-bold mb-2">오픈소스 라이선스</h2>

            <p class="text-sm text-gray-600">
                본 프로젝트는 Tailwind CSS, FontAwesome 등을 포함한 외부 라이브러리를 사용합니다.
            </p>
        </section>

    </main>

</body>
</html>
