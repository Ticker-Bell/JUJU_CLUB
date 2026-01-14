<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--공통 헤더--%>

<link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lesson.css">
<link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonchat.css">
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>JUJU CLUB - Education 1</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>

<%@ include file="/WEB-INF/views/lesson/common/lesson2.jsp" %>

<section class="web-card flex-1 min-h-0 flex flex-col">
    <div class="px-6 py-4 border-b border-gray-100 flex items-center justify-between">
        <div class="flex items-center gap-3">
            <div class="w-9 h-9 rounded-2xl bg-gray-100 border border-gray-200 flex items-center justify-center">
                <i data-lucide="messages-square" class="w-5 h-5 text-gray-500"></i>
            </div>
            <div>
                <div class="text-sm font-extrabold text-gray-900">주식 기초 채팅</div>
                <div class="text-[11px] font-semibold text-gray-400">버튼을 눌러 다음 메시지를
                    받아보세요
                </div>
            </div>
        </div>

        <button id="resetBtn"
                class="px-3 py-2 rounded-xl bg-white border border-gray-200 text-gray-600 font-extrabold text-xs hover:bg-gray-50 transition flex items-center gap-2">
            <i data-lucide="rotate-ccw" class="w-4 h-4"></i>
            다시보기
        </button>
    </div>

    <div id="chatScroll" class="flex-1 min-h-0 overflow-y-auto px-6 py-5 bg-white">
        <div id="chatList" class="flex flex-col gap-4"></div>

        <div id="typingRow" class="mt-4 hidden">
            <div class="bubble-wrap">
                <div class="typing">
                    <span class="dot"></span><span class="dot"></span><span
                        class="dot"></span>
                </div>
            </div>
        </div>
    </div>

    <div class="px-6 py-5 border-t border-gray-100 bg-white">
        <div class="flex items-center justify-between gap-4">
            <div class="text-[11px] font-semibold text-gray-400 leading-relaxed">
                ✔ “다음”을 누르면 바로 메시지가 표시됩니다(대기시간 없음).<br/>
                ✔ 모든 대화를 보면 버튼이 “완료”로 바뀝니다.
            </div>

            <div class="flex items-center gap-2">
                <button id="nextBtn"
                        class="px-4 py-2 rounded-xl bg-primary text-white font-extrabold text-sm shadow-sm hover:brightness-[1.03] transition flex items-center gap-2">
                    <i data-lucide="send" class="w-4 h-4"></i>
                    다음
                </button>

                <button id="skipBtn"
                        class="px-4 py-2 rounded-xl bg-white border border-gray-200 text-gray-600 font-extrabold text-sm hover:bg-gray-50 transition">
                    빠르게 보기
                </button>
            </div>
        </div>
    </div>
</section>

<script>
  const script = [];
  // 여러 options 컬럼 반복
  <c:forEach var="colName" items="${colNames}">
  <c:set var="chatList" value="${chat[colName]}" />

  <c:forEach var="msg" items="${chatList}" varStatus="s">
  script.push({
    side: '${msg.sender}',  // 일단 DB sender 그대로
    name: '${msg.sender}',  // JS에서 변경
    text: '<c:out value="${msg.text}" />'
  });
  </c:forEach>
  </c:forEach>
</script>

<script src="${cpath}/resources/js/lesson/lessonchat.js"></script>


</html>
