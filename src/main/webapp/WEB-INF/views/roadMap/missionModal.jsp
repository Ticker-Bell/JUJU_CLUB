<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: 퍼스트존 아카데미02
  Date: 2026-01-16
  Time: 오후 4:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div id="missionModal" class="fixed inset-0 flex items-center justify-center z-[80] p-6"
     style="background: rgba(17,24,39,0.45);">
    <div class="w-[560px] max-w-[96vw] rounded-[18px] bg-white/90 backdrop-blur border border-gray-200 shadow-[0_30px_80px_rgba(17,24,39,0.25)]">
        <div class="p-5 border-b border-gray-100 flex items-center justify-between">
            <div>
                <div class="text-xs font-extrabold text-gray-400 flex items-center gap-2"><span
                        class="w-2 h-2 rounded-full bg-primary"></span> 일일 미션
                </div>
                <div class="mt-1 text-base font-extrabold text-gray-900">오늘의 미션 <span id="missionCountText"
                                                                                      class="text-gray-400 text-sm font-extrabold">(${successCount}/4)</span>
                </div>
            </div>
            <button id="closeMissionBtn"
                    class="w-10 h-10 rounded-full bg-white border border-gray-200 flex items-center justify-center hover:bg-gray-50 transition"
                    onclick="document.getElementById('missionModal').remove()">
                <img class="w-5 h-5 object-contain" src="${cpath}/resources/images/roadMapIcons/close.svg" alt="닫기아이콘">
            </button>
        </div>
        <div class="p-5">
            <div class="flex items-center justify-between">
                <div class="text-sm font-extrabold text-gray-900">진행도</div>
                <%-- id 유지 --%>
                <div class="text-sm font-extrabold text-primary num-font" id="missionTopProgress">
                    ${successCount}/4
                </div>
            </div>
            <div class="mt-3 h-2 rounded-full bg-primary/20 overflow-hidden">
                <%-- 초기 width는 0%로 두고 JS로 채웁니다. 트랜지션 효과 추가 --%>
                <div id="missionBar" class="h-full bg-primary rounded-full transition-all duration-500 ease-out"
                     style="width: 0%; min-width: 0.5rem;"></div>
            </div>

            <div id="missionList" class="mt-5 space-y-3">
                <c:forEach items="${mission}" var="m"> <label
                        class="flex items-center gap-3 p-3 rounded-2xl border border-gray-100 bg-white hover:bg-gray-50 transition cursor-pointer">
                    <div class="flex items-center gap-3 w-full">

                            <%-- 완료 상태 --%>
                        <c:if test="${m.isSuccess == 'Y'}">
                            <input type="hidden" name="completedOne" value="1">
                            <div class="w-8 h-8 rounded-full flex items-center justify-center bg-primary/10 border border-primary/20 flex-shrink-0">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                     stroke-linejoin="round" data-lucide="check" class="text-primary">
                                    <path d="M20 6 9 17l-5-5"></path>
                                </svg>
                            </div>
                        </c:if>

                            <%-- 미완료 상태 --%>
                        <c:if test="${m.isSuccess == 'N'}">
                            <div class="w-8 h-8 rounded-full flex-shrink-0 flex items-center justify-center bg-gray-100 border border-gray-200">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                     fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                     stroke-linejoin="round" data-lucide="circle"
                                     class="lucide lucide-circle w-4 h-4 text-gray-400">
                                    <circle cx="12" cy="12" r="10"></circle>
                                </svg>
                            </div>
                        </c:if>

                        <div class="flex-1">
                            <div class="text-sm font-extrabold text-gray-900 line-clamp-1">${m.content}</div>
                        </div>
                        <div class="flex-1">
                            <div class="flex items-center gap-1 flex-shrink-0">
                                <img class="w-5 h-5 object-contain"
                                     src="${cpath}/resources/images/roadMapIcons/money1.png" alt="돈아이콘">
                                <div class="text-sm font-extrabold text-gray-900"><fmt:formatNumber value="${m.reward}" type="number" /></div>
                            </div>
                        </div>
                        <div class="text-sm font-extrabold text-gray-500 flex-shrink-0">
                                ${m.progress} / ${m.count}
                        </div>
                    </div>
                </label>
                </c:forEach>
            </div>
        </div>
    </div>
</div>


<script>
    // 애니메이션 효과 0.1초 딜레이
    setTimeout(function() {

        // JSP 변수 값 가져오기
        const totalMissions = ${mission.size()};
        const completedCount = ${successCount};

        // console.log("HTMX 모달 로드됨 - 전체:", totalMissions, "완료:", completedCount);

        // 퍼센트 계산
        let percent = 0;
        if (totalMissions > 0) {
            percent = (completedCount / totalMissions) * 100;
        }

        // 바(Bar) 길이 업데이트
        const barElement = document.getElementById('missionBar');
        if (barElement) { barElement.style.width = percent + "%"; }

    }, 100);
</script>
