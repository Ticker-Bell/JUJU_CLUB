<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>JUJU CLUB - Education 4</title>

<script src="https://cdn.tailwindcss.com"></script>
<script src="https://unpkg.com/lucide@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>

<%--레슨 공통 css--%>
<link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lesson.css">
<%--문항 버튼, 모달 css--%>
<link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonSelect.css">

<link rel="stylesheet" as="style" crossorigin
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css"/>


<%--챕터명,레슨명,문제 진행바--%>
<%@ include file="/WEB-INF/views/lesson/common/lessonCommon.jsp" %>

<section class="web-card flex-1 min-h-0 flex flex-col items-center justify-center p-8 relative">

    <div class="w-full max-w-2xl flex flex-col gap-12">
        <div class="bg-gray-50 rounded-2xl p-8 border border-gray-100 text-center shadow-inner">
        <span class="inline-block px-3 py-1 rounded-full bg-white border border-gray-200 text-primary text-xs font-extrabold mb-5 shadow-sm">
                Question 4
            </span>
            <div id="questionText" class="text-2xl leading-relaxed text-gray-900 font-bold"></div>
        </div>

        <div class="bg-gray-50 rounded-2xl p-6 border border-gray-100 flex flex-wrap justify-center gap-4 min-h-[100px]"
             id="dragSource">
        </div>
    </div>

    <div class="absolute bottom-0 left-0 w-full p-6 border-t border-gray-100 bg-white flex justify-end">
        <button id="checkBtn" onclick="checkAnswer()" disabled
                class="px-6 py-3 rounded-xl bg-gray-200 text-gray-400 font-extrabold text-sm transition-all cursor-not-allowed">
            정답 확인
        </button>
    </div>
</section>

<%--레슨 선택형,드래그형,매치형,라인형 결과 모달창--%>
<%@ include file="/WEB-INF/views/lesson/common/resultModal.jsp" %>

<script>
  updateActiveDot('${titles[3].questionId}');

  (function () {
    lucide.createIcons();

    const question = {
      questionText: "${fn:escapeXml(qst[2].questionText)}",
      optionList: [
        <c:forEach var="opt" items="${qst[2].optionList}" varStatus="st">
        "${opt}"<c:if test="${!st.last}">, </c:if>
        </c:forEach>
      ],
      answer: JSON.parse('${qst[2].answerList}') // 항상 배열 형태로 사용 가능
    };

    const dropCount = (question.questionText.match(/{{blank}}/g) || []).length;

    // 빈칸을 drop-zone으로 변환
    let renderedQuestion = question.questionText;
    for (let i = 0; i < dropCount; i++) {
      renderedQuestion = renderedQuestion.replace("{{blank}}",
          `<span class="drop-zone" data-index="${i}"></span>`);
    }
    document.getElementById('questionText').innerHTML = renderedQuestion;

    // 2️⃣ 옵션 렌더링
    const dragSource = document.getElementById('dragSource');
    const words = question.optionList.map((text, idx) => ({id: idx, text}));
    words.sort(() => Math.random() - 0.5);

    words.forEach(w => {
      const el = document.createElement('div');
      el.className = 'draggable-item';
      el.draggable = true;
      el.textContent = w.text;
      el.dataset.id = w.id;

      el.addEventListener('dragstart', handleDragStart);
      el.addEventListener('click', handleClickItem);

      dragSource.appendChild(el);
    });

    const dropZones = document.querySelectorAll('.drop-zone');
    dropZones.forEach(zone => {
      zone.addEventListener('dragover', handleDragOver);
      zone.addEventListener('drop', handleDrop);
      zone.addEventListener('click', handleClickZone);
    });

    let draggedEl = null;
    let selectedEl = null;

    function handleDragStart(e) {
      draggedEl = this;
      e.dataTransfer.setData('text/plain', this.dataset.id);
      this.classList.add('dragging');
      if (selectedEl) {
        selectedEl.classList.remove('selected');
        selectedEl = null;
      }
    }

    function handleDragOver(e) {
      e.preventDefault();
      this.classList.add('hovered');
    }

    function handleDrop(e) {
      e.preventDefault();
      this.classList.remove('hovered');
      if (draggedEl) {
        moveToZone(draggedEl, this);
        draggedEl.classList.remove('dragging');
        draggedEl = null;
      }
    }

    function handleClickItem(e) {
      if (this.parentElement.classList.contains('drop-zone')) {
        moveBackToSource(this);
        return;
      }
      if (selectedEl === this) {
        this.classList.remove('selected');
        selectedEl = null;
      } else {
        if (selectedEl) selectedEl.classList.remove('selected');
        this.classList.add('selected');
        selectedEl = this;
      }
    }

    function handleClickZone(e) {
      if (selectedEl && !this.hasChildNodes()) {
        moveToZone(selectedEl, this);
        selectedEl.classList.remove('selected');
        selectedEl = null;
      }
    }

    function moveToZone(item, zone) {
      if (zone.hasChildNodes()) {
        moveBackToSource(zone.firstChild);
      }
      zone.appendChild(item);
      zone.classList.add('filled');
      checkCompletion();
    }

    function moveBackToSource(item) {
      dragSource.appendChild(item);
      if (item.parentElement.classList.contains('drop-zone')) item.parentElement.classList.remove(
          'filled');
      checkCompletion();
    }

    document.addEventListener('dragend', () => {
      dropZones.forEach(z => z.classList.remove('hovered'));
      if (draggedEl) draggedEl.classList.remove('dragging');
      draggedEl = null;
    });

    function checkCompletion() {
      const filledCount = Array.from(dropZones).filter(z => z.hasChildNodes()).length;
      const btn = document.getElementById('checkBtn');
      if (filledCount === dropCount) {
        btn.disabled = false;
        btn.classList.remove('bg-gray-200', 'text-gray-400', 'cursor-not-allowed');
        btn.classList.add('bg-primary', 'text-white', 'shadow-lg', 'shadow-primary/30',
            'hover:brightness-105');
      } else {
        btn.disabled = true;
        btn.classList.add('bg-gray-200', 'text-gray-400', 'cursor-not-allowed');
        btn.classList.remove('bg-primary', 'text-white', 'shadow-lg', 'shadow-primary/30',
            'hover:brightness-105');
      }
    }

    function checkAnswer() {
      const userAns = Array.from(dropZones).map(z => parseInt(z.firstChild.dataset.id)+1);
      const correctAns = question.answer;
      const modal = document.getElementById('resultModal');
      const icon = document.getElementById('modalIcon');
      const title = document.getElementById('modalTitle');
      const desc = document.getElementById('modalDesc');
      const bar = document.getElementById('modalBar');
      const btn = document.getElementById('modalActionBtn');

      modal.classList.remove('hidden');

      const isCorrect = userAns.every((val, i) => val === correctAns[i]);

      if (isCorrect) {
        icon.textContent = "🎉";
        icon.className = "w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-5 text-4xl shadow-lg bg-green-100 text-green-600";
        title.textContent = "정답입니다!";
        title.className = "text-2xl font-extrabold text-green-600 mb-2";
        desc.innerHTML = "${qst[2].explanation}"
        bar.className = "h-2 w-full bg-green-500";
        btn.textContent = "다음 문제로";

        confetti({
          particleCount: 150,
          spread: 70,
          origin: {y: 0.6},
          colors: ['#5E45EB', '#10B981', '#F59E0B']
        });

        btn.onclick = function () {
          htmx.ajax('POST', '${cpath}/lesson/qst', {
            target: '#main',
            values: {
              lessonId: '${lessonId}',
              questionId: 'LV1_CH001_LS001_Q005'
            }
          });
        };

      } else {
        icon.textContent = "💪";
        icon.className = "w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-5 text-4xl shadow-lg bg-orange-100 text-orange-500";
        title.textContent = "다시 배치해보세요!";
        title.className = "text-2xl font-extrabold text-orange-500 mb-2";
        desc.innerHTML = "정답이 아니에요. 빈칸을 올바르게 배치해보세요.";
        bar.className = "h-2 w-full bg-orange-500";
        btn.textContent = "다시 시도";
        btn.onclick = closeModal;
      }
    }

    function closeModal() {
      document.getElementById('resultModal').classList.add('hidden');
    }

    window.selectOption = selectOption;
    window.checkAnswer = checkAnswer;
    window.closeModal = closeModal;
  })();
</script>
