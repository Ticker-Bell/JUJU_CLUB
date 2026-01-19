function renderStockChart(elementId, rawData, periodCode) {
    //elementId: 차트 Id, rawData: API로 받은 데이터, periodCode: 차트 일/주/월 별
    const ctx = document.getElementById(elementId);
    if (!ctx) return null;

    const existingChart = Chart.getChart(elementId);
    if (existingChart) {
        existingChart.destroy();
    }

    const labels = rawData.map(item => item.date);
    const prices = rawData.map(item => item.price);

    return new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: '주식 현재가',
                data: prices,
                fill: true,
                backgroundColor: function(context) {
                    const {ctx, chartArea} = context.chart;
                    if (!chartArea) return null;
                    const gradient = ctx.createLinearGradient(0, chartArea.bottom, 0, chartArea.top);
                    gradient.addColorStop(0, 'rgba(191, 15, 6, 0.1)');
                    gradient.addColorStop(1, 'rgba(191, 15, 6, 0.8)');
                    return gradient;
                },
                borderColor: 'rgba(191, 15, 6, 0.8)',
                tension: 0.1,
                pointRadius: 0
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            layout: {
                padding: { right: 60, top: 20, bottom: 20 }
            },
            scales: {
                y: { position: 'right' },
                x: {
                    ticks: {
                        autoSkip: false,
                        callback: function (value, index) {
                            const fullDate = this.getLabelForValue(value);
                            if (!fullDate || !fullDate.includes('/')) return fullDate;
                            const parts = fullDate.split('/');
                            if (periodCode === 'D' || periodCode === 'W') {
                                if (index === 0) return [parts[0] + '월', parts[1]];
                                const prev = this.chart.data.labels[index - 1];
                                if (prev && prev.split('/')[0] !== parts[0]) return [parts[0] + '월', parts[1]];
                                return parts[1];
                            }
                            if (periodCode === 'M') {
                                if (index === 0) return [parts[0] + '년', parts[1] + '월'];
                                const prev = this.chart.data.labels[index - 1];
                                if (prev && prev.split('/')[0] !== parts[0]) return [parts[0] + '년', parts[1] + '월'];
                                return parts[1] + '월';
                            }
                            return fullDate;
                        }
                    }
                }
            }
        },
        plugins: [{
            id: 'lastPriceLabel',
            afterDraw: (chart) => {
                const { ctx, chartArea, scales: { y } } = chart;
                const dataset = chart.data.datasets[0].data;
                const lastValue = dataset[dataset.length - 1];

                if (lastValue === undefined || lastValue === null) return;

                const yCoor = y.getPixelForValue(lastValue);

                const boxWidth = 55;
                const boxHeight = 20;
                const padding = 6;

                //y축 안 가리도록 안쪽으로 이동
                const xPos = chartArea.right - boxWidth - padding;

                ctx.save();

                // 점선 가이드 라인
                ctx.beginPath();
                ctx.strokeStyle = 'rgba(191, 15, 6, 0.5)';
                ctx.setLineDash([3, 3]);
                ctx.moveTo(chartArea.left, yCoor);
                ctx.lineTo(chartArea.right, yCoor);
                ctx.stroke();

                ctx.setLineDash([]);

                // 가격 박스
                ctx.fillStyle = 'rgba(191, 15, 6, 1)';
                ctx.fillRect(xPos, yCoor - boxHeight / 2, boxWidth, boxHeight);

                // 텍스트
                ctx.fillStyle = 'white';
                ctx.font = 'bold 11px Arial';
                ctx.textAlign = 'center';
                ctx.textBaseline = 'middle';
                ctx.fillText(
                    lastValue.toLocaleString(),
                    xPos + boxWidth / 2,
                    yCoor
                );

                ctx.restore();
            }
        }]

    });
}