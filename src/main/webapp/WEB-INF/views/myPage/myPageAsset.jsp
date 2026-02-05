<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- [Part 1] 총 자산 (최종 코드 상태 유지) --%>
<div id="totalAssetPartial" class="contents">

  <div class="flex items-center gap-0.5">
    <p id="totalAssetValue"
       class="text-lg font-bold text-slate-800 tracking-tight whitespace-nowrap"
       data-value="${not empty userAsset ? userAsset.totalAsset : 0}">
      0
    </p>
    <span class="text-lg font-bold text-slate-800">원</span>
  </div>

  <c:if test="${not empty userAsset and userAsset.totalReturnPct < 0}">
    <span class="text-xs font-bold text-blue-500 flex items-center whitespace-nowrap ml-1.5">
            <i data-lucide="trending-down" class="w-2.5 h-2.5 mr-0.5"></i>
            <fmt:formatNumber value="${userAsset.totalReturnPct}" pattern="#,##0.1"/>%
        </span>
  </c:if>

  <script>
    (function() {
      if(window.lucide) lucide.createIcons();
      const el = document.getElementById('totalAssetValue');
      if(el) {
        const target = parseInt(el.getAttribute('data-value')) || 0;
        const duration = 1500;
        const start = 0;
        let startTime = null;

        function animate(currentTime) {
          if (!startTime) startTime = currentTime;
          const progress = Math.min((currentTime - startTime) / duration, 1);
          const ease = progress === 1 ? 1 : 1 - Math.pow(2, -10 * progress);
          const currentVal = Math.floor(start + (target - start) * ease);
          el.innerText = currentVal.toLocaleString();
          if (progress < 1) requestAnimationFrame(animate);
          else el.innerText = target.toLocaleString();
        }
        requestAnimationFrame(animate);
      }
    })();
  </script>
</div>

<%-- [Part 2] 차트 영역 --%>
<div id="portfolioPartial" class="w-full h-full">
  <div class="flex-1 min-h-0 flex items-center justify-center h-full">

    <%-- [구조 복구] Turn 17의 레이아웃 (gap-3, -translate-x-7) --%>
    <div class="w-full max-w-[550px] h-full flex items-stretch gap-3 -translate-x-7">

      <div class="flex-1 min-h-0">
        <canvas id="stockChart" class="w-full h-full"></canvas>
      </div>

      <div class="w-[180px] shrink-0 flex flex-col self-center gap-2">
        <h4 class="text-xs font-bold text-gray-500 text-left pl-1">보유 주식 비율</h4>

        <%-- [구조 복구] Turn 17의 스크롤 방식 (기본 overflow-y-auto, 인라인 max-height) --%>
        <div class="w-full overflow-y-auto pr-1 pl-1"
             id="stockLegend"
             style="scrollbar-gutter: stable; max-height: 170px;"></div>
      </div>

    </div>
  </div>
  <script>
    (function() {
      var rawData = ${not empty chartDataJson ? chartDataJson : '[]'};

      // [색상 유지] 마음에 들어하셨던 Modern Cool Theme 컬러셋
      var colorPalette = [
        '#5E45EB', // Main Indigo
        '#38BDF8', // Sky Blue
        '#C084FC', // Bright Purple
        '#2DD4BF', // Teal
        '#FB7185', // Rose
        '#818CF8', // Soft Indigo
        '#60A5FA'  // Soft Blue
      ];

      if (window.__stockChartInstance) {
        window.__stockChartInstance.destroy();
        window.__stockChartInstance = null;
      }

      var ctx = document.getElementById('stockChart').getContext('2d');
      var legendEl = document.getElementById('stockLegend');

      function ellipsize(str, max) {
        if (!str) return '';
        return str.length > max ? (str.slice(0, max) + '…') : str;
      }

      function normalizeAndSort(items) {
        var arr = Array.isArray(items) ? items.slice() : [];
        arr.sort(function(a, b) {
          var pa = Number(a.weightPct ?? 0);
          var pb = Number(b.weightPct ?? 0);
          return pb - pa;
        });
        return arr;
      }

      function renderHtmlLegend(legendEl, fullLabels, shortLabels, colors, data) {
        if (!legendEl) return;
        legendEl.innerHTML = "";
        var ul = document.createElement("ul");
        ul.className = "space-y-2";
        for (var i = 0; i < fullLabels.length; i++) {
          var li = document.createElement("li");
          li.className = "flex items-center gap-2";

          var dot = document.createElement("span");
          dot.className = "inline-block w-2.5 h-2.5 rounded-full shrink-0";

          // [색상 적용]
          var color = colors[i % colors.length];
          dot.style.backgroundColor = color;

          var name = document.createElement("span");
          name.className = "text-xs font-bold text-slate-600 truncate max-w-[80px]";
          name.textContent = shortLabels[i];
          name.title = fullLabels[i];

          var pct = document.createElement("span");
          pct.className = "ml-auto text-[11px] font-extrabold text-slate-400 tabular-nums whitespace-nowrap";
          pct.textContent = (data[i] ?? 0) + "%";

          li.appendChild(dot);
          li.appendChild(name);
          li.appendChild(pct);
          ul.appendChild(li);
        }
        legendEl.appendChild(ul);
      }

      var sorted = normalizeAndSort(rawData);

      if (!sorted || sorted.length === 0) {
        legendEl.innerHTML = "<p class='text-xs text-center text-gray-300 py-2'>데이터 없음</p>";
        window.__stockChartInstance = new Chart(ctx, {
          type: 'doughnut',
          data: { labels: ['데이터 없음'], datasets: [{ data: [100], backgroundColor: ['#F1F5F9'], borderWidth: 0 }] },
          options: { responsive: true, maintainAspectRatio: false, cutout: '70%', plugins: { legend: { display: false }, tooltip: { enabled: false } } }
        });
        return;
      }

      var fullLabels = sorted.map(function(item) { return item.stockName; });
      var data = sorted.map(function(item) { return item.weightPct; });

      // [색상 적용] 데이터 매핑 시 새로운 팔레트 사용
      // var colors = sorted.map(function(item, index) {
      //   return colorPalette[index % colorPalette.length];
      // });
      let colors = sorted.map(function (item) {
        return item.color || '#ccc';
      });

      var shortLabels = fullLabels.map(function(name) { return ellipsize(name, 7); });

      renderHtmlLegend(legendEl, fullLabels, shortLabels, colors, data);

      window.__stockChartInstance = new Chart(ctx, {
        type: 'doughnut',
        data: {
          labels: shortLabels,
          datasets: [{
            data: data,
            backgroundColor: colors,
            borderWidth: 0,
            hoverOffset: 15
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          animation: { duration: 1000, animateScale: true, animateRotate: true },
          cutout: '65%',
          layout: { padding: { top: 10, right: 8, bottom: 10, left: 8 } },
          plugins: {
            legend: { display: false },
            tooltip: {
              backgroundColor: 'rgba(30, 41, 59, 0.95)',
              padding: 12,
              cornerRadius: 8,
              displayColors: false,
              bodyFont: { family: 'Pretendard', size: 14 },
              callbacks: {
                label: function(context) {
                  var idx = context.dataIndex;
                  return fullLabels[idx] + ': ' + context.raw + '%';
                }
              }
            }
          }
        }
      });
    })();
  </script>
</div>