<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Stock Chart</title>
</head>
<body>
<div style="width: 800px; height: 400px;">
    <canvas id="myChart"></canvas>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/invest/stockSocket.js"></script>
<script>
    let myChart;
    //차트
    window.onload = function () {
        function getGradient(ctx, chartArea) {
            const chartWidth = chartArea.right - chartArea.left;
            const chartHeight = chartArea.bottom - chartArea.top;

            // 위(top)에서 아래(bottom)로 흐르는 그라데이션 생성
            const gradient = ctx.createLinearGradient(0, chartArea.bottom, 0, chartArea.top);

            // 아래쪽 (10% 투명도)
            gradient.addColorStop(0, 'rgba(191, 15, 6, 0.1)');
            // 위쪽 (80% 투명도)
            gradient.addColorStop(1, 'rgba(191, 15, 6, 0.8)');

            return gradient;
        }

        //rest api
        const chartData = [];
        <c:forEach var = "stock" items="${stockList}">
        chartData.push({
            date: "${stock.displayDate}",
            price: parseFloat("${stock.displayPrice}".replace(/,/g, ''))
        });
        </c:forEach>

        const labels = chartData.map(item => item.date);
        const prices = chartData.map(item => item.price);

        prices.pop();
        prices.push(null);

        const ctx = document.getElementById('myChart');
        if (ctx) {
            // 차트를 변수에 할당하여 나중에 접근 가능하게 함
            myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels, // 실시간 데이터를 위해 빈 배열로 시작하거나 초기값 사용
                    datasets: [{
                        label: '주식 현재가',
                        data: prices,
                        fill: true,
                        backgroundColor: function (context) {

                            const chart = context.chart;

                            const {ctx, chartArea} = chart;


                            if (!chartArea) {

// 차트가 처음 렌더링될 때 chartArea가 없을 수 있음

                                return null;

                            }

                            return getGradient(ctx, chartArea);

                        },
                        borderColor: 'rgba(191, 15, 6, 0.8)',
                        tension: 0.1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        x: {
                            ticks: {
                                y: {
                                    beginAtZero: false // 주가는 0부터 시작하지 않는 게 보기 좋습니다
                                }

                            }
                        }
                    }
                }
            });
            initSocket(myChart);
        }
    }

    //websocket api
    function initSocket(targetChart) {
        StockSocket.connect(
            "${pageContext.request.contextPath}",
            ["005930"],
            function (stockData) {
                const dataArray = targetChart.data.datasets[0].data;
                const lastIdx = dataArray.length - 1;

                dataArray[lastIdx] = stockData.currentPrice;

                targetChart.update('none');
            }
        );
    }
</script>
</body>
</html>