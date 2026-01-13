<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    window.onload = function() {
        const ctx = document.getElementById('myChart');

        if (ctx) {
            new Chart(ctx, {
                type: 'line',
                data: {

                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
                    datasets: [{
                        // 2. label을 datasets 안으로 이동
                        label: 'My First Dataset',
                        data: [65, 59, 80, 81, 56, 55, 40],
                        fill: true,
                        borderColor: 'rgb(0,67,192)',

                    }]
                },

            });
        }
    };
</script>
</body>
</html>