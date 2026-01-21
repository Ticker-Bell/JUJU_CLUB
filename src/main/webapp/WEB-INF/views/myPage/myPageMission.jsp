<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- [수정] Tailwind 클래스 직접 적용으로 스타일 깨짐 방지 --%>
<div class="bg-white rounded-[24px] border border-slate-200 shadow-[0_4px_12px_rgba(0,0,0,0.02)] p-6 flex flex-col h-full justify-between">

  <div class="flex items-center justify-between mb-4 shrink-0">
    <h3 class="text-lg font-extrabold text-gray-900">미션 달성 현황</h3>
  </div>

  <div class="flex-1 flex flex-col justify-around py-1 gap-4">

    <%-- 1. 일일 미션 --%>
    <div class="group cursor-pointer"
         hx-get="${pageContext.request.contextPath}/roadMap/mission.do"
         hx-target="body"
         hx-swap="beforeend">

      <div class="flex justify-between text-sm font-bold mb-1.5">
                <span class="text-gray-900 flex items-center gap-1 group-hover:text-primary transition-colors">
                    일일 미션 <i data-lucide="chevron-right" class="w-4 h-4 text-gray-400 group-hover:text-primary"></i>
                </span>
        <span class="text-primary font-extrabold">
                    <fmt:formatNumber value="${missionList.size() > 0 ? (missionSuccessCount / missionList.size()) * 100 : 0}" pattern="#,##0"/>%
                </span>
      </div>

      <div class="w-full bg-slate-100 rounded-full h-3.5 overflow-hidden">
        <c:set var="dailyPercent" value="${missionList.size() > 0 ? (missionSuccessCount / missionList.size()) * 100 : 0}"/>
        <div class="bg-primary h-full rounded-full shadow-sm transition-colors duration-300 group-hover:bg-indigo-600"
             style="width: ${dailyPercent}%"></div>
      </div>
      <p class="text-xs text-gray-400 mt-1.5 truncate">클릭하여 오늘의 미션을 확인하세요.</p>
    </div>

    <%-- 2. 주간 미션 --%>
    <div class="group">
      <div class="flex justify-between text-sm font-bold mb-1.5">
                <span class="text-gray-600 flex items-center gap-1 group-hover:text-emerald-500 transition-colors">
                    주간 미션 <i data-lucide="chevron-right" class="w-4 h-4 text-gray-400 group-hover:text-emerald-500"></i>
                </span>
        <span class="text-emerald-500 font-extrabold">45%</span>
      </div>
      <div class="w-full bg-slate-100 rounded-full h-3.5 overflow-hidden">
        <div class="bg-emerald-500 h-full rounded-full shadow-sm transition-colors duration-300 group-hover:bg-emerald-600"
             style="width: 45%"></div>
      </div>
      <p class="text-xs text-gray-400 mt-1.5 truncate">이번 주 수익률 3% 달성 도전</p>
    </div>

    <%-- 3. 월간 미션 --%>
    <div class="group">
      <div class="flex justify-between text-sm font-bold mb-1.5">
                <span class="text-gray-600 flex items-center gap-1 group-hover:text-amber-500 transition-colors">
                    월간 미션 <i data-lucide="chevron-right" class="w-4 h-4 text-gray-400 group-hover:text-amber-500"></i>
                </span>
        <span class="text-amber-500 font-extrabold">20%</span>
      </div>
      <div class="w-full bg-slate-100 rounded-full h-3.5 overflow-hidden">
        <div class="bg-amber-500 h-full rounded-full shadow-sm transition-colors duration-300 group-hover:bg-amber-600"
             style="width: 20%"></div>
      </div>
      <p class="text-xs text-gray-400 mt-1.5 truncate">누적 거래액 500만원 달성하기</p>
    </div>

  </div>

  <script>
    if(window.lucide) lucide.createIcons();
  </script>
</div>