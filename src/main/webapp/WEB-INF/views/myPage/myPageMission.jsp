<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    /* ✅ 포인트(#5E45EB)랑 "완전 다른" 계열로 확실히 구분 (Teal/Orange/Pink) */
    .mypage-mission-bar{
        height: 100%;
        border-radius: 9999px;
        box-shadow: 0 1px 2px rgba(0,0,0,0.06);
        transition: filter .2s ease;
    }
    .mypage-mission-bar:hover{ filter: brightness(0.95); }

    /* Daily: Teal */
    .mypage-mission-bar.daily{ background: #14B8A6; }   /* teal-500 */
    /* Weekly: Orange */
    .mypage-mission-bar.weekly{ background: #F97316; }  /* orange-500 */
    /* Monthly: Pink */
    .mypage-mission-bar.monthly{ background: #EC4899; } /* pink-500 */
</style>

<div class="bg-white rounded-[24px] border border-slate-200 shadow-[0_4px_12px_rgba(0,0,0,0.02)] p-6 flex flex-col h-full justify-between">

    <div class="flex items-center justify-between mb-4 shrink-0">
        <h3 class="text-xl font-extrabold text-gray-900">미션 달성 현황</h3>
    </div>

    <div class="flex-1 flex flex-col justify-around py-1 gap-4">

        <%-- 1. 일일 미션 --%>
        <div class="group cursor-pointer"
             hx-get="${pageContext.request.contextPath}/roadMap/mission.do"
             hx-target="body"
             hx-swap="beforeend">

            <div class="flex justify-between text-sm font-bold mb-1.5">
                <span class="text-gray-900 flex items-center gap-1 group-hover:text-[#5E45EB] transition-colors">
                    일일 미션 <i data-lucide="chevron-right" class="w-4 h-4 text-gray-400 group-hover:text-[#5E45EB]"></i>
                </span>
                <span class="font-extrabold" style="color:#14B8A6;">
                    <fmt:formatNumber value="${missionList.size() > 0 ? (missionSuccessCount / missionList.size()) * 100 : 0}" pattern="#,##0"/>%
                </span>
            </div>

            <div class="w-full bg-slate-100 rounded-full h-3.5 overflow-hidden">
                <c:set var="dailyPercent" value="${missionList.size() > 0 ? (missionSuccessCount / missionList.size()) * 100 : 0}"/>
                <div class="mypage-mission-bar daily" style="width: ${dailyPercent}%"></div>
            </div>
            <p class="text-xs text-gray-400 mt-1.5 truncate">클릭하여 오늘의 미션을 확인하세요.</p>
        </div>

        <%-- 2. 주간 미션 --%>
        <div class="group">
            <div class="flex justify-between text-sm font-bold mb-1.5">
                <span class="text-gray-600 flex items-center gap-1 group-hover:text-[#5E45EB] transition-colors">
                    주간 미션 <i data-lucide="chevron-right" class="w-4 h-4 text-gray-400 group-hover:text-[#5E45EB]"></i>
                </span>
                <span class="font-extrabold" style="color:#F97316;">45%</span>
            </div>
            <div class="w-full bg-slate-100 rounded-full h-3.5 overflow-hidden">
                <div class="mypage-mission-bar weekly" style="width: 45%"></div>
            </div>
            <p class="text-xs text-gray-400 mt-1.5 truncate">이번 주 수익률 3% 달성 도전</p>
        </div>

        <%-- 3. 월간 미션 --%>
        <div class="group">
            <div class="flex justify-between text-sm font-bold mb-1.5">
                <span class="text-gray-600 flex items-center gap-1 group-hover:text-[#5E45EB] transition-colors">
                    월간 미션 <i data-lucide="chevron-right" class="w-4 h-4 text-gray-400 group-hover:text-[#5E45EB]"></i>
                </span>
                <span class="font-extrabold" style="color:#EC4899;">20%</span>
            </div>
            <div class="w-full bg-slate-100 rounded-full h-3.5 overflow-hidden">
                <div class="mypage-mission-bar monthly" style="width: 20%"></div>
            </div>
            <p class="text-xs text-gray-400 mt-1.5 truncate">누적 거래액 500만원 달성하기</p>
        </div>

    </div>

    <script>
        if(window.lucide) lucide.createIcons();
    </script>
</div>
