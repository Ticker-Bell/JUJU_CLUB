<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>JUJU CLUB - Education 5</title>

<script src="https://cdn.tailwindcss.com"></script>
<script src="https://unpkg.com/lucide@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>

<%--레슨 공통 css--%>
<link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lesson.css">
<%--문항 버튼, 모달 css--%>
<link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonSelect.css">

<link rel="stylesheet" as="style" crossorigin
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css"/>


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

<%--챕터명,레슨명,문제 진행바--%>
<%@ include file="/WEB-INF/views/lesson/common/lesson2.jsp" %>

<section
        class="web-card flex-1 min-h-0 flex flex-col items-center justify-center p-8 relative overflow-hidden">

    <div class="w-full max-w-5xl flex flex-col h-full relative">

        <div class="text-center mb-8 shrink-0">
                        <span class="inline-block px-3 py-1 rounded-full bg-gray-100 text-gray-500 text-xs font-extrabold mb-3">
                            Final Question
                        </span>
            <h2 class="text-2xl font-bold text-gray-900 leading-snug">
                왼쪽의 <span class="text-primary">투자 용어</span>와 오른쪽의 <span
                    class="text-blue-500">올바른 뜻</span>을<br>
                클릭하여 선으로 이어주세요.
            </h2>
        </div>

        <div class="flex-1 relative w-full flex items-center justify-center min-h-0">
            <div class="match-container" id="matchContainer">
                <svg id="svg-layer"></svg>

                <div class="match-col" id="col-left">
                </div>

                <div class="match-col" id="col-right">
                </div>
            </div>
        </div>

        <div class="shrink-0 mt-6 pt-6 border-t border-gray-100 flex justify-between items-center">
            <div class="text-xs text-gray-400 font-medium">
                💡 팁: 항목을 누른 후, 반대편의 짝을 눌러보세요.
            </div>
            <button id="checkBtn" onclick="checkAnswer()" disabled
                    class="px-6 py-3 rounded-xl bg-gray-200 text-gray-400 font-extrabold text-sm transition-all flex items-center gap-2 cursor-not-allowed">
                <span>최종 제출</span>
                <i data-lucide="check-circle-2" class="w-4 h-4"></i>
            </button>
        </div>

    </div>
</section>

<%--레슨 선택형,드래그형,매치형,라인형 결과 모달창--%>
<%@ include file="/WEB-INF/views/lesson/common/resultModal.jsp" %>

<script>
  (function () {
    lucide.createIcons();

    // Data: Harder terms
    const terms = [
      {id: 'per', text: 'PER (주가수익비율)'},
      {id: 'pbr', text: 'PBR (주가순자산비율)'},
      {id: 'roe', text: 'ROE (자기자본이익률)'},
      {id: 'cap', text: '시가총액 (Market Cap)'}
    ];

    const definitions = [
      {id: 'def-cap', matchId: 'cap', text: '발행주식수 × 현재 주가. 기업의 총 가치를 나타냄'},
      {id: 'def-roe', matchId: 'roe', text: '투입한 자본 대비 이익을 얼마나 냈는지 보여주는 지표'},
      {id: 'def-per', matchId: 'per', text: '순이익 대비 주가가 몇 배인지 나타내는 지표 (이익 기준)'},
      {id: 'def-pbr', matchId: 'pbr', text: '보유 자산 대비 주가가 몇 배인지 나타내는 지표 (자산 기준)'}
    ];

    // Shuffle definitions only (Keep terms order for readability)
    definitions.sort(() => Math.random() - 0.5);

    // State
    let selectedLeft = null;
    let connections = new Map(); // Map<leftId, rightId>

    // Render
    const leftCol = document.getElementById('col-left');
    const rightCol = document.getElementById('col-right');
    const svgLayer = document.getElementById('svg-layer');
    const container = document.getElementById('matchContainer');

    // ✅ DOM 캐싱
    const leftDomMap = new Map();
    const rightDomMap = new Map();

    // Render Left
    terms.forEach(t => {
      const el = document.createElement('div');
      el.className = 'match-item left-item';
      el.dataset.id = t.id;
      el.innerHTML = `
  <span class="font-bold text-gray-800">\${t.text}</span>
  <div class="dot-handle"></div>
`;
      el.onclick = () => handleLeftClick(t.id, el);
      leftCol.appendChild(el);
      leftDomMap.set(t.id, el);
    });

    // Render Right
    definitions.forEach(d => {
      const el = document.createElement('div');
      el.className = 'match-item right-item';
      el.dataset.id = d.id;
      el.innerHTML = `
  <div class="dot-handle"></div>
  <span class="text-sm font-medium text-gray-600 leading-snug">\${d.text}</span>
`;
      el.onclick = () => handleRightClick(d.id, el);
      rightCol.appendChild(el);
      rightDomMap.set(d.id, el);
    });

    // Logic
    function handleLeftClick(id) {
      if (connections.has(id)) {
        connections.delete(id);
        updateVisuals();
        return;
      }

      selectedLeft = selectedLeft === id ? null : id;
      updateVisuals();
    }

    function handleRightClick(id) {
      for (let [lId, rId] of connections.entries()) {
        if (rId === id) {
          connections.delete(lId);
          updateVisuals();
          return;
        }
      }

      if (selectedLeft) {
        connections.set(selectedLeft, id);
        selectedLeft = null;
        updateVisuals();
      }
    }

    function updateVisuals() {
      svgLayer.innerHTML = '';

      document.querySelectorAll('.match-item').forEach(el => {
        el.classList.remove('selected', 'matched', 'border-primary', 'bg-purple-50');
        if (el.dataset.id === selectedLeft) el.classList.add('selected');
      });

      const rect = container.getBoundingClientRect();

      connections.forEach((rId, lId) => {
        const lEl = leftDomMap.get(lId);
        const rEl = rightDomMap.get(rId);

        lEl.classList.add('border-primary', 'bg-purple-50');
        rEl.classList.add('border-primary', 'bg-purple-50');

        const lDot = lEl.querySelector('.dot-handle').getBoundingClientRect();
        const rDot = rEl.querySelector('.dot-handle').getBoundingClientRect();

        const line = document.createElementNS('http://www.w3.org/2000/svg', 'line');
        line.setAttribute('x1', lDot.left + lDot.width / 2 - rect.left);
        line.setAttribute('y1', lDot.top + lDot.height / 2 - rect.top);
        line.setAttribute('x2', rDot.left + rDot.width / 2 - rect.left);
        line.setAttribute('y2', rDot.top + rDot.height / 2 - rect.top);
        line.setAttribute('class', 'connection-line');

        line.onclick = () => {
          connections.delete(lId);
          updateVisuals();
        };

        svgLayer.appendChild(line);
      });

      const btn = document.getElementById('checkBtn');
      btn.disabled = connections.size !== 4;
      btn.className = connections.size === 4
          ? 'px-6 py-3 rounded-xl bg-primary text-white font-extrabold'
          : 'px-6 py-3 rounded-xl bg-gray-200 text-gray-400 font-extrabold';
    }

    function checkAnswer() {
      let correctCount = 0;
      connections.forEach((rId, lId) => {
        // Check logic: find the definition object where id == rId, and check if matchId == lId
        const def = definitions.find(d => d.id === rId);
        if (def && def.matchId === lId) {
          correctCount++;
        }
      });

      const modal = document.getElementById('resultModal');
      const icon = document.getElementById('modalIcon');
      const title = document.getElementById('modalTitle');
      const desc = document.getElementById('modalDesc');
      const bar = document.getElementById('modalBar');
      const btn = document.getElementById('modalActionBtn');

      modal.classList.remove('hidden');

      if (correctCount === 4) {
        // All Correct
        icon.textContent = "🎓";
        icon.className = "w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-5 text-4xl shadow-lg bg-green-100 text-green-600";
        title.textContent = "모든 과정을 수료했습니다!";
        title.className = "text-2xl font-extrabold text-green-600 mb-2";
        desc.innerHTML = `어려운 용어까지 완벽하게 이해하셨네요.<br>이제 실전 모의투자로 떠날 준비가 되셨습니다!`;
        bar.className = "h-2 w-full bg-green-500";
        btn.textContent = "학습 완료하고 로드맵 가기";

        // Make lines green
        document.querySelectorAll('.connection-line').forEach(l => l.classList.add('correct'));
        document.querySelectorAll('.match-item').forEach(el => el.classList.add('matched'));

        confetti({
          particleCount: 200,
          spread: 100,
          origin: {y: 0.6},
          colors: ['#10B981', '#34D399', '#6EE7B7']
        });

        btn.onclick = () => {
          window.location.href = 'roadmap.html';
        };

      } else {
        // Wrong
        icon.textContent = "🤔";
        icon.className = "w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-5 text-4xl shadow-lg bg-yellow-100 text-yellow-600";
        title.textContent = `${correctCount}개만 맞았습니다`;
        title.className = "text-2xl font-extrabold text-gray-700 mb-2";
        desc.innerHTML = `PER는 이익, PBR은 자산, ROE는 자본!<br>헷갈리는 용어를 다시 연결해보세요.`;
        bar.className = "h-2 w-full bg-yellow-400";
        btn.textContent = "다시 시도하기";
        btn.onclick = closeModal;
      }
    }

    function closeModal() {
      document.getElementById('resultModal').classList.add('hidden');
    }

    // Handle Resize
    window.addEventListener('resize', updateVisuals);
    window.checkAnswer = checkAnswer;
    window.closeModal = closeModal;
  })();
</script>
