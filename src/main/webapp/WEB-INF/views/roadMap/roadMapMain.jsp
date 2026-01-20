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
        <%@ include file="missionButton.jsp" %>
        <div id="roadmapScroll" class="w-full h-full overflow-y-auto scroll-smooth">
            <div class="relative w-full" style="height: 2600px;">
                <svg class="absolute inset-0 w-full h-full" viewBox="0 0 1200 2600" preserveAspectRatio="none">
                    <defs>
                        <linearGradient id="bgLayer" x1="0" y1="1" x2="0" y2="0">
                            <stop offset="0%" stop-color="#F1FAF5"/>
                            <stop offset="10%" stop-color="#E9F9F1"/>
                            <stop offset="18%" stop-color="#EAF7FF"/>
                            <stop offset="26%" stop-color="#E0ECFF"/>
                            <stop offset="36%" stop-color="#CFE2FF"/>
                            <stop offset="46%" stop-color="#B9D4FF"/>
                            <stop offset="56%" stop-color="#86B7FF"/>
                            <stop offset="64%" stop-color="#5B9BFF"/>
                            <stop offset="70%" stop-color="#3B82F6"/>
                            <stop offset="76%" stop-color="#4D6BFF"/>
                            <stop offset="82%" stop-color="#6A50FF"/>
                            <stop offset="88%" stop-color="#7C3AED"/>
                            <stop offset="92%" stop-color="#4B2FB3"/>
                            <stop offset="96%" stop-color="#2B1B6E"/>
                            <stop offset="100%" stop-color="#060A2B"/>
                        </linearGradient>
                        <filter id="softBlur" x="-30%" y="-30%" width="160%" height="160%">
                            <feGaussianBlur stdDeviation="12"/>
                        </filter>
                        <radialGradient id="cloudG" cx="50%" cy="40%" r="70%">
                            <stop offset="0%" stop-color="rgba(255,255,255,0.95)"/>
                            <stop offset="55%" stop-color="rgba(255,255,255,0.55)"/>
                            <stop offset="100%" stop-color="rgba(255,255,255,0.0)"/>
                        </radialGradient>
                        <radialGradient id="sunG" cx="35%" cy="35%" r="75%">
                            <stop offset="0%" stop-color="#FFF7ED"/>
                            <stop offset="55%" stop-color="#FDE68A"/>
                            <stop offset="100%" stop-color="#F59E0B"/>
                        </radialGradient>
                        <linearGradient id="houseRoof" x1="0" y1="0" x2="1" y2="1">
                            <stop offset="0%" stop-color="rgba(94,69,235,0.34)"/>
                            <stop offset="100%" stop-color="rgba(168,85,247,0.18)"/>
                        </linearGradient>
                        <linearGradient id="balloonG" x1="0" y1="0" x2="1" y2="1">
                            <stop offset="0%" stop-color="rgba(255,255,255,0.95)"/>
                            <stop offset="40%" stop-color="rgba(94,69,235,0.60)"/>
                            <stop offset="100%" stop-color="rgba(168,85,247,0.55)"/>
                        </linearGradient>
                        <filter id="starGlow" x="-60%" y="-60%" width="220%" height="220%">
                            <feGaussianBlur stdDeviation="2"/>
                        </filter>
                    </defs>
                    <rect x="0" y="0" width="1200" height="2600" fill="url(#bgLayer)"/>
                    <circle cx="240" cy="1900" r="460" fill="rgba(255,255,255,0.10)" filter="url(#softBlur)"/>
                    <circle cx="980" cy="1500" r="560" fill="rgba(255,255,255,0.09)" filter="url(#softBlur)"/>
                    <circle cx="760" cy="900" r="620" fill="rgba(255,255,255,0.08)" filter="url(#softBlur)"/>
                    <circle cx="720" cy="380" r="520" fill="rgba(255,255,255,0.06)" filter="url(#softBlur)"/>
                    <g opacity="0.98">
                        <path d="M0 2050 C 180 1940, 360 2080, 540 1980 C 740 1880, 980 2060, 1200 1960 L1200 2600 L0 2600 Z"
                              fill="rgba(209,250,229,0.95)"/>
                        <path d="M0 2260 C 180 2140, 320 2360, 520 2220 C 720 2080, 900 2380, 1060 2200 C 1120 2140, 1160 2160, 1200 2180 L1200 2600 L0 2600 Z"
                              fill="rgba(187,247,208,0.90)"/>
                    </g>
                    <g opacity="0.95" transform="translate(140 2140)">
                        <rect x="0" y="54" width="132" height="104" rx="22" fill="rgba(255,255,255,0.82)"/>
                        <path d="M-10 72 L66 10 L142 72 Z" fill="url(#houseRoof)"/>
                        <rect x="50" y="110" width="32" height="48" rx="12" fill="rgba(94,69,235,0.14)"/>
                    </g>
                    <g opacity="0.95">
                        <circle cx="980" cy="1200" r="74" fill="url(#sunG)"/>
                        <circle cx="980" cy="1200" r="140" fill="rgba(245,158,11,0.14)" filter="url(#softBlur)"/>
                    </g>
                    <g opacity="0.92">
                        <ellipse class="floaty" cx="280" cy="1500" rx="210" ry="86" fill="url(#cloudG)"/>
                        <ellipse class="floaty" cx="430" cy="1484" rx="150" ry="66" fill="url(#cloudG)"/>
                        <ellipse class="floaty" cx="150" cy="1478" rx="140" ry="60" fill="url(#cloudG)"/>
                    </g>
                    <g opacity="0.7" fill="none" stroke="rgba(255,255,255,0.80)" stroke-width="5"
                       stroke-linecap="round">
                        <path d="M240 1320 Q260 1302 280 1320"/>
                    </g>
                    <g class="floaty" opacity="0.98" transform="translate(820 1550)">
                        <path d="M120 0 C 40 0, 0 70, 0 140 C 0 240, 55 310, 120 330 C 185 310, 240 240, 240 140 C 240 70, 200 0, 120 0 Z"
                              fill="url(#balloonG)"/>
                        <path d="M120 0 C 90 40, 70 90, 66 140 C 60 220, 92 288, 120 330" fill="none"
                              stroke="rgba(255,255,255,0.35)" stroke-width="10" opacity="0.7"/>
                        <rect x="84" y="380" width="72" height="52" rx="12" fill="rgba(120,53,15,0.35)"/>
                    </g>
                    <g opacity="0.95">
                        <circle class="twinkle" cx="120" cy="160" r="2.2" fill="rgba(255,255,255,0.95)"/>
                        <circle class="twinkle" cx="340" cy="140" r="1.9" fill="rgba(255,255,255,0.95)"/>
                        <circle class="twinkle" cx="520" cy="240" r="2.5" fill="rgba(255,255,255,0.98)"/>
                        <circle class="twinkle" cx="820" cy="290" r="2.1" fill="rgba(255,255,255,0.96)"/>
                    </g>
                </svg>

                <div id="nodesLayer" class="absolute inset-0"></div>
                <c:forEach items="${selectLearningList}" var="lesson" varStatus="status">
                    <button type="button" class="orb completed absolute transition-transform hover:scale-110"
                            style="left: calc(51.5026% - 36px + ${status.index * 80}px); top: calc(80.8889% - 36px);"
                            onclick="event.stopPropagation(); showTip({
                                    id: '${lesson.lessonId}',
                                    title: '${lesson.lessonName}',
                                    desc: '${lesson.lessonName}', /* [추가됨] 종류와 시간 데이터 전달 */
                                    type: '${lesson.lessonType}',  time: '${lesson.lessonType}'   }, this);">
                    </button>
                </c:forEach>

                <div id="nodeTip" class="tip hidden absolute z-50 w-[320px] rounded-2xl bg-white p-4 shadow-xl border border-gray-100"></div>
                <div class="absolute left-6 bottom-6 z-10">
                    <div class="px-4 py-3 rounded-2xl bg-white/80 backdrop-blur border border-gray-200 shadow-sm">
                        <div class="text-[11px] font-extrabold text-gray-500 flex items-center gap-2">
                            발판을 클릭하면 설명이 떠요!
                        </div>
                    </div>
                </div>
            </div>
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

<div id="tooltipTemplate" style="display: none;">
    <div class="flex items-start justify-between gap-3">
        <div>
            <div id="tip-title" class="text-sm font-extrabold text-gray-900"></div>
            <div id="tip-desc" class="mt-1 text-[11px] font-semibold text-gray-500 leading-relaxed"></div>
        </div>
        <div id="tip-badge"></div>
    </div>

    <div class="mt-3 grid grid-cols-2 gap-2">
        <div class="rounded-xl border border-gray-100 bg-gray-50 p-3">
            <div class="text-[10px] font-extrabold text-gray-400">종류</div>
            <div id="tip-type" class="mt-1 text-xs font-extrabold text-gray-900"></div>
        </div>
        <div class="rounded-xl border border-gray-100 bg-gray-50 p-3">
            <div class="text-[10px] font-extrabold text-gray-400">예상 시간</div>
            <div id="tip-time" class="mt-1 text-xs font-extrabold text-gray-900"></div>
        </div>
    </div>

    <div class="mt-3 flex items-center justify-between gap-2">
        <button id="tipCloseBtn" class="px-3 py-2 rounded-xl bg-white border border-gray-200 text-gray-600 font-extrabold text-xs hover:bg-gray-50 transition">닫기</button>
        <button id="startLessonBtn" class="px-3 py-2 rounded-xl bg-primary text-white font-extrabold text-xs shadow-sm hover:brightness-[1.03] transition">시작하기</button>
    </div>
</div>

<script>
    // [설정] 유저 데이터
    const user = {
        currentLessonId: "${userLesson[0].lessonId}",
        completedLessons: new Set([
            <c:forEach items="${userLesson}" var="cid">"${cid}",</c:forEach>
        ])
    };

    // [수정 포인트 1] tip 요소 가져오기 (HTML에서 중복된 ID 하나 삭제 필수)
    const tip = document.getElementById("nodeTip");

    // [수정 포인트 2] 스크롤 영역 ID를 HTML과 일치시킴
    const scrollEl = document.getElementById("roadmapScroll");

    // 툴팁 표시 함수
    function showTip(lesson, orbEl) {
        if (!tip || !scrollEl) return;

        // 1. 템플릿 복사
        const templateHTML = document.getElementById("tooltipTemplate").innerHTML;
        tip.innerHTML = templateHTML;

        // 2. [기존] 제목, 설명 넣기
        const dbLessonId = `\${lesson.id}`;
        const lessonNum = dbLessonId.substring(12);
        tip.querySelector("#tip-title").innerText = "[Lesson"+ lessonNum + "]";
        tip.querySelector("#tip-desc").innerText = `\${lesson.title}`;

        // 3. [추가됨] 종류, 예상 시간 넣기
        // 데이터가 없으면 '정보 없음' 등으로 처리
        lesson.type = (lesson.type === "THEORY"? "이론" : "실습");

        tip.querySelector("#tip-type").innerText = lesson.type || "기본 학습";
        tip.querySelector("#tip-time").innerText = "1~5분";

        // 4. [기존] 뱃지 로직
        const isCompleted = user.completedLessons.has(lesson.id);
        const isCurrent = (lesson.id === user.currentLessonId);
        const badgeContainer = tip.querySelector("#tip-badge");

        if (isCompleted) {
            badgeContainer.innerHTML = `<span class="px-2 py-0.5 rounded-full bg-primary/10 text-primary text-[10px] font-extrabold border border-primary/20">완료</span>`;
        } else if (isCurrent) {
            badgeContainer.innerHTML = `<span class="px-2 py-0.5 rounded-full bg-primary/10 text-primary text-[10px] font-extrabold border border-primary/20">진행중</span>`;
        } else {
            badgeContainer.innerHTML = `<span class="px-2 py-0.5 rounded-full bg-white/60 text-gray-600 text-[10px] font-extrabold border border-gray-200">잠김</span>`;
        }

        // 위치 계산
        const containerRect = scrollEl.getBoundingClientRect();
        const orbRect = orbEl.getBoundingClientRect();

        const nx = (orbRect.left - containerRect.left) + scrollEl.scrollLeft;
        const ny = (orbRect.top - containerRect.top) + scrollEl.scrollTop;

        let left = nx + 90;
        let top = ny - 10;

        const contentWidth = scrollEl.scrollWidth;
        const contentHeight = scrollEl.scrollHeight;

        if (left + 320 > contentWidth - 24) left = nx - 338;
        if (left < 18) left = 18;
        if (top < 18) top = 18;
        if (top + 220 > contentHeight - 18) top = contentHeight - 220;

        tip.style.left = left + "px";
        tip.style.top = top + "px";

        tip.classList.remove("hidden");

        document.getElementById("tipCloseBtn").onclick = hideTip;
        document.getElementById("startLessonBtn").onclick = function() {
            alert(`"\${lesson.title}" 시작!`);
        };
    }

    function hideTip() {
        if(tip) tip.classList.add("hidden");
    }

    document.addEventListener("click", (e) => {
        if (tip && !tip.classList.contains("hidden") && !tip.contains(e.target)) {
            hideTip();
        }
    });

    if (scrollEl) {
        scrollEl.addEventListener("scroll", () => {
            if (tip && !tip.classList.contains("hidden")) hideTip();
        }, { passive: true });
    }
</script>