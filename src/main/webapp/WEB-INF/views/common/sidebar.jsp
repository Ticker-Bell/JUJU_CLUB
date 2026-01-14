<%--
  Created by IntelliJ IDEA.
  User: 이유경
  Date: 2026-01-12
  Time: 오후 3:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common.jsp"%>
<link rel="stylesheet" type="text/css" href="${cpath}/resources/css/sidebar/sidebar.css">
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css" />
<script src="https://unpkg.com/htmx.org@1.9.10"></script>
<aside class="w-[220px] bg-primary/5 flex flex-col flex-shrink-0 z-40 py-8 pl-4 border-r border-transparent h-full overflow-y-auto transition-all duration-300">
    <div class="flex-shrink-0"></div>

    <%-- 로드맵  --%>
    <nav class="flex flex-col justify-center gap-5 w-full pr-4 my-auto">
        <a href="${cpath}/main/roadMapMain.do" class="nav-item group"
            hx-get="${cpath}/main/roadMapMain.do"
            hx-target="#main"
            hx-swap="innerHTML"
            hx-push-url="true">
            <div class="nav-icon-box"><img class="w-5 h-5 stroke-[2]" src="${cpath}/resources/images/navIcons/map.svg" alt="맵아이콘"></div>
            <span class="text-sm font-bold mt-0.5">학습 로드맵</span>
        </a>
        <a href="${cpath}/main/myPageMain.do" class="nav-item group"
           hx-get="${cpath}/main/myPageMain.do"
           hx-target="#main"
           hx-swap="innerHTML"
           hx-push-url="true">
            <div class="nav-icon-box"><img src="${cpath}/resources/images/navIcons/user.svg" alt="마이아이콘" class="w-5 h-5 stroke-[2]"></div>
            <span class="text-sm font-bold mt-0.5">마이페이지</span>
        </a>
        <a href="${cpath}/main/investMain.do" class="nav-item group"
           hx-get="${cpath}/main/investMain.do"
           hx-target="#main"
           hx-swap="innerHTML"
           hx-push-url="true">
            <div class="nav-icon-box"><img src="${cpath}/resources/images/navIcons/bar-chart.svg" alt="차트아이콘" class="w-5 h-5 stroke-[2]"></div>
            <span class="text-sm font-bold mt-0.5">모의투자</span>
        </a>
        <a href="${cpath}/main/rankingMain.do" class="nav-item group"
           hx-get="${cpath}/main/rankingMain.do"
           hx-target="#main"
           hx-swap="innerHTML"
           hx-push-url="true">
            <div class="nav-icon-box"><img src="${cpath}/resources/images/navIcons/trophy-outline.svg" alt="랭킹아이콘" class="w-5 h-5 stroke-[2]"></div>
            <span class="text-sm font-bold mt-0.5">랭킹</span>
        </a>
    </nav>

    <footer class="mt-auto pr-4 pt-6 pb-2">
        <div class="text-center text-[10px] font-extrabold text-gray-400 leading-relaxed">
            <div class="text-gray-500">© 2026 JUJU CLUB</div>
            <div class="mt-1">모의투자 서비스</div>
            <div class="mt-1">학습 로드맵</div>
            <div class="mt-1">문의: support@jujuclub.example</div>
        </div>
    </footer>
</aside>