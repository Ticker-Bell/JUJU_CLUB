<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:set var="topAsset" value="${rankingInfo.rankingBorardListOBA}"/>
<c:set var="topLssn" value="${rankingInfo.rankingBorardListOBR}"/>
<c:set var="listSize" value="${topAsset != null ? fn:length(topAsset) : 0}"/>

<div class="ranking-wrapper" id="rankingMainContent">
    <div id="leftAnimZone">
        <div class="text-center px-6">
            <h2 class="text-4xl font-black text-gray-900 mb-4 tracking-tighter">명예의 전당</h2>
            <p class="text-sm font-bold text-gray-500 leading-relaxed">
                최고의 투자 전략으로 자산을 증식시킨 상위 1% 주주들입니다.<br>
                <span class="text-primary font-black" style="color:#5E45EB;">지금 바로 투자를 시작하고 이 자리에 이름을 올리세요!</span>
            </p>
        </div>

        <div class="trophy-wrap">
            <div id="trophy-1" class="trophy silver">
                <i data-lucide="trophy" class="w-full h-auto text-color"></i>
                <div class="mt-3 text-[13px] font-black text-gray-600 trophy-name" id="trophy-name-1"></div>
            </div>

            <div id="trophy-0" class="trophy gold active">
                <i data-lucide="trophy" class="w-full h-auto text-color"></i>
                <div class="mt-3 text-[13px] font-black text-gray-600 trophy-name" id="trophy-name-0"></div>
            </div>

            <div id="trophy-2" class="trophy bronze">
                <i data-lucide="trophy" class="w-full h-auto text-color"></i>
                <div class="mt-3 text-[13px] font-black text-gray-600 trophy-name" id="trophy-name-2"></div>
            </div>
        </div>

        <div class="portfolio-slider">
            <button type="button" class="nav-btn prev" id="prevBtn"><i data-lucide="chevron-left"></i></button>
            <div class="portfolio-container">
                <div class="portfolio-inner" id="portfolioInner">
                    <div class="winner-card">
                        <div class="card-content">
                            <div class="flex justify-between items-center mb-5">
                                <div id="card-title" class="text-[14px] font-black text-gray-800"></div>
                                <div id="card-rank" class="text-[11px] font-bold px-3 py-1 rounded-full bg-indigo-50 text-indigo-600"></div>
                            </div>

                            <div class="grid grid-cols-2 gap-4">
                                <div class="bg-gray-50 p-4 rounded-2xl">
                                    <div class="text-[10px] text-gray-400 font-bold mb-1 uppercase">총 보유자산</div>
                                    <div id="card-asset" class="text-[16px] font-black text-gray-900"></div>
                                </div>
                                <div class="bg-gray-50 p-4 rounded-2xl">
                                    <div class="text-[10px] text-gray-400 font-bold mb-1 uppercase">레슨 진행 수</div>
                                    <div id="card-lesson" class="text-[16px] font-black text-red-500"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <button type="button" class="nav-btn next" id="nextBtn"><i data-lucide="chevron-right"></i></button>
        </div>
    </div>

    <div id="rightDataZone">
        <section class="web-card p-5 border border-gray-100 rounded-2xl shadow-sm bg-white shrink-0">
            <div class="flex items-center justify-between gap-4">
                <div class="flex items-center gap-3">
                    <div class="w-11 h-11 rounded-full bg-indigo-50 flex items-center justify-center">
                        <i data-lucide="award" class="w-6 h-6 text-indigo-600"></i>
                    </div>
                    <div>
                        <div class="text-[11px] font-bold text-gray-400 mb-1">나의 랭킹</div>
                        <div class="flex items-baseline gap-1">
                            <span id="my-rank-val" class="text-3xl font-black text-gray-900 leading-none">${rankingInfo.userAssetRank}</span>
                            <span class="text-[12px] font-bold text-gray-300">/ <fmt:formatNumber value="${rankingInfo.totUserCnt}"/></span>
                        </div>
                    </div>
                </div>
                <div class="h-10 w-[1px] bg-gray-100"></div>
                <div class="flex-1 pl-2">
                    <div id="my-main-label" class="text-[11px] font-bold text-gray-400 mb-1">총 보유자금</div>
                    <div id="my-main-val" class="text-2xl font-black text-indigo-600 leading-none">
                        ₩ <fmt:formatNumber value="${rankingInfo.cashBalance}"/>
                    </div>
                </div>
            </div>
        </section>

        <section class="web-card flex-1 flex flex-col border border-gray-100 rounded-2xl shadow-sm bg-white overflow-hidden">
            <div class="p-4 border-b border-gray-50 bg-gray-50/30 flex flex-col gap-2">
                <span class="text-xs font-black text-gray-900 uppercase">전체 랭킹 리스트</span>
                <div class="relative flex items-center gap-6 mt-2 border-b border-gray-200">
                    <button id="tab-asset" class="rank-tab-btn active" onclick="switchRankTab('asset')">총 보유자금</button>
                    <button id="tab-profit" class="rank-tab-btn" onclick="switchRankTab('profit')">총 진행레슨 수</button>
                    <div id="tab-slider"></div>
                </div>
            </div>

            <div class="flex-1 overflow-y-auto relative">
                <table id="table-asset" class="rank-table w-full text-left transition-opacity duration-300">
                    <colgroup>
                        <col style="width: 88px;"/>
                        <col/>
                        <col style="width: 180px;"/>
                    </colgroup>

                    <thead class="bg-white text-[11px] font-black text-gray-400 sticky top-0 z-10">
                    <tr class="border-b border-gray-100">
                        <th class="py-2.5 px-4 pl-6">순위</th>
                        <th class="py-2.5 px-4" style="padding-left: calc(1rem + 50px);">닉네임</th>
                        <th class="py-2.5 px-4 pr-6 text-right">보유자금</th>
                    </tr>
                    </thead>

                    <tbody class="divide-y divide-gray-50">
                    <c:forEach var="row" items="${rankingInfo.rankingBorardListOBA}">
                        <tr class="
                            ${row.userAssetRank == 1 ? 'rank-top-1' : (row.userAssetRank == 2 ? 'rank-top-2' : (row.userAssetRank == 3 ? 'rank-top-3' : 'hover:bg-gray-50'))}
                            ${row.userSeq == rankingInfo.userSeq ? ' ring-2 ring-indigo-300 ring-inset' : ''}">
                            <td class="py-2.5 px-4 pl-6 font-bold text-sm">${row.userAssetRank}</td>

                            <td class="py-2.5 px-4 font-black text-sm">
                                <div class="rank-user">
                                        <%-- ✅ 변경: userSeq로 DB 이미지 내려받기 (없으면 onerror로 default) --%>
                                    <img class="rank-avatar"
                                         src="${pageContext.request.contextPath}/member/profile-image?userSeq=${row.userSeq}&v=${row.userSeq}"
                                         alt="profile"
                                         loading="lazy"
                                         onerror="this.onerror=null; this.src='${defaultProfile}';"/>

                                    <div class="rank-avatar-fallback" style="display:none;">?</div>
                                    <span>${row.userName}</span>
                                </div>
                            </td>

                            <td class="py-2.5 px-4 pr-6 text-right font-bold text-sm text-gray-600">
                                ₩ <fmt:formatNumber value="${row.cashBalance}"/>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <table id="table-profit"
                       class="rank-table w-full text-left absolute top-0 left-0 opacity-0 pointer-events-none transition-opacity duration-300">
                    <colgroup>
                        <col style="width: 88px;"/>
                        <col/>
                        <col style="width: 180px;"/>
                    </colgroup>

                    <thead class="bg-white text-[11px] font-black text-gray-400 sticky top-0 z-10">
                    <tr class="border-b border-gray-100">
                        <th class="py-2.5 px-4 pl-6">순위</th>
                        <th class="py-2.5 px-4" style="padding-left: calc(1rem + 50px);">닉네임</th>
                        <th class="py-2.5 px-4 pr-6 text-right">진행 레슨 수</th>
                    </tr>
                    </thead>

                    <tbody class="divide-y divide-gray-50">
                    <c:if test="${not empty rankingInfo.rankingBorardListOBR}">
                        <c:forEach var="row" items="${rankingInfo.rankingBorardListOBR}">
                            <tr class="
                                ${row.userLssnRank == 1 ? 'rank-top-1' : (row.userLssnRank == 2 ? 'rank-top-2' : (row.userLssnRank == 3 ? 'rank-top-3' : 'hover:bg-gray-50'))}
                                ${row.userSeq == rankingInfo.userSeq ? ' ring-2 ring-indigo-300 ring-inset' : ''}">
                                <td class="py-2.5 px-4 pl-6 font-bold text-sm">${row.userLssnRank}</td>

                                <td class="py-2.5 px-4 font-black text-sm">
                                    <div class="rank-user">
                                            <%-- ✅ 변경: userSeq로 DB 이미지 내려받기 (없으면 onerror로 default) --%>
                                        <img class="rank-avatar"
                                             src="${pageContext.request.contextPath}/member/profile-image?userSeq=${row.userSeq}&v=${row.userSeq}"
                                             alt="profile"
                                             loading="lazy"
                                             onerror="this.onerror=null; this.src='${defaultProfile}';"/>

                                        <div class="rank-avatar-fallback" style="display:none;">?</div>
                                        <span>${row.userName}</span>
                                    </div>
                                </td>

                                <td class="py-2.5 px-4 pr-6 text-right font-bold text-sm text-red-500">
                                        ${row.userLssnCnt} 개
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </section>
    </div>
</div>

<script>
    (function () {
        // ⭐ HTMX로 로드될 때 바로 실행되도록 즉시 실행
        window.RANKING_DATA = {
            asset: {
                myRank: "${rankingInfo.userAssetRank}",
                myVal: "₩ <fmt:formatNumber value='${rankingInfo.cashBalance}'/>",
                label: "총 보유자금",
                top3: [
                    <c:forEach var="r" items="${rankingInfo.rankingBorardListOBA}" begin="0" end="2" varStatus="s">
                    {
                        name: "${r.userName}",
                        mainVal: "₩ <fmt:formatNumber value='${r.cashBalance}'/>",
                        lessonVal: "${r.userLssnCnt} 개"
                    }${!s.last ? ',' : ''}
                    </c:forEach>
                ]
            },
            profit: {
                myRank: "${rankingInfo.userLssnRank}",
                myVal: "${rankingInfo.userLssnCnt} 개",
                label: "총 진행 레슨 수",
                top3: [
                    <c:forEach var="r" items="${rankingInfo.rankingBorardListOBR}" begin="0" end="2" varStatus="s">
                    {
                        name: "${r.userName}",
                        mainVal: "₩ <fmt:formatNumber value='${r.cashBalance}'/>",
                        lessonVal: "${r.userLssnCnt} 개"
                    }${!s.last ? ',' : ''}
                    </c:forEach>
                ]
            }
        };

        let currentSlideIndex = 0;
        let currentRankType = 'asset';

        function updateCardContent() {
            const cardTitle = document.getElementById('card-title');
            const cardRank = document.getElementById('card-rank');
            const cardAsset = document.getElementById('card-asset');
            const cardLesson = document.getElementById('card-lesson');
            if(!cardTitle || !cardRank || !cardAsset || !cardLesson) return;

            const data = window.RANKING_DATA[currentRankType]?.top3?.[currentSlideIndex];
            console.log('data', data);
            if(!data) return;

            // 카드 제목/랭크 업데이트
            cardTitle.textContent = (data.name ?? '-') + '님의 투자 현황';
            cardRank.textContent = "RANK #" + (currentSlideIndex + 1);
            cardAsset.textContent = data.mainVal ?? '-';
            cardLesson.textContent = data.lessonVal ?? '-';

            // 트로피 활성화
            document.querySelectorAll('.trophy').forEach(t => t.classList.remove('active'));
            const activeTrophy = document.getElementById('trophy-' + currentSlideIndex);
            if(activeTrophy) activeTrophy.classList.add('active');

            // 트로피 이름 업데이트
            const list = window.RANKING_DATA[currentRankType]?.top3 || [];
            list.forEach((user, idx) => {
                const el = document.getElementById('trophy-name-' + idx);
                if(el) el.textContent = user.name ?? '-';
            });
        }

        function moveSlide(dir) {
            const max = window.RANKING_DATA[currentRankType]?.top3?.length || 0;
            if(max <= 1) return;
            currentSlideIndex = (currentSlideIndex + dir + max) % max;
            updateCardContent();
        }

        window.switchRankTab = function(type) {
            currentRankType = type;
            currentSlideIndex = 0;
            updateCardContent();

            const tabAsset = document.getElementById('tab-asset');
            const tabProfit = document.getElementById('tab-profit');
            const tableAsset = document.getElementById('table-asset');
            const tableProfit = document.getElementById('table-profit');
            const slider = document.getElementById('tab-slider');

            if(type === 'asset') {
                tabAsset.classList.add('active');
                tabProfit.classList.remove('active');
                slider.style.width = tabAsset.offsetWidth + 'px';
                slider.style.left = tabAsset.offsetLeft + 'px';
                tableAsset.style.opacity = '1';
                tableAsset.style.pointerEvents = 'auto';
                tableProfit.style.opacity = '0';
                tableProfit.style.pointerEvents = 'none';
            } else {
                tabAsset.classList.remove('active');
                tabProfit.classList.add('active');
                slider.style.width = tabProfit.offsetWidth + 'px';
                slider.style.left = tabProfit.offsetLeft + 'px';
                tableAsset.style.opacity = '0';
                tableAsset.style.pointerEvents = 'none';
                tableProfit.style.opacity = '1';
                tableProfit.style.pointerEvents = 'auto';
            }

            const data = window.RANKING_DATA[type];
            document.getElementById('my-rank-val').innerText = data.myRank;
            document.getElementById('my-main-label').innerText = data.label;
            document.getElementById('my-main-val').innerText = data.myVal;
        };

        // 버튼 이벤트 연결
        const prevBtn = document.getElementById('prevBtn');
        const nextBtn = document.getElementById('nextBtn');
        if(prevBtn) prevBtn.onclick = () => moveSlide(-1);
        if(nextBtn) nextBtn.onclick = () => moveSlide(1);

        // 첫 화면 asset으로
        switchRankTab('asset');

        // lucide 아이콘 생성
        if(typeof lucide !== 'undefined') lucide.createIcons();

    })();
</script>
