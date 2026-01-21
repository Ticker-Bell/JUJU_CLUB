<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" scope="request"/>
<html>
<head>
    <%--얘 없으면 기능 활성화가 안돼요--%>
    <script src="https://unpkg.com/lucide@latest"></script>
        <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>

        <script src="https://unpkg.com/htmx.org@1.9.10"></script>
    <%--개념형 문제 css--%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lesson.css">
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonchat.css">
    <%--문항 버튼, 모달 css--%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonSelect.css">
    <%--드래형 문제 css --%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonDrag.css">
    <%--연결형 문제 css--%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonMatch.css">
    <%--랭킹 메인 css--%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/ranking/rankingMain.css">

    <%--선택형 문제 css--%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonSelect.css">
    <title>Main</title>
    <script src="https://unpkg.com/htmx.org@1.9.10"></script>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="flex flex-col h-screen w-full overflow-hidden bg-white">
<!-- topbar -->
<jsp:include page="topbar.jsp"/>
<div class="flex flex-1 h-full pt-20 overflow-hidden relative">

    <!-- sidebar -->
    <jsp:include page="sidebar.jsp"/>

    <!-- Main -->
    <main class="flex-1 overflow-y-auto p-8 flex flex-col bg-gray-50">
            <jsp:include page="/WEB-INF/views/${targetPage}.jsp"/>
    </main>
</div>

<script src="${cpath}/resources/js/main/main.js"></script>

</body>
</html>
