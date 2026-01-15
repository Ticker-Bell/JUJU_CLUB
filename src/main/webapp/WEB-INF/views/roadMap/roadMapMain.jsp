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
    <button type="button"
            class="bg-blue-500 text-white p-2 rounded"
            hx-post="${cpath}/lesson/lessonInfo"
            hx-vals='{"lessonId": "lesson_stock_01"}'
            hx-target="#main"
            hx-swap="innerHTML"
            hx-push-url="true"> 이동버튼 </button>
</div>