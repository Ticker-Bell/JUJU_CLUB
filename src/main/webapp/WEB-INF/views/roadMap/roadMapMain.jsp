<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 퍼스트존 아카데미02
  Date: 2026-01-12
  Time: 오후 4:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ include file="../common/common.jsp"%>--%>
<div>
    <h1>로드맵</h1>
    <form action="roadMap/main.do" method="post">
        <label for="level">단계</label><select name="levelId" id="levelId">
            <c:forEach items="${levelList}" var="level">
                <option value="${level.levelId}">${level.levelName}</option>
            </c:forEach>
        </select>
        <label for="level">챕터</label><select name="chapterId" id="chapterId">
        <c:forEach items="${chptList}" var="chapter">
            <option value="${chapter.chapterId}">${chapter.chapterName}</option>
        </c:forEach>
    </select>
    <input type="submit" value="이동">
    </form>

    <button type="button"
            class="bg-blue-500 text-white p-2 rounded"
            hx-post="${cpath}/lesson/lessonInfo"
            hx-vals='{"lessonId": "10", "category": "java"}'
            hx-target="#main"
            hx-swap="innerHTML"
            hx-push-url="true"> 이동버튼 </button>
</div>