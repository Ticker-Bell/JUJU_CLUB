<%--
  Created by IntelliJ IDEA.
  User: JHH
  Date: 2026-01-13
  Time: 오후 4:00
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lesson.css">
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" as="style" crossorigin
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css"/>

<c:if test="${!empty titles}">
    <div class="mb-6 px-1 flex items-end relative min-h-[50px]">
        <div>
            <div class="text-[11px] font-extrabold text-gray-400 flex items-center gap-2 mb-1">
                <span class="w-2 h-2 rounded-full bg-primary"></span>
                챕터명: ${titles[0].chapterName}
            </div>

            <div class="text-lg font-extrabold text-gray-900">
                레슨명: ${titles[0].lessonName}
            </div>
        </div>


        <div id="qDots" class="q-dots absolute left-1/2 -translate-x-1/2 bottom-2"
             aria-label="문제 진행도">
            <c:forEach var="t" items="${titles}">
                <span class="q-dot" data-q="${t.questionId}" title="${t.questionId}번 문제"></span>
            </c:forEach>
        </div>
    </div>
</c:if>
