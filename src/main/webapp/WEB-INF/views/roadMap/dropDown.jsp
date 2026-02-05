<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="${cpath}/resources/css/roadMap/dropDown.css">

<div class="stage-controls-left">
    <div class="select-wrapper">
        <button id="levelSelect" class="control-item w-[100px]" type="button" aria-label="레벨 선택">
            <span class="btn-text">${userLesson.levelName}</span>
        </button>
        <ul class="optionList">
            <c:forEach items="${levelList}" var="level">
                <li class="optionItem" data-value="${level.levelId}">${level.levelName}</li>
            </c:forEach>
        </ul>
    </div>

    <div class="select-wrapper">
        <button id="chapterSelect" class="control-item w-[260px]" type="button" aria-label="챕터 선택">
                <span class="btn-text">${userLesson.chapterName}</span>
        </button>
        <ul class="optionList custom-scroll" id="chapterListContainer"></ul>
    </div>
    <button id="moveBtn" type="submit" class="control-item btn-move">이동</button>
</div>
