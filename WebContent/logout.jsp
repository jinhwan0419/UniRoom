<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // TODO(백엔드/DB):
    // 1. 세션에 저장한 로그인 정보 제거
    // 2. 필요하면 로그 기록 남기기 (예: 로그아웃 시간)

    // 현재 세션 무효화
    session.invalidate();

    // 로그아웃 후 로그인 페이지로 이동
    response.sendRedirect("login.jsp");
%>
