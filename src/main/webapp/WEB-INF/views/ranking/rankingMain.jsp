<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--
  [참고] htmx로 호출되는 페이지라면 아래의 <script> 태그들은
  메인 레이아웃(사이드바가 있는 곳)의 <head>에 넣는 것이 성능과 안정성 면에서 훨씬 좋습니다.
--%>
<script src="https://unpkg.com/lucide@latest"></script>

<style>
    /* TOP 3 하이라이트 */
    .rank-top-1 { background: rgba(255, 193, 7, 0.14) !important; }   /* gold */
    .rank-top-2 { background: rgba(156, 163, 175, 0.16) !important; } /* silver */
    .rank-top-3 { background: rgba(205, 127, 50, 0.16) !important; }  /* bronze */
    .rank-top-1:hover, .rank-top-2:hover, .rank-top-3:hover { filter: brightness(0.98); }

    /* 랭킹 리스트 - 프로필 아바타 */
    .rank-user { display: flex; align-items: center; gap: 10px; padding-left: 50px; }
    .rank-avatar {
        width: 30px; height: 30px; border-radius: 9999px; object-fit: cover;
        border: 1px solid rgba(229, 231, 235, 0.9);
        box-shadow: 0 6px 18px rgba(0,0,0,0.06);
        flex: 0 0 auto;
    }
    .rank-avatar-fallback {
        width: 30px; height: 30px; border-radius: 9999px;
        display: flex; align-items: center; justify-content: center;
        background: #EEF2FF; color: #4F46E5; font-weight: 900; font-size: 12px;
        border: 1px solid rgba(229, 231, 235, 0.9);
        box-shadow: 0 6px 18px rgba(0,0,0,0.06);
        flex: 0 0 auto;
    }

    /* ✅ 전체 랭킹 테이블: 탭마다 컬럼폭 고정 */
    .rank-table { table-layout: fixed; }

    /* 기본 설정 및 레이아웃 */
    #rankingMainContent { font-family: 'Pretendard', sans-serif; display: flex; height: 100vh; width: 100%; background: #fff; overflow: hidden; }

    /* [왼쪽] 스테이지 영역 */
    #leftAnimZone {
        flex: 1; height: 100%;
        background: radial-gradient(circle at 50% 50%, #fcfcfd 0%, #f3f4f6 100%);
        border-right: 1px solid #f1f5f9;
        display: flex; flex-direction: column; align-items: center; justify-content: flex-start;
        padding-top: 50px; position: relative;
    }

    /* 트로피 섹션 */
    .trophy-wrap {
        display: flex; justify-content: center; align-items: flex-end;
        gap: 50px; margin-top:16vh; margin-bottom: 18px;
    }
    .trophy {
        position: relative; width: clamp(110px, 12vw, 170px);
        display: flex; flex-direction: column; align-items: center;
        transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        filter: grayscale(1) opacity(0.5);
    }

    /* 트로피 색상 및 활성화 효과 */
    .trophy.gold .text-color { color: #FFC107; }
    .trophy.silver .text-color { color: #9CA3AF; }
    .trophy.bronze .text-color { color: #CD7F32; }
    .trophy.active { filter: grayscale(0) opacity(1); transform: scale(1.15) translateY(-15px); }
    .trophy.gold.active { transform: scale(1.4) translateY(-25px); animation: activeGlowGold 2s ease-in-out infinite; }
    .trophy.silver.active { animation: activeGlowSilver 2s ease-in-out infinite; }
    .trophy.bronze.active { animation: activeGlowBronze 2s ease-in-out infinite; }

    @keyframes activeGlowGold {
        0%, 100% { filter: drop-shadow(0 0 15px rgba(255, 193, 7, 0.4)); }
        50% { filter: drop-shadow(0 0 35px rgba(255, 193, 7, 0.7)); }
    }
    @keyframes activeGlowSilver {
        0%, 100% { filter: drop-shadow(0 0 15px rgba(156, 163, 175, 0.4)); }
        50% { filter: drop-shadow(0 0 35px rgba(156, 163, 175, 0.7)); }
    }
    @keyframes activeGlowBronze {
        0%, 100% { filter: drop-shadow(0 0 15px rgba(205, 127, 50, 0.4)); }
        50% { filter: drop-shadow(0 0 35px rgba(205, 127, 50, 0.7)); }
    }

    /* 슬라이더 및 카드 */
    .portfolio-slider {
        width: 100%; max-width: 600px;
        position: relative; display: flex; align-items: center; justify-content: center;
        margin-top: 4px;
    }
    .portfolio-container { width: 100%; overflow: hidden; border-radius: 24px; touch-action: none; z-index: 10; }
    .portfolio-inner { display: flex; width: 100%; transition: transform 0.5s cubic-bezier(0.25, 1, 0.5, 1); }
    .winner-card { flex: 0 0 100%; width: 100%; padding: 10px; box-sizing: border-box; }
    .card-content { background: #fff; border: 1px solid #f1f5f9; border-radius: 24px; padding: 24px; box-shadow: 0 15px 40px rgba(0,0,0,0.06); }

    /* 버튼 및 탭 */
    .nav-btn { position: absolute; z-index: 20; opacity: 0.3; transition: all 0.3s ease; color: #111827; }
    .nav-btn:hover { opacity: 1; transform: scale(1.2); color: #5E45EB; }
    .nav-btn.prev { left: -50px; }
    .nav-btn.next { right: -50px; }

    #rightDataZone { flex: 1; height: 100%; overflow-y: auto; padding: 40px; background: #fff; display: flex; flex-direction: column; gap: 20px; }
    .rank-tab-btn { position: relative; padding-bottom: 10px; font-weight: 900; font-size: 13px; color: #9CA3AF; }
    .rank-tab-btn.active { color: #111827; }
    #tab-slider { position: absolute; bottom: 0; left: 0; height: 2px; background-color: #5E45EB; transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); }
</style>

<c:set var="topAsset" value="${rankingInfo.rankingBorardListOBA}"/>
<c:set var="topProfit" value="${rankingInfo.rankingBorardListOBR}"/>
<c:set var="listSize" value="${topAsset != null ? fn:length(topAsset) : 0}" />

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
            <c:if test="${listSize > 1}">
                <div id="trophy-1" class="trophy silver">
                    <i data-lucide="trophy" class="w-full h-auto text-color"></i>
                    <div class="mt-3 text-[13px] font-black text-gray-600 trophy-name">${topAsset[1].userName}</div>
                </div>
            </c:if>
            <c:if test="${listSize > 0}">
                <div id="trophy-0" class="trophy gold active">
                    <i data-lucide="trophy" class="w-full h-auto text-color"></i>
                    <div class="mt-4 text-[16px] font-black text-gray-900 trophy-name">${topAsset[0].userName}</div>
                </div>
            </c:if>
            <c:if test="${listSize > 2}">
                <div id="trophy-2" class="trophy bronze">
                    <i data-lucide="trophy" class="w-full h-auto text-color"></i>
                    <div class="mt-3 text-[13px] font-black text-gray-600 trophy-name">${topAsset[2].userName}</div>
                </div>
            </c:if>
        </div>

        <div class="portfolio-slider">
            <button class="nav-btn prev" id="prevBtn"><i data-lucide="chevron-left"></i></button>
            <div class="portfolio-container">
                <div class="portfolio-inner" id="portfolioInner">
                    <c:forEach var="item" items="${topAsset}" varStatus="status" end="2">
                        <c:set var="idx" value="${status.index}" />
                        <div class="winner-card" id="card-${idx}">
                            <div class="card-content">
                                <div class="flex justify-between items-center mb-5">
                                    <span class="text-[14px] font-black text-gray-800 card-title">${item.userName}님의 투자 현황</span>
                                    <span class="text-[11px] font-bold px-3 py-1 rounded-full bg-indigo-50 text-indigo-600">RANK #${idx+1}</span>
                                </div>
                                <div class="grid grid-cols-2 gap-4">
                                    <div class="bg-gray-50 p-4 rounded-2xl">
                                        <div class="text-[10px] text-gray-400 font-bold mb-1 uppercase card-lbl-1">Total Assets</div>
                                        <div class="text-[16px] font-black text-gray-900 card-val-1">₩<fmt:formatNumber value="${item.totalAsset}"/></div>
                                    </div>
                                    <div class="bg-gray-50 p-4 rounded-2xl">
                                        <div class="text-[10px] text-gray-400 font-bold mb-1 uppercase card-lbl-2">Revenue</div>
                                        <div class="text-[16px] font-black text-red-500 card-val-2">+${item.totalRevenueRate}%</div>
                                    </div>
                                        <%-- Main Stocks 삭제 --%>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <button class="nav-btn next" id="nextBtn"><i data-lucide="chevron-right"></i></button>
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
                    <div id="my-main-val" class="text-2xl font-black text-indigo-600 leading-none">₩ <fmt:formatNumber value="${rankingInfo.totalAsset}"/></div>
                </div>
            </div>
        </section>

        <section class="web-card flex-1 flex flex-col border border-gray-100 rounded-2xl shadow-sm bg-white overflow-hidden">
            <div class="p-4 border-b border-gray-50 bg-gray-50/30 flex flex-col gap-2">
                <span class="text-xs font-black text-gray-900 uppercase">전체 랭킹 리스트</span>
                <div class="relative flex items-center gap-6 mt-2 border-b border-gray-200">
                    <button id="tab-asset" class="rank-tab-btn active" onclick="switchRankTab('asset')">총 보유자금</button>
                    <button id="tab-profit" class="rank-tab-btn" onclick="switchRankTab('profit')">누적수익률</button>
                    <div id="tab-slider"></div>
                </div>
            </div>

            <div class="flex-1 overflow-y-auto relative">
                <table id="table-asset" class="rank-table w-full text-left transition-opacity duration-300">
                    <colgroup>
                        <col style="width: 88px;" />
                        <col />
                        <col style="width: 180px;" />
                    </colgroup>

                    <thead class="bg-white text-[11px] font-black text-gray-400 sticky top-0 z-10">
                    <tr class="border-b border-gray-100">
                        <th class="py-2.5 px-4 pl-6">순위</th>
                        <%-- ✅ 헤더도 .rank-user padding-left(50px)만큼 맞춤 --%>
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
                                    <img class="rank-avatar"
                                         src="${defaultProfile}"
                                         alt="profile"
                                         loading="lazy"
                                         onerror="this.onerror=null; this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                                    <div class="rank-avatar-fallback" style="display:none;">?</div>
                                    <span>${row.userName}</span>
                                </div>
                            </td>
                            <td class="py-2.5 px-4 pr-6 text-right font-bold text-sm text-gray-600">₩ <fmt:formatNumber value="${row.totalAsset}"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <table id="table-profit" class="rank-table w-full text-left absolute top-0 left-0 opacity-0 pointer-events-none transition-opacity duration-300">
                    <colgroup>
                        <col style="width: 88px;" />
                        <col />
                        <col style="width: 180px;" />
                    </colgroup>

                    <thead class="bg-white text-[11px] font-black text-gray-400 sticky top-0 z-10">
                    <tr class="border-b border-gray-100">
                        <th class="py-2.5 px-4 pl-6">순위</th>
                        <%-- ✅ 헤더도 동일하게 맞춤 --%>
                        <th class="py-2.5 px-4" style="padding-left: calc(1rem + 50px);">닉네임</th>
                        <th class="py-2.5 px-4 pr-6 text-right">수익률</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-50">
                    <c:if test="${not empty rankingInfo.rankingBorardListOBR}">
                        <c:forEach var="row" items="${rankingInfo.rankingBorardListOBR}">
                            <tr class="
                                ${row.userRevenueRank == 1 ? 'rank-top-1' : (row.userRevenueRank == 2 ? 'rank-top-2' : (row.userRevenueRank == 3 ? 'rank-top-3' : 'hover:bg-gray-50'))}
                                ${row.userSeq == rankingInfo.userSeq ? ' ring-2 ring-indigo-300 ring-inset' : ''}">
                                <td class="py-2.5 px-4 pl-6 font-bold text-sm">${row.userRevenueRank}</td>
                                <td class="py-2.5 px-4 font-black text-sm">
                                    <div class="rank-user">
                                        <img class="rank-avatar"
                                             src="${defaultProfile}"
                                             alt="profile"
                                             loading="lazy"
                                             onerror="this.onerror=null; this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                                        <div class="rank-avatar-fallback" style="display:none;">?</div>
                                        <span>${row.userName}</span>
                                    </div>
                                </td>
                                <td class="py-2.5 px-4 pr-6 text-right font-bold text-sm text-red-500">+${row.totalRevenueRate}%</td>
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
    window.RANKING_DATA = {
        asset: {
            myRank: "${rankingInfo.userAssetRank}",
            myVal: "₩ <fmt:formatNumber value='${rankingInfo.totalAsset}'/>",
            label: "총 보유자금",
            top3: [
                <c:forEach var="r" items="${rankingInfo.rankingBorardListOBA}" begin="0" end="2" varStatus="s">
                {
                    name: "${r.userName}",
                    mainVal: "₩ <fmt:formatNumber value='${r.totalAsset}'/>",
                    subVal: "+${r.totalRevenueRate}%",
                    mainLbl: "Total Assets",
                    subLbl: "Revenue"
                }${!s.last ? ',' : ''}
                </c:forEach>
            ]
        },
        profit: {
            myRank: "${rankingInfo.userRevenueRank}",
            myVal: "+${rankingInfo.totalRevenueRate}%",
            label: "누적수익률",
            top3: [
                <c:forEach var="r" items="${rankingInfo.rankingBorardListOBR}" begin="0" end="2" varStatus="s">
                {
                    name: "${r.userName}",
                    mainVal: "+${r.totalRevenueRate}%",
                    subVal: "₩ <fmt:formatNumber value='${r.totalAsset}'/>",
                    mainLbl: "Revenue",
                    subLbl: "Total Assets"
                }${!s.last ? ',' : ''}
                </c:forEach>
            ]
        }
    };

    let listSize = <c:out value="${listSize}" default="0" />;
    let currentSlideIndex = 0;
    const maxSlides = Math.min(3, listSize);

    function updateSliderUI() {
        const inner = document.getElementById('portfolioInner');
        if (!inner) return;
        inner.style.transform = `translateX(-${currentSlideIndex * 100}%)`;

        document.querySelectorAll('.trophy').forEach(t => t.classList.remove('active'));
        const activeTrophy = document.getElementById('trophy-' + currentSlideIndex);
        if (activeTrophy) activeTrophy.classList.add('active');
    }

    function moveSlide(dir) {
        if (maxSlides <= 1) return;
        currentSlideIndex = (currentSlideIndex + dir + maxSlides) % maxSlides;
        updateSliderUI();
    }

    window.switchRankTab = function(type) {
        const tabAsset = document.getElementById('tab-asset');
        const tabProfit = document.getElementById('tab-profit');
        const tableAsset = document.getElementById('table-asset');
        const tableProfit = document.getElementById('table-profit');
        const slider = document.getElementById('tab-slider');

        if (!tabAsset || !tabProfit) return;

        if (type === 'asset') {
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
        if (data) {
            const rankEl = document.getElementById('my-rank-val');
            const lblEl = document.getElementById('my-main-label');
            const valEl = document.getElementById('my-main-val');

            if (rankEl) rankEl.innerText = data.myRank; // # 제거
            if (lblEl) lblEl.innerText = data.label;
            if (valEl) valEl.innerText = data.myVal;
        }
    };

    function initRankingPage() {
        if (typeof lucide !== 'undefined') lucide.createIcons();

        const prev = document.getElementById('prevBtn');
        const next = document.getElementById('nextBtn');
        if (prev) prev.onclick = () => moveSlide(-1);
        if (next) next.onclick = () => moveSlide(1);

        updateSliderUI();
        setTimeout(() => switchRankTab('asset'), 100);
    }

    document.addEventListener('DOMContentLoaded', initRankingPage);

    document.body.addEventListener('htmx:afterOnLoad', function() {
        if (document.getElementById('rankingMainContent')) initRankingPage();
    });
</script>