<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--공통 헤더--%>

<link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lesson.css">
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>JUJU CLUB - Education 1</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>

    <style>

      /* chat bubbles */
      .bubble-wrap {
        display: flex;
        gap: 10px;
        max-width: 820px;
      }

      .bubble {
        position: relative;
        padding: 12px 14px;
        border-radius: 18px;

        /* 글자 크기 키움 */
        font-size: 16.5px;
        line-height: 1.6;

        font-weight: 700;
        box-shadow: 0 10px 24px rgba(17, 24, 39, 0.08);
        transform: translateY(6px);
        opacity: 0;
        animation: msgIn .26s ease-out forwards;
      }

      @keyframes msgIn {
        to {
          transform: translateY(0);
          opacity: 1;
        }
      }

      .bubble.left {
        background: #F3F4F6;
        border: 1px solid #E5E7EB;
        color: #111827;
        border-top-left-radius: 10px;
      }

      .bubble.right {
        background: rgba(94, 69, 235, 0.92);
        border: 1px solid rgba(94, 69, 235, 0.22);
        color: #fff;
        border-top-right-radius: 10px;
      }

      .meta {
        font-size: 11px;
        font-weight: 800;
        color: #9CA3AF;
        margin: 0 0 2px 2px;
        letter-spacing: -0.01em;
      }

      .meta.right {
        text-align: right;
        margin: 0 2px 2px 0;
      }

      /* typing dots */
      .typing {
        display: flex;
        align-items: center;
        gap: 6px;
        padding: 10px 12px;
        border-radius: 18px;
        background: rgba(255, 255, 255, 0.72);
        border: 1px solid rgba(229, 231, 235, 0.9);
        backdrop-filter: blur(10px);
        box-shadow: 0 12px 28px rgba(17, 24, 39, 0.10);
      }

      .dot {
        width: 6px;
        height: 6px;
        border-radius: 999px;
        background: #9CA3AF;
        animation: b 1s infinite;
      }

      .dot:nth-child(2) {
        animation-delay: .12s;
      }

      .dot:nth-child(3) {
        animation-delay: .24s;
      }

      @keyframes b {
        0%, 100% {
          transform: translateY(0);
          opacity: .55;
        }
        50% {
          transform: translateY(-3px);
          opacity: 1;
        }
      }
    </style>

    <script>
      tailwind.config = {
        theme: {
          extend: {
            fontFamily: {sans: ['Pretendard', 'sans-serif']},
            colors: {primary: '#5E45EB', text: '#191919'}
          }
        }
      }
    </script>
</head>

<body class="flex flex-col h-screen w-full overflow-hidden bg-white">

<div class="w-full h-20 flex flex-shrink-0 fixed top-0 z-50">
    <%@ include file="/WEB-INF/views/lesson/common/lesson.jsp" %>

    <header class="flex-1 bg-primary/10 flex items-center justify-end px-10 gap-6">
        <div class="flex items-center gap-6">
            <div class="grid grid-cols-2 gap-4">
                <div class="text-right">
                    <div class="text-[10px] font-extrabold text-gray-500">총 자산</div>
                    <div class="text-sm font-extrabold num-font text-gray-900">₩ 12,450,000</div>
                </div>
                <div class="text-right">
                    <div class="text-[10px] font-extrabold text-gray-500">예수금</div>
                    <div class="text-sm font-extrabold num-font text-gray-900">₩ 3,200,000</div>
                </div>
            </div>

            <div class="flex items-center">
        <span id="userLevelBadge"
              class="px-3 py-1 rounded-full bg-primary/10 text-primary text-[11px] font-extrabold border border-primary/20">
          초급
        </span>
            </div>

            <div class="text-right">
                <span class="block text-sm font-extrabold text-text">김주린</span>
            </div>
        </div>

        <div class="w-[1px] h-4 bg-primary/20"></div>

        <button class="flex items-center gap-2 text-gray-500 hover:text-red-500 transition-colors group">
            <span class="text-xs font-bold">로그아웃</span>
            <div class="w-8 h-8 rounded-full flex items-center justify-center bg-white group-hover:bg-red-50 transition-colors shadow-sm">
                <i data-lucide="log-out" class="w-4 h-4"></i>
            </div>
        </button>
    </header>
</div>

<div class="flex flex-1 h-full pt-20 overflow-hidden relative">
    <%--sidebar 공통헤더--%>
    <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

    <main class="flex-1 overflow-hidden p-8 flex flex-col bg-gray-50">
        <div class="flex flex-col w-full h-full max-w-[1800px] mx-auto min-h-0">

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

        </div>
    </main>
</div>

<script>
  window.addEventListener("DOMContentLoaded", () => {
    if (window.lucide) lucide.createIcons();

    document.getElementById("userLevelBadge").textContent = "초급";

    // ====== 전체 문제(5문항) 진행도: 1번 active 유지 ======
    const qDots = document.querySelectorAll("#qDots .q-dot");

    function setActiveQuestion(qIndex) { // 1..5
      qDots.forEach((d, i) => d.classList.toggle("active", (i + 1) === qIndex));
    }

    setActiveQuestion(1);

    // ====== Chat script (left = 설명자, right = 학습자) ======
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

// JS에서 side와 name 처리
    script.forEach(msg => {
      const isUser = msg.side.trim() === 'user';
      msg.side = isUser ? 'right' : 'left';        // UI용 side
      msg.name = isUser ? '홍길동' : '멘토';       // 유저명 / 멘토명
    });

// 테스트용: 콘솔 출력
    console.log(script);



    // ====== UI refs ======
    const chatList = document.getElementById("chatList");
    const chatScroll = document.getElementById("chatScroll");
    const typingRow = document.getElementById("typingRow");
    const nextBtn = document.getElementById("nextBtn");
    const skipBtn = document.getElementById("skipBtn");
    const resetBtn = document.getElementById("resetBtn");
    console.log(chatList)
    let idx = 0;

    function mdBoldToHTML(s) {
      return s.replace(/\*\*(.+?)\*\*/g, "<span class='font-extrabold'>$1</span>");
    }

    function timeStamp() {
      var d = new Date();
      var hh = ("0" + d.getHours()).slice(-2);
      var mm = ("0" + d.getMinutes()).slice(-2);
      return hh + ":" + mm;
    }

    function scrollToBottom() {
      chatScroll.scrollTop = chatScroll.scrollHeight;
    }

    function addMessage(msg) {
      const isRight = msg.side === "right";


      const row = document.createElement("div");
      row.className = `flex w-full`; // 이거 해야 오른쪽 배치됌
      row.style.justifyContent = isRight ? "flex-end" : "flex-start";

      const wrap = document.createElement("div");
      wrap.className = "flex flex-col";
      wrap.style.alignItems = isRight ? "flex-end" : "flex-start";

      const meta = document.createElement("div");
      meta.className = `meta ${isRight ? "right" : ""}`;
      meta.textContent = msg.name + ' · ' + timeStamp();

      const bubbleWrap = document.createElement("div");
      bubbleWrap.className = "bubble-wrap";
      if (isRight) bubbleWrap.style.justifyContent = "flex-end";

      const bubble = document.createElement("div");
      bubble.className = `bubble ${isRight ? "right" : "left"}`;
      bubble.innerHTML = mdBoldToHTML(msg.text);

      bubbleWrap.appendChild(bubble);
      wrap.appendChild(meta);
      wrap.appendChild(bubbleWrap);
      row.appendChild(wrap);

      chatList.appendChild(row);
      scrollToBottom();
    }

    // 대기시간 없이 즉시 표시(말풍선 애니메이션 유지)
    function step() {
      if (idx >= script.length) {
        alert("Education 1 완료! (연동 시 로드맵 완료 처리 + 다음 레슨 이동)");
        return;
      }
      const msg = script[idx];
      idx += 1;

      typingRow.classList.add("hidden");
      addMessage(msg);

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

    // first message auto
    step();
  });
</script>

</body>
</html>
