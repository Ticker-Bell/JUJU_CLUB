<%--
  Created by IntelliJ IDEA.
  User: 퍼스트존 아카데미02
  Date: 2026-01-15
  Time: 오후 4:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/roadMap/dropDown.css">

<div class="stage-controls-left">
    <div class="select-wrapper">
        <button id="levelSelect" class="control-item w-[100px]" type="button" aria-label="레벨 선택">
            <span class="btn-text">${userLesson.get(0).getLevelName()}</span>
        </button>
        <ul class="optionList">
            <c:forEach items="${levelList}" var="level">
                <li class="optionItem" data-value="${level.levelId}">${level.levelName}</li>
            </c:forEach>
        </ul>
    </div>

    <div class="select-wrapper">
        <button id="chapterSelect" class="control-item w-[260px]" type="button" aria-label="챕터 선택">
                <span class="btn-text">${userLesson.get(0).getChapterName()}</span>

        </button>
        <ul class="optionList custom-scroll" id="chapterListContainer"></ul>
    </div>
    <button id="moveBtn" type="submit" class="control-item btn-move">이동</button>
</div>

<%--<script src="${pageContext.request.contextPath}/resources/js/roadMap/dropDown.js"></script>--%>