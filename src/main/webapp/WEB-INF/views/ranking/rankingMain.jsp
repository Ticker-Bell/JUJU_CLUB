<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>JUJU CLUB - Ranking</title>


<script src="https://cdn.tailwindcss.com"></script>
<script src="https://unpkg.com/lucide@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>

<link rel="stylesheet" as="style" crossorigin
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css"/>

<%--css 삭제 x--%>
<style>
  /* underline toggle */
  .rank-tab-btn{position:relative;padding-bottom:10px;font-weight:900;font-size:13px;color:#9CA3AF;}
  .rank-tab-btn.active{color:#111827;}

  #rank-tab-slider{height:2px;background:#5E45EB;bottom:0;position:absolute;transition:all .25s ease;}

</style>

<c:set var="topAsset" value="${rankingInfo.rankingBorardListOBA}"/>
<c:set var="gold" value="${topAsset[0]}"/>
<c:set var="silver" value="${topAsset[1]}"/>
<c:set var="bronze" value="${topAsset[2]}"/>

<script>
  tailwind.config = {
    theme: {
      extend: {
        fontFamily: {sans: ['Pretendard', 'sans-serif']},
        colors: {primary: '#5E45EB', text: '#191919'}
      }
    }
  }
</script>

<!-- 스크롤영영 -->
<div id="rankScroll"
     class="flex-1 min-h-0 overflow-y-auto pr-2 max-w-[1800px] mx-auto w-full">

    <!-- 상단 트로피 -->
    <section class="trophy-stage shrink-0">
        <div class="relative">
            <span class="spark s1"></span>
            <span class="spark s2"></span>
            <span class="spark s3"></span>

            <div class="trophy-wrap">
                <!-- Silver -->
                <div class="trophy silver" title="2위">
                    <div class="icon">
                        <i data-lucide="trophy" class="w-full h-auto"></i>
                    </div>
                    <div class="mt-3 text-[12px] font-extrabold text-gray-700">
                        ${silver.userName}
                    </div>
                </div>

                <!-- Gold -->
                <div class="trophy gold" title="1위">
                    <div class="icon">
                        <i data-lucide="trophy" class="w-full h-auto"></i>
                    </div>
                    <div class="mt-3 text-[12px] font-extrabold text-gray-900">
                        ${gold.userName}
                    </div>
                </div>

                <!-- Bronze -->
                <div class="trophy bronze" title="3위">
                    <div class="icon">
                        <i data-lucide="trophy" class="w-full h-auto"></i>
                    </div>
                    <div class="mt-3 text-[12px] font-extrabold text-gray-800">
                        ${bronze.userName}
                    </div>
                </div>
            </div>

            <!-- 포트폴리오는 처음엔 숨김 → 스크롤 시 펼쳐짐 -->
            <div class="portfolio-wrap mt-2">
                <div class="portfolio-grid">
                    <!-- #2 -->
                    <div class="winner-card">
                        <div class="top">
                            <div class="text-[11px] font-extrabold text-gray-900">
                                ${rankingInfo.rankingBorardListOBR[1].userName}님의 포트폴리오
                            </div>
                            <span class="text-[10px] font-extrabold text-gray-500">#2</span>
                        </div>
                        <div class="grid">
                            <div class="kv">
                                <div class="k">누적수익률</div>
                                <div class="v num-font text-red-500">
                                    +<fmt:formatNumber
                                        value="${rankingInfo.rankingBorardListOBR[1].totalRevenueRate}"/>%
                                </div>
                            </div>
                            <div class="kv">
                                <div class="k">총자산</div>
                                <div class="v num-font">
                                    ₩ <fmt:formatNumber
                                        value="${rankingInfo.rankingBorardListOBR[1].totalAsset}"/>
                                </div>
                            </div>
                            <div class="kv">
                                <div class="k">대표보유</div>
                                <div class="v small">NVDA · AAPL</div>
                            </div>
                            <div class="kv">
                                <div class="k">이메일</div>
                                <div class="v small">
                                    ${rankingInfo.rankingBorardListOBR[1].userId}
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- #1 -->
                    <div class="winner-card">
                        <div class="top">
                            <div class="text-[11px] font-extrabold text-gray-900">
                                ${rankingInfo.rankingBorardListOBR[0].userName}님의 포트폴리오
                            </div>
                            <span class="text-[10px] font-extrabold text-yellow-700">#1</span>
                        </div>
                        <div class="grid">
                            <div class="kv">
                                <div class="k">누적수익률</div>
                                <div class="v num-font text-red-600">
                                    +<fmt:formatNumber
                                        value="${rankingInfo.rankingBorardListOBR[0].totalRevenueRate}"/>%
                                </div>
                            </div>
                            <div class="kv">
                                <div class="k">총자산</div>
                                <div class="v num-font">
                                    ₩ <fmt:formatNumber
                                        value="${rankingInfo.rankingBorardListOBR[0].totalAsset}"/>
                                </div>
                            </div>
                            <div class="kv">
                                <div class="k">대표보유</div>
                                <div class="v small">TSLA · META</div>
                            </div>
                            <div class="kv">
                                <div class="k">이메일</div>
                                <div class="v small">
                                    ${rankingInfo.rankingBorardListOBR[0].userId}
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- #3 -->
                    <div class="winner-card">
                        <div class="top">
                            <div class="text-[11px] font-extrabold text-gray-900">
                                ${rankingInfo.rankingBorardListOBR[2].userName}님의 포트폴리오
                            </div>
                            <span class="text-[10px] font-extrabold text-orange-700">#3</span>
                        </div>
                        <div class="grid">
                            <div class="kv">
                                <div class="k">누적수익률</div>
                                <div class="v num-font text-red-500">
                                    +<fmt:formatNumber
                                        value="${rankingInfo.rankingBorardListOBR[2].totalRevenueRate}"/>%
                                </div>
                            </div>
                            <div class="kv">
                                <div class="k">총자산</div>
                                <div class="v num-font">
                                    ₩ <fmt:formatNumber
                                        value="${rankingInfo.rankingBorardListOBR[2].totalAsset}"/>
                                </div>
                            </div>
                            <div class="kv">
                                <div class="k">대표보유</div>
                                <div class="v small">AMD · MSFT</div>
                            </div>
                            <div class="kv">
                                <div class="k">이메일</div>
                                <div class="v small">
                                    ${rankingInfo.rankingBorardListOBR[2].userId}
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!-- /portfolio-grid -->
            </div><!-- /portfolio-wrap -->

        </div>
    </section>

    <!-- BELOW (scroll 시 숨김) -->
    <div id="belowPanels" class="grid grid-cols-12 gap-6 pb-8">

        <!-- My Rank -->
        <section class="col-span-12 lg:col-span-4 web-card p-6">
            <div class="flex items-start justify-between">
                <div>
                    <div class="text-xs font-extrabold text-gray-400 flex items-center gap-2">
                        <span class="w-2 h-2 rounded-full bg-primary"></span> 나의 랭킹
                    </div>
                    <div class="mt-2 flex items-baseline gap-2">
                        <span id="my-rank-number" class="text-4xl font-extrabold num-font">
                            # ${rankingInfo.userAssetRank}
                        </span>

                        <span class="text-sm font-extrabold text-gray-400">
                            / <fmt:formatNumber value="${rankingInfo.totUserCnt}"/>
                        </span>
                        <span class="font-semibold text-gray-400 ">
                            명
                        </span>
                    </div>
                </div>
            </div>

            <div class="mt-6 grid grid-cols-2 gap-3">
                <div class="p-4 rounded-xl bg-gray-50 border border-gray-100">
                    <div class="text-[10px] font-extrabold text-gray-400">누적수익률</div>
                    <div class="mt-1 text-xl font-extrabold num-font text-red-500">
                        +${rankingInfo.totalRevenueRate}%
                    </div>

                </div>
                <div class="p-4 rounded-xl bg-gray-50 border border-gray-100">
                    <div class="text-[10px] font-extrabold text-gray-400">누적수익금</div>
                    <div class="mt-1 text-2xl font-extrabold num-font text-primary">
                        ₩ <fmt:formatNumber value="${rankingInfo.totalAsset}"/>
                    </div>

                </div>
                <div class="p-4 rounded-xl bg-gray-50 border border-gray-100 col-span-2">
                    <div class="text-[10px] font-extrabold text-gray-400">총 보유자금</div>
                    <div class="mt-1 text-2xl font-extrabold num-font text-primary">
                        ₩ <fmt:formatNumber value="${rankingInfo.totalAsset}"/>
                    </div>
                    <div class="mt-2 text-[10px] font-bold text-gray-400">* 시즌 종료 시
                        보상(뱃지/포인트)
                        지급
                    </div>
                </div>
            </div>
        </section>

        <!-- 랭킹 보드  -->
        <section class="col-span-12 lg:col-span-8 web-card flex flex-col overflow-hidden">
            <div class="p-5 border-b border-gray-100 bg-gray-50/30">
                <div class="flex items-end justify-between gap-4 flex-wrap">
                    <div>
                        <div class="text-xs font-extrabold text-gray-400 flex items-center gap-2">
                            <span class="w-2 h-2 rounded-full bg-primary"></span> 유저 순위
                        </div>
                        <div class="mt-1 text-sm font-extrabold text-gray-900">랭킹 리스트</div>
                    </div>

                    <div class="relative border-b border-gray-200">
                        <div class="flex items-center gap-6">
                            <button id="rank-tab-0" class="rank-tab-btn active"
                                    onclick="switchRankTab(0)">누적수익률
                            </button>
                            <button id="rank-tab-1" class="rank-tab-btn"
                                    onclick="switchRankTab(1)">
                                총 보유자금
                            </button>
                        </div>
                        <div id="rank-tab-slider" class="absolute bottom-0 left-0"></div>
                    </div>
                </div>
            </div>

            <!-- 누적 수익률 탭 -->
            <div id="table-profit" class="flex-1 overflow-auto">
                <table class="w-full text-left border-collapse">
                    <thead class="bg-white text-[11px] font-extrabold text-gray-400 sticky top-0">
                    <tr>
                        <th class="p-4 border-b border-gray-100 pl-6">랭킹</th>
                        <th class="p-4 border-b border-gray-100">닉네임</th>
                        <th class="p-4 border-b border-gray-100 text-right pr-6">누적수익률</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="row" items="${rankingInfo.rankingBorardListOBR}">
                        <tr class="${row.userSeq == rankingInfo.userSeq ? 'bg-primary/5 border-primary/10' : 'hover:bg-gray-50'}">
                            <td class="p-4 pl-6 num-font">
                                    ${row.userRevenueRank}
                            </td>
                            <td class="p-4 font-extrabold">
                                <c:choose>
                                    <c:when test="${row.userSeq == rankingInfo.userSeq}">
                                        <span class="text-primary">${row.userName} (나)</span>
                                    </c:when>
                                    <c:otherwise>
                                        ${row.userName}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="p-4 text-right pr-6 num-font">
                                +${row.totalRevenueRate}%
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>

                </table>
            </div>

            <!-- 총 보유 자금 탭 -->
            <div id="table-asset" class="hidden flex-1 overflow-auto">
                <table class="w-full text-left border-collapse">
                    <thead class="bg-white text-[11px] font-extrabold text-gray-400 sticky top-0">
                    <tr>
                        <th class="p-4 border-b border-gray-100 pl-6">랭킹</th>
                        <th class="p-4 border-b border-gray-100">닉네임</th>
                        <th class="p-4 border-b border-gray-100 text-right pr-6">총 보유자금</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="row" items="${rankingInfo.rankingBorardListOBA}">
                        <tr class="${row.userSeq == rankingInfo.userSeq ? 'bg-primary/5 border-primary/10' : 'hover:bg-gray-50'}">
                            <td class="p-4 pl-6 num-font">
                                    ${row.userAssetRank}
                            </td>
                            <td class="p-4 font-extrabold">
                                <c:choose>
                                    <c:when test="${row.userSeq == rankingInfo.userSeq}">
                                        <span class="text-primary">${row.userName} (나)</span>
                                    </c:when>
                                    <c:otherwise>
                                        ${row.userName}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="p-4 text-right pr-6 num-font">
                                ₩ <fmt:formatNumber value="${row.totalAsset}"/>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </section>

    </div><!-- /belowPanels -->

</div>
<!-- /rankScroll -->


<script>
  (function () {
    lucide.createIcons();
    window.RANKING_DATA = {
      profit: {
        myRank: ${rankingInfo.userRevenueRank},
        list: [
          <c:forEach var="r" items="${rankingInfo.rankingBorardListOBR}" varStatus="s">
          {
            userSeq: ${r.userSeq},
            userName: "${r.userName}",
            rank: ${r.userRevenueRank},
            totalRevenueRate: ${r.totalRevenueRate},
            totalAsset: ${r.totalAsset}
          }${!s.last ? ',' : ''}
          </c:forEach>
        ]
      },
      asset: {
        myRank: ${rankingInfo.userAssetRank},
        list: [
          <c:forEach var="r" items="${rankingInfo.rankingBorardListOBA}" varStatus="s">
          {
            userSeq: ${r.userSeq},
            userName: "${r.userName}",
            rank: ${r.userAssetRank},
            totalRevenueRate: ${r.totalRevenueRate},
            totalAsset: ${r.totalAsset}
          }${!s.last ? ',' : ''}
          </c:forEach>
        ]
      }
    };

    function positionRankSlider() {
      const slider = document.getElementById('rank-tab-slider');
      const a = document.getElementById('rank-tab-0');
      const b = document.getElementById('rank-tab-1');
      if (!slider || !a || !b) return;
      const activeBtn = a.classList.contains('active') ? a : b;
      slider.style.width = activeBtn.offsetWidth + 'px';
      slider.style.left = activeBtn.offsetLeft + 'px';
    }

    window.switchRankTab = function (idx) {
      const a = document.getElementById('rank-tab-0');
      const b = document.getElementById('rank-tab-1');
      const tProfit = document.getElementById('table-profit');
      const tAsset = document.getElementById('table-asset');

      const type = (idx === 0) ? 'profit' : 'asset';

      // 탭 UI
      if (idx === 0) {
        a.classList.add('active');
        b.classList.remove('active');
        tProfit.classList.remove('hidden');
        tAsset.classList.add('hidden');
      } else {
        b.classList.add('active');
        a.classList.remove('active');
        tAsset.classList.remove('hidden');
        tProfit.classList.add('hidden');
      }

      //  나의 랭킹 변경
      document.getElementById('my-rank-number').innerText =
          '# ' + window.RANKING_DATA[type].myRank;

      // 트로피 + 포트폴리오 변경
      updateTop3(type);

      positionRankSlider();
    }

    function updateTop3(type) {
      const list = window.RANKING_DATA[type].list;
      if (!list || list.length < 3) return;

      const gold = list[0];
      const silver = list[1];
      const bronze = list[2];

      const goldEl = document.querySelector('.trophy.gold .mt-3');
      const silverEl = document.querySelector('.trophy.silver .mt-3');
      const bronzeEl = document.querySelector('.trophy.bronze .mt-3');

      if (goldEl) goldEl.innerText = gold.userName;
      if (silverEl) silverEl.innerText = silver.userName;
      if (bronzeEl) bronzeEl.innerText = bronze.userName;

      // 포트폴리오 카드
      const cards = document.querySelectorAll('.winner-card');

      [silver, gold, bronze].forEach((u, i) => {
        const card = cards[i];
        if (!card) return;

        card.querySelector('.top div').innerText =
            `${u.userName}님의 포트폴리오`;

        const values = card.querySelectorAll('.kv .v');

        if (type === 'profit') {
          values[0].innerText = `+${u.totalRevenueRate}%`;
          values[1].innerText = `₩ ${u.totalAsset.toLocaleString()}`;
        } else {
          values[0].innerText = `₩ ${u.totalAsset.toLocaleString()}`;
          values[1].innerText = `+${u.totalRevenueRate}%`;
        }
      });
    }

    function clamp(n, min, max) {
      return Math.max(min, Math.min(max, n));
    }

    function lerp(a, b, t) {
      return a + (b - a) * t;
    }

    function applyScrollEffects() {
      const sc = document.getElementById('rankScroll');
      if (!sc) return;

      const y = sc.scrollTop;

      // 0~1 진행도
      const TH = 320;
      const p = clamp(y / TH, 0, 1);

      // 트로피 확대 + 간격 증가 (처음엔 기본)
      const boost = lerp(1.0, 1.085, p);
      const gapPx = lerp(28, 66, p);

      // 포트폴리오: "일정 스크롤 이후"부터 펼치기 (처음엔 0)
      const revealStart = 0.18;     // 18% 지점부터 등장
      const revealEnd = 0.62;     // 62% 지점에서 완전 등장
      const po = clamp((p - revealStart) / (revealEnd - revealStart), 0, 1);

      // 아래 패널: 포트폴리오가 나오기 시작하면 숨기기
      const hideStart = 0.14;
      const hideEnd = 0.55;
      const h = clamp((p - hideStart) / (hideEnd - hideStart), 0, 1);

      const belowOpacity = lerp(1, 0, h);
      const belowY = lerp(0, 110, h);
      const belowBlur = lerp(0, 3, h);

      sc.style.setProperty('--trophyBoost', boost.toFixed(3));
      sc.style.setProperty('--trophyGapPx', gapPx.toFixed(0) + 'px');
      sc.style.setProperty('--portfolioOpen', po.toFixed(3));
      sc.style.setProperty('--belowOpacity', belowOpacity.toFixed(3));
      sc.style.setProperty('--belowY', belowY.toFixed(0) + 'px');
      sc.style.setProperty('--belowBlur', belowBlur.toFixed(2) + 'px');

      const below = document.getElementById('belowPanels');
      if (below) {
        below.style.pointerEvents = (h > 0.85) ? 'none' : 'auto';
      }
    }

    window.addEventListener('load', () => {
      switchRankTab(0);
      positionRankSlider();

      const sc = document.getElementById('rankScroll');
      sc.addEventListener('scroll', applyScrollEffects, {passive: true});
      applyScrollEffects();
    });

    window.addEventListener('resize', () => {
      positionRankSlider();
      applyScrollEffects();
    });
  })();
</script>
