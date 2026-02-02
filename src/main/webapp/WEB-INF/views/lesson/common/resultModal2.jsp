<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%-- ✅ pageEncoding="UTF-8" 추가로 한글 깨짐 방지 --%>
<%-- 버튼 취소, 확인있는 재사용 가능한 모달 창입니다 ㅎㅎ --%>
<div id="resultModal" class="fixed inset-0 z-[100] modal-bg hidden flex items-center justify-center p-4">
  <div class="modal-content bg-white w-full max-w-md rounded-3xl shadow-2xl overflow-hidden relative">
    <button onclick="closeModal()" class="absolute top-4 right-4 text-gray-300 hover:text-gray-500 transition">
      <i data-lucide="x" class="w-6 h-6"></i>
    </button>

    <div class="p-8 text-center">
      <div id="modalIcon" class="w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-5 text-4xl shadow-lg transition-transform"></div>

      <h3 id="modalTitle" class="text-2xl font-extrabold text-gray-900 mb-2"></h3>
      <p id="modalDesc" class="text-gray-600 font-medium leading-relaxed mb-6"></p>

      <div class="flex gap-3">
        <button id="modalCancelBtn" class="hidden flex-1 py-3.5 rounded-xl bg-gray-100 text-gray-500 font-bold hover:bg-gray-200 transition-all whitespace-nowrap">
          취소
        </button>
        <button id="modalActionBtn" class="flex-1 w-full py-3.5 rounded-xl bg-primary text-white font-extrabold shadow-lg shadow-primary/30 hover:brightness-105 transition-all whitespace-nowrap">
          확인
        </button>
      </div>
    </div>

    <div id="modalBar" class="h-2 w-full bg-primary"></div>
  </div>
</div>