<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" as="style" crossorigin
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css"/>

<script>
  tailwind.config = {theme: {extend: {colors: {primary: '#5E45EB', secondary: '#10B981'}}}}
</script>

<body class="flex flex-col h-screen w-full overflow-hidden bg-[#F8FAFC]">

<header class="w-full h-24 px-8 flex items-center justify-between relative shrink-0">
    <div class="flex items-center gap-3">
        <div class="w-10 h-10 rounded-xl bg-white border border-gray-200 flex items-center justify-center text-primary shadow-sm">
            <i data-lucide="book-open" class="w-5 h-5"></i>
        </div>
        <div>
            <div class="text-[10px] font-bold text-gray-400 uppercase tracking-wider mb-0.5">Current
                Lesson
            </div>
            <div class="text-sm font-extrabold text-gray-900">Chapter 1. 기초 용어</div>
        </div>
    </div>

    <div class="absolute left-1/2 -translate-x-1/2 flex flex-col items-center gap-3">
        <div class="progress-container" id="progressBar"></div>
        <div class="text-xs font-bold text-gray-400 tracking-widest">
            <span id="currentStep" class="text-primary font-extrabold">1</span> /
            <span id="totalStep" class="text-gray-400 font-bold"></span>
        </div>
    </div>

    <button onclick="openExitModal()"
            class="w-12 h-12 rounded-full bg-white border border-gray-200 flex items-center justify-center text-gray-400 hover:text-red-500 hover:border-red-200 hover:bg-red-50 transition-all shadow-sm group">
        <i data-lucide="x" class="w-6 h-6 group-hover:scale-110 transition-transform"></i>
    </button>
</header>

<main class="flex-1 flex flex-col items-center justify-center p-6 pb-12">
    <div class="w-full max-w-4xl h-full flex flex-col">

        <section
                class="quiz-card flex-1 flex flex-col p-8 md:p-12 relative animate-fade-in overflow-y-auto">
            <div id="quizArea" class="flex-1 flex flex-col justify-center"></div>
        </section>

        <div class="mt-6 flex items-center justify-between shrink-0">
            <div id="guideArea" class="animate-fade-in pl-2"></div>

            <button id="checkBtn" onclick="checkAnswer()" disabled
                    class="px-10 py-4 rounded-2xl bg-gray-200 text-gray-400 font-bold text-lg transition-all flex items-center gap-3 cursor-not-allowed shadow-none">
                <span>정답 확인</span>
                <i data-lucide="check" class="w-5 h-5"></i>
            </button>
        </div>

    </div>
</main>

<div id="feedbackModal" class="modal-overlay">
    <div class="modal-box">
        <div id="feedbackIcon"
             class="w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-6 text-4xl shadow-inner transition-colors"></div>
        <h3 id="feedbackTitle" class="text-2xl font-extrabold text-gray-900 mb-2"></h3>
        <p id="feedbackDesc" class="text-gray-500 font-medium mb-8 text-sm break-keep"></p>
        <button onclick="nextQuestion()"
                class="w-full py-3.5 bg-gray-900 text-white font-bold rounded-xl hover:bg-black transition-colors">
            다음 문제
        </button>
    </div>
</div>

<div id="exitModal" class="modal-overlay">
    <div class="modal-box">
        <div class="w-16 h-16 rounded-full bg-red-50 text-red-500 flex items-center justify-center mx-auto mb-5">
            <i data-lucide="log-out" class="w-8 h-8"></i>
        </div>
        <h3 class="text-xl font-bold text-gray-900 mb-2">학습을 종료하시겠어요?</h3>
        <p class="text-gray-500 text-sm mb-8">지금 나가시면 진행 상황이 저장되지 않을 수 있습니다.</p>
        <div class="flex gap-3">
            <button onclick="closeExitModal()"
                    class="flex-1 py-3 bg-gray-100 text-gray-600 font-bold rounded-xl hover:bg-gray-200 transition">
                취소
            </button>
            <button onclick="location.href='${cpath}/roadMap/main.do'"
                    class="flex-1 py-3 bg-red-500 text-white font-bold rounded-xl hover:bg-red-600 transition">
                나가기
            </button>
        </div>
    </div>
</div>

<div id="successModal" class="modal-overlay">
    <div class="modal-box w-full max-w-xl p-10">
        <div class="w-20 h-20 rounded-full bg-green-100 text-green-600 flex items-center justify-center mx-auto mb-6 shadow-inner animate-bounce">
            <i data-lucide="party-popper" class="w-10 h-10"></i>
        </div>
        <h2 class="text-3xl font-extrabold text-gray-900 mb-2">챕터 테스트 통과!</h2>
        <p class="text-gray-500 font-medium mb-8">
            축하합니다! 테스트를 훌륭하게 완수하셨네요.<br>챕터 보상이 계좌로 입금되었습니다.
        </p>

        <div class="flex items-center justify-center gap-4 md:gap-8 mb-8 bg-gray-50 rounded-2xl p-6 border border-gray-100">
            <div class="text-center">
                <div class="text-xs font-bold text-gray-400 uppercase mb-1">총 문제</div>
                <div class="text-2xl font-black text-gray-800">10</div>
            </div>
            <div class="w-px h-10 bg-gray-200"></div>
            <div class="text-center">
                <div class="text-xs font-bold text-gray-400 uppercase mb-1">맞춘 개수</div>
                <div class="text-2xl font-black text-primary" id="finalScore">0</div>
            </div>
            <div class="w-px h-10 bg-gray-200"></div>
            <div class="text-center">
                <div class="text-xs font-bold text-gray-400 uppercase mb-1">정답률</div>
                <div class="text-2xl font-black text-secondary" id="finalPercent">0%</div>
            </div>
        </div>

        <div class="deposit-card bg-primary/5 border border-primary/10 rounded-2xl p-5 mb-8 text-left shadow-sm relative overflow-hidden">
            <div class="absolute top-0 left-0 w-1 h-full bg-primary"></div>
            <div class="flex justify-between items-start mb-2">
                <div class="flex items-center gap-2">
                    <div class="w-6 h-6 rounded-full bg-primary text-white flex items-center justify-center text-xs font-bold">
                        J
                    </div>
                    <span class="text-xs font-bold text-gray-500">주주클럽 뱅킹</span>
                </div>
                <span class="text-[10px] text-gray-400">방금 전</span>
            </div>
            <div class="text-lg font-extrabold text-gray-900 mb-1">입금 완료</div>
            <div class="text-2xl font-black text-primary num-font">
                + <fmt:formatNumber value="${title[0].rewardCash}" type="number"/>원
            </div>
            <div class="text-xs text-gray-400 mt-2 font-medium">Chapter ${chapterId.substring(8)} 수료 장학금</div>
        </div>

        <button id="goToRoadmapBtn"
                class="w-full py-4 bg-primary text-white font-bold rounded-xl shadow-lg shadow-primary/30 hover:brightness-110 hover:-translate-y-1 transition-all text-lg">
            로드맵으로 돌아가기
        </button>
    </div>
</div>

<div id="failModal" class="modal-overlay">
    <div class="modal-box">
        <div class="w-20 h-20 rounded-full bg-red-100 text-red-500 flex items-center justify-center mx-auto mb-6 shadow-inner">
            <i data-lucide="frown" class="w-10 h-10"></i>
        </div>
        <h2 class="text-2xl font-extrabold text-gray-900 mb-2">테스트 불합격</h2>
        <p class="text-gray-500 text-sm font-medium mb-8">
            아쉽게도 <span class="text-red-500 font-bold">4문제 이상</span> 틀려<br>테스트가 종료되었습니다.<br>
            <span class="text-primary font-bold mt-2 block">도전 횟수는 무제한이니 다시 도전해보세요!</span>
        </p>

        <div class="flex flex-col gap-3">
            <%--다시 도전하기 비활성화--%>
            <%--<button onclick="location.reload()"
                    class="w-full py-3.5 bg-gray-900 text-white font-bold rounded-xl shadow-lg hover:bg-black transition-all">
                다시 도전하기
            </button>--%>
            <button onclick="handleFailExit()"
                    class="w-full py-3.5 bg-gray-900 text-white font-bold rounded-xl shadow-lg hover:bg-black transition-all">
                로드맵으로 돌아가기
            </button>
        </div>
    </div>
</div>
</body>

<script>

  /* ---------------- quizData 생성 ---------------- */
  var quizData = [
    <c:forEach var="q" items="${qst}" varStatus="st">
    {
      questionType: "${q.questionType}",
      questionText: "${fn:escapeXml(q.questionText)}",
      explanation: "${fn:escapeXml(q.explanation)}",
      optionList: [
        <c:forEach var="o" items="${q.optionList}" varStatus="i">
        "${fn:escapeXml(o)}"<c:if test="${!i.last}">, </c:if>
        </c:forEach>
      ],
      answer: "${q.answer}",
      answerList: "${q.answerList}",
      leftOptions: [
        <c:forEach var="l" items="${q.leftOptions}" varStatus="i">
        {id: "${l.id}", text: "${fn:escapeXml(l.text)}"}<c:if test="${!i.last}">, </c:if>
        </c:forEach>
      ],
      rightOptions: [
        <c:forEach var="r" items="${q.rightOptions}" varStatus="i">
        {id: "${r.id}", text: "${fn:escapeXml(r.text)}"}<c:if test="${!i.last}">, </c:if>
        </c:forEach>
      ],
      matchAnswer: {
        <c:forEach var="e" items="${q.matchAnswer}" varStatus="i">
        "${e.key}": "${e.value}"<c:if test="${!i.last}">, </c:if>
        </c:forEach>
      }
    }
    <c:if test="${!st.last}">, </c:if>
    </c:forEach>
  ];

  /* ---------------- 전역 변수 ---------------- */
  var currentIndex = 0;
  var userAnswers = {};
  var historyStatus = new Array(10).fill(null);
  var draggedText = null;
  var matchState = {left: null, connections: {}};
  var score = 0;
  var wrongCount = 0;

  // DOM 엘리먼트 참조
  const quizArea = document.getElementById('quizArea');
  const checkBtn = document.getElementById('checkBtn');
  const progressBar = document.getElementById('progressBar');
  const currentStepText = document.getElementById('currentStep');
  const guideArea = document.getElementById('guideArea');
  const chapterId = '${chapterId}'
  <%--const cpath = '${cpath}'--%>

  initQuiz();

  /* ---------------- 초기화 ---------------- */
  function initQuiz() {
    //DB에서 가져오는 문항들 중에서 10문제
    shuffledQuiz = shuffleQuiz([...quizData]).slice(0, 10);
    renderProgress();
    renderQuestion();
  }

  /* ---------------- 진행도 렌더링 ---------------- */
  function renderProgress() {
    const progressBar = document.getElementById('progressBar');
    if (!progressBar) return;
    progressBar.innerHTML = '';

    // DB에서 가져온 문제 개수 기준
    const total = shuffledQuiz.length;

    for (let i = 0; i < total; i++) {
      const dot = document.createElement('div');
      dot.className = 'p-dot';

      if (i === currentIndex) {
        dot.classList.add('current');
        dot.textContent = i + 1;
      } else if (i < currentIndex) {
        dot.classList.add(historyStatus[i] === true ? 'correct' : 'wrong');
        dot.textContent = i + 1;
      } else {
        dot.textContent = i + 1;
      }

      progressBar.appendChild(dot);
    }

    // 현재 스텝 텍스트 갱신
    const stepEl = document.getElementById('currentStep');
    const totalEl = document.getElementById('totalStep');
    if (stepEl && totalEl) {
      stepEl.textContent = currentIndex + 1;
      totalEl.textContent = shuffledQuiz.length;
    }
  }

  /* ---------------- 문제 렌더링 ---------------- */
  function renderQuestion() {
    if (!quizData[currentIndex]) return;
    const data = shuffledQuiz[currentIndex];

    userAnswers[currentIndex] = null;

    var quizArea = document.getElementById('quizArea');
    var guideArea = document.getElementById('guideArea');
    var checkBtn = document.getElementById('checkBtn');
    if (!quizArea) return;

    checkBtn.disabled = true;
    checkBtn.className =
        "px-10 py-4 rounded-2xl bg-gray-200 text-gray-400 font-bold text-lg transition-all flex items-center gap-2 cursor-not-allowed";

    var html = ''; // ✅ 반드시 필요
    var guideText = "", guideIcon = "";
    if (data.questionType === 'SELECT') {
      guideText = "보기 중 정답을 하나 선택해주세요.";
      guideIcon = "list-checks";
    } else if (data.questionType === 'MATCH') {
      guideText = "단어를 클릭하여 빈칸을 채워보세요.";
      guideIcon = "text-cursor-input";
    } else if (data.questionType === 'DRAG') {
      guideText = "단어를 드래그하여 [ ] 안으로 옮겨주세요.";
      guideIcon = "grab";
    } else if (data.questionType === 'LINK') {
      guideText = "왼쪽 용어와 오른쪽 설명을 연결하세요.";
      guideIcon = "git-merge";
    }

    guideArea.innerHTML =
        '<div class="inline-flex items-center gap-2 text-gray-500 font-bold text-lg">' +
        '<i data-lucide="' + guideIcon + '" class="w-5 h-5 text-primary"></i>' +
        '<span>' + guideText + '</span></div>';

      html += '<div class="text-center mb-10 fade-in">';
      html += '<span class="inline-block px-4 py-1.5 rounded-full bg-primary/10 text-primary text-sm font-extrabold mb-4 border border-primary/20">';
      html += 'Question ' + (currentIndex + 1) + '</span>';
    if (data.questionType === 'SELECT' || data.questionType === 'LINK') {
      html += '<h2 class="text-2xl md:text-3xl font-extrabold text-gray-900 leading-snug break-keep">';
      html += data.questionText;
      html += '</h2></div>';
    }

    if (data.questionType === 'SELECT') {
      html += '<div class="grid grid-cols-1 md:grid-cols-2 gap-4">';
      for (var i = 0; i < data.optionList.length; i++) {
        html += '<button class="choice-btn" onclick="handleMultipleSelect(' + i + ', this)">';
        html += '<span>' + data.optionList[i] + '</span>';
        html += '<div class="w-6 h-6 rounded-full border-2 border-gray-300 flex items-center justify-center check-circle transition-colors"></div></button>';
      }
      html += '</div>';
    }

    else if (data.questionType === 'MATCH') {

      // {{blank}} → blank-box 치환
      var sentence = data.questionText.replace(/\{\{blank\}\}/g,
          '<div class="blank-box empty mx-1" onclick="removeWord(this)"></div>'
      );

      html +=
          '<div class="bg-gray-50 p-8 rounded-2xl border border-gray-200 mb-8 ' +
          'text-center leading-loose text-lg font-medium text-gray-800">' +
          sentence +
          '</div>';

      // 보기 (클릭형)
      html += '<div class="flex flex-wrap justify-center gap-3">';
      for (var j = 0; j < data.optionList.length; j++) {
        html +=
            '<button class="word-chip" onclick="selectWord(\'' + data.optionList[j] + '\', this)">'
            +
            data.optionList[j] +
            '</button>';
      }
      html += '</div>';
    } else if (data.questionType === 'DRAG') {
      var sentence = data.questionText.replace(/\{\{blank\}\}/g,
          '<div class="drop-zone mx-1" ondragover="allowDrop(event)" ondrop="handleDrop(event)"></div>');
      html += '<div class="bg-gray-50 p-8 rounded-2xl border border-gray-200 mb-8 text-center leading-loose text-lg font-medium text-gray-800">'
          + sentence + '</div>';
      html += '<div class="flex justify-center gap-4 min-h-[60px]" id="dragSource">';
      for (var j = 0; j < data.optionList.length; j++) {
        html += '<div class="drag-item" draggable="true" ondragstart="handleDragStart(event,\''
            + data.optionList[j] + '\')">' + data.optionList[j] + '</div>';
      }
      html += '</div>';
    } else if (data.questionType === 'LINK') {
      html += '<div class="match-container h-[320px]" id="matchContainer"><svg id="svg-layer"></svg>';
      html += '<div class="match-col" id="col-left">';
      for (var l = 0; l < data.leftOptions.length; l++) {
        var left = data.leftOptions[l];
        html += '<div class="match-item left-item shadow-sm" data-id="' + left.id
            + '" onclick="handleMatchClick(\'' + left.id + '\',\'left\',this)">';
        html += '<span class="font-bold text-gray-800">' + left.text
            + '</span><div class="dot-handle"></div></div>';
      }
      html += '</div>';
      html += '<div class="match-col" id="col-right">';
      for (var r = 0; r < data.rightOptions.length; r++) {
        var right = data.rightOptions[r];
        html += '<div class="match-item right-item shadow-sm" data-id="' + right.id
            + '" onclick="handleMatchClick(\'' + right.id + '\',\'right\',this)">';
        html += '<div class="dot-handle"></div><span class="text-sm font-medium text-gray-600 text-right w-full">'
            + right.text + '</span></div>';
      }
      html += '</div></div>';
    }

    html += '</div>';
    quizArea.innerHTML = html;

    if (typeof lucide !== 'undefined') lucide.createIcons();
    if (data.questionType === 'LINK') initMatchGame();
  }

  // 정답 확인 버튼 활성화/비활성화 처리
  function enableCheckBtn(enable = true) {
    if (enable) {
      checkBtn.disabled = false;
      checkBtn.className = "px-10 py-4 rounded-2xl bg-primary text-white font-bold text-lg shadow-lg shadow-primary/30 hover:brightness-110 transition-all flex items-center gap-3";
    } else {
      checkBtn.disabled = true;
      checkBtn.className = "px-10 py-4 rounded-2xl bg-gray-200 text-gray-400 font-bold text-lg transition-all flex items-center gap-2 cursor-not-allowed";
    }
  }

  // [유형2] 단어 선택 (빈칸 채우기) → 숫자로 바로 저장
  function selectWord(word, btn) {
    const blanks = document.querySelectorAll('.blank-box');
    for (let i = 0; i < blanks.length; i++) {
      if (blanks[i].classList.contains('empty')) {
        blanks[i].innerText = word;
        blanks[i].classList.remove('empty');
        btn.classList.add('hidden');

        // 선택한 단어를 optionList index로 변환해서 바로 숫자로 저장
        const mappedValue = shuffledQuiz[currentIndex].optionList.indexOf(word);
        userAnswers[currentIndex] = mappedValue; // 배열 대신 숫자

        // 모든 빈칸이 채워졌는지 확인 (MATCH는 한 번만 선택하면 채워진 것으로 간주)
        enableCheckBtn();
        return;
      }
    }
  }

  // [유형2] 단어 제거 → 숫자 초기화
  function removeWord(el) {
    const word = el.innerText;
    if (!word) return;
    el.innerText = '';
    el.classList.add('empty');

    document.querySelectorAll('.word-chip').forEach(btn => {
      if (btn.innerText === word) btn.classList.remove('hidden');
    });

    // 숫자 초기화
    userAnswers[currentIndex] = null;
    enableCheckBtn(false);
  }

  // [유형3] 드래그 앤 드롭 핸들러
  function handleDragStart(e, text) {
    draggedText = text;
  }

  function allowDrop(e) {
    e.preventDefault();
  }

  function handleDrop(e) {
    e.preventDefault();

    const zone = e.target;

    // drop-zone 아니면 무시
    if (!zone.classList.contains('drop-zone')) return;

    const prevText = zone.textContent.trim();

    // 같은 단어를 같은 곳에 다시 드롭한 경우 무시
    if (prevText === draggedText) return;

    if (prevText) {
      document.querySelectorAll('.drag-item').forEach(item => {
        if (item.textContent.trim() === prevText) {
          item.classList.remove('hidden-item');
        }
      });
    }

    zone.textContent = draggedText;
    zone.classList.add('filled');

    document.querySelectorAll('.drag-item').forEach(item => {
      if (item.textContent.trim() === draggedText) {
        item.classList.add('hidden-item');
      }
    });

    const zones = document.querySelectorAll('.drop-zone');
    userAnswers[currentIndex] = Array.from(zones).map(z => {
      const text = z.textContent.trim();
      if (!text) return null;

      const idx = shuffledQuiz[currentIndex].optionList.indexOf(text);
      return idx + 1; // DB 1-based
    });

    const filledCount = document.querySelectorAll('.drop-zone.filled').length;
    enableCheckBtn(filledCount === zones.length);
  }




  /* ---------------- LINK ---------------- */
  function initMatchGame() {
    matchState = {left: null, connections: {}};
  }

  function handleMatchClick(id, side, el) {
    if (side === 'left' && matchState.connections[id]) {
      delete matchState.connections[id];
      drawConnections();
      checkMatch();
      return;
    }
    if (side === 'right') {
      const connectedKey = Object.keys(matchState.connections).find(
          k => matchState.connections[k] === id);
      if (connectedKey) {
        delete matchState.connections[connectedKey];
        drawConnections();
        checkMatch();
        return;
      }
    }
    document.querySelectorAll('.match-item').forEach(i => i.classList.remove('selected'));
    if (side === 'left') {
      matchState.left = id;
      el.classList.add('selected');
    } else if (side === 'right' && matchState.left) {
      matchState.connections[matchState.left] = id;
      matchState.left = null;
      drawConnections();
      checkMatch();
    }
  }

  function drawConnections() {
    const svg = document.getElementById('svg-layer');
    svg.innerHTML = '';
    const container = document.getElementById('matchContainer').getBoundingClientRect();

    for (const [lid, rid] of Object.entries(matchState.connections)) {
      const lEl = document.querySelector('.left-item[data-id="' + lid + '"] .dot-handle');
      const rEl = document.querySelector('.right-item[data-id="' + rid + '"] .dot-handle');
      if (!lEl || !rEl) continue;

      const lRect = lEl.getBoundingClientRect(), rRect = rEl.getBoundingClientRect();
      const x1 = lRect.left + lRect.width / 2 - container.left;
      const y1 = lRect.top + lRect.height / 2 - container.top;
      const x2 = rRect.left + rRect.width / 2 - container.left;
      const y2 = rRect.top + rRect.height / 2 - container.top;

      const line = document.createElementNS('http://www.w3.org/2000/svg', 'line');
      line.setAttribute('x1', x1);
      line.setAttribute('y1', y1);
      line.setAttribute('x2', x2);
      line.setAttribute('y2', y2);
      line.setAttribute('class', 'connection-line');
      svg.appendChild(line);
    }
  }

  function checkMatch() {
    const req = Object.keys(shuffledQuiz[currentIndex].matchAnswer).length;
    const cur = Object.keys(matchState.connections).length;
    userAnswers[currentIndex] = matchState.connections;
    if (cur === req) enableCheckBtn(); else enableCheckBtn(false);
  }

  function handleMultipleSelect(idx, btn) {
    // 이미 선택된 버튼 초기화
    document.querySelectorAll('.choice-btn').forEach(b => {
      b.classList.remove('selected');
      const circle = b.querySelector('.check-circle');
      if (circle) {
        circle.classList.remove('bg-primary', 'border-primary');
        circle.classList.add('border-gray-300');
      }
    });

    // 현재 버튼 선택 처리
    btn.classList.add('selected');
    const checkCircle = btn.querySelector('.check-circle');
    if (checkCircle) {
      checkCircle.classList.remove('border-gray-300');
      checkCircle.classList.add('bg-primary', 'border-primary');
    }

    // 답안 저장
    userAnswers[currentIndex] = idx;

    // 체크 버튼 활성화
    const checkBtn = document.getElementById('checkBtn');
    if (checkBtn) {
      checkBtn.disabled = false;
      checkBtn.className =
          "px-10 py-4 rounded-2xl bg-primary text-white font-bold text-lg transition-all flex items-center gap-2 hover:bg-primary/90";
    }
  }

  function checkAnswer() {
    var data = shuffledQuiz[currentIndex];
    var isCorrect = false;

    //------------SELECT , MATCH 형 정답 체크---------------//
    if (data.questionType === 'SELECT' || data.questionType === 'MATCH') {
      const selected = userAnswers[currentIndex]; // 0부터 시작
      if (selected == null) return; // 선택 안 됨

      const correct = Number(data.answer); // DB 저장값 1-based
      isCorrect = (selected + 1) === correct; // 비교

    } else if (data.questionType === 'DRAG') {
      const user = userAnswers[currentIndex] || []; // 유저 선택
      const correct = (typeof data.answerList === 'string'
          ? JSON.parse(data.answerList)
          : data.answerList || []);     // 정답 배열

      // 길이 다르면 바로 false
      if (user.length !== correct.length) {
        isCorrect = false;
      } else {
        // 순서와 값 모두 일치해야 정답
        isCorrect = user.every((val, idx) => val === correct[idx]);
      }

    } else if (data.questionType === 'LINK') {
      const user = userAnswers[currentIndex] || {};   // 유저 선택
      const correct = data.matchAnswer || {}; // 정답

      // 정답과 비교
      const keys = Object.keys(correct);
      isCorrect = keys.every(k => user[k] === correct[k]);

      // 연결선 색상 변경
      document.querySelectorAll('.connection-line').forEach(line => {
        line.classList.add(isCorrect ? 'correct' : 'wrong');
      });
    }

    // --- 결과 저장 ---
    historyStatus[currentIndex] = isCorrect;

    if (isCorrect) {
      score++;
      // 정답 시 폭죽 효과
      confetti({particleCount: 150, spread: 80, origin: {y: 0.6}, colors: ['#10B981', '#34D399']});
    } else {
      wrongCount++;
    }

    // --- 탈락 조건 확인 ---
    if (wrongCount >= 4) {
      submitQuizResults(chapterId, true); // isFinal=false
      document.getElementById('failModal').classList.add('active');
      return;
    }

    // 마지막 문제면 바로 최종 제출
    if (currentIndex === shuffledQuiz.length - 1) {
      finalizeQuiz();
      return;
    }

    showFeedbackModal(isCorrect);
  }

  /* ---------------- 다음 문제 이동 ---------------- */
  function nextQuestion() {
    const modal = document.getElementById('feedbackModal');
    if (modal) modal.classList.remove('active');

    currentIndex++;
    renderProgress();

    if (currentIndex < shuffledQuiz.length) {
      renderQuestion();
    }
  }

  /* ---------------- 최종 제출 처리 ---------------- */
  function finalizeQuiz() {
    const isPass = score >= 7 ? 'Y' : 'N';
    const successModal = document.getElementById('successModal');
    const failModal = document.getElementById('failModal');

    if (isPass === 'Y') {
      // 폭죽 모달 띄우기
      document.getElementById('finalScore').innerText = score;
      document.getElementById('finalPercent').innerText = Math.round(
          (score / shuffledQuiz.length) * 100) + '%';
      successModal.classList.add('active');

      // 모달 안에 버튼 클릭 시 서버 저장 + 이동
      const roadmapBtn = document.getElementById('goToRoadmapBtn');
      if (roadmapBtn) {
        roadmapBtn.onclick = () => {
          submitQuizResults(chapterId, true);
          location.href = '${cpath}/roadMap/main.do';
        };
      }

      // 폭죽 애니메이션
      const duration = 2000;
      const end = Date.now() + duration;
      (function frame() {
        confetti({
          particleCount: 5,
          angle: 60,
          spread: 55,
          origin: {x: 0},
          colors: ['#5E45EB', '#10B981']
        });
        confetti({
          particleCount: 5,
          angle: 120,
          spread: 55,
          origin: {x: 1},
          colors: ['#5E45EB', '#10B981']
        });
        if (Date.now() < end) requestAnimationFrame(frame);
      })();

    } else {
      failModal.classList.add('active');
    }
  }

  /* ---------------- 서버 저장 ---------------- */
  function submitQuizResults(chapterId, isFinal = true) {
    const totalScore = score * 10;
    const isPass = totalScore >= 70 ? 'Y' : 'N';

    fetch('${cpath}/lesson/update-chapter', {
      method: 'POST',
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: new URLSearchParams({
        chapterId: chapterId,
        score: totalScore,
        isPass: isPass
      }).toString()
    })
    .then(res => console.log('서버 저장 완료'))
    .catch(err => console.error(err));
  }

  /* ---------------- 퀴즈 셔플 ---------------- */
  function shuffleQuiz(array) {
    for (let i = array.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [array[i], array[j]] = [array[j], array[i]];
    }
    return array;
  }

  /* ---------------- 결과 모달 ---------------- */
  function showFeedbackModal(isCorrect) {
    const modal = document.getElementById('feedbackModal');
    const icon = document.getElementById('feedbackIcon');
    const title = document.getElementById('feedbackTitle');
    const desc = document.getElementById('feedbackDesc');

    modal.classList.add('active');

    if (isCorrect) {
      icon.className = "w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-6 text-4xl shadow-inner bg-green-100 text-green-600";
      icon.innerHTML = '<i data-lucide="party-popper" class="w-10 h-10"></i>';
      title.textContent = "정답입니다!";
      desc.textContent = "훌륭해요! 다음 문제로 넘어갈 준비가 되셨나요?";
    } else {
      icon.className = "w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-6 text-4xl shadow-inner bg-red-100 text-red-600";
      icon.innerHTML = '<i data-lucide="alert-circle" class="w-10 h-10"></i>';
      title.textContent = "아쉽게 틀렸네요";
      desc.textContent = "괜찮아요, 다음 문제에서 만회해봐요!";
    }
    lucide.createIcons();
  }

  // 나가기 모달 열기/닫기
  function handleFailExit() {
    location.href = '${cpath}/roadMap/main.do';
  }

  function openExitModal() {
    document.getElementById('exitModal').classList.add('active');
  }

  function closeExitModal() {
    document.getElementById('exitModal').classList.remove('active');
  }

  // 리사이즈 시 선 잇기 다시 그리기 (반응형 대응)
  // window.addEventListener('resize', () => { if(shuffleQuiz[currentIndex].type === 'LINK') drawConnections(); });

</script>



