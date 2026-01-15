<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="form-survey" class="auth-form items-start justify-start p-2 md:p-4 overflow-y-auto max-h-[80vh]" style="justify-content: flex-start;">
  <div class="w-full">
    <div class="text-center mb-10 space-y-2">
      <h2 class="text-2xl md:text-3xl font-black tracking-tight text-gray-900">맞춤 로드맵 설정</h2>
      <p class="text-gray-500 text-sm md:text-base">투자의 첫 걸음, 당신에게 꼭 맞는 단계를 찾아드릴게요.</p>
    </div>

    <form id="level-test-form" class="space-y-8 pb-8">
      <div id="question-container" class="space-y-8 text-left"></div>

      <div class="pt-4 flex justify-center">
        <button id="btn-submit-survey" type="button"
                class="w-full px-8 py-4 bg-primary text-white text-lg font-bold rounded-2xl hover:bg-primary/90 transition-all shadow-lg shadow-primary/30 transform hover:-translate-y-1">
          설정 완료하고 시작하기
        </button>
      </div>
    </form>
  </div>
</div>