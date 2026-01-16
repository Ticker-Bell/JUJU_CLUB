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
    <script>window.projectContextPath = "${pageContext.request.contextPath}";</script>
    <%--얘 없으면 기능 활성화가 안돼요--%>
    <script src="https://unpkg.com/lucide@latest"></script>
        <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>

        <script src="https://unpkg.com/htmx.org@1.9.10"></script>
        <%--차트 라이브러리--%>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <%--개념형 문제 css--%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lesson.css">
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonchat.css">

    <%--선택형 문제 css--%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonSelect.css">
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

<%--htmx 사용할때는 동적으로 처리하는거라 화면 교체후에 다시 생성해야 한다고하네요--%>
<script>
  document.body.addEventListener('htmx:afterSwap', (evt) => {
    if (evt.detail.target.id === 'main' && window.lucide) {
      lucide.createIcons(evt.detail.target); // main 안에 있는 SVG만 다시 생성
    }
  });
</script>

<script src="${cpath}/resources/js/main/main.js"></script>

</body>
</html>
