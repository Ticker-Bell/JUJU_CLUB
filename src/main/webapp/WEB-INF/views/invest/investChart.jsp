<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Stock Chart</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <style>
        .btn-active {
            background-color: #bf0f06;
            color: white;
            border-color: #bf0f06;
            font-weight: 700;
        }

        .period-btn {
            background-color: white;
            color: #4b5563; /* gray-600 */
            border-color: #d1d5db; /* gray-300 */
            font-weight: 500;
        }

        .period-btn.btn-active {
            background-color: #bf0f06;
            color: white;
            border-color: #bf0f06;
            font-weight: 700;
        }

    </style>

</head>
<body>
<div class="flex flex-col gap-4">
    <div class="p-6 border-bottom border-gray-100 stock-info-header">
        <div class="flex items-baseline gap-4">
            <h2 id="header-stockName" class="text-gray-500 text-lg font-medium">기업</h2>
            <span id="header-stock" class="text-3xl font-extrabold tracking-tight text-gray-900">000000</span>
        </div>
    </div>
    <div class="p-6 border-bottom border-gray-100 stock-info-header">
        <div class="flex items-baseline gap-4">
            <h2 id="header-price" class="text-3xl font-extrabold tracking-tight text-gray-900">0원</h2>
            <div class="change-info">
                <span id="header-change" class="text-lg font-semibold">0</span>
            </div>
        </div>
    </div>


</div>
<div id="button-group" class="flex justify-end gap-2 p-4 bg-gray-50/50 border-y border-gray-100 period-buttons">
    <button id="btn-D" onclick="loadChartData('D')"
            class="period-btn px-4 py-1.5 rounded-full border text-sm transition-all duration-200 shadow-sm">
        일별
    </button>

    <button id="btn-W" onclick="loadChartData('W')"
            class="period-btn px-4 py-1.5 rounded-full border text-sm transition-all duration-200 shadow-sm">
        주별
    </button>

    <button id="btn-M" onclick="loadChartData('M')"
            class="period-btn px-4 py-1.5 rounded-full border text-sm transition-all duration-200 shadow-sm">
        월별
    </button>

</div>
<div class="p-4 h-[400px]">
    <canvas id="myChart"></canvas>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/invest/stockLineChart.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/invest/stockSocket.js"></script>

<script>
    let myChartInstance;
    let currentPeriod = 'D';
    let selectedStockState = {
        stockCode: null,
        stockName: null
    };

    window.onload = function () {
        updateButtonUI('D');
    };

    function getSelectedChart(stockCode, stockName) {
        selectedStockState.stockName = stockName;
        selectedStockState.stockCode = stockCode;

        document.getElementById('header-stockName').innerText = stockName;
        document.getElementById('header-stock').innerText = stockCode;

        const url = `invest/chart/selectedStockInfo?stockCode=${stockCode}&stockName=${stockName}`;

        $.ajax({
            url: url,
            type: 'GET',
            success: function () {
                updateButtonUI('D');
                loadChartData('D', selectedStockState.stockCode);

            }
        });

    }


    function loadChartData(periodCode, stockCode) {
        currentPeriod = periodCode;
        updateButtonUI(periodCode);

        //rest api 연결
        const url = `${pageContext.request.contextPath}/api/invest/chartData?periodCode=${periodCode}&stockCode=${stockCode}`;

        fetch(url)
            .then(response => response.json())
            .then(data => {
                const formattedData = data.map(item => ({
                    date: item.displayDate,
                    price: parseFloat(item.displayPrice.replace(/,/g, ''))
                }));
                if (myChartInstance) {
                    myChartInstance.destroy();
                }
                myChartInstance = renderStockChart('myChart', formattedData, periodCode);

                if (periodCode === 'D') {
                    initSocket(myChartInstance, [stockCode]); //배열 형태의 stockCode가 들어가야함
                }
                updateButtonUI(periodCode);
            })
            .catch(error => console.error('Error fetching chart data:', error));
    }

    function updateButtonUI(periodCode) {
        const buttons = document.querySelectorAll('.period-btn');

        buttons.forEach(btn => btn.classList.remove('btn-active'));

        const activeBtn = document.getElementById('btn-' + periodCode);
        if (activeBtn) {
            activeBtn.classList.add('btn-active');
        }
    }


    function updateHeaderInfo(stock) {
        if (!stock) return;
        const priceEl = document.getElementById('header-price');
        const changeEl = document.getElementById('header-change');


        if (stock.displayPrice) priceEl.innerText = stock.displayPrice + "원";
        if (stock.displayChange) changeEl.innerText = stock.displayChange;


        const sign = stock.dayOverDaySign;
        let color = "#666"; // 보합
        if (sign === "1" || sign === "2") color = "#bf0f06"; // 빨강
        if (sign === "4" || sign === "5") color = "#0051af"; // 파랑

        changeEl.style.color = color;
    }

    function initSocket(targetChart, stockCodes) {
        //웹소켓 연결
        StockSocket.connect(
            "${pageContext.request.contextPath}",
            stockCodes,
            function (stockData) {
                const dataArray = targetChart.data.datasets[0].data;
                const lastIdx = dataArray.length - 1;

                dataArray[lastIdx] = stockData.currentPrice;
                updateHeaderInfo(stockData);
                targetChart.update('none');

            }
        );
    }
</script>
</body>
</html>