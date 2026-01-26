<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://unpkg.com/lucide@latest"></script>

<%--개념형 문제 css--%>
<link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lesson.css">
<link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonchat.css">

<%--챕터명,레슨명,문제 진행바--%>
<%@ include file="/WEB-INF/views/lesson/common/lessonCommon.jsp" %>

<section class="web-card flex-1 min-h-0 flex flex-col">
    <div class="px-6 py-4 border-b border-gray-100 flex items-center justify-between">
        <div class="flex items-center gap-3">
            <div class="w-9 h-9 rounded-2xl bg-gray-100 border border-gray-200 flex items-center justify-center">
                <i data-lucide="messages-square" class="w-5 h-5 text-gray-500"></i>
            </div>
            <div>
                <div class="text-sm font-extrabold text-gray-900">주식 기초 채팅</div>
                <div class="text-[11px] font-semibold text-gray-400">
                    버튼을 눌러 다음 메시지를 받아보세요
                </div>
            </div>
        </div>

        <!-- 오른쪽 버튼 영역 -->
        <div class="flex items-center gap-2">
            <!-- 빠르게 보기 (이동됨) -->
            <button id="skipBtn"
                    class="px-3 py-2 rounded-xl bg-white border border-gray-200 text-gray-600 font-extrabold text-xs hover:bg-gray-50 transition">
                빠르게 보기
            </button>

            <!-- 다시보기 -->
            <button id="resetBtn"
                    class="px-3 py-2 rounded-xl bg-white border border-gray-200 text-gray-600 font-extrabold text-xs hover:bg-gray-50 transition flex items-center gap-2">
                <i data-lucide="rotate-ccw" class="w-4 h-4"></i>
                다시보기
            </button>
        </div>
    </div>

    <div id="chatScroll" class="flex-1 min-h-0 overflow-y-auto px-6 py-5 bg-white">
        <div id="chatList" class="flex flex-col gap-4"></div>

        <div id="typingRow" class="mt-4 hidden">
            <div class="bubble-wrap">
                <div class="typing">
                    <span class="dot"></span>
                    <span class="dot"></span>
                    <span class="dot"></span>
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

            </div>
        </div>
    </div>
</section>

<%--레슨 선택형,드래그형,매치형,라인형 결과 모달창--%>
<%@ include file="/WEB-INF/views/lesson/common/resultModal.jsp" %>

<script>

  (function () {
    if (!document.getElementById("chatList")) return; // htmx 로딩 후 DOM 확인

    const script = [];
    <c:forEach var="colName" items="${colNames}">
    <c:set var="chatList" value="${chat[colName]}" />
    <c:forEach var="msg" items="${chatList}" varStatus="s">
    script.push({
      side: '${msg.sender}',
      name: '${msg.sender}',
      text: '<c:out value="${msg.text}" />'
    });
    </c:forEach>
    </c:forEach>

    // JS side/name UI 처리
    script.forEach(msg => {
      const isUser = msg.side.trim() === 'user';
      msg.side = isUser ? 'right' : 'left';
      msg.name = isUser ? '홍길동' : '멘토';
    });

    const chatList = document.getElementById("chatList");
    const nextBtn = document.getElementById("nextBtn");
    const skipBtn = document.getElementById("skipBtn");
    const resetBtn = document.getElementById("resetBtn");
    let idx = 0;

    function checkAnswer() {
      const modal = document.getElementById('resultModal');
      const icon = document.getElementById('modalIcon');
      const title = document.getElementById('modalTitle');
      const desc = document.getElementById('modalDesc');
      const bar = document.getElementById('modalBar');
      const btn = document.getElementById('modalActionBtn');

      modal.classList.remove('hidden');



        icon.textContent = "⚖️";
        icon.className = "w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-5 text-4xl shadow-lg bg-indigo-100 text-indigo-600";
        title.textContent = "개념 문제를 완료했어요!";
        title.className = "text-2xl font-extrabold text-indigo-600 mb-2";
        desc.innerHTML = EXPLANATION;
        bar.className = "h-2 w-full bg-indigo-500";
        btn.textContent = "다음 문제로";

        confetti({
          particleCount: 150,
          spread: 70,
          origin: {y: 0.6},
          colors: ['#5E45EB', '#818CF8', '#C7D2FE']
        });
      }


    function scrollToBottom() {
      chatScroll.scrollTop = chatScroll.scrollHeight;
    }

    function addMessage(msg) {
      const row = document.createElement("div");
      const isRight = msg.side === "right";
      row.className = "flex w-full";
      row.style.justifyContent = isRight ? "flex-end" : "flex-start";

      const wrap = document.createElement("div");
      wrap.className = "flex flex-col";
      wrap.style.alignItems = isRight ? "flex-end" : "flex-start";

      const meta = document.createElement("div");
      meta.className = `meta ${isRight ? "right" : ""}`;
      meta.textContent = msg.name + ' · ' + new Date().toLocaleTimeString([],
          {hour: '2-digit', minute: '2-digit'});

      const bubbleWrap = document.createElement("div");
      bubbleWrap.className = "bubble-wrap";

      const bubble = document.createElement("div");
      bubble.className = `bubble ${isRight ? "right" : "left"}`;
      bubble.innerHTML = msg.text;

      bubbleWrap.appendChild(bubble);
      wrap.appendChild(meta);
      wrap.appendChild(bubbleWrap);
      row.appendChild(wrap);
      chatList.appendChild(row);
      chatList.scrollTop = chatList.scrollHeight;
    }

    function step() {

      if (idx >= script.length) {

        htmx.ajax('POST', '${cpath}/lesson/qst', {
          target: '#main',
          values: {
            lessonId: '${lessonId}',
            questionId: 'LV1_CH001_LS001_Q002'
          }
        });

        return;
      }
      addMessage(script[idx]);
      idx++;
      const done = idx >= script.length;
      nextBtn.innerHTML = done
          ? `<i data-lucide="check" class="w-4 h-4"></i> 완료`
          : `<i data-lucide="send" class="w-4 h-4"></i> 다음`;

      if (window.lucide) lucide.createIcons();
    }

    function reset() {
      idx = 0;
      chatList.innerHTML = "";
      typingRow.classList.add("hidden");
      nextBtn.innerHTML = `<i data-lucide="send" class="w-4 h-4"></i> 다음`;
      if (window.lucide) lucide.createIcons();
      scrollToBottom();
    }

    function skipAll() {
      typingRow.classList.add("hidden");
      while (idx < script.length) {
        addMessage(script[idx]);
        idx++;
      }
      nextBtn.innerHTML = `<i data-lucide="check" class="w-4 h-4"></i> 완료`;
      if (window.lucide) lucide.createIcons();
      scrollToBottom();
    }

    nextBtn.addEventListener("click", step);
    skipBtn.addEventListener("click", skipAll);
    resetBtn.addEventListener("click", reset);

    // 첫 메시지 자동
    step();
  })();
  // 문제 진행바 활성화 (전역)
  function updateActiveDot(currentQId) {
    document.querySelectorAll('.q-dot').forEach(dot => {
      dot.classList.toggle('active', dot.dataset.q === currentQId);
    });
  }
  // 매 화면마다 udateActiveDot으로 활성화
  updateActiveDot('${titles[0].questionId}');
</script>
