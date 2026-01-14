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
            time: "${stock.displayTime}",
            price: "${stock.currentPrice}"
        });
        </c:forEach>
    chartData.sort((a,b)=>{
        return a.time.localeCompare(b.time);
    });
    const labels = chartData.map(item=>item.time);
    const prices = chartData.map(item=>item.price);

        const ctx = document.getElementById('myChart');

        if (ctx) {
            new Chart(ctx, {
                type: 'line',
                data: {

                    labels: labels,
                    datasets: [{
                        // 2. label을 datasets 안으로 이동
                        label: '주식 현재가',
                        data: prices,
                        fill: true, // 배경을 채움
                        backgroundColor: function(context) {
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
</body>
</html>