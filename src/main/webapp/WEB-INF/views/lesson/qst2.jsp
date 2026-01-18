<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>JUJU CLUB - Education 2</title>

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

<section class="web-card flex-1 min-h-0 flex flex-col items-center justify-center p-8 relative">

    <div class="w-full max-w-3xl flex flex-col gap-8">
        <div class="text-center">
        <span class="inline-block px-3 py-1 rounded-full bg-gray-100 text-gray-500 text-xs font-extrabold mb-4">
            Question 2
        </span>
            <h2 class="text-2xl md:text-3xl font-extrabold text-gray-900 leading-tight">
                ${qst[0].questionText}
            </h2>
        </div>

        <div class="grid grid-cols-1 gap-3 w-full" id="quizOptions">
            <c:forEach var="opt" items="${qst[0].optionList}" varStatus="status">
                <button class="quiz-option"
                        onclick="selectOption(this, ${status.index + 1})">
                <span class="mr-2 text-gray-400 font-extrabold">
                    ${fn:substring("ABCDEFGHIJKLMNOPQRSTUVWXYZ", status.index, status.index + 1)}.
                </span>
                        ${opt}
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
  (function () {
    lucide.createIcons();

    let selectedIdx = null;
    const CORRECT_IDX = ${qst[0].answer};
    const EXPLANATION = `${fn:escapeXml(qst[0].explanation)}`;

    function selectOption(el, idx) {
      document.querySelectorAll('.quiz-option')
      .forEach(btn => btn.classList.remove('selected'));

      el.classList.add('selected');
      selectedIdx = idx;

      const checkBtn = document.getElementById('checkBtn');
      checkBtn.disabled = false;
      checkBtn.classList.remove(
          'bg-gray-200', 'text-gray-400', 'cursor-not-allowed'
      );
      checkBtn.classList.add(
          'bg-primary', 'text-white', 'shadow-lg',
          'shadow-primary/30', 'hover:brightness-105'
      );
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
        icon.textContent = "🎉";
        icon.className =
            "w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-5 text-4xl shadow-lg bg-green-100 text-green-600";
        title.textContent = "정답입니다!";
        title.className = "text-2xl font-extrabold text-green-600 mb-2";
        desc.innerHTML = EXPLANATION;
        bar.className = "h-2 w-full bg-green-500";
        btn.textContent = "다음 문제로";

        confetti({
          particleCount: 150,
          spread: 70,
          origin: {y: 0.6},
          colors: ['#5E45EB', '#10B981', '#F59E0B']
        });

      } else {
        icon.textContent = "💪";
        icon.className =
            "w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-5 text-4xl shadow-lg bg-orange-100 text-orange-500";
        title.textContent = "아쉽네요!";
        title.className = "text-2xl font-extrabold text-orange-500 mb-2";

        let feedback = "";
        if (selectedIdx === 1) feedback = "선택하신 것은 '채권'에 대한 설명이에요.";
        if (selectedIdx === 3) feedback = "선택하신 것은 '예금'에 대한 설명이에요.";
        if (selectedIdx === 4) feedback = "주식이 무조건 오르진 않아요. 위험 자산입니다.";

        desc.innerHTML = `힘내세요! 다시 한 번 생각해볼까요?<br>
        <span class="text-sm text-gray-500 mt-1 block">${feedback}</span>`;
        bar.className = "h-2 w-full bg-orange-500";
        btn.textContent = "다시 풀기";
        btn.onclick = closeModal;
        return;
      }

      btn.onclick = function () {
        htmx.ajax('POST', '${cpath}/lesson/qst', {
          target: '#main',
          values: {
            lessonId: 'lesson_stock_01',
            questionId: 'Q003'
          }
        });
      };
    }

    function closeModal() {
      document.getElementById('resultModal').classList.add('hidden');
    }

    // 🔥 htmx inline onclick을 위해 필요한 함수만 전역 노출
    window.selectOption = selectOption;
    window.checkAnswer = checkAnswer;
    window.closeModal = closeModal;
  })();
</script>
