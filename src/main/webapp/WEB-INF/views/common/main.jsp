<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" scope="request"/>

<html>
<head>
    <!-- ✅ Tailwind 확장 설정: 반드시 tailwind CDN 로드 "이전"에 있어야 함 -->
    <script>
        window.tailwind = window.tailwind || {};
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: { sans: ['Pretendard', 'sans-serif'] },
                    colors: {
                        primary: '#5E45EB',
                        secondary: '#F8FAFC'
                    }
                }
            }
        };
    </script>

    <%-- 얘 없으면 기능 활성화가 안돼요 --%>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://unpkg.com/htmx.org@1.9.10"></script>
    <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>

    <%-- 도넛차트 --%>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/invest/portfolioDonutChart.js"></script>

    <%-- 주식 차트 js --%>
    <script src="${pageContext.request.contextPath}/resources/js/invest/stockLineChart.js"></script>

    <%-- jQuery --%>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <%-- 웹소켓js --%>
    <script src="${pageContext.request.contextPath}/resources/js/invest/stockSocket.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

    <%-- 레슨 공통 css --%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lesson.css">
    <%-- 문항 버튼, 모달 css --%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonSelect.css">
    <%-- 개념형 문제 css --%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonchat.css">
    <%-- 드래형 문제 css --%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonDrag.css">
    <%-- 연결형 문제 css --%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonMatch.css">
    <%-- 랭킹 메인 css --%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/ranking/rankingMain.css">
    <%-- 챕터 테스트 css --%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/chapterTest.css">
    <%-- 로딩 --%>
    <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/main/main.css">

    <!-- ✅ 아이콘/스크립트가 먼저 “딱 한번” 초기화되도록 -->
    <script>
        function refreshLucide(target) {
            if (!window.lucide) return;
            try {
                if (target) lucide.createIcons(target);
                else lucide.createIcons();
            } catch (e) {
                // 무시 (lucide 로딩 타이밍 방어)
            }
        }

        document.addEventListener('DOMContentLoaded', () => {
            refreshLucide(document);
        });

        // HTMX swap 이후에도 다시 찍어주기
        document.body.addEventListener('htmx:afterSwap', (evt) => {
            // main 영역이 바뀐 경우만 처리
            if (evt.detail && evt.detail.target && evt.detail.target.id === 'main') {
                refreshLucide(evt.detail.target);
            }
        });

        // 혹시 load 이벤트에서도 방어적으로 한번 더
        document.body.addEventListener('htmx:load', (evt) => {
            if (evt.target && evt.target.id === 'main') {
                refreshLucide(evt.target);
            }
        });
    </script>
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

<script src="${cpath}/resources/js/main/main.js"></script>
</body>
</html>