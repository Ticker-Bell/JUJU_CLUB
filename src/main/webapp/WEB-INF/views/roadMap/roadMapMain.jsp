<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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


<div class="flex flex-col -m-8 w-[calc(100%+4rem)] h-[calc(100%+4rem)] min-h-0 bg-gray-50 relative p-0 border-0">

    <div class="absolute top-4 left-4 z-40 gap-2">
        <%@ include file="dropDown.jsp" %>
    </div>
    <div class="absolute top-4 right-4 z-40">
        <%@ include file="missionButton.jsp" %>
    </div>
    <div class="absolute bottom-10 left-4 z-50">
        <div class="nav-btn-locaton-left">
            <button id="preBtn" type="button" class="nav-btn" aria-label="이전 챕터">
                <img src="${cpath}/resources/images/roadMapIcons/left-Icon.svg" alt="왼쪽아이콘">
            </button>
        </div>
    </div>

    <div class="absolute bottom-10 right-4 z-50">
        <div class="nav-btn-locaton-right">
            <button id="nextBtn" type="button" class="nav-btn" aria-label="다음 챕터">
                <img src="${cpath}/resources/images/roadMapIcons/right-Icon.svg" alt="오른쪽아이콘">
            </button>
        </div>
    </div>

    <div id="roadmapScroll"
         class="w-full h-full overflow-x-auto overflow-y-hidden snap-container scroll-smooth relative">
        <div id="innerContent" class="h-full relative">

            <div id="space-bg" class="absolute inset-0 overflow-hidden pointer-events-none"
                 style="background:#0b0820;">

                <!-- 🌙 Big Dome -->
                <div class="absolute bottom-[-40%] left-1/2 -translate-x-1/2
              w-[140%] h-[140%] rounded-full"
                     style="background:
         radial-gradient(circle at 50% 30%,
           #7c5cff 0%,
           #4b3bd6 35%,
           #2a1e78 60%,
           transparent 70%);">
                </div>

                <!-- 🌌 Inner Glow -->
                <div class="absolute bottom-[-30%] left-1/2 -translate-x-1/2
              w-[90%] h-[90%] rounded-full blur-2xl"
                     style="background:
         radial-gradient(circle,
           #9f7bff 0%,
           #5b4bdb 45%,
           transparent 70%);">
                </div>

                <!-- ⭐ Soft Stars -->
                <div class="absolute inset-0"
                     style="
        background-image:
          radial-gradient(#fff6c9 2px, transparent 3px),
          radial-gradient(#fff6c9 1.5px, transparent 3px);
        background-size: 120px 120px, 80px 80px;
        background-position: 0 0, 40px 60px;
        opacity: 0.6;
       ">
                </div>
            </div>



            <svg id="roadmapSvg" class="absolute top-0 left-0 w-full h-full pointer-events-none" style="z-index: 10;">
                <path id="roadBorder" d=""/>
                <path id="roadPath" d=""/>
                <path id="roadDashed" d=""/>
                <path id="roadPathActive" d=""/>
            </svg>

            <div id="nodesLayer" class="absolute inset-0 pointer-events-none p-0 m-0" style="z-index: 20;">
            </div>

            <%@ include file="toolTip.jsp" %>

        </div>
    </div>
</div>

<script>
    {
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
            id: '${item.lessonId}',
            chapterIdx: currentChapterIdx,
            inChapterIdx: nodesData.filter(n => n.chapterIdx === currentChapterIdx).length,
            lessonName: '${item.lessonName}',
            lessonDesc: '${item.lessonDesc}',
            type: '${item.lessonType}', // THEORY, PRACTICE, TEST
            status: '${item.status}',
            chapterId: '${item.chapterId}',
            chapterName: '${item.chapterName}',
            testReward: '${item.testReward}',
            testPay: '${item.testPay}',
            levelId: '${item.levelId}',
            levelName: '${item.levelName}'
        });
        </c:if>
        </c:forEach>

        console.log("로드된 노드 개수:", nodesData.length); // 0개면 Controller 확인 필요

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
                .then(response => {
                    if (!response.ok) throw new Error('Network response');
                    return response.json();
                })
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
                .catch(error => {
                    console.error('Error:', error);
                    chapterSpan.textContent = "로드 실패";
                });
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
            const isChapter = data.type === 'TEST';

            let title;
            try {
                const rawId = isChapter ? data.chapterId : data.id;
                const num = rawId.replace(/[^0-9]/g, '').slice(-3);

                title = (isChapter ? "Chapter " : "Lesson ") + parseInt(num || "0");
            } catch (e) {
                title = isChapter ? "Chapter Test" : "Lesson";
            }

            document.getElementById('tip-chapter').innerText = title;
            document.getElementById('tip-title').innerText = isChapter ? data.chapterName : data.lessonName;
            document.getElementById('tip-desc').innerText = isChapter
                ? '챕터 테스트를 통과하면 다음 챕터로 갈 수 있어요. \n도전하고 보상금을 받으세요!!'
                : (data.lessonDesc || "레슨 설명이 없습니다.");

            const status = data.status || 'locked';
            const badge = document.getElementById('tip-badge');

            if (status === 'completed') {
                badge.innerHTML = '<span class="px-2 py-1 rounded-lg bg-indigo-50 text-indigo-600 text-[10px] font-extrabold border border-indigo-100">완료</span>'
            } else if (status === 'current') {
                badge.innerHTML = '<span class="px-2 py-1 rounded-lg bg-orange-50 text-orange-600 text-[10px] font-extrabold border border-orange-100">진행중</span>';
            } else {
                badge.innerHTML = '<span class="px-2 py-0.5 rounded-full bg-white/60 text-gray-600 text-[10px] font-extrabold border border-gray-200">잠김</span>';
            }

            const infoDiv = document.getElementById('tip-info');
            if (isChapter) {
                infoDiv.innerHTML = '<div class="rounded-xl border border-gray-100 bg-gray-50 p-3"><div class="text-[10px] font-extrabold text-gray-400">보상금</div><div class="mt-1 text-xs font-extrabold text-gray-900">' + Number(data.testReward).toLocaleString() + '원</div></div>' +
                    '<div class="rounded-xl border border-gray-100 bg-gray-50 p-3"><div class="text-[10px] font-extrabold text-gray-400">응시료</div><div class="mt-1 text-xs font-extrabold text-gray-900">' + Number(data.testPay).toLocaleString() + '원</div></div>';
            } else {
                infoDiv.innerHTML = '<div class="rounded-xl border border-gray-100 bg-gray-50 p-3"><div class="text-[10px] font-extrabold text-gray-400">종류</div><div class="mt-1 text-xs font-extrabold text-gray-900">' + (data.type === 'THEORY' ? '이론' : '실습') + '</div></div>' +
                    '<div class="rounded-xl border border-gray-100 bg-gray-50 p-3"><div class="text-[10px] font-extrabold text-gray-400">예상 시간</div><div class="mt-1 text-xs font-extrabold text-gray-900">1~5분</div></div>';
            }

            let startBtn = document.getElementById('startBtn');
            const newBtn = startBtn.cloneNode(true);

            // 버튼이 없으면 중단 (툴팁 안 뜰 때)
            if (!startBtn) {
                console.error("startBtn을 찾을 수 없습니다.");
                return;
            }

            if ((!isChapter && status === 'completed') || status === 'current') {
                newBtn.disabled = false;
                newBtn.classList.remove("bg-gray-400", "cursor-not-allowed", "shadow-none");
                newBtn.classList.add("bg-indigo-600", "hover:bg-indigo-700", "shadow-indigo-200");
                newBtn.innerText = isChapter ? "시험 응시하기" : (status === 'completed' ? "다시하기" : "시작하기");

                newBtn.setAttribute('hx-post', CPATH + '/lesson/' + (isChapter ? 'chapter-test' : 'lessonInfo'));
                newBtn.setAttribute('hx-target', '#main');

                var param = {lessonId: data.id};
                if (isChapter) param.chapterId = data.chapterId;
                newBtn.setAttribute('hx-vals', JSON.stringify(param));
            } else {
                // 잠김이거나 챕터테스트를 완료한 경우
                newBtn.disabled = true;
                newBtn.classList.remove("bg-indigo-600", "hover:bg-indigo-700", "shadow-indigo-200");
                newBtn.classList.add("bg-gray-400", "cursor-not-allowed", "shadow-none");
                newBtn.innerText = (isChapter && status === 'completed') ? "완료" : "잠김";
            }

            startBtn.parentNode.replaceChild(newBtn, startBtn);
            htmx.process(newBtn);

            const TIP_WIDTH = 300;
            let left = pos.x - 150;
            let top = pos.y + 60;
            if (left < 10) left = 10;
            if (left + TIP_WIDTH > inner.offsetWidth) left = inner.offsetWidth - TIP_WIDTH - 10;
            if (top + 250 > inner.offsetHeight) top = pos.y - 320;

            tooltip.style.left = left + "px";
            tooltip.style.top = top + "px";
            tooltip.classList.add('visible');
        };

        /* --- 3. 로드맵 그리기 (초기화 플래그 파라미터 추가) --- */
        // isFirstLoad: true면 현재 진행 위치로 강제 스크롤, false(resize 등)면 위치 유지
        const initRoadmap = (isFirstLoad = false) => {
            const inner = document.getElementById('innerContent');
            const nodesLayer = document.getElementById('nodesLayer');
            const scrollContainer = document.getElementById('roadmapScroll');
            if (!inner || !nodesLayer || !scrollContainer) return;

            const vw = window.innerWidth - 220;
            const vh = window.innerHeight - 80;
            const NODES_PER_CHAPTER = 6;
            const maxChapterIdx = nodesData.length > 0 ? nodesData[nodesData.length - 1].chapterIdx : 0;
            const TOTAL_CHAPTERS = maxChapterIdx + 1;

            inner.style.width = (TOTAL_CHAPTERS * vw) + "px";

            nodesLayer.innerHTML = '';
            nodePositions = [];

            // 발판 위치 지정
            nodesData.forEach((node, i) => {
                const marginX = vw * 0.12;
                const availableW = vw - (marginX * 2);
                const stepX = availableW / (NODES_PER_CHAPTER - 1);
                const x = (node.chapterIdx * vw) + marginX + (node.inChapterIdx * stepX);
                const progress = node.inChapterIdx / (NODES_PER_CHAPTER - 1);
                const amplitude = vh * 0.3;
                const centerY = vh / 2;
                const y = centerY + (Math.sin(progress * 2 * Math.PI) * -amplitude);

                nodePositions.push({x, y, data: node});
            });

            // 발판 모양 생성
            nodePositions.forEach(pos => {
                const el = document.createElement('div');
                const data = pos.data;
                const isChapter = data.type === 'TEST';
                const status = data.status;

                el.className = 'orb ' + status;
                if (isChapter) {
                    el.style.width = '80px';
                    el.style.height = '80px';
                }

                if (isChapter) {
                    if (status === 'completed') {
                        el.innerHTML = '<i data-lucide="trophy" class="w-10 h-10 text-yellow-400 fill-yellow-100"></i>';
                        el.classList.add('border-yellow-400', 'bg-yellow-50');
                    } else if (status === 'current') {
                        el.innerHTML = '<i data-lucide="unlock" class="w-10 h-10 text-white animate-pulse"></i>';
                    } else {
                        el.innerHTML = '<i data-lucide="lock" class="w-8 h-8 text-gray-400"></i>';
                    }
                } else {
                    if (status === 'completed') {
                        el.innerHTML = '<i data-lucide="check" class="w-8 h-8 stroke-[3]"></i>';
                    } else if (status === 'current') {
                        el.innerHTML = '<i data-lucide="play" class="w-8 h-8 fill-white ml-1"></i>';
                    } else {
                        el.innerHTML = '<span class="text-xl font-bold font-mono text-gray-300">' + (data.inChapterIdx + 1) + '</span>';
                    }
                }


                el.style.left = (pos.x - (isChapter ? 40 : 36)) + "px";
                el.style.top = (pos.y - (isChapter ? 40 : 36)) + "px";

                el.onclick = (e) => {
                    e.stopPropagation();
                    window.openTooltip(pos, el);
                };
                nodesLayer.appendChild(el);
            });

            drawContinuousPath();
            if (window.lucide) window.lucide.createIcons();
            preBtn.onclick = () => {
                const vw = window.innerWidth - 220;
                const currentScroll = scrollContainer.scrollLeft;
                const currentChapter = Math.round(currentScroll / vw);
                if (currentChapter > 0) {
                    const targetIdx = currentChapter - 1;
                    const targetX = targetIdx * vw;
                    scrollContainer.scrollTo({left: targetX, behavior: 'smooth'});
                    updateDropdownUI(targetIdx);
                }
            };

            // 초기 로딩일 때만 현재 위치로 스크롤 & 드롭다운 동기화
            if (isFirstLoad) {
                const currentNode = nodePositions.find(p => p.data.status === 'current');

                // 만약 'current'가 없으면(다 깼거나 오류) 가장 마지막 완료된 곳이라도 찾음
                const targetNode = currentNode || nodePositions[nodePositions.length - 1];

                if (targetNode) {
                    const vw = window.innerWidth - 220;
                    let targetScroll = targetNode.data.chapterIdx * vw;
                    if (targetScroll < 0) targetScroll = 0;

                    // 약간의 지연을 주어 렌더링 후 스크롤 보장
                    setTimeout(() => {
                        // auto로 즉시 이동
                        scrollContainer.scrollTo({left: targetScroll, behavior: 'auto'});

                        // 들어오자마자 드롭다운도 현재 진행 챕터로 세팅
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
                fetchChapters(nodeData.levelId);
            }
        }

        // 라인 그리기
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
                const cp1 = {x: curr.x + (dist * 0.5), y: curr.y};
                const cp2 = {x: next.x - (dist * 0.5), y: next.y};
                d += " C " + cp1.x + " " + cp1.y + ", " + cp2.x + " " + cp2.y + ", " + next.x + " " + next.y;
            }

            if (pathBorder) pathBorder.setAttribute('d', d);
            if (pathMain) pathMain.setAttribute('d', d);
            if (pathDashed) pathDashed.setAttribute('d', d);

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
                        const cp1 = {x: curr.x + (dist * 0.5), y: curr.y};
                        const cp2 = {x: next.x - (dist * 0.5), y: next.y};
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

            // 이동 버튼 (드롭다운 내의 이동버튼)
            const moveBtn = document.getElementById('moveBtn');
            if (moveBtn) {
                moveBtn.onclick = () => {
                    const chapterBtn = document.getElementById('chapterSelect');
                    const selectedChId = chapterBtn.dataset.value;

                    if (!selectedChId) {
                        alert("이동할 챕터를 선택해주세요.");
                        return;
                    }

                    const targetNode = nodesData.find(n => n.chapterId === selectedChId);
                    if (targetNode) {
                        const vw = window.innerWidth - 220;
                        const targetX = targetNode.chapterIdx * vw;
                        const scrollContainer = document.getElementById('roadmapScroll');
                        scrollContainer.scrollTo({left: targetX, behavior: 'smooth'});
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
                    scrollContainer.scrollTo({left: targetX, behavior: 'smooth'});
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
                    scrollContainer.scrollTo({left: targetX, behavior: 'smooth'});
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

        // 실행 함수 (초기화)
        const initialize = () => {
            initRoadMapDropdowns();
            initChapterNavigation();

            // 리사이즈 이벤트는 전역이므로, 기존 리스너가 있다면 제거하고 다시 등록하거나 덮어씌움
            window.removeEventListener('resize', handleResize);
            window.addEventListener('resize', handleResize);

            // [핵심] 렌더링 안정성을 위해 약간의 지연 후 그리기
            setTimeout(() => {
                initRoadmap(true); // true = 내 위치로 스크롤 이동
            }, 100);
        };

        const handleResize = () => {
            // 리사이즈 시에는 스크롤 이동 없이 다시 그리기만
            initRoadmap(false);
            // 챕터 네비게이션 버튼 상태 업데이트
            const scrollContainer = document.getElementById('roadmapScroll');
            if (scrollContainer) {
                const event = new Event('scroll');
                scrollContainer.dispatchEvent(event);
            }
        };

        // 스크립트가 로드되자마자 실행
        initialize();

        if (window.lucide) {
            setTimeout(() => window.lucide.createIcons(), 50);
        }
    }
</script>
