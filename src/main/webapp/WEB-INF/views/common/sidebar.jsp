<%--
  Created by IntelliJ IDEA.
  User: 이유경
  Date: 2026-01-12
  Time: 오후 3:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/sidebar.css">

<div class="sidebar">
    <div class="menu-container">
        <button class="menu-item" onclick="location.href='/main/roadMapMain.do'">
            <div class="icon-wrap"><img src="/resources/images/icons/map.svg" alt="맵아이콘"></div>
            <span class="menu-text">학습로드맵</span>
        </button>

        <button class="menu-item" onclick="location.href='/main/investMain.do'">
            <div class="icon-wrap"><img src="/resources/images/icons/bar-chart.svg" alt="차트아이콘"></div>
            <span class="menu-text">모의투자</span>
        </button>

        <button class="menu-item" onclick="location.href='/main/rankingMain.do'">
            <div class="icon-wrap"><img src="/resources/images/icons/trophy-outline.svg" alt="랭킹아이콘"></div>
            <span class="menu-text">랭킹</span>
        </button>

        <button class="menu-item" onclick="location.href='/main/myPageMain.do'">
            <div class="icon-wrap"><img src="/resources/images/icons/user.svg" alt="마이아이콘"></div>
            <span class="menu-text">마이페이지</span>
        </button>
    </div>

</div>

<script>
    // 1. 현재 브라우저의 전체 경로를 가져옵니다. (예: /main/roadMapMain.do)
    const currentPath = window.location.pathname;

    // 2. 모든 메뉴 버튼을 가져옵니다.
    const menuItems = document.querySelectorAll('.menu-item');

    menuItems.forEach(item => {
        // 3. 우선 모든 active 클래스를 제거하여 비활성 상태로 만듭니다.
        item.classList.remove('active');

        // 4. onclick 속성값에서 따옴표 사이의 경로만 추출합니다.
        // 예: "location.href='/main/roadMapMain.do'" -> "/main/roadMapMain.do"
        const clickAttr = item.getAttribute('onclick');
        const match = clickAttr.match(/'([^']+)'/);

        if (match && match[1] === currentPath) {
            // 5. 현재 주소와 버튼의 이동 경로가 '정확히' 일치할 때만 활성화!
            item.classList.add('active');
        }
    });
</script>