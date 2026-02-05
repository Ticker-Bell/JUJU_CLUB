<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
    .container {
        width: min(1200px, 100%);
        margin: 0 auto;
        /*padding: 0 20px; !* 양쪽 여백 확보 *!*/
        min-width: 0;
    }

    /* SUMMARY WRAPPER (전체 큰 박스) */
    .summary-wrapper {
        grid-area: summary;
        background: #fff;
        border: 1px solid #e8e8e8;
        border-radius: 16px;
        padding: 24px;
        margin-bottom: 0;
        /*height: 175px;*/
        display: flex;
        align-items: center;     /* 세로 중앙 */
        justify-content:center;
        height: 100%;            /* 그리드가 늘린 높이를 그대로 사용 */
    }

    /* 왼쪽(총평가자산 텍스트 영역) + 오른쪽(3카드) */
    .summary-cards {
        width: min(100%, 1120px);
        margin: 0 auto;
        display: grid;
        grid-template-columns: 1.2fr 2.8fr; /* 예시처럼 오른쪽이 더 넓게 */
        gap: 24px;
        align-items: stretch;
        /*width: min(1100px, 100%);*/
    }

    /* 왼쪽 총평가자산은 "박스 없음" */
    .summary-left {
        display: flex;
        align-items: center;
        justify-content: center;
    }

    /* 총평가자산 텍스트 블록 */
    .summary-total {
        width: fit-content;
        padding: 6px 8px 0px 0; /* 상 우 하 좌 - 오른쪽에만 약간 여백 */
    }

    .summary-total-title {
        display: flex;
        align-items: center;
        gap: 10px;
        font-size: 16px;
        font-weight: 700;
        color: #333;
        margin-bottom: 18px;
    }

    /* 타이틀 앞 점 */
    .summary-total-title .dot {
        width: 10px;
        height: 10px;
        border-radius: 50%;
        background: #6b5bff; /* 필요하면 #333으로 통일 가능 */
        display: inline-block;
    }

    /* 총평가자산 숫자 */
    .summary-total-value {
        font-size: 52px;
        font-weight: 800;
        letter-spacing: -0.8px;
        display: flex;
        align-items: baseline;
        gap: 8px;
        line-height: 1;
        color: #333;
        white-space: nowrap; /* 줄바꿈 방지 */
    }

    /* 단위 */
    .unit {
        margin-left: 0; /* gap으로 spacing 주기 */
        padding: 0;
        line-height: 1; /* 높이 딱 맞추기 */
        display: inline; /* 박스화 방지 */
        font-size: 18px;
        font-weight: 600;
        color: #777;
    }

    /* RIGHT: 작은 카드 3개 */
    .summary-right {
        display: grid;
        gap: 16px;
        grid-template-columns: repeat(3, 1fr); /*기본 3열 고정*/
    }

    /* 작은 카드 공통 */
    .summary-right .summary-card {
        background: #fff;
        border: 1px solid #ededed;
        border-radius: 14px;
        padding: 18px;
        height: 100%;
        transition: all 0.2s ease;
    }

    .summary-right .summary-card:hover {
        background: #f8f9ff;
        border-color: #6b5bff;
    }

    /* 작은 카드 텍스트 */
    .summary-right .summary-card .label {
        font-size: 13px;
        font-weight: 600;
        color: #666;
        margin-bottom: 12px;
        white-space: nowrap;
    }

    .summary-right .summary-card .value {
        font-size: 24px;
        font-weight: 800;
        color: #333;
        white-space: nowrap; /*줄바꿈 방지 */
    }

    /* 수익률 색상 */
    .summary-right .summary-card .value.positive {
        color: #e53935;
    }

    .summary-right .summary-card .value.negative {
        color: #1e88e5;
    }

    /* RESPONSIVE */
    @media (max-width: 1100px) {
        .summary-cards {
            grid-template-columns: 1fr;
        }

        .summary-right {
            grid-template-columns: repeat(3, 1fr); /*3열 유지*/
        }

        .summary-total-value {
            font-size: 44px;
        }
    }

    @media (max-width: 700px) {
        .summary-right {
            grid-template-columns: repeat(2, 1fr); /*2열 유지*/
        }
    }

    @media (max-width: 480px) {
        .summary-right {
            grid-template-columns: 1fr; /*1열 유지*/
        }

        .summary-total-value {
            font-size: 38px;
        }
    }

    .dashboard {
        display: grid;
        grid-template-columns: 1fr minmax(280px, 320px);
        grid-template-rows: auto auto auto;
        gap: 20px 32px;
        /*align-items: start;*/
        grid-template-areas:
    "summary chart"
    "hold    chart";
        /*"hold    watch";*/
        min-height: 0;
    }

    /* 각 카드의 위치 지정 */
    .holdings-card {
        grid-area: hold;
        display: flex;
        flex-direction: column;
        min-height: 0;
    }

    .chart-card {
        grid-area: chart;
        background: linear-gradient(135deg, #ffffff 0%, #f8f9ff 100%);
    }

    .watch-card {
        grid-area: watch;
    }

    @media (max-width: 992px) {
        .dashboard {
            grid-template-columns: 1fr;
            grid-template-rows: auto auto auto auto;
            grid-template-areas: "summary" "hold" "chart" "watch";
        }
    }

    /* 카드 공통 */
    .card {
        background: #fff;
        border-radius: 12px;
        padding: 25px;
    }

    .card-title {
        margin-bottom: 15px;
        font-size: 18px;
        font-weight: 600;
        color: #333;
    }

    /* 관심 종목 리스트 */
    .watchlist-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 0;
        border-bottom: 1px solid #f0f0f0;
    }

    .watchlist-item:last-child {
        border-bottom: none;
    }

    .stock-info .stock-name {
        font-size: 15px;
        font-weight: 500;
        color: #333;
    }

    .stock-info .stock-code {
        font-size: 12px;
        color: #999;
        margin-top: 2px;
    }

    .stock-price {
        text-align: right;
        padding-right: 5px;
    }

    .stock-price .price {
        font-size: 15px;
        font-weight: 600;
    }

    .stock-price .change {
        font-size: 12px;
        margin-top: 2px;
    }

    .stock-price .change.positive {
        color: #e53935;
    }

    .stock-price .change.negative {
        color: #1e88e5;
    }

    /* 차트 영역 */
    .chart-container {
        width: 100%;
        height: 280px;
        display: flex;
        align-items: center;
        justify-content: center;
        background: #fff;
        border: 1px solid #f0f0f0;
        border-radius: 8px;
        margin-bottom: 20px;
    }

    /* 차트 범례 */
    .chart-legend {
        display: flex;
        gap: 15px;
        flex-wrap: wrap;
        max-height: 180px;
        overflow-y: auto;
        justify-content: flex-start;
    }

    .legend-item {
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 13px;
    }

    .legend-color {
        width: 14px;
        height: 14px;
        border-radius: 3px;
    }

    /* 보유 종목 리스트 테이블 */
    .holdings-table {
        width: 100%;
        border-collapse: collapse;
        table-layout: fixed; /* 균등 배분 핵심 */
    }

    .holdings-table th {
        background: #f8f9fa; /* 헤더 배경색 */
        text-align: center;
        padding: 16px 12px;
        font-size: 13px;
        font-weight: 600;
        color: #666;
        border-bottom: 1px solid #e0e0e0;
    }

    .holdings-table td {
        text-align: center;
        padding: 18px 12px;
        font-size: 14px;
        border-bottom: 1px solid #f0f0f0;
        color: #333;
    }

    /* 종목명만 왼쪽 정렬 */
    .holdings-table th:first-child,
    .holdings-table td:first-child {
        text-align: center;
        padding-left: 24px;
    }

    /* 숫자 컬럼 오른쪽 정렬 */
    .holdings-table th:nth-child(n+2),
    .holdings-table td:nth-child(n+2) {
        text-align: center;
        padding-right: 24px;
    }

    /* 컬럼 너비 지정 */
    .holdings-table th:nth-child(1) {
        width: 22%;
    }

    .holdings-table th:nth-child(2) {
        width: 14%;
    }

    .holdings-table th:nth-child(3) {
        width: 18%;
    }

    .holdings-table th:nth-child(4) {
        width: 18%;
    }

    .holdings-table th:nth-child(5) {
        width: 22%;
    }

    /* 종목 코드 스타일 */
    .holdings-table .stock-name-cell .name {
        font-weight: 600;
        color: #333;
    }

    .holdings-table .stock-name-cell .code {
        font-size: 12px;
        color: #999;
        margin-top: 4px;
    }

    .holdings-table .stock-name-cell .name {
        font-weight: 500;
    }

    .holdings-table .stock-name-cell .code {
        font-size: 12px;
        color: #999;
        margin-top: 2px;
    }

    .holdings-table tbody tr {
        transition: background 0.15s ease;
    }

    .holdings-table tbody tr:hover {
        background: #f8f9ff;
    }

    .holdings-table .profit.positive {
        color: #e53935;
    }

    .holdings-table .profit.negative {
        color: #1e88e5;
    }

    /* 빈 상태 메시지 */
    .empty-state {
        text-align: center;
        padding: 40px;
        color: #999;
    }

    /* 차트 빈 상태 */
    .empty-chart-message {
        text-align: center;
        color: #888;
    }

    .empty-chart-message .icon {
        font-size: 28px;
        margin-bottom: 8px;
    }

    .empty-chart-message .message {
        font-weight: 700;
        margin-bottom: 4px;
    }

    .empty-chart-message .sub-message {
        font-size: 12px;
        color: #aaa;
    }

    /* 숫자 포맷팅 */
    .text-right {
        text-align: right;
    }

    .pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 6px;
        margin-top: 16px;
        padding-top: 12px;
        border-top: 1px solid #f0f0f0;
    }

    .pagination button {
        min-width: 28px;
        height: 28px;
        padding: 0 8px;
        border: 1px solid #e0e0e0;
        background: #fff;
        border-radius: 6px;
        font-size: 12px;
        color: #666;
        cursor: pointer;
        transition: all 0.15s ease;
    }

    .pagination button:hover:not(:disabled) {
        background: #f5f5f5;
        border-color: #ccc;
    }

    .pagination button:disabled {
        opacity: 0.4;
        cursor: not-allowed;
    }

    .pagination button.active {
        background: #6b5bff;
        border-color: #6b5bff;
        color: #fff;
        font-weight: 600;
    }

    .holdings-scroll {
        overflow-y: auto;
        min-height: 0; /* flex/grid 내부 스크롤 살리는 핵심 */
        padding-right: 10px;
        scrollbar-gutter: stable;
        max-height: calc(56px * 7); /* 7줄 정도 보이게 */

    }

    .watchlist-scroll {
        max-height: calc(56px * 5);
        overflow-y: auto;
        min-height: 0;
        padding-right: 10px;
        scrollbar-gutter: stable;
    }

    .card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .update-time {
        font-size: 14px;
        color: #999;
    }

    .card-header.compact {
        margin-bottom: 10px;
    }

    .card-title.spacious {
        margin-bottom: 24px;
    }

    /* 수익률 TOP/WORST 카드 - 차트 범례 밑에 추가 */
    .profit-summary,
    .profit-card,
    .profit-card .card-content {
        min-width: 0; /*내용이 길어져도 튀어나가지 않도록*/
    }

    /* 종목명/금액 같은 텍스트가 폭을 밀지 못하게 */
    .profit-card .stock-name,
    .profit-card .profit-rate,
    .profit-card .card-label {
        min-width: 0;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: normal; /*줄바꿈 허용*/
    }

    .profit-summary {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 10px;
        margin-top: 16px;
    }

    .profit-card {
        display: flex;
        align-items: center;
        flex-direction: column;
        text-align: center;
        gap: 8px;
        padding: 16px 12px;
        border-radius: 10px;
        transition: all 0.15s ease;
        cursor: default;
        background: #fafafa;
        border: 1px solid #e8e8e8;
    }

    .profit-card:hover {
        border-color: #d0d0d0;
    }

    .profit-card.best:hover {
        background: #fff5f5;
        border-color: #ffcdd2;
    }

    .profit-card.worst:hover {
        background: #f5f5ff;
        border-color: #c5cae9;
    }

    .card-emoji {
        font-size: 24px;
        line-height: 1;
        padding-bottom: 12px;
    }

    .card-content {
        flex: 1;
        min-width: 0;
    }

    .card-label {
        font-size: 10px;
        font-weight: 600;
        color: #999;
        margin-bottom: 4px;
        text-transform: uppercase;
        letter-spacing: 0.3px;
    }

    .profit-card .stock-name {
        font-size: 14px;
        font-weight: 700;
        color: #333;
        margin-bottom: 3px;
        /*white-space: normal; !*줄 바꿈 허용*!*/
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .profit-rate {
        font-size: 12px;
        font-weight: 700;
        /*white-space: normal;*/
        word-break: break-word;
    }

    .profit-rate.positive {
        color: #e53935;
    }

    .profit-rate.negative {
        color: #1e88e5;
    }

    /* 반응형 */
    @media (max-width: 480px) {
        .profit-summary {
            grid-template-columns: 1fr;
        }

        .card-emoji {
            font-size: 20px;
        }
    }
</style>

<div class="container">
    <!-- 메인 콘텐츠 -->
    <div class="dashboard w-full">
        <!-- 상단 요약 카드 -->
        <div class="summary-wrapper">
            <div class="summary-cards">

                <!-- LEFT: 큰 카드 -->
                <div class="summary-left">
                    <div class="summary-total">
                        <div class="summary-total-title">
                            <span class="dot"></span>
                            총 평가자산
                        </div>
                        <div class="summary-total-value">
                        <span id="totalAsset">
                            <fmt:formatNumber value="${userAsset.totalAsset}" pattern="#,###"/>
                        </span>
                            <span class="unit">원</span>
                        </div>
                    </div>
                </div>

                <!-- RIGHT: 작은 카드 3개 묶음 -->
                <div class="summary-right">
                    <div class="summary-card">
                        <div class="label">💰 예수금</div>
                        <div class="value">
                        <span id="cashBalance">
                        <fmt:formatNumber value="${userAsset.cashBalance}" pattern="#,###"/>
                        </span>
                            <span class="unit">원</span>
                        </div>
                    </div>

                    <div class="summary-card">
                        <div class="label">📊 총 평가금액</div>
                        <div class="value ">
                        <span id="totalStockValue">
                        <fmt:formatNumber value="${userAsset.totalStockValue}" pattern="#,###"/>
                        </span>
                            <span class="unit">원</span>
                        </div>
                    </div>

                    <div class="summary-card">
                        <div class="label">📈 투자 총 수익률</div>
                        <div id="totalReturnPct"
                             class="value ${userAsset.totalReturnPct > 0 ? 'positive' : (userAsset.totalReturnPct < 0 ? 'negative' : '')}">
                            <c:if test="${userAsset.totalReturnPct >= 0}">+</c:if><fmt:formatNumber value="${userAsset.totalReturnPct}" pattern="#,##0.00"/>%
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <!-- LEFT: 메인(넓게) - 보유 종목 리스트 -->
        <!-- 보유 종목 리스트 -->
        <div class="card holdings-card">
            <div class="card-header compact">
                <h3 class="card-title">보유 종목 리스트</h3>
                <span class="update-time">마지막 갱신 시간 <span id="test_time">-</span></span>
            </div>
            <c:choose>
                <c:when test="${not empty holdings}">
                    <div id="holdingsScroll" class="holdings-scroll">
                        <table class="holdings-table">
                            <thead>
                            <tr>
                                <th>종목</th>
                                <th>보유주(주)</th>
                                <th>평균단가(원)</th>
                                <th>현재가(원)</th>
                                <th>평가손익(원)</th>
                            </tr>
                            </thead>
                            <tbody id="holdingStocks">
                            <c:forEach var="holding" items="${holdings}">
                                <tr class="holding-row" data-code="${holding.stockCode}" data-qty="${holding.quantity}"
                                    data-avg="${holding.avgPrice}">
                                    <td class="stock-name-cell">
                                        <div class="name">${holding.stockName}</div>
                                        <div class="code">${holding.stockCode}</div>
                                    </td>
                                    <td class="text-right"><fmt:formatNumber value="${holding.quantity}"
                                                                             pattern="#,###"/></td>
                                    <td class="text-right"><fmt:formatNumber value="${holding.avgPrice}"
                                                                             pattern="#,###"/></td>
                                    <td class="text-right currentPriceData"><fmt:formatNumber
                                            value="${holding.currentPrice}"
                                            pattern="#,###"/></td>
                                    <td class="text-right profit ${holding.pnl > 0 ? 'positive' : (holding.pnl < 0 ? 'negative' : '')} pnlData">
                                        <c:if test="${holding.pnl > 0}">+</c:if><fmt:formatNumber value="${holding.pnl}" pattern="#,###"/>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                            <%--다음페이지 로드할 기준점--%>
                        <div id="holdingsSentinel" style="height:1px;"></div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">보유 종목이 없습니다🥲</div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- RIGHT: 사이드(좁게) - 차트 + 관심종목 -->
        <!-- 보유 종목 차트 -->
        <div class="card chart-card">
            <h3 class="card-title spacious">보유 종목 차트</h3>

            <div class="chart-container">
                <canvas id="holdingsChart"></canvas>
                <div id="emptyChartMessage" class="empty-chart-message"
                     style="${empty holdings ? '' : 'display:none;'}">
                    <div class="icon">📈</div>
                    <div class="message">보유 종목이 없습니다</div>
                    <div class="sub-message">주식을 매수하면 차트가 표시됩니다</div>
                </div>
            </div>

            <div class="chart-legend" id="chartLegend">
                <c:forEach var="item" items="${chartData}">
                    <div class="legend-item">
                        <div class="legend-color" style="background-color: ${item.color};"></div>
                        <span>${item.stockName}</span>
                        <span><fmt:formatNumber value="${item.weightPct}" pattern="#,##0.00"/>%</span>
                    </div>
                </c:forEach>
            </div>
            <!-- 수익률 TOP/WORST -->
            <div class="profit-summary" id="profitSummary" style="${empty holdings ? 'display:none;' : ''}">
                <div class="profit-card best">
                    <div class="card-emoji">👑</div>
                    <div class="card-content">
                        <div class="card-label">오늘의 MVP</div>
                        <div class="stock-name" id="bestStockName">-</div>
                        <div class="profit-rate positive" id="bestStockPnl">-</div>
                    </div>
                </div>

                <div class="profit-card worst">
                    <div class="card-emoji">💪</div>
                    <div class="card-content">
                        <div class="card-label">제발 올라줘</div>
                        <div class="stock-name" id="worstStockName">-</div>
                        <div class="profit-rate negative" id="worstStockPnl">-</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    //페이지를 바꿔도 전역변수가 안없어져서 감싸기
    (function () {
        const userSeq = "${sessionScope.userSeq}";

        //서버에서 전달받은 차트 데이터 : StockMyController에서 전달하는 JSON(chartDataJson)
        const chartDataFromServer = ${empty chartDataJson ? "[]" : chartDataJson};

        //페이징
        const countPerPage = 7;

        const holdingsState = {
            loadedCount: countPerPage,
            rows: () => Array.from(document.querySelectorAll("#holdingStocks .holding-row")),
        };


        //무한 스크롤
        function renderInfinite(state) {
            const rows = state.rows();
            rows.forEach((row, idx) => {
                row.style.display = (idx < state.loadedCount) ? "" : "none";
            });
        }

        //스크롤 끝까지 내려가면 다시 늘려주기
        function bindInfiniteScroll(scrollEl, state) {

            if (!scrollEl) {
                console.warn("스크롤 엘리먼트를 찾지 못함:", state);
                return;
            }

            const threshold = 40; // 바닥에서 40px 위쯤

            scrollEl.addEventListener("scroll", () => {
                const nearBottom = scrollEl.scrollTop + scrollEl.clientHeight >= scrollEl.scrollHeight - threshold;
                if (!nearBottom) return;

                const total = state.rows().length;
                if (state.loadedCount >= total) return;

                state.loadedCount = Math.min(total, state.loadedCount + countPerPage);
                renderInfinite(state);
            });
        }

        //로드된 양만큼 자동 리프레시 : codes 파라미터 selectedData로 보내기
        function getLoadedCodes(state, rowSelector) {
            const rows = state.rows().slice(0, state.loadedCount);
            return rows.map(r => r.getAttribute("data-code")).filter(Boolean);
        }


        //보유 종목 없을 경우 차트 메세지 토글
        function setChartEmptyState(isEmpty) {
            const message = document.getElementById("emptyChartMessage");
            const canvas = document.getElementById("holdingsChart");
            if (!message || !canvas) return;

            message.style.display = isEmpty ? "block" : "none";
            canvas.style.display = isEmpty ? "none" : "block";
        }

        let flag = false; //중복 호출 방지

        function initChart() {

            renderInfinite(holdingsState);

            bindInfiniteScroll(document.getElementById("holdingsScroll"), holdingsState);

            if (Array.isArray(chartDataFromServer) && chartDataFromServer.length > 0) {
                setChartEmptyState(false);
                DonutChart.renderOrUpdateDonut("holdingsChart", chartDataFromServer);
            } else {
                setChartEmptyState(true);
            }

            updateData();
            //페이지 자동 갱신(1분) 60*1000
            setInterval(updateData, 30 * 1000);
        }

        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', initChart);
        } else {
            initChart();
        }


        async function updateData() {

            //dom에 investMain의 데이터도 올라와 있으므로 my 탭 아닐때 제한하기
            const myJsp = document.getElementById('myJsp');
            if (!myJsp || !myJsp.classList.contains('active')) {
                return; //my탭이 아니면 updateData 함수 즉시 종료
            }

            if (flag) return;
            flag = true;
            try {

                const holdingCodes = getLoadedCodes(holdingsState).join(",");

                let url =
                    "${pageContext.request.contextPath}/stock/api/invest/selectedData"
                    + "?userSeq=" + userSeq //userSeq (세션 저장 완료시 변경)
                    + "&ts=" + Date.now(); // 캐시 방지용
                if (holdingCodes) {
                    url += "&holdingCodes=" + encodeURIComponent(holdingCodes);
                }

                const result = await fetch(url, {cache: "no-store"});
                if (!result.ok) throw new Error("HTTP " + result.status);
                const data = await result.json();

                //사용자 자산
                const assetData = data.userInvestSummeryData;
                const pctData = document.getElementById("totalReturnPct");

                if (assetData) {

                    if (pctData) {
                        //null 또는 undefined일 경우 0으로 처리
                        const pct = parseFloat(assetData.totalReturnPct) || 0;
                        pctData.classList.remove("positive", "negative");
                        if (pct > 0) {
                            pctData.classList.add("positive");
                        } else if (pct < 0) {
                            pctData.classList.add("negative");
                        }
                        pctData.textContent = (pct >= 0 ? "+" : "") + pct.toFixed(2) + "%";
                    }

                    //test
                    document.getElementById("test_time").textContent = new Date().toLocaleTimeString();
                }

                //차트 갱신 + 범례 갱신
                const newChartData = data.chartData || []; //chartData에 값이 없으면 빈 배열 사용
                setChartEmptyState(!newChartData || newChartData.length === 0); //없으면 없다고 텍스트 띄우기
                if (Array.isArray(newChartData)) {
                    //차트 갱신
                    const chartCanvas2 = document.getElementById("holdingsChart");
                    if (chartCanvas2 && newChartData.length > 0) {
                        DonutChart.renderOrUpdateDonut("holdingsChart", newChartData);
                    }

                    //범례 갱신 (DOM 다시 그리기)
                    const legend = document.getElementById("chartLegend");
                    if (legend) {
                        legend.innerHTML = "";
                        newChartData.forEach(it => {
                            const div = document.createElement("div");
                            div.className = "legend-item";
                            div.innerHTML =
                                '<div class="legend-color" style="background-color:' + (it.color || "#ccc") + ';"></div>'
                                + "<span>" + (it.stockName || "") + "</span>"
                                + "<span>" + (it.weightPct != null ? Number(it.weightPct).toFixed(2) : "-") + "%</span>";
                            legend.appendChild(div);
                        });
                    }
                }

                //보유종목(테이블) 갱신
                //portfolioAllocationItemList = 보유종목 리스트(REST가 주는 키)
                const portfolioList = data.portfolioAllocationItemList || [];
                if (Array.isArray(portfolioList)) {
                    portfolioList.forEach(item => {
                        const stockCode = item.stockCode;
                        //JSP에서 각 행에 data-code="005930" 이런 식으로 박혀있음
                        const row = document.querySelector('.holding-row[data-code="' + stockCode + '"]');
                        if (!row) {
                            console.warn("화면에 없는 보유종목(새로 생긴 듯):", stockCode);
                            return;
                        }

                        //현재가 갱신
                        const curEl = row.querySelector(".currentPriceData");
                        if (curEl && item.currentPrice != null) {
                            curEl.textContent = Number(item.currentPrice).toLocaleString("ko-KR");
                        }

                        //평가손익 갱신
                        const pnlEl = row.querySelector(".pnlData"); //row<tr>한줄 안에서 클래스가 pnlData인 요소의 HTMLElement(요소객체)
                        if (pnlEl) { //존재여부체크
                            //서버값주기
                            const pnl = (item.pnl == null) ? 0 : Number(item.pnl);

                            pnlEl.classList.remove("positive", "negative");
                            if (pnl > 0) {
                                pnlEl.classList.add("positive");
                            } else if (pnl < 0) {
                                pnlEl.classList.add("negative");
                            }
                            pnlEl.textContent = (pnl > 0 ? "+" : "") + Math.round(pnl).toLocaleString("ko-KR"); //trunc에서 round로 바꿈
                        }
                    });
                }

                //MVP / WORST를 portfolioList로 직접 계산
                const bestNameEl = document.getElementById("bestStockName");
                const bestPnlEl = document.getElementById("bestStockPnl");
                const worstNameEl = document.getElementById("worstStockName");
                const worstPnlEl = document.getElementById("worstStockPnl");
                const ps = document.getElementById("profitSummary");

                if (Array.isArray(portfolioList) && portfolioList.length > 0) {
                    //숨김 풀기 (초기 holdings 비었으면 display:none 박혀있어서 계속 안 보일 수 있음)
                    if (ps) {
                        ps.style.display = "grid";
                    }

                    let best = null, worst = null;

                    portfolioList.forEach(it => {
                        const pnl = Number(it.pnl);
                        const qty = Number(it.quantity);
                        const cur = Number(it.currentPrice);

                        if (!Number.isFinite(pnl)) {
                            return;
                        }

                        // ===== BEST: pnl 큰 순 -> quantity 큰 순 -> currentPrice 큰 순 =====
                        if (!best
                            || pnl > best.pnl
                            || (pnl === best.pnl && qty > best.qty)
                            || (pnl === best.pnl && qty === best.qty && cur > best.cur)
                        ) {
                            best = { name: it.stockName, pnl, qty, cur };
                        }

                        // ===== WORST: pnl 작은 순 -> quantity 큰 순 -> currentPrice 큰 순 =====
                        if (!worst
                            || pnl < worst.pnl
                            || (pnl === worst.pnl && qty > worst.qty)
                            || (pnl === worst.pnl && qty === worst.qty && cur > worst.cur)
                        ) {
                            worst = { name: it.stockName, pnl, qty, cur };
                        }
                    });

                    if (bestNameEl) {
                        bestNameEl.textContent = best?.name ?? "-";
                    }
                    if (worstNameEl) {
                        worstNameEl.textContent = worst?.name ?? "-";
                    }

                    if (bestPnlEl) {
                        const v = best?.pnl;
                        bestPnlEl.textContent = Number.isFinite(v)
                            ? (v >= 0 ? "+" : "") + Math.round(v).toLocaleString("ko-KR") + "원"
                            : "-";
                    }

                    if (worstPnlEl) {
                        const v = worst?.pnl;
                        worstPnlEl.textContent = Number.isFinite(v)
                            ? (v >= 0 ? "+" : "") + Math.round(v).toLocaleString("ko-KR") + "원"
                            : "-";
                    }
                } else {
                    //보유종목 없으면 숨김
                    if (ps) {
                        ps.style.display = "none";
                    }
                }

                renderInfinite(holdingsState);

                //마지막 갱신 표시
                const testEl = document.getElementById("test_time");
                if (testEl) testEl.textContent = new Date().toLocaleTimeString();

            } catch (error) {
                console.log("실패 : ", error);
            } finally {
                flag = false; //성공 실패 두 경우 다 해제
            }
        }
    })();
</script>