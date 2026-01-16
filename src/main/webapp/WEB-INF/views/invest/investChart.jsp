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
<script>
    let myChart;
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
        }
    }
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script>
    const socket = new SockJS("${pageContext.request.contextPath}/ws-jujuclub");
    const stompClient = Stomp.over(socket);

    stompClient.connect({}, function (frame) {
        console.log('connected' + frame);
        const targetStock = "005930";
        stompClient.subscribe('/topic/stock/' + targetStock, function (response) {
            const stockData = JSON.parse(response.body);
            console.log("받은 데이터: ", stockData);
            if (myChart.data.datasets[0].data.length > 0) {
                myChart.data.datasets[0].data[myChart.data.datasets[0].data.length - 1] = stockData.currentPrice;
            }

            myChart.update();
        });
        const initialRequest = {
            stockCode: targetStock
        };

        stompClient.send("/app/invest/request/chartData", {}, JSON.stringify(initialRequest));
        console.log("기본종목 요청 보냄");
    }, function (error) {
        console.log("websocket연결 실패: ", error);
    });
</script>
</body>
</html>