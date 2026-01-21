<%--
  Created by IntelliJ IDEA.
  User: 퍼스트존 아카데미02
  Date: 2026-01-16
  Time: 오후 2:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/roadMap/missionButton.css">

<div class="mission-fab">
    <button id="openMissionBtn" type="button"
            class="btn-mission" aria-label="일일 미션"
            hx-get="${cpath}/roadMap/mission.do"
            hx-target="body"
            hx-swap="beforeend"
            hx-push-url="false">
        <c:if test="${isMissionClear}">
            <span class="mission-dot" id="missionDot"></span>
        </c:if>
        <img class="w-8 h-8 stroke-[-2]" src="${cpath}/resources/images/roadMapIcons/target.svg" alt="미션아이콘">
    </button>
</div>
