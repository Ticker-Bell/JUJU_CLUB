(function (global) { //즉시실행함수
    "use strict";

    function renderOrUpdateDonut(canvasId, chartData) {
        /**
         * 도넛차트 렌더/갱신
         * @param {string} canvasId - canvas id
         * @param {Array|String} chartData - [{label, percentage, color}, ...] 또는 JSON 문자열
         * @returns {Chart|null}
         */
            //캔버스가 없다면
        const canvas = document.getElementById(canvasId);
        if (!canvas) {
            console.warn("[DonutChart] canvas not found:", canvasId);
            return null;
        }
        //라이브러리 없을 때
        if (!global.Chart) {
            console.error("[DonutChart] Chart.js is not loaded.");
            return null;
        }

        //chartData 문자열이면 JSON 파싱, 아니면 빈 배열로 초기화
        let items = chartData;
        if (typeof items === "string") {
            try { items = JSON.parse(items); } catch (e) { items = []; }
        }
        if (!Array.isArray(items)) items = [];

        //데이터가 없는데 기존 차트가 있으면 제거하고 종료
        if (items.length === 0) {
            if (canvas.__donutChart__) {
                canvas.__donutChart__.destroy();
                canvas.__donutChart__ = null;
            }
            return null;
        }

        const labels = items.map(x => x.stockName);
        const data = items.map(x => Number(x.weightPct) || 0);
        const colors = items.map(x => x.color);

        //기존 차트가 있으면 update
        if (canvas.__donutChart__) {
            const chart = canvas.__donutChart__;
            chart.data.labels = labels;
            chart.data.datasets[0].data = data;
            chart.data.datasets[0].backgroundColor = colors;
            chart.update();
            return chart;
        }
        //없으면 new
        const chart = new global.Chart(canvas, {
            type: "doughnut",
            data: {
                labels: labels,
                datasets: [{
                    data: data,
                    backgroundColor: colors,
                    borderWidth: 0,
                    hoverOffset: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: "60%",
                plugins: {
                    legend: { display: false }, // JSP 커스텀 범례 사용
                    tooltip: {
                        callbacks: {
                            label: (ctx) => `${ctx.label}: ${ctx.parsed}%`
                        }
                    }
                }
            }
        });
        //업데이트 위해 임시저장
        canvas.__donutChart__ = chart;
        return chart;
    }

    global.DonutChart = { renderOrUpdateDonut };
})(window); //외부에서 사용할 수 있게 노출시켜주기
