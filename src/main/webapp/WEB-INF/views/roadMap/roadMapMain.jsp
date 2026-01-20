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
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://unpkg.com/htmx.org@1.9.10"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/roadMap/roadMap.css">
<link rel="stylesheet" as="style" crossorigin
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css"/>

<style>
    /* 기본 폰트 설정 */
    /*body { font-family: 'Pretendard', sans-serif; }*/

    /* Scroll Snap 및 컨테이너 설정 */
    .snap-container {
        scroll-snap-type: x mandatory;
        overflow-x: auto;
        overflow-y: hidden;
        -ms-overflow-style: none; /* IE/Edge */
        scrollbar-width: none; /* Firefox */
    }

    .snap-container::-webkit-scrollbar {
        display: none; /* Chrome/Safari */
    }

    /* SVG Styles */
    #roadBorder {
        fill: none;
        stroke: #312E81;
        stroke-width: 100px;
        stroke-linecap: round;
        stroke-linejoin: round;
        opacity: 0.1;
    }

    #roadPath {
        fill: none;
        stroke: #4F46E5;
        stroke-width: 6px;
        stroke-linecap: round;
        stroke-linejoin: round;
    }

    #roadDashed {
        fill: none;
        stroke: rgba(255, 255, 255, 0.4);
        stroke-width: 2px;
        stroke-dasharray: 10 15;
        stroke-linecap: round;
        pointer-events: none;
    }

    #roadPathActive {
        fill: none;
        stroke: #818CF8;
        stroke-width: 6px;
        stroke-linecap: round;
        stroke-linejoin: round;
        filter: drop-shadow(0 0 8px rgba(129, 140, 248, 0.8));
        transition: d 0.8s ease-in-out;
    }

    /* Orb (노드) 스타일 */
    .orb {
        position: absolute;
        width: 72px;
        height: 72px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        background: #fff;
        border: 4px solid #E0E7FF;
        z-index: 30;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        transition: transform .18s ease, box-shadow .18s ease;
        user-select: none;
        cursor: pointer;
    }

    .orb:hover {
        transform: scale(1.15) translateY(-5px);
        box-shadow: 0 15px 35px rgba(79, 70, 229, 0.3);
    }

    /* 상태별 스타일 */
    .orb.completed {
        border-color: #4F46E5;
        background: #fff;
        color: #4F46E5;
    }

    .orb.current {
        border-color: #4F46E5;
        background: #4F46E5;
        color: #fff;
        box-shadow: 0 0 0 8px rgba(79, 70, 229, 0.25);
        animation: pulse 2s infinite;
    }

    .orb.locked {
        background: #F3F4F6;
        border-color: #E5E7EB;
        color: #9CA3AF;
        cursor: not-allowed;
        opacity: 0.9;
    }

    @keyframes pulse {
        0% {
            box-shadow: 0 0 0 0 rgba(79, 70, 229, 0.6);
        }
        70% {
            box-shadow: 0 0 0 14px rgba(79, 70, 229, 0);
        }
        100% {
            box-shadow: 0 0 0 0 rgba(79, 70, 229, 0);
        }
    }

    /* 툴팁 스타일 */
    .tip {
        position: absolute;
        z-index: 50;
        width: 300px;
        background: white;
        border-radius: 1rem;
        padding: 1.25rem;
        box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        border: 1px solid #F3F4F6;
        opacity: 0;
        visibility: hidden;
        transition: opacity 0.2s, visibility 0.2s;
        pointer-events: none;
    }
    .tip::before,
    .tip::after {
        display: none !important;
        content: none !important;
        border: none !important;
        background: none !important;
    }

    .tip.visible {
        opacity: 1;
        visibility: visible;
        pointer-events: auto;
    }
</style>

<div class="flex flex-col w-full h-full min-h-0 bg-gray-50 relative">

    <div class="absolute top-4 left-4 z-40 gap-2">
        <%@ include file="dropDown.jsp" %>
    </div>
    <div class="absolute top-4 right-4 z-40 gap-2">
        <%@ include file="missionButton.jsp" %>
    </div>

    <div id="roadmapScroll"
         class="w-full h-full overflow-x-auto overflow-y-hidden snap-container scroll-smooth relative">
        <div id="innerContent" class="h-full relative">

            <svg id="roadmapSvg" class="absolute top-0 left-0 w-full h-full pointer-events-none" style="z-index: 10;">
                <path id="roadBorder" d=""/>
                <path id="roadPath" d=""/>
                <path id="roadDashed" d=""/>
                <path id="roadPathActive" d=""/>
            </svg>

            <div id="nodesLayer" class="absolute top-0 left-0 w-full h-full" style="z-index: 20;">
            </div>

            <div id="tooltip" class="tip">
                <div class="flex items-start justify-between gap-3">
                    <div>
                        <div id="tip-title" class="text-sm font-extrabold text-gray-900"></div>
                        <div id="tip-desc" class="mt-1 text-[11px] font-semibold text-gray-500 leading-relaxed"></div>
                    </div>
                    <div id="tip-badge"></div>
                </div>

                <div id="tip-info" class="mt-3 grid grid-cols-2 gap-2"></div>

                <div class="mt-4 pt-4 border-t border-gray-100 flex items-center justify-between gap-2">
                    <button id="tipCloseBtn"
                            class="px-3 py-2 rounded-xl bg-white border border-gray-200 text-gray-600 font-extrabold text-xs hover:bg-gray-50 transition">
                        닫기
                    </button>
                    <button id="startBtn"
                            class="flex-1 bg-indigo-600 text-white font-bold py-2.5 rounded-xl hover:bg-indigo-700 transition shadow-lg shadow-indigo-200 text-sm">
                        시작하기
                    </button>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    { // 블록 스코프 시작 (HTMX 재호출 시 const 중복 에러 방지)

        /* --- 1. 데이터 구성 (JSTL -> JS) --- */
        const nodesData = [];
        const chapterMap = {};
        let globalChapterSeq = 0;

        <c:forEach items="${allLearningList}" var="item" varStatus="status">
        var chId = '${item.chapterId}';
        if (chapterMap[chId] === undefined) {
            chapterMap[chId] = globalChapterSeq++;
        }
        var currentChapterIdx = chapterMap[chId];

        <c:if test="${not empty item.lessonId}">
        nodesData.push({
            type: 'lesson',
            id: '${item.lessonId}',
            chapterIdx: currentChapterIdx,
            inChapterIdx: nodesData.filter(n => n.chapterIdx === currentChapterIdx).length,
            lessonName: '${item.lessonName}',
            lessonType: '${item.lessonType}',
            status: '${item.lessonStatus}',
            chapterId: '${item.chapterId}',
            chapterName: '${item.chapterName}'
        });
        </c:if>

        <c:if test="${status.index % 5 == 4}">
        nodesData.push({
            type: 'chapter',
            id: '${item.chapterId}',
            chapterIdx: currentChapterIdx,
            inChapterIdx: 5,
            chapterId: '${item.chapterId}',
            chapterName: '${item.chapterName}',
            testReward: '${item.testReward}',
            testPay: '${item.testPay}',
            status: '${item.chapterPass}'
        });
        </c:if>
        </c:forEach>

        /* --- 2. 로드맵 로직 함수 정의 --- */
        const initRoadmap = () => {
            const inner = document.getElementById('innerContent');
            const nodesLayer = document.getElementById('nodesLayer');
            if (!inner || !nodesLayer) return;

            const vw = window.innerWidth - 220;
            const vh = window.innerHeight - 80;
            const NODES_PER_CHAPTER = 6;
            const totalChapters = Math.ceil(nodesData.length / NODES_PER_CHAPTER);

            inner.style.width = `\${Math.max(1, totalChapters) * vw}px`;
            nodesLayer.innerHTML = '';
            const nodePositions = [];

            // 1) 위치 계산
            nodesData.forEach((node) => {
                const marginX = vw * 0.1;
                const availableW = vw - (marginX * 2);
                const stepX = availableW / (NODES_PER_CHAPTER - 1);
                const x = (node.chapterIdx * vw) + marginX + (node.inChapterIdx * stepX);
                const progress = node.inChapterIdx / (NODES_PER_CHAPTER - 1);
                const amplitude = vh * 0.3;
                const centerY = vh / 2;
                const y = centerY + (Math.sin(progress * 2 * Math.PI) * -amplitude);

                nodePositions.push({x, y, data: node});
            });

            // 2) 노드 그리기
            nodePositions.forEach(pos => {
                const el = document.createElement('div');
                const data = pos.data;
                const isChapter = data.type === 'chapter';
                const status = data.status || 'locked';

                el.className = `orb \${status}`;
                if (isChapter) {
                    el.style.width = '80px';
                    el.style.height = '80px';
                }

                if (isChapter) {
                    if (status === 'completed') el.innerHTML = '<i data-lucide="award" class="w-9 h-9 text-indigo-600"></i>';
                    else if (status === 'current') el.innerHTML = '<i data-lucide="award" class="w-9 h-9 text-white"></i>';
                    else el.innerHTML = '<i data-lucide="lock" class="w-8 h-8 text-gray-400"></i>';
                } else {
                    if (status === 'completed') el.innerHTML = '<i data-lucide="check" class="w-8 h-8 stroke-[3]"></i>';
                    else if (status === 'current') el.innerHTML = '<i data-lucide="play" class="w-8 h-8 fill-white ml-1"></i>';
                    else el.innerHTML = `<span class="text-xl font-bold font-mono text-gray-300">\${data.inChapterIdx + 1}</span>`;
                }

                el.style.left = `\${pos.x - (isChapter ? 40 : 36)}px`;
                el.style.top = `\${pos.y - (isChapter ? 40 : 36)}px`;

                // 클릭 이벤트 연결
                el.onclick = (e) => {
                    e.stopPropagation();
                    if (status !== 'locked') openTooltip(pos, el);
                    else alert("이전 단계를 먼저 완료해주세요!");
                };
                nodesLayer.appendChild(el);
            });

            drawContinuousPath(nodePositions);
            if (window.lucide) window.lucide.createIcons();
        };

        const drawContinuousPath = (nodePositions) => {
            const pathBorder = document.getElementById('roadBorder');
            const pathMain = document.getElementById('roadPath');
            const pathDashed = document.getElementById('roadDashed');
            if (!pathMain || nodePositions.length === 0) return;

            let d = `M \${nodePositions[0].x} \${nodePositions[0].y}`;
            for (let i = 0; i < nodePositions.length - 1; i++) {
                const curr = nodePositions[i];
                const next = nodePositions[i + 1];
                const cp1 = {x: curr.x + ((next.x - curr.x) * 0.5), y: curr.y};
                const cp2 = {x: next.x - ((next.x - curr.x) * 0.5), y: next.y};
                d += ` C \${cp1.x} \${cp1.y}, \${cp2.x} \${cp2.y}, \${next.x} \${next.y}`;
            }
            pathBorder.setAttribute('d', d);
            pathMain.setAttribute('d', d);
            pathDashed.setAttribute('d', d);
        };

        /* --- 3. 툴팁 로직 --- */
        const openTooltip = (pos, el) => {
            const tooltip = document.getElementById('tooltip');
            const inner = document.getElementById('innerContent');
            if (!tooltip || !inner) return;

            const data = pos.data;
            const isChapter = data.type === 'chapter';

            // 제목 및 숫자 추출
            let title;
            try {
                const num = (isChapter ? data.chapterId : data.id).replace(/[^0-9]/g, '').slice(-3);
                title = (isChapter ? "Chapter " : "Lesson ") + parseInt(num || "0");
            } catch(e) { title = isChapter ? "Chapter Test" : "Lesson"; }

            document.getElementById('tip-title').innerText = title;
            document.getElementById('tip-desc').innerText = isChapter
                ? '챕터 테스트를 통과하면 다음 챕터로 갈 수 있어요. \n도전하고 보상금을 받으세요!!'
                : (data.lessonName || "레슨 설명이 없습니다.");

            // 배지 및 정보 영역 설정
            const status = data.status || 'locked';
            const badge = document.getElementById('tip-badge');
            badge.innerHTML = status === 'completed'
                ? '<span class="px-2 py-1 rounded-lg bg-indigo-50 text-indigo-600 text-[10px] font-extrabold border border-indigo-100">완료</span>'
                : (status === 'current' ? '<span class="px-2 py-1 rounded-lg bg-orange-50 text-orange-600 text-[10px] font-extrabold border border-orange-100">진행중</span>' : '');

            const infoDiv = document.getElementById('tip-info');
            if (isChapter) {
                infoDiv.innerHTML = `<div class="rounded-xl border border-gray-100 bg-gray-50 p-3"><div class="text-[10px] font-extrabold text-gray-400">보상금</div><div class="mt-1 text-xs font-extrabold text-gray-900">\${data.testReward || 0}원</div></div>
                                 <div class="rounded-xl border border-gray-100 bg-gray-50 p-3"><div class="text-[10px] font-extrabold text-gray-400">응시료</div><div class="mt-1 text-xs font-extrabold text-gray-900">\${data.testPay || 0}원</div></div>`;
            } else {
                infoDiv.innerHTML = `<div class="rounded-xl border border-gray-100 bg-gray-50 p-3"><div class="text-[10px] font-extrabold text-gray-400">종류</div><div class="mt-1 text-xs font-extrabold text-gray-900">\${data.lessonType === 'THEORY' ? '이론' : '실습'}</div></div>
                                 <div class="rounded-xl border border-gray-100 bg-gray-50 p-3"><div class="text-[10px] font-extrabold text-gray-400">예상 시간</div><div class="mt-1 text-xs font-extrabold text-gray-900">1~5분</div></div>`;
            }

            // 버튼 재생성 및 HTMX 설정
            let startBtn = document.getElementById('startBtn');
            const newBtn = startBtn.cloneNode(true);
            startBtn.parentNode.replaceChild(newBtn, startBtn);
            startBtn = newBtn;

            startBtn.innerText = status === 'completed' ? "다시하기" : (isChapter ? "시험 응시하기" : "시작하기");
            startBtn.setAttribute('hx-post', '${cpath}/lesson/lessonInfo');
            startBtn.setAttribute('hx-target', '#main');
            startBtn.setAttribute('hx-vals', JSON.stringify({ targetId: data.id }));
            htmx.process(startBtn);

            // 위치 보정
            const TIP_WIDTH = 300;
            let left = pos.x - 150;
            let top = pos.y + 70;
            if (left < 10) left = 10;
            if (left + TIP_WIDTH > inner.offsetWidth) left = inner.offsetWidth - TIP_WIDTH - 10;
            if (top + 250 > inner.offsetHeight) top = pos.y - 280;

            tooltip.style.left = left + "px";
            tooltip.style.top = top + "px";
            tooltip.classList.add('visible');
        };

        /* --- 4. 이벤트 위임 (HTMX 대응) --- */
        document.addEventListener('click', function(e) {
            const tooltip = document.getElementById('tooltip');
            if (!tooltip) return;

            // 닫기 버튼 클릭 (closest 사용하여 아이콘 클릭 대응)
            if (e.target.closest('#tipCloseBtn')) {
                tooltip.classList.remove('visible');
            }

            // 바탕 클릭 시 닫기
            // if (e.target.id === 'roadmapScroll' || e.target.id === 'innerContent') {
            //     tooltip.classList.remove('visible');
            // }
        });

        window.addEventListener('resize', initRoadmap);

        // 초기 실행
        initRoadmap();

        // HTMX 페이지 전환 대응
        document.body.addEventListener('htmx:afterSettle', function(evt) {
            if (document.getElementById('roadmapScroll')) {
                initRoadmap();
            }
        });
    }
</script>