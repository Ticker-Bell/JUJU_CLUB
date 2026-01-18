tailwind.config = {
  theme: {
    extend: {
      fontFamily: {sans: ['Pretendard', 'sans-serif']},
      colors: {primary: '#5E45EB', text: '#191919'}
    }
  }
}

window.addEventListener("DOMContentLoaded", () => {
  if (window.lucide) lucide.createIcons();

  // ====== 전체 문제(5문항) 진행도: 1번 active 유지 ======
  const qDots = document.querySelectorAll("#qDots .q-dot");

  function setActiveQuestion(qIndex) { // 1..5
    qDots.forEach((d, i) => d.classList.toggle("active", (i + 1) === qIndex));
  }

  setActiveQuestion(1);

  // ====== Chat script (left = 설명자, right = 학습자) ======


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
    row.className = `flex w-full`; // 이거 해야 유저 채팅이 오른쪽 배치됌요
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
      location.href = "<c:url value='/lesson/lessonInfo' />";
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