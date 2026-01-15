<%--
  Created by IntelliJ IDEA.
  User: 퍼스트존 아카데미02
  Date: 2026-01-13
  Time: 오후 12:11
  To change this template use File | Settings | File Templates.
--%>
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
    <main id="main" class="flex-1 overflow-hidden p-8 flex flex-col bg-gray-50">
<%--        <div id="main" class="flex flex-col w-full h-full max-w-[1800px] mx-auto min-h-0">--%>

            <jsp:include page="/WEB-INF/views/${targetPage}.jsp"/>

<%--        </div>--%>
    </main>
</div>

<script src="${cpath}/resources/js/main/main.js"></script>

</body>
</html>
