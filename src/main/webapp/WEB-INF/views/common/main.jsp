<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" scope="request"/>
<html>
<head>
    <%--얘 없으면 기능 활성화가 안돼요--%>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://unpkg.com/htmx.org@1.9.10"></script>
    <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>
    <%--도넛차트--%>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <%--레슨 공통 css--%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lesson.css">
    <%--문항 버튼, 모달 css--%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonSelect.css">
    <%--개념형 문제 css--%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonchat.css">
    <%--드래형 문제 css --%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonDrag.css">
    <%--연결형 문제 css--%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonMatch.css">
    <%--랭킹 메인 css--%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/ranking/rankingMain.css">
    <%--챕터 테스트 css--%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/chapterTest.css">
</head>

<body class="flex flex-col h-screen w-full overflow-hidden bg-white">
<!-- topbar -->
<jsp:include page="topbar.jsp"/>
<div class="flex flex-1 h-full pt-20 overflow-hidden relative">

    <!-- sidebar -->
    <jsp:include page="sidebar.jsp"/>

    <!-- Main -->
    <main id="main" class="flex-1 overflow-y-auto p-8 flex flex-col bg-gray-50">
        <jsp:include page="/WEB-INF/views/${targetPage}.jsp"/>
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
