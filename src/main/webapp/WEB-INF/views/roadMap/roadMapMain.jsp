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
        pointer-events: auto !important;
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

    /* 챕터 이동 버튼 전용 스타일 */
    /* 이동 버튼 전용 스타일 (.control-item 기반 수정) */
    .btn-nav {
        /* 1. 크기 및 모양 (원형) */
        width: 52px;
        height: 52px;
        border-radius: 50%; /* 99px 대신 50%로 완벽한 원형 유지 */
        padding: 0; /* 텍스트용 패딩 제거 */

        /* 2. 배경 및 테두리 (드롭다운과 동일) */
        background: rgba(255, 255, 255, 0.9);
        border: 1px solid rgba(229, 231, 235, 1); /* 기본은 은은한 회색 */
        box-shadow: 0 12px 24px rgba(17, 24, 39, 0.08);
        backdrop-filter: blur(8px);

        /* 3. 아이콘 중앙 정렬 (핵심) */
        display: flex;
        align-items: center;
        justify-content: center;

        /* 4. 기타 설정 */
        cursor: pointer;
        user-select: none;
        transition: all .2s ease;
        z-index: 50;
    }

    /* Hover 효과: 살짝 떠오르면서 테두리가 보라색으로 변경 (드롭다운 active 느낌 차용) */
    .btn-nav:hover {
        background: #fff;
        transform: translateY(-2px);
        box-shadow: 0 16px 36px rgba(17, 24, 39, 0.12);
        border-color: #5E45EB; /* 호버 시 강조색 */
    }

    /* Click(Active) 효과: 눌리는 느낌 */
    .btn-nav:active {
        transform: translateY(0);
        box-shadow: 0 0 0 3px rgba(94, 69, 235, 0.1);
    }

    /* 내부 SVG 아이콘 색상 관리 */
    .btn-nav svg path {
        fill: #666666; /* 기본 회색 */
        transition: fill 0.2s ease;
    }

    .btn-nav:hover svg path {
        fill: #5E45EB; /* 호버 시 아이콘도 보라색으로 변경 */
    }
</style>

<div class="flex flex-col w-full h-full min-h-0 bg-gray-50 relative p-0 m-0 border-0">

    <div class="absolute top-4 left-4 z-40 gap-2">
        <%@ include file="dropDown.jsp" %>
    </div>
    <div class="absolute top-4 right-4 z-40 gap-2">
        <%@ include file="missionButton.jsp" %>
    </div>
    <div class="absolute bottom-20 left-4 z-40 gap-2">
        <div>
            <button id="preBtn" type="button" class="btn-nav">
                <svg xmlns="http://www.w3.org/2000/svg" width=24 height="24" viewBox="0 0 30 30" fill="none">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M14.4508 29.3724C13.7186 30.2092 12.5314 30.2092 11.7992 29.3724L0.549175 16.5152C-0.183059 15.6784 -0.183059 14.3216 0.549176 13.4848L11.7992 0.627629C12.5314 -0.20921 13.7186 -0.20921 14.4508 0.627629C15.1831 1.46447 15.1831 2.82125 14.4508 3.65809L6.40165 12.8571H28.125C29.1605 12.8571 30 13.8165 30 15C30 16.1835 29.1605 17.1429 28.125 17.1429L6.40165 17.1429L14.4508 26.3419C15.1831 27.1788 15.1831 28.5355 14.4508 29.3724Z" fill="#666666"/>
                </svg>
            </button>
        </div>
    </div>
    <div class="absolute bottom-20 right-4 z-40 gap-2">
        <div>
            <button id="nextBtn" type="button" class="btn-nav">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 30 30" fill="none">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M15.5492 0.627626C16.2814 -0.209211 17.4686 -0.209211 18.2008 0.627626L29.4508 13.4848C30.1831 14.3216 30.1831 15.6784 29.4508 16.5152L18.2008 29.3724C17.4686 30.2092 16.2814 30.2092 15.5492 29.3724C14.8169 28.5355 14.8169 27.1788 15.5492 26.3419L23.5983 17.1429H1.875C0.839468 17.1429 0 16.1835 0 15C0 13.8165 0.839468 12.8571 1.875 12.8571L23.5983 12.8571L15.5492 3.65808C14.8169 2.82125 14.8169 1.46446 15.5492 0.627626Z" fill="#666666"/>
                </svg>
            </button>
        </div>
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

            <div id="nodesLayer" class="absolute inset-0 pointer-events-none p-0 m-0" style="z-index: 20;">
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
<div>

    <script>
        { // 블록 스코프 시작

            /* --- 1. 데이터 구성 (JSTL -> JS) --- */
            const nodesData = [];
            const chapterMap = {};
            let globalChapterSeq = 0;

            const CPATH = '${pageContext.request.contextPath}';

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
                chapterName: '${item.chapterName}',
                levelId: '${item.levelId}',
                levelName: '${item.levelName}'
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
                levelId: '${item.levelId}',
                levelName: '${item.levelName}',
                testReward: '${item.testReward}',
                testPay: '${item.testPay}',
                status: '${item.chapterPass}'
            });
            </c:if>
            </c:forEach>

            // 전역 변수로 nodePositions 관리
            let nodePositions = [];

            /* =========================================
               [공통 함수] 드롭다운 제어 및 데이터 페칭
               ========================================= */
            function setupOptionItem(item, button, list, textSpan) {
                item.onclick = (e) => {
                    e.stopPropagation();
                    textSpan.textContent = item.textContent;
                    const value = item.getAttribute('data-value');

                    button.dataset.value = value;

                    const siblings = list.querySelectorAll('.optionItem');
                    siblings.forEach(i => i.classList.remove('selected'));
                    item.classList.add('selected');

                    button.classList.remove('active');
                    list.classList.remove('show');

                    if (button.id === 'levelSelect') {
                        const chapterBtn = document.getElementById('chapterSelect');
                        chapterBtn.querySelector('.btn-text').textContent = "챕터 선택";
                        chapterBtn.dataset.value = "";
                        fetchChapters(value);
                    }
                };
            }

            function fetchChapters(levelId) {
                const chapterBtn = document.getElementById('chapterSelect');
                const chapterSpan = chapterBtn.querySelector('.btn-text');
                const chapterListUl = document.getElementById('chapterListContainer');

                return fetch(CPATH + '/roadMapApi/chapters?levelId=' + levelId)
                    .then(response => { if (!response.ok) throw new Error('Network response'); return response.json(); })
                    .then(data => {
                        chapterListUl.innerHTML = '';
                        if (!data || data.length === 0) {
                            chapterSpan.textContent = "챕터 없음";
                            return;
                        }
                        data.forEach(chapter => {
                            const li = document.createElement('li');
                            li.className = 'optionItem';
                            li.textContent = chapter.chapterName;
                            li.setAttribute('data-value', chapter.chapterId);
                            setupOptionItem(li, chapterBtn, chapterListUl, chapterSpan);
                            chapterListUl.appendChild(li);
                        });
                    })
                    .catch(error => { console.error('Error:', error); chapterSpan.textContent = "로드 실패"; });
            }

            function highlightOption(listContainer, value) {
                if (!listContainer) return;
                const items = listContainer.querySelectorAll('.optionItem');
                items.forEach(item => {
                    if (item.getAttribute('data-value') === value) {
                        item.classList.add('selected');
                    } else {
                        item.classList.remove('selected');
                    }
                });
            }


            /* --- 2. 툴팁 함수 --- */
            window.openTooltip = (pos, el) => {
                const tooltip = document.getElementById('tooltip');
                const inner = document.getElementById('innerContent');
                if (!tooltip || !inner) return;

                const data = pos.data;
                const isChapter = data.type === 'chapter';

                let title;
                try {
                    const rawId = isChapter ? data.chapterId : data.id;
                    const num = rawId.replace(/[^0-9]/g, '').slice(-3);
                    title = (isChapter ? "Chapter " : "Lesson ") + parseInt(num || "0");
                } catch (e) { title = isChapter ? "Chapter Test" : "Lesson"; }

                document.getElementById('tip-title').innerText = title;
                document.getElementById('tip-desc').innerText = isChapter
                    ? '챕터 테스트를 통과하면 다음 챕터로 갈 수 있어요. \n도전하고 보상금을 받으세요!!'
                    : (data.lessonName || "레슨 설명이 없습니다.");

                const status = data.status || 'locked';
                const badge = document.getElementById('tip-badge');
                badge.innerHTML = status === 'completed'
                    ? '<span class="px-2 py-1 rounded-lg bg-indigo-50 text-indigo-600 text-[10px] font-extrabold border border-indigo-100">완료</span>'
                    : (status === 'current' ? '<span class="px-2 py-1 rounded-lg bg-orange-50 text-orange-600 text-[10px] font-extrabold border border-orange-100">진행중</span>' : '');

                const infoDiv = document.getElementById('tip-info');
                if (isChapter) {
                    infoDiv.innerHTML = '<div class="rounded-xl border border-gray-100 bg-gray-50 p-3"><div class="text-[10px] font-extrabold text-gray-400">보상금</div><div class="mt-1 text-xs font-extrabold text-gray-900">' + (data.testReward || 0) + '원</div></div>' +
                        '<div class="rounded-xl border border-gray-100 bg-gray-50 p-3"><div class="text-[10px] font-extrabold text-gray-400">응시료</div><div class="mt-1 text-xs font-extrabold text-gray-900">' + (data.testPay || 0) + '원</div></div>';
                } else {
                    infoDiv.innerHTML = '<div class="rounded-xl border border-gray-100 bg-gray-50 p-3"><div class="text-[10px] font-extrabold text-gray-400">종류</div><div class="mt-1 text-xs font-extrabold text-gray-900">' + (data.lessonType === 'THEORY' ? '이론' : '실습') + '</div></div>' +
                        '<div class="rounded-xl border border-gray-100 bg-gray-50 p-3"><div class="text-[10px] font-extrabold text-gray-400">예상 시간</div><div class="mt-1 text-xs font-extrabold text-gray-900">1~5분</div></div>';
                }

                let startBtn = document.getElementById('startBtn');
                const newBtn = startBtn.cloneNode(true);
                startBtn.parentNode.replaceChild(newBtn, startBtn);

                newBtn.innerText = status === 'completed' ? "다시하기" : (isChapter ? "시험 응시하기" : "시작하기");
                newBtn.setAttribute('hx-post', CPATH + '/lesson/lessonInfo');
                newBtn.setAttribute('hx-target', '#main');
                newBtn.setAttribute('hx-vals', JSON.stringify({targetId: data.id}));
                htmx.process(newBtn);

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

            /* --- [수정됨] 3. 로드맵 그리기 (초기화 플래그 파라미터 추가) --- */
            // isFirstLoad: true면 현재 진행 위치로 강제 스크롤, false(resize 등)면 위치 유지
            const initRoadmap = (isFirstLoad = false) => {
                const inner = document.getElementById('innerContent');
                const nodesLayer = document.getElementById('nodesLayer');
                const scrollContainer = document.getElementById('roadmapScroll');
                if (!inner || !nodesLayer || !scrollContainer) return;

                const vw = window.innerWidth - 220;
                const vh = window.innerHeight - 80;
                const NODES_PER_CHAPTER = 6;
                const maxChapterIdx = nodesData.length > 0 ? nodesData[nodesData.length-1].chapterIdx : 0;
                const TOTAL_CHAPTERS = maxChapterIdx + 1;

                inner.style.width = (TOTAL_CHAPTERS * vw) + "px";

                nodesLayer.innerHTML = '';
                nodePositions = [];

                nodesData.forEach((node, i) => {
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

                nodePositions.forEach(pos => {
                    const el = document.createElement('div');
                    const data = pos.data;
                    const isChapter = data.type === 'chapter';
                    const status = data.status || 'locked';

                    el.className = 'orb ' + status;
                    if (isChapter) { el.style.width = '80px'; el.style.height = '80px'; }

                    if (isChapter) {
                        if (status === 'completed') el.innerHTML = '<i data-lucide="award" class="w-9 h-9 text-indigo-600"></i>';
                        else if (status === 'current') el.innerHTML = '<i data-lucide="award" class="w-9 h-9 text-white"></i>';
                        else el.innerHTML = '<i data-lucide="lock" class="w-8 h-8 text-gray-400"></i>';
                    } else {
                        if (status === 'completed') el.innerHTML = '<i data-lucide="check" class="w-8 h-8 stroke-[3]"></i>';
                        else if (status === 'current') el.innerHTML = '<i data-lucide="play" class="w-8 h-8 fill-white ml-1"></i>';
                        else el.innerHTML = '<span class="text-xl font-bold font-mono text-gray-300">' + (data.inChapterIdx + 1) + '</span>';
                    }

                    el.style.left = (pos.x - (isChapter ? 40 : 36)) + "px";
                    el.style.top = (pos.y - (isChapter ? 40 : 36)) + "px";

                    const label = document.createElement('div');
                    const labelText = isChapter ? data.chapterName : data.lessonName;
                    label.className = 'absolute -bottom-8 left-1/2 -translate-x-1/2 whitespace-nowrap text-xs font-extrabold tracking-wide ' + (status === 'locked' ? 'text-gray-300' : 'text-gray-600');
                    label.innerText = labelText;

                    if(pos.y > (vh/2)) {
                        label.className = label.className.replace('-bottom-8', '-top-8');
                    }
                    el.appendChild(label);

                    el.onclick = (e) => {
                        e.stopPropagation();
                        if (status !== 'locked') window.openTooltip(pos, el);
                        else alert("이전 단계를 먼저 완료해주세요!");
                    };
                    nodesLayer.appendChild(el);
                });

                drawContinuousPath();
                if (window.lucide) window.lucide.createIcons();

                // [핵심 수정] 초기 로딩일 때만 현재 위치로 스크롤 & 드롭다운 동기화
                if(isFirstLoad) {
                    const currentNode = nodePositions.find(p => p.data.status === 'current');

                    // 만약 'current'가 없으면(다 깼거나 오류) 가장 마지막 완료된 곳이라도 찾음
                    // const targetNode = currentNode || nodePositions[nodePositions.length - 1];

                    if (currentNode) {
                        const screenCenter = (window.innerWidth - 220) / 2;
                        let targetScroll = currentNode.x - screenCenter;
                        if (targetScroll < 0) targetScroll = 0;

                        // 약간의 지연을 주어 렌더링 후 스크롤 보장
                        setTimeout(() => {
                            scrollContainer.scrollTo({ left: targetScroll, behavior: 'auto' }); // auto로 즉시 이동

                            // [추가] 들어오자마자 드롭다운도 현재 진행 챕터로 세팅
                            // initChapterNavigation 내부의 updateDropdownUI를 호출하기 위해
                            // 여기서 직접 유사한 로직을 수행하거나, 전역 함수로 분리할 수 있음.
                            // 여기서는 간단하게 이벤트 발생 트리거를 활용하거나, 아래 동기화 로직 사용
                            syncDropdownWithNode(currentNode.data);

                        }, 50);
                    }
                }
            };

            // 초기 로딩 시 드롭다운 동기화용 헬퍼 함수
            function syncDropdownWithNode(nodeData) {
                const levelBtn = document.getElementById('levelSelect');
                if (levelBtn) {
                    const levelSpan = levelBtn.querySelector('.btn-text');
                    if (levelSpan) levelSpan.textContent = nodeData.levelName;
                    levelBtn.dataset.value = nodeData.levelId;
                }

                const chapterBtn = document.getElementById('chapterSelect');
                if (chapterBtn) {
                    const chapterSpan = chapterBtn.querySelector('.btn-text');
                    if (chapterSpan) chapterSpan.textContent = nodeData.chapterName;
                    chapterBtn.dataset.value = nodeData.chapterId;

                    // 필요하다면 여기서 fetchChapters 호출하여 목록 미리 로드 가능
                    // fetchChapters(nodeData.levelId);
                }
            }

            const drawContinuousPath = () => {
                const pathBorder = document.getElementById('roadBorder');
                const pathMain = document.getElementById('roadPath');
                const pathDashed = document.getElementById('roadDashed');
                const pathActive = document.getElementById('roadActive');

                if (!pathMain || nodePositions.length === 0) return;

                let d = "M " + nodePositions[0].x + " " + nodePositions[0].y;
                for (let i = 0; i < nodePositions.length - 1; i++) {
                    const curr = nodePositions[i];
                    const next = nodePositions[i + 1];
                    const dist = next.x - curr.x;
                    const cp1 = { x: curr.x + (dist * 0.5), y: curr.y };
                    const cp2 = { x: next.x - (dist * 0.5), y: next.y };
                    d += " C " + cp1.x + " " + cp1.y + ", " + cp2.x + " " + cp2.y + ", " + next.x + " " + next.y;
                }

                if(pathBorder) pathBorder.setAttribute('d', d);
                if(pathMain) pathMain.setAttribute('d', d);
                if(pathDashed) pathDashed.setAttribute('d', d);

                if (pathActive) {
                    const currentPosIdx = nodePositions.findIndex(p => p.data.status === 'current');
                    if (currentPosIdx <= 0) {
                        pathActive.setAttribute('d', '');
                    } else {
                        let activeD = "M " + nodePositions[0].x + " " + nodePositions[0].y;
                        for (let i = 0; i < currentPosIdx; i++) {
                            const curr = nodePositions[i];
                            const next = nodePositions[i + 1];
                            const dist = next.x - curr.x;
                            const cp1 = { x: curr.x + (dist * 0.5), y: curr.y };
                            const cp2 = { x: next.x - (dist * 0.5), y: next.y };
                            activeD += " C " + cp1.x + " " + cp1.y + ", " + cp2.x + " " + cp2.y + ", " + next.x + " " + next.y;
                        }
                        pathActive.setAttribute('d', activeD);
                    }
                }
            };

            /* --- 4. 드롭다운 초기화 --- */
            function initRoadMapDropdowns() {
                const wrappers = document.querySelectorAll('.select-wrapper');

                wrappers.forEach(wrapper => {
                    const button = wrapper.querySelector('button.control-item');
                    const list = wrapper.querySelector('.optionList');
                    const items = list.querySelectorAll('.optionItem');
                    const textSpan = button.querySelector('.btn-text');

                    button.onclick = (e) => {
                        e.stopPropagation();
                        closeAllDropdowns(button);
                        button.classList.toggle('active');
                        list.classList.toggle('show');
                    };

                    items.forEach(item => {
                        setupOptionItem(item, button, list, textSpan);
                    });
                });

                // 이동 버튼 (드롭다운 내의 이동버튼이 있다면)
                const moveBtn = document.getElementById('moveBtn');
                if (moveBtn) {
                    moveBtn.onclick = () => {
                        const chapterBtn = document.getElementById('chapterSelect');
                        const selectedChId = chapterBtn.dataset.value;

                        if (!selectedChId) { alert("이동할 챕터를 선택해주세요."); return; }

                        const targetNode = nodesData.find(n => n.chapterId === selectedChId);
                        if (targetNode) {
                            const vw = window.innerWidth - 220;
                            const targetX = targetNode.chapterIdx * vw;
                            const scrollContainer = document.getElementById('roadmapScroll');
                            scrollContainer.scrollTo({ left: targetX, behavior: 'smooth' });
                        } else {
                            alert("해당 챕터를 찾을 수 없습니다.");
                        }
                    };
                }

                document.removeEventListener('click', closeAllDropdowns);
                document.addEventListener('click', closeAllDropdowns);

                function closeAllDropdowns(e) {
                    const target = e ? e.target : null;
                    document.querySelectorAll('.select-wrapper').forEach(wrapper => {
                        const btn = wrapper.querySelector('button.control-item');
                        const list = wrapper.querySelector('.optionList');
                        if (btn && btn !== target && !btn.contains(target)) {
                            btn.classList.remove('active');
                            list.classList.remove('show');
                        }
                    });
                }
            }

            /* --- 5. 챕터 이동 버튼 로직 --- */
            function initChapterNavigation() {
                const preBtn = document.getElementById('preBtn');
                const nextBtn = document.getElementById('nextBtn');
                const scrollContainer = document.getElementById('roadmapScroll');

                if (!preBtn || !nextBtn || !scrollContainer) return;

                const maxChapterIdx = nodesData.length > 0 ? nodesData[nodesData.length - 1].chapterIdx : 0;

                const updateDropdownUI = (targetChapterIdx) => {
                    const targetNode = nodesData.find(n => n.chapterIdx === targetChapterIdx);
                    if (targetNode) {
                        const levelBtn = document.getElementById('levelSelect');
                        if (levelBtn) {
                            const levelSpan = levelBtn.querySelector('.btn-text');
                            if (levelSpan) levelSpan.textContent = targetNode.levelName;
                            const oldLevelId = levelBtn.dataset.value;
                            const newLevelId = targetNode.levelId;
                            levelBtn.dataset.value = newLevelId;

                            const levelList = levelBtn.nextElementSibling;
                            highlightOption(levelList, newLevelId);

                            const chapterBtn = document.getElementById('chapterSelect');
                            if (chapterBtn) {
                                const chapterSpan = chapterBtn.querySelector('.btn-text');
                                if (chapterSpan) chapterSpan.textContent = targetNode.chapterName;
                                chapterBtn.dataset.value = targetNode.chapterId;

                                const chapterListUl = document.getElementById('chapterListContainer');
                                if (oldLevelId !== newLevelId) {
                                    fetchChapters(newLevelId).then(() => {
                                        highlightOption(chapterListUl, targetNode.chapterId);
                                    });
                                } else {
                                    highlightOption(chapterListUl, targetNode.chapterId);
                                }
                            }
                        }
                    }
                };

                const updateButtons = () => {
                    const vw = window.innerWidth - 220;
                    const currentScroll = scrollContainer.scrollLeft;
                    const currentChapter = Math.round(currentScroll / vw);

                    if (currentChapter <= 0) preBtn.style.display = 'none';
                    else preBtn.style.display = 'block';

                    if (currentChapter >= maxChapterIdx) nextBtn.style.display = 'none';
                    else nextBtn.style.display = 'block';
                };

                updateButtons();
                scrollContainer.addEventListener('scroll', updateButtons);
                window.addEventListener('resize', updateButtons);

                preBtn.onclick = () => {
                    const vw = window.innerWidth - 220;
                    const currentScroll = scrollContainer.scrollLeft;
                    const currentChapter = Math.round(currentScroll / vw);
                    if (currentChapter > 0) {
                        const targetIdx = currentChapter - 1;
                        const targetX = targetIdx * vw;
                        scrollContainer.scrollTo({ left: targetX, behavior: 'smooth' });
                        updateDropdownUI(targetIdx);
                    }
                };

                nextBtn.onclick = () => {
                    const vw = window.innerWidth - 220;
                    const currentScroll = scrollContainer.scrollLeft;
                    const currentChapter = Math.round(currentScroll / vw);
                    if (currentChapter < maxChapterIdx) {
                        const targetIdx = currentChapter + 1;
                        const targetX = targetIdx * vw;
                        scrollContainer.scrollTo({ left: targetX, behavior: 'smooth' });
                        updateDropdownUI(targetIdx);
                    }
                };
            }

            /* --- 6. 실행 및 리스너 --- */
            document.addEventListener('click', function (e) {
                const tooltip = document.getElementById('tooltip');
                if (!tooltip) return;
                if (e.target.closest('#tipCloseBtn')) tooltip.classList.remove('visible');
            });

            // 리사이즈 시에는 위치만 다시 계산 (스크롤 이동 X)
            window.addEventListener('resize', () => initRoadmap(false));

            // 초기 실행: 처음 로딩이므로 true 전달
            initRoadmap(true);
            initRoadMapDropdowns();
            initChapterNavigation();

            document.body.addEventListener('htmx:afterSettle', function (evt) {
                if (document.getElementById('roadmapScroll')) {
                    // HTMX로 다시 로드되었을 때도 강제 스크롤 적용
                    initRoadmap(true);
                    initRoadMapDropdowns();
                    initChapterNavigation();
                }
            });
        }
    </script>