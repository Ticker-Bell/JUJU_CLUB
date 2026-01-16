<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 퍼스트존 아카데미02
  Date: 2026-01-12
  Time: 오후 4:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script src="https://unpkg.com/lucide@latest"></script>
<%--<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/roadMap/dropDown.css">--%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/roadMap/roadMap.css">
<link rel="stylesheet" as="style" crossorigin
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css"/>

<div class="flex flex-col w-full h-full min-h-0">
    <section class="roadmap-stage flex-1 min-h-0 relative">
        <%@ include file="dropDown.jsp" %>

        <div class="mission-fab">
            <button id="openMissionBtn" type="button" class="control-item btn-mission" aria-label="일일 미션">
                <span class="mission-dot" id="missionDot"></span>
                <img class="w-5 h-5 stroke-[2]" src="${cpath}/resources/images/roadMapIcons/target.svg" alt="미션아이콘">
            </button>
        </div>


    </section>

    <button type="button"
            class="bg-blue-500 text-white p-2 rounded"
            hx-post="${cpath}/lesson/lessonInfo"
            hx-vals='{"lessonId": "lesson_stock_01"}'
            hx-target="#main"
            hx-swap="innerHTML"
            hx-push-url="true"> 이동버튼
    </button>
</div>

<%--<div id="missionModal" class="fixed inset-0 hidden items-center justify-center z-[80] p-6" style="background: rgba(17,24,39,0.45);">--%>
<%--    <div class="w-[560px] max-w-[96vw] rounded-[18px] bg-white/90 backdrop-blur border border-gray-200 shadow-[0_30px_80px_rgba(17,24,39,0.25)] overflow-hidden">--%>
<%--        <div class="p-5 border-b border-gray-100 flex items-center justify-between">--%>
<%--            <div>--%>
<%--                <div class="text-xs font-extrabold text-gray-400 flex items-center gap-2"><span class="w-2 h-2 rounded-full bg-primary"></span> 일일 미션</div>--%>
<%--                <div class="mt-1 text-base font-extrabold text-gray-900">오늘의 미션 <span id="missionCountText" class="text-gray-400 text-sm font-extrabold">(0/5)</span></div>--%>
<%--            </div>--%>
<%--            <button id="closeMissionBtn" class="w-10 h-10 rounded-full bg-white border border-gray-200 flex items-center justify-center hover:bg-gray-50 transition"><i data-lucide="x" class="w-4 h-4"></i></button>--%>
<%--        </div>--%>
<%--        <div class="p-5">--%>
<%--            <div class="flex items-center justify-between"><div class="text-sm font-extrabold text-gray-900">진행도</div><div class="text-sm font-extrabold text-primary num-font" id="missionTopProgress">0/5</div></div>--%>
<%--            <div class="mt-3 h-2 rounded-full bg-gray-100 overflow-hidden"><div id="missionBar" class="h-full bg-primary rounded-full" style="width:0%"></div></div>--%>
<%--            <div id="missionList" class="mt-5 space-y-3"></div>--%>
<%--            <div class="mt-6 flex items-center justify-end gap-2"><button id="missionDoneBtn" class="px-4 py-2 rounded-xl bg-primary text-white font-extrabold text-sm shadow-sm hover:brightness-[1.03]">확인</button></div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<%--<script>--%>
<%--    /* Mission Logic */--%>
<%--    const missions = [ { id:"m1", text:"뉴스 3개 읽고 키워드 1줄 요약", done:false }, { id:"m2", text:"관심종목 3개 추가하기", done:false }, { id:"m3", text:"호가창 1회 확인하기", done:false }, { id:"m4", text:"모의투자 매수/매도 1회 체험", done:false }, { id:"m5", text:"오늘 학습 1단계 완료하기", done:false } ];--%>
<%--    const missionModal = document.getElementById("missionModal");--%>
<%--    const closeMissionBtn = document.getElementById("closeMissionBtn");--%>
<%--    const missionDoneBtn = document.getElementById("missionDoneBtn");--%>
<%--    const missionList = document.getElementById("missionList");--%>
<%--    const missionDot = document.getElementById("missionDot");--%>

<%--    function renderMissions(){--%>
<%--        missionList.innerHTML = "";--%>
<%--        missions.forEach(m => {--%>
<%--            const row = document.createElement("label");--%>
<%--            row.className = "flex items-start gap-3 p-3 rounded-2xl border border-gray-100 bg-white hover:bg-gray-50 transition cursor-pointer";--%>
<%--            row.innerHTML = `<input type="checkbox" class="mt-1 w-4 h-4 accent-[#5E45EB]" ${m.done ? "checked" : ""} data-id="${m.id}">--%>
<%--        <div class="flex-1"><div class="text-sm font-extrabold text-gray-900">${m.text}</div><div class="mt-1 text-[11px] font-semibold text-gray-400">완료하면 체크 표시가 반영돼요</div></div>--%>
<%--        <div class="w-8 h-8 rounded-full flex items-center justify-center ${m.done ? "bg-primary/10 border border-primary/20" : "bg-gray-100 border border-gray-200"}"><i data-lucide="${m.done ? "check" : "circle"}" class="w-4 h-4 ${m.done ? "text-primary" : "text-gray-400"}"></i></div>`;--%>
<%--            missionList.appendChild(row);--%>
<%--        });--%>
<%--        lucide.createIcons();--%>
<%--        updateMissionProgress();--%>
<%--    }--%>
<%--    function updateMissionProgress(){--%>
<%--        const doneCount = missions.filter(m => m.done).length;--%>
<%--        const total = missions.length;--%>
<%--        document.getElementById("missionCountText").textContent = `(${doneCount}/${total})`;--%>
<%--        document.getElementById("missionTopProgress").textContent = `${doneCount}/${total}`;--%>
<%--        document.getElementById("missionBar").style.width = `${Math.round((doneCount/total) * 100)}%`;--%>
<%--        missionDot.style.display = (doneCount < total) ? "block" : "none";--%>
<%--    }--%>
<%--    function openMission(){ renderMissions(); missionModal.classList.remove("hidden"); missionModal.classList.add("flex"); }--%>
<%--    function closeMission(){ missionModal.classList.add("hidden"); missionModal.classList.remove("flex"); }--%>
<%--    document.getElementById("openMissionBtn").addEventListener("click", (e)=>{ e.stopPropagation(); openMission(); });--%>
<%--    closeMissionBtn.addEventListener("click", closeMission);--%>
<%--    missionDoneBtn.addEventListener("click", closeMission);--%>
<%--    missionModal.addEventListener("click", (e) => { if(e.target === missionModal) closeMission(); });--%>
<%--    missionList.addEventListener("change", (e) => { const t = e.target; if(t && t.matches("input[type='checkbox'][data-id]")){ const target = missions.find(x => x.id === t.getAttribute("data-id")); if(target){ target.done = t.checked; renderMissions(); }} });--%>

<%--    renderOrbs();--%>
<%--    updateMissionProgress();--%>
<%--</script>--%>