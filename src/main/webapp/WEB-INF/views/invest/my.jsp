<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JUJU CLUB</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', -apple-system, BlinkMacSystemFont, sans-serif;
            background-color: #f5f5f5;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* 탭 네비게이션 */
        .tab-nav {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
            border-bottom: 2px solid #e0e0e0;
            padding-bottom: 10px;
        }

        .tab-nav a {
            text-decoration: none;
            color: #999;
            font-size: 18px;
            font-weight: 500;
            padding-bottom: 10px;
            position: relative;
        }

        .tab-nav a.active {
            color: #0046ff;
            font-weight: 800;
        }

        .tab-nav a.active::after {
            content: '';
            position: absolute;
            bottom: -12px;
            left: 0;
            width: 100%;
            height: 3px;
            background-color: #ffc107;
        }

        /* 단위 */
        /*.unit {*/
        /*    font-size: 16px;*/
        /*    font-weight: 500;*/
        /*    color: #777;*/
        /*    margin-left: 4px;*/
        /*}*/

        /* ===== SUMMARY WRAPPER (전체 큰 박스) ===== */
        .summary-wrapper {
            background: #fff;
            border: 1px solid #e8e8e8;
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 20px;
        }

        /* 왼쪽(총평가자산 텍스트 영역) + 오른쪽(3카드) */
        .summary-cards {
            display: grid;
            grid-template-columns: 1.2fr 2.8fr; /* 예시처럼 오른쪽이 더 넓게 */
            gap: 24px;
            align-items: stretch;
        }

        /* 왼쪽 총평가자산은 "박스 없음" */
        .summary-left {
            display: flex;
            align-items: flex-start;
        }

        /* 총평가자산 텍스트 블록 */
        .summary-total {
            width: 100%;
            padding: 6px 0; /* 살짝만 여백 */
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
        }

        /* 단위 */
        .unit {
            margin-left: 0; /* gap으로 spacing 주기 */
            padding: 0; /* 혹시 들어가있다면 제거 */
            line-height: 1; /* 높이 딱 맞추기 */
            display: inline; /* 박스화 방지 */
            font-size: 18px;
            font-weight: 600;
            color: #777;
        }

        /* ===== RIGHT: 작은 카드 3개 ===== */
        .summary-right {
            display: grid !important;
            gap: 16px !important;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)) !important;
        }

        /* 작은 카드 공통 */
        .summary-right .summary-card {
            background: #fff;
            border: 1px solid #ededed;
            border-radius: 14px;
            padding: 18px;
            height: 100%;
        }

        /* 작은 카드 텍스트(예시처럼 좌측정렬) */
        .summary-right .summary-card .label {
            font-size: 13px;
            font-weight: 600;
            color: #666;
            margin-bottom: 12px;
        }

        .summary-right .summary-card .value {
            font-size: 24px;
            font-weight: 800;
            color: #333;
        }

        /* 수익률 색상 */
        .summary-right .summary-card .value.positive {
            color: #e53935;
        }

        .summary-right .summary-card .value.negative {
            color: #1e88e5;
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 1100px) {
            .summary-cards {
                grid-template-columns: 1fr;
            }

            .summary-right {
                grid-template-columns: repeat(3, 1fr);
            }

            .summary-total-value {
                font-size: 44px;
            }
        }

        @media (max-width: 700px) {
            .summary-right {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 480px) {
            .summary-right {
                grid-template-columns: 1fr;
            }

            .summary-total-value {
                font-size: 38px;
            }
        }

        /* =========================
           DASHBOARD (보유리스트 / 차트+관심)
           ========================= */

        .dashboard {
            display: grid;
            grid-template-columns: 3fr 1fr;
            gap: 20px;
            align-items: start;
            grid-template-rows: auto auto; /* 2행 */

            grid-template-areas:
                "hold chart"
                "hold watch";
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
        }

        .watch-card {
            grid-area: watch;
        }

        @media (max-width: 992px) {
            .dashboard {
                grid-template-columns: 1fr;
                grid-template-rows: auto auto auto;
                grid-template-areas:
                  "hold"
                  "chart"
                  "watch";
            }
        }

        /* 카드 공통 */
        .card {
            background: #fff;
            border-radius: 12px;
            padding: 25px;
        }

        .card-title {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 20px;
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
            background: #fafafa;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        /* 차트 범례 */
        .chart-legend {
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap;
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
        }

        .holdings-table th {
            text-align: left;
            padding: 12px 8px;
            font-size: 13px;
            font-weight: 500;
            color: #999;
            border-bottom: 1px solid #e0e0e0;
        }

        .holdings-table td {
            padding: 15px 8px;
            font-size: 14px;
            border-bottom: 1px solid #f0f0f0;
        }

        .holdings-table .stock-name-cell .name {
            font-weight: 500;
        }

        .holdings-table .stock-name-cell .code {
            font-size: 12px;
            color: #999;
            margin-top: 2px;
        }

        .holdings-table .profit.positive {
            color: #e53935;
        }

        .holdings-table .profit.negative {
            color: #1e88e5;
        }

        .holdings-scroll {
            flex: 1;
            overflow-y: auto;
            min-height: 0;
            padding-right: 14px; /* 스크롤바 여유 */
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

        /*스크롤*/
        .watchlist-scroll {
            max-height: calc(60px * 5); /* 5개 높이 */
            overflow-y: auto;
            padding-right: 14px; /* 스크롤바랑 내용 간격 */
            scrollbar-gutter: stable; /* 가능 브라우저에서 레이아웃 흔들림 방지 */
        }

    </style>
</head>
<body>
<div class="container">
    <!-- 탭 네비게이션 -->
<%--    <nav class="tab-nav">--%>
<%--        <a href="${pageContext.request.contextPath}/invest/my" class="active">마이</a>--%>
<%--        <a href="${pageContext.request.contextPath}/invest/main.do">투자</a>--%>
<%--    </nav>--%>

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
                    <div class="label">보유 현금</div>
                    <div class="value">
                        <span id="cashBalance">
                        <fmt:formatNumber value="${userAsset.cashBalance}" pattern="#,###"/>
                        </span>
                        <span class="unit">원</span>
                    </div>
                </div>

                <div class="summary-card">
                    <div class="label">투자금</div>
                    <div class="value ">
                        <span id="totalStockValue">
                        <fmt:formatNumber value="${userAsset.totalStockValue}" pattern="#,###"/>
                        </span>
                        <span class="unit">원</span>
                    </div>
                </div>

                <div class="summary-card">
                    <div class="label">총 수익률</div>
                    <div id="totalReturnPct" class="value ${userAsset.totalReturnPct >= 0 ? 'positive' : 'negative'}">
                        <c:if test="${userAsset.totalReturnPct >= 0}">+</c:if>
                        <fmt:formatNumber value="${userAsset.totalReturnPct}" pattern="#,##0.0"/>%
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- 메인 콘텐츠 (재배치된 대시보드) -->
    <div class="dashboard">

        <!-- LEFT: 메인(넓게) - 보유 종목 리스트 -->
        <!-- 보유 종목 리스트 -->
        <div class="card holdings-card">
            <h3 class="card-title">보유 종목 리스트</h3>
            마지막 갱신: <span id="test">-</span>
            <c:choose>
                <c:when test="${not empty holdings}">
                    <div class="holdings-scroll">
                        <table class="holdings-table">
                            <thead>
                            <tr>
                                <th>종목</th>
                                <th class="text-right">보유주(주)</th>
                                <th class="text-right">평균단가(원)</th>
                                <th class="text-right">현재가(원)</th>
                                <th class="text-right">평가손익(원)</th>
                            </tr>
                            </thead>
                            <tbody>
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
                                    <td class="text-right profit ${holding.pnl >= 0 ? 'positive' : 'negative'} pnlData">
                                        <c:if test="${holding.pnl >= 0}">+</c:if>
                                        <fmt:formatNumber value="${holding.pnl}" pattern="#,###"/>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
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
            <h3 class="card-title">보유 종목 차트</h3>

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
                        <span><fmt:formatNumber value="${item.weightPct}" pattern="#,##0"/>%</span>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- 관심 종목 리스트 -->
        <div class="card watch-card">
            <h3 class="card-title">관심 종목 리스트</h3>
            <c:choose>
                <c:when test="${not empty watchlist}">
                    <div class="watchlist-scroll">
                        <c:forEach var="stock" items="${watchlist}">
                            <fmt:parseNumber var="changePct" value="${stock.changePct}" type="number"/>
                            <div class="watchlist-item watch-row" data-code="${stock.stockCode}">
                                <div class="stock-info">
                                    <div class="stock-name">${stock.stockName}</div>
                                    <div class="stock-code">${stock.stockCode}</div>
                                </div>
                                <div class="stock-price">
                                    <div class="price currentPriceValue">
                                        <fmt:formatNumber value="${stock.currentPrice}"
                                                          pattern="#,###"/>
                                    </div>
                                    <div class="change ${changePct >= 0 ? 'positive' : 'negative'} pctValue">
                                        <c:if test="${changePct >= 0}">+</c:if>
                                        <fmt:formatNumber value="${changePct}" pattern="#,##0.0"/>%
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">관심 종목이 없습니다🥲</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</div>

<!-- Chart.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/invest/portfolioDonutChart.js"></script>
<script>
    //보유 종목 없을 경우 차트 메세지 토글
    function setChartEmptyState(isEmpty) {
        const message = document.getElementById("emptyChartMessage");
        const canvas = document.getElementById("holdingsChart");
        if (!message || !canvas) return;

        message.style.display = isEmpty ? "block" : "none";
        canvas.style.display = isEmpty ? "none" : "block";
    }


    //서버에서 전달받은 차트 데이터 : StockMyController에서 전달하는 JSON(chartDataJson)
    const chartDataFromServer = ${empty chartDataJson ? "[]" : chartDataJson};

    //Chart.js 도넛 차트 초기화
    document.addEventListener('DOMContentLoaded', function () {
        const chartCanvas = document.getElementById("holdingsChart");
        //데이터 없다고 표시해주기
        setChartEmptyState(!chartDataFromServer || chartDataFromServer.length === 0);
        //데이터 있으면 차트 표시
        if (chartCanvas && Array.isArray(chartDataFromServer) && chartDataFromServer.length > 0) {
            DonutChart.renderOrUpdateDonut("holdingsChart", chartDataFromServer);
        }
        console.log("페이지 준비 완료!");

        updateData();
        //페이지 자동 갱신(1분) 60*1000
        setInterval(updateData, 30 * 1000);
    });

    //1분마다 데이터 자동 갱신 AJAX
    //1)fetch(url) 서버에 데이터 요청
    //2)data=await result.json() json을 js객체로 변환
    //3)setInterval() 1분마다 updateData() 실행

    let flag = false; //중복 호출 방지
    const userSeq = 1; //userSeq (세션 저장 완료시 변경) <%--${sessionScope.userSeq}--%>

    async function updateData() {
        if (flag) return;
        flag = true;
        try {
            const url =
                "${pageContext.request.contextPath}/stock/api/invest/selectedData"
                + "?userSeq=" + userSeq //userSeq (세션 저장 완료시 변경)
                + "&ts=" + Date.now(); // 캐시 방지용

            const result = await fetch(url, {cache: "no-store"});
            if (!result.ok) throw new Error("HTTP " + result.status);
            const data = await result.json();

            console.log("받아온 데이터 : ", data);
            console.log("portfolio 보유종목 리스트:", data.portfolioAllocationItemList);
            console.log(data.portfolioAllocationItemList?.[0]);
            console.log("chartData 보유종목:", data.chartData);
            console.log("보유종목 개수:", data.chartData?.length);
            console.log("현재가 샘플:", data.portfolioAllocationItemList?.map(x => [x.stockCode, x.currentPrice]));

            //사용자 자산
            const assetData = data.userInvestSummeryData;
            if (assetData) {
                document.getElementById("totalAsset").textContent = Number(assetData.totalAsset).toLocaleString("ko-KR");
                document.getElementById("cashBalance").textContent = Number(assetData.cashBalance).toLocaleString("ko-KR");
                document.getElementById("totalStockValue").textContent = Number(assetData.totalStockValue).toLocaleString("ko-KR");
                const pct = Number(assetData.totalReturnPct);
                const pctData = document.getElementById("totalReturnPct");
                if (pctData && !Number.isNaN(pct)) {
                    pctData.classList.remove("positive", "negative");
                    pctData.classList.add(pct >= 0 ? "positive" : "negative");
                    pctData.textContent = (pct >= 0 ? "+" : "") + pct.toFixed(1) + "%";
                }

                //test
                document.getElementById("test").textContent = new Date().toLocaleTimeString();
            }
            //관심종목
            const watchlist = data.watchlistItemList;
            if (Array.isArray(watchlist)) {
                watchlist.forEach(item => {
                    const code = item.stockCode;
                    const row = document.querySelector('.watch-row[data-code="' + code + '"]');
                    if (!row) return;

                    //현재가
                    const curData = row.querySelector(".currentPriceValue");
                    if (curData != null && item.currentPrice != null) {
                        curData.textContent = Number(item.currentPrice).toLocaleString("ko-KR");
                    }

                    //등락률
                    const pctData = row.querySelector(".pctValue");
                    if (pctData != null && item.changePct != null) {
                        const cp = Number(item.changePct);
                        pctData.classList.remove("positive", "negative");
                        pctData.classList.add(cp >= 0 ? "positive" : "negative");
                        pctData.textContent = (cp >= 0 ? "+" : "") + cp.toFixed(1) + "%";
                    }
                });
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
                            + "<span>" + (it.weightPct != null ? Number(it.weightPct).toFixed(0) : "-") + "%</span>";
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
                        pnlEl.classList.add(pnl >= 0 ? "positive" : "negative");
                        pnlEl.textContent = (pnl >= 0 ? "+" : "") + Math.trunc(pnl).toLocaleString("ko-KR");
                    }
                });
            }

            //마지막 갱신 표시
            const testEl = document.getElementById("test");
            if (testEl) testEl.textContent = new Date().toLocaleTimeString();

        } catch (error) {
            console.log("실패 : ", error);
        } finally {
            flag = false; //성공 실패 두 경우 다 해제
        }
    }
</script>
</body>
</html>
