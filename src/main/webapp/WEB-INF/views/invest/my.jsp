<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모의투자 - 마이 탭 페이지</title>
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

        /* 총 평가자산 카드 */
        .total-asset-card {
            background: #fff;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 20px;
            border: 2px solid #0046ff;
        }

        .total-asset-card .label {
            font-size: 14px;
            color: #666;
            margin-bottom: 10px;
        }

        .total-asset-card .amount {
            font-size: 48px;
            font-weight: 700;
            color: #333;
        }

        .total-asset-card .amount .unit {
            font-size: 20px;
            font-weight: 400;
            color: #666;
        }

        /* 상단 요약 카드 그룹 */
        .summary-cards {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .summary-card {
            background: #fff;
            border-radius: 12px;
            padding: 20px 25px;
        }

        .summary-card.highlight {
            border: 2px solid #0046ff;
            grid-column: span 1;
        }

        .summary-card .label {
            font-size: 13px;
            color: #666;
            margin-bottom: 8px;
        }

        .summary-card .value {
            font-size: 24px;
            font-weight: 600;
        }

        .summary-card .value.positive {
            color: #e53935;
        }

        .summary-card .value.negative {
            color: #1e88e5;
        }

        /* 메인 콘텐츠 영역 */
        .main-content {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 20px;
        }

        /* 좌측 영역 */
        .left-section {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* 카드 공통 스타일 */
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

        .chart-placeholder {
            color: #999;
            font-size: 14px;
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

        /* 빈 상태 메시지 */
        .empty-state {
            text-align: center;
            padding: 40px;
            color: #999;
        }

        /* 숫자 포맷팅 */
        .text-right {
            text-align: right;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 탭 네비게이션 -->
    <nav class="tab-nav">
        <a href="${pageContext.request.contextPath}/invest/my" class="active">마이</a>
        <a href="#">투자</a>
    </nav>

    <!-- 상단 요약 카드 -->
    <div class="summary-cards">
        <!-- 총 평가자산 -->
        <div class="summary-card highlight">
            <div class="label">총 평가자산</div>
            <div class="value">
                <fmt:formatNumber value="${userAsset.totalAsset}" pattern="#,###"/>
                <span class="unit">원</span>
            </div>
        </div>

        <!-- 보유 현금 -->
        <div class="summary-card">
            <div class="label">보유 현금</div>
            <div class="value">
                <fmt:formatNumber value="${userAsset.cashBalance}" pattern="#,###"/>
                <span class="unit">원</span>
            </div>
        </div>

        <!-- 투자금 -->
        <div class="summary-card">
            <div class="label">투자금</div>
            <div class="value">
                <fmt:formatNumber value="${userAsset.totalStockValue}" pattern="#,###"/>
                <span class="unit">원</span>
            </div>
        </div>

        <!-- 총 수익률 -->
        <div class="summary-card">
            <div class="label">총 수익률</div>
            <div class="value ${userAsset.totalReturnPct >= 0 ? 'positive' : 'negative'}">
                <c:if test="${userAsset.totalReturnPct >= 0}">+</c:if>
                <fmt:formatNumber value="${userAsset.totalReturnPct}" pattern="#,##0.0"/>%
            </div>
        </div>
    </div>

    <!-- 메인 콘텐츠 -->
    <div class="main-content">
        <!-- 좌측 영역 -->
        <div class="left-section">
            <!-- 관심 종목 리스트 -->
            <div class="card">
                <h3 class="card-title">관심 종목 리스트</h3>
                <c:choose>
                    <c:when test="${not empty watchlist}">
                        <c:forEach var="stock" items="${watchlist}">
                            <fmt:parseNumber var="changePct" value="${stock.changePct}" type="number" />
                            <div class="watchlist-item">
                                <div class="stock-info">
                                    <div class="stock-name">${stock.stockName}</div>
                                    <div class="stock-code">${stock.stockCode}</div>
                                </div>
                                <div class="stock-price">
                                    <div class="price">
                                        <fmt:formatNumber value="${stock.currentPrice}" pattern="#,###"/>
                                    </div>
                                    <div class="change ${changePct >= 0 ? 'positive' : 'negative'}">
                                        <c:if test="${changePct >= 0}">+</c:if>
                                        <fmt:formatNumber value="${changePct}" pattern="#,##0.0"/>%
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            관심 종목이 없습니다🥲
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 보유 종목 차트 -->
            <div class="card">
                <h3 class="card-title">보유 종목 차트</h3>

                <!-- Chart.js 캔버스 -->
                <div class="chart-container">
                    <c:choose>
                        <c:when test="${empty holdings}">
                            <div class="empty-chart-message">
                                <div class="icon">📈</div>
                                <div class="message">보유 종목이 없습니다</div>
                                <div class="sub-message">주식을 매수하면 차트가 표시됩니다</div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <canvas id="holdingsChart"></canvas>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 차트 범례 (동적 생성용) -->
                <div class="chart-legend" id="chartLegend">
                    <!-- Chart.js에서 동적으로 생성하거나, 아래처럼 서버에서 받아올 수 있음 -->
                    <c:forEach var="item" items="${chartData}">
                        <div class="legend-item">
                            <div class="legend-color" style="background-color: ${item.color};"></div>
                            <span>${item.stockName}</span>
                            <span><fmt:formatNumber value="${item.weightPct}" pattern="#,##0"/>%</span>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- 우측 영역: 보유 종목 리스트 -->
        <div class="card">
            <h3 class="card-title">보유 종목 리스트</h3>

            <c:choose>
                <c:when test="${not empty holdings}">
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
                            <tr>
                                <td class="stock-name-cell">
                                    <div class="name">${holding.stockName}</div>
                                    <div class="code">${holding.stockCode}</div>
                                </td>
                                <td class="text-right">
                                    <fmt:formatNumber value="${holding.quantity}" pattern="#,###"/>
                                </td>
                                <td class="text-right">
                                    <fmt:formatNumber value="${holding.avgPrice}" pattern="#,###"/>
                                </td>
                                <td class="text-right">
                                    <fmt:formatNumber value="${holding.currentPrice}" pattern="#,###"/>
                                </td>
                                <td class="text-right profit ${holding.pnl >= 0 ? 'positive' : 'negative'}">
                                    <c:if test="${holding.pnl >= 0}">+</c:if>
                                    <fmt:formatNumber value="${holding.pnl}" pattern="#,###"/>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        보유 종목이 없습니다🥲
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- Chart.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/invest/portfolioDonutChart.js"></script>
<script>
    //서버에서 전달받은 차트 데이터 : StockMyController에서 전달하는 JSON(chartDataJson)
    const chartDataFromServer = ${not empty chartDataJson ? chartDataJson : '[]'};

    //Chart.js 도넛 차트 초기화
    document.addEventListener('DOMContentLoaded', function() {
        DonutChart.renderOrUpdateDonut('holdingsChart', chartDataFromServer);//canvas id
    });
</script>
</body>
</html>
