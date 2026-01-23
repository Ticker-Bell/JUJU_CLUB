<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>JUJU CLUB - Education 3</title>

<script src="https://cdn.tailwindcss.com"></script>
<script src="https://unpkg.com/lucide@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>

<%--레슨 공통 css--%>
<link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lesson.css">
<%--문항 버튼, 모달 css--%>
<link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lessonSelect.css">

<link rel="stylesheet" as="style" crossorigin
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css"/>

<style>

  /* Quiz Specific Styles */
  .blank-box {
    display: inline-block;
    min-width: 100px;
    padding: 0 8px;
    border-bottom: 3px solid #E5E7EB;
    color: #5E45EB;
    font-weight: 800;
    text-align: center;
    transition: all 0.2s ease;
  }

  .blank-box.filled {
    border-bottom-color: #5E45EB;
    background-color: rgba(94, 69, 235, 0.05);
    border-radius: 4px;
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

<%--챕터명,레슨명,문제 진행바--%>
<%@ include file="/WEB-INF/views/lesson/common/lessonCommon.jsp" %>

<section class="web-card flex-1 min-h-0 flex flex-col items-center justify-center p-8 relative">
    <div class="w-full max-w-2xl flex flex-col gap-10">
        <div class="bg-gray-50 rounded-2xl p-8 border border-gray-100 text-center shadow-inner">
                        <span class="inline-block px-3 py-1 rounded-full bg-white border border-gray-200 text-primary text-xs font-extrabold mb-5 shadow-sm">
                            Question 3
                        </span>
            <h2 id="questionText"
                class="text-2xl md:text-[26px] font-bold text-gray-800 leading-relaxed word-keep-all">
            </h2>
        </div>

        <div class="grid grid-cols-2 gap-4 w-full">
            <c:forEach var="opt" items="${qst[1].optionList}" varStatus="st">
                <button class="quiz-option"
                        onclick="selectOption(this, ${st.index + 1}, '${opt}')">
                        ${st.index + 1}. ${opt}
                </button>
            </c:forEach>
        </div>
    </div>

    <div class="absolute bottom-0 left-0 w-full p-6 border-t border-gray-100 bg-white flex justify-end">
        <button id="checkBtn" onclick="checkAnswer()" disabled
                class="px-6 py-3 rounded-xl bg-gray-200 text-gray-400 font-extrabold text-sm transition-all flex items-center gap-2 cursor-not-allowed">
            <span>정답 확인</span>
            <i data-lucide="arrow-right" class="w-4 h-4"></i>
        </button>
    </div>

</section>

<%--레슨 선택형,드래그형,매치형,라인형 결과 모달창--%>
<%@ include file="/WEB-INF/views/lesson/common/resultModal.jsp" %>


<script>
  updateActiveDot('${titles[2].questionId}');

  const rawQuestion = `${qst[1].questionText}`;
  const renderedQuestion = rawQuestion.replace(
      '{{blank}}',
      '<span id="targetBlank" class="blank-box">______</span>'
  );

  document.getElementById('questionText').innerHTML = renderedQuestion;

  (function () {
    lucide.createIcons();

    let selectedIdx = null;
    const CORRECT_IDX =  ${qst[1].answer};
    const EXPLANATION = `${fn:escapeXml(qst[1].explanation)}`;

    function selectOption(el, idx, text) {
      document.querySelectorAll('.quiz-option')
      .forEach(btn => btn.classList.remove('selected'));

      el.classList.add('selected');
      selectedIdx = idx;

      const blank = document.getElementById('targetBlank');
      blank.textContent = text;
      blank.classList.add('filled');

      const checkBtn = document.getElementById('checkBtn');
      checkBtn.disabled = false;
      checkBtn.classList.remove('bg-gray-200', 'text-gray-400', 'cursor-not-allowed');
      checkBtn.classList.add('bg-primary', 'text-white');
    }

    function checkAnswer() {
      const modal = document.getElementById('resultModal');
      const icon = document.getElementById('modalIcon');
      const title = document.getElementById('modalTitle');
      const desc = document.getElementById('modalDesc');
      const bar = document.getElementById('modalBar');
      const btn = document.getElementById('modalActionBtn');

      modal.classList.remove('hidden');

      if (selectedIdx === CORRECT_IDX) {
        // Correct
        icon.textContent = "⚖️";
        icon.className = "w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-5 text-4xl shadow-lg bg-indigo-100 text-indigo-600";
        title.textContent = "정답입니다!";
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
      } else {
        // Wrong
        icon.textContent = "🧐";
        icon.className = "w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-5 text-4xl shadow-lg bg-gray-100 text-gray-500";
        title.textContent = "다시 생각해볼까요?";
        title.className = "text-2xl font-extrabold text-gray-600 mb-2";

        let feedback = "";
        if (selectedIdx === 1) feedback = "만유인력은 뉴턴의 사과와 관련이 있죠! 🍎";
        if (selectedIdx === 3) feedback = "상대성 이론은 아인슈타인의 물리 이론이에요. ⚛️";
        if (selectedIdx === 4) feedback = "복리는 '이자'와 관련된 개념이에요. 💰";

        desc.innerHTML = `<span class="block mb-2 font-bold text-primary">오답 힌트</span>${feedback}<br>시장에서 물건 가격이 정해지는 원리를 떠올려보세요.`;
        bar.className = "h-2 w-full bg-gray-400";
        btn.textContent = "다시 풀기";
        btn.onclick = closeModal;
        return;
      }

      btn.onclick = function () {
        htmx.ajax('POST', '${cpath}/lesson/qst', {
          target: '#main',
          values: {
            lessonId: '${lessonId}',
            questionId: 'LV1_CH001_LS001_Q004'
          }
        });
      };
    }

    function closeModal() {
      document.getElementById('resultModal').classList.add('hidden');
    }

    // 👉 htmx에서 쓰는 함수는 window에 명시적으로 노출
    window.selectOption = selectOption;
    window.checkAnswer = checkAnswer;
    window.closeModal = closeModal;
  })();
</script>

