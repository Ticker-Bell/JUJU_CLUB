<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--공통헤더--%>
<link rel="stylesheet" type="text/css" href="${cpath}/resources/css/lesson/lesson.css">
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>JUJU CLUB - Education 2</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>

    <link rel="stylesheet" as="style" crossorigin
          href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css"/>

    <style>
      /* Quiz Button Styles */
      .quiz-option {
        width: 100%;
        text-align: left;
        padding: 20px 24px;
        border-radius: 16px;
        border: 1px solid #E5E7EB;
        background-color: #FFFFFF;
        transition: all 0.2s ease;
        position: relative;
        font-weight: 600;
        color: #4B5563;
      }

      .quiz-option:hover {
        background-color: #F9FAFB;
        border-color: #D1D5DB;
      }

      .quiz-option.selected {
        background-color: #F5F3FF; /* primary light */
        border-color: #5E45EB;
        color: #5E45EB;
        font-weight: 800;
        box-shadow: 0 0 0 1px #5E45EB;
      }


      /* Modal Animation */
      .modal-bg {
        background-color: rgba(0, 0, 0, 0.4);
        backdrop-filter: blur(4px);
      }

      .modal-content {
        animation: modalUp 0.3s cubic-bezier(0.16, 1, 0.3, 1);
      }

      @keyframes modalUp {
        from {
          opacity: 0;
          transform: scale(0.95) translateY(10px);
        }
        to {
          opacity: 1;
          transform: scale(1) translateY(0);
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

<%--lfex flex-1 빼면 구조 망가짐--%>
<div class="flex flex-1 h-full pt-20 overflow-hidden relative">
    <main class="flex-1 overflow-hidden p-8 flex flex-col bg-gray-50">
        <div class="flex flex-col w-full h-full max-w-[1800px] mx-auto min-h-0">

            <%@ include file="/WEB-INF/views/lesson/common/lesson2.jsp" %>

            <section
                    class="web-card flex-1 min-h-0 flex flex-col items-center justify-center p-8 relative">

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
        </div>
    </main>
</div>

<div id="resultModal"
     class="fixed inset-0 z-[100] modal-bg hidden flex items-center justify-center p-4">
    <div class="modal-content bg-white w-full max-w-md rounded-3xl shadow-2xl overflow-hidden relative">
        <button onclick="closeModal()"
                class="absolute top-4 right-4 text-gray-300 hover:text-gray-500 transition">
            <i data-lucide="x" class="w-6 h-6"></i>
        </button>

        <div class="p-8 text-center">
            <div id="modalIcon"
                 class="w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-5 text-4xl shadow-lg transition-transform">
                🎉
            </div>

            <h3 id="modalTitle" class="text-2xl font-extrabold text-gray-900 mb-2">
                정답입니다!
            </h3>

            <p id="modalDesc" class="text-gray-600 font-medium leading-relaxed mb-6">
                주식은 회사의 자본금을 쪼갠 것으로,<br>주식을 가지면 회사의 주인이 되는 것입니다.
            </p>

            <button id="modalActionBtn"
                    class="w-full py-3.5 rounded-xl bg-primary text-white font-extrabold shadow-lg shadow-primary/30 hover:brightness-105 transition-all">
                다음 문제로
            </button>
        </div>

        <div id="modalBar" class="h-2 w-full bg-primary"></div>
    </div>
</div>

<script>
  lucide.createIcons();

  let selectedIdx = null;
  const CORRECT_IDX = ${qst[0].answer};

  function selectOption(el, idx) {
    // 기존 선택 해제
    document.querySelectorAll('.quiz-option').forEach(btn => btn.classList.remove('selected'));

    // 새로운 선택 적용
    el.classList.add('selected');
    selectedIdx = idx;

    // 버튼 활성화
    const checkBtn = document.getElementById('checkBtn');
    checkBtn.disabled = false;
    checkBtn.classList.remove('bg-gray-200', 'text-gray-400', 'cursor-not-allowed');
    checkBtn.classList.add('bg-primary', 'text-white', 'shadow-lg', 'shadow-primary/30',
        'hover:brightness-105');
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
      // 정답 처리
      icon.textContent = "🎉";
      icon.className = "w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-5 text-4xl shadow-lg bg-green-100 text-green-600";
      title.textContent = "정답입니다!";
      title.className = "text-2xl font-extrabold text-green-600 mb-2";
      desc.innerHTML = `맞아요! <span class="font-bold text-gray-900">주식은 회사의 소유권</span>을 의미합니다.<br>채권(A)이나 예금(C)과는 다른 개념이죠.`;
      bar.className = "h-2 w-full bg-green-500";
      btn.textContent = "다음 문제로";

      // 폭죽 효과
      confetti({
        particleCount: 150,
        spread: 70,
        origin: {y: 0.6},
        colors: ['#5E45EB', '#10B981', '#F59E0B']
      });

    } else {
      // 오답 처리
      icon.textContent = "💪";
      icon.className = "w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-5 text-4xl shadow-lg bg-orange-100 text-orange-500";
      title.textContent = "아쉽네요!";
      title.className = "text-2xl font-extrabold text-orange-500 mb-2";

      let feedback = "";
      if (selectedIdx === 1) feedback = "선택하신 것은 '채권'에 대한 설명이에요.";
      if (selectedIdx === 3) feedback = "선택하신 것은 '예금'에 대한 설명이에요.";
      if (selectedIdx === 4) feedback = "주식이 무조건 오르진 않아요. 위험 자산입니다.";

      desc.innerHTML = `힘내세요! 다시 한 번 생각해볼까요?<br><span class="text-sm text-gray-500 mt-1 block">${feedback}</span>`;
      bar.className = "h-2 w-full bg-orange-500";
      btn.textContent = "다시 풀기";
      btn.onclick = closeModal; // 다시 풀기 위해 모달 닫기
      return; // 여기서 함수 종료 (Next Action 설정 안함)
    }

    // 정답일 때 버튼 액션 (다음 페이지 이동 등)
    btn.onclick = function () {
      alert("다음 단계(Education 3)로 이동합니다.");
      // location.href = 'education3.html';
    };
  }

  function closeModal() {
    document.getElementById('resultModal').classList.add('hidden');
  }
</script>

</html>