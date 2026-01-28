<%@ page import="java.util.Date" %>
<%@ page import="com.tickerbell.jujuclub.auth.dto.MemberDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
    long dayCount = 1;
    if (user != null && user.getCreatedAt() != null) {
        long diff = new Date().getTime() - user.getCreatedAt().getTime();
        dayCount = diff / (1000 * 60 * 60 * 24) + 1;
    }
%>

<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<c:set var="defaultProfile" value="${cpath}/resources/images/default-profile.png"/>

<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>마이페이지 | JUJU CLUB</title>

<script src="https://cdn.tailwindcss.com"></script>
<script src="https://unpkg.com/lucide@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://unpkg.com/htmx.org@1.9.10"></script>

<link rel="stylesheet" as="style" crossorigin
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css"/>

<script>
    tailwind.config = {
        theme: {
            extend: {
                fontFamily: {sans: ['Pretendard', 'sans-serif']},
                colors: {primary: '#5E45EB', secondary: '#F8FAFC'}
            }
        }
    };
</script>

<div class="w-full max-w-[1600px] mx-auto h-full flex flex-col p-5">
    <div class="flex-1 grid grid-cols-2 grid-rows-2 gap-5 min-h-0">

        <div class="bg-white rounded-[24px] border border-slate-200 shadow-[0_4px_12px_rgba(0,0,0,0.02)] p-6 h-full flex flex-col relative">
            <div class="flex items-center justify-between mb-2 shrink-0">
                <h3 class="text-lg font-extrabold text-gray-900">프로필</h3>
            </div>

            <div class="flex-1 flex flex-col items-center justify-center relative z-10 min-h-0">
                <div class="relative mb-4">
                    <div class="w-24 h-24 rounded-full relative overflow-visible bg-transparent">
                        <div class="w-full h-full rounded-full overflow-hidden bg-transparent">
                            <img id="mainProfileImg"
                                 src="${cpath}/member/profile-image?ts=<%=System.currentTimeMillis()%>"
                                 alt="profile"
                                 class="w-full h-full object-cover"
                                 loading="lazy"
                                 onerror="this.onerror=null; this.src='${defaultProfile}';"/>
                        </div>

                        <div class="absolute -bottom-1 -right-1 bg-gray-900 p-1.5 rounded-full hover:bg-primary transition-colors cursor-pointer z-30"
                             hx-get="${cpath}/myPage/profile"
                             hx-target="body"
                             hx-swap="beforeend">
                            <i data-lucide="settings-2" class="w-4 h-4 text-white"></i>
                        </div>
                    </div>
                </div>

                <h2 class="text-2xl font-extrabold text-gray-900 mb-1">${loginUser.userName}</h2>
                <p class="text-sm text-gray-400 font-medium mb-3">${loginUser.userId}</p>

                <div class="flex items-center gap-2 mb-4">

                    <!-- ✅ 레벨 뱃지 (동일 스타일 + Lv 표기) -->
                    <c:choose>
                        <c:when test="${loginUser.userLevel == 1}">
            <span class="px-3 py-1 rounded-full bg-primary/10 text-primary text-[11px] font-extrabold border border-primary/20">
                Lv.1 초급
            </span>
                        </c:when>

                        <c:when test="${loginUser.userLevel == 2}">
            <span class="px-3 py-1 rounded-full bg-green-100 text-green-600 text-[11px] font-extrabold border border-green-200">
                Lv.2 중급
            </span>
                        </c:when>

                        <c:when test="${loginUser.userLevel == 3}">
            <span class="px-3 py-1 rounded-full bg-orange-100 text-orange-600 text-[11px] font-extrabold border border-orange-200">
                Lv.3 고급
            </span>
                        </c:when>

                        <c:otherwise>
            <span class="px-3 py-1 rounded-full bg-gray-100 text-gray-600 text-[11px] font-extrabold border border-gray-200">
                일반
            </span>
                        </c:otherwise>
                    </c:choose>

                    <span class="w-1 h-1 rounded-full bg-gray-300"></span>

                    <p class="text-xs text-gray-500 font-bold">
                        함께한 지 <span class="text-primary"><%= dayCount %>일</span>
                    </p>
                </div>

            </div>

            <div class="flex w-full border-t border-slate-100 pt-4">
                <div class="flex-1 flex items-center justify-center gap-3 border-r border-slate-100">
                    <span class="text-sm font-extrabold text-gray-500 whitespace-nowrap">총 자산</span>
                    <p class="text-lg font-black text-slate-800 tracking-tight whitespace-nowrap">
                        <c:choose>
                            <c:when test="${not empty userAsset}">
                                <fmt:formatNumber value="${userAsset.totalAsset}" pattern="#,###"/>
                            </c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                        <span class="text-lg font-black text-slate-800 ml-1">원</span>
                    </p>
                    <c:if test="${not empty userAsset and userAsset.totalReturnPct < 0}">
                        <span class="text-xs font-bold text-blue-500 flex items-center whitespace-nowrap">
                            <i data-lucide="trending-down" class="w-3 h-3 mr-1"></i>
                            <fmt:formatNumber value="${userAsset.totalReturnPct}" pattern="#,##0.1"/>%
                        </span>
                    </c:if>
                </div>

                <div class="flex-1 flex items-center justify-center gap-3">
                    <span class="text-sm font-extrabold text-gray-500 whitespace-nowrap">예수금</span>
                    <p class="text-lg font-black text-primary tracking-tight whitespace-nowrap">
                        <c:choose>
                            <c:when test="${not empty userAsset}">
                                <fmt:formatNumber value="${userAsset.cashBalance}" pattern="#,###"/>
                            </c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                        <span class="text-lg font-black text-primary ml-1">원</span>
                    </p>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-[24px] border border-slate-200 shadow-[0_4px_12px_rgba(0,0,0,0.02)] p-6 h-full flex flex-col">
            <div class="flex items-center justify-between mb-2 shrink-0">
                <h3 class="text-lg font-extrabold text-gray-900">내 포트폴리오</h3>
            </div>

            <div id="chartContainer" class="flex-1 relative w-full min-h-0 flex flex-col p-2">
                <div class="flex-1 min-h-0 flex items-stretch justify-center">
                    <div class="w-full max-w-[760px] h-full flex items-stretch gap-6 -translate-x-2">
                        <div class="flex-1 min-h-0">
                            <canvas id="stockChart" class="w-full h-full"></canvas>
                        </div>
                        <div class="w-[260px] max-w-[260px] shrink-0 pr-1 flex flex-col min-h-0">
                            <div class="flex-1 min-h-0 overflow-y-auto pr-1"
                                 id="stockLegend"
                                 style="scrollbar-gutter: stable;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="myPageMission.jsp"/>

        <div class="bg-white rounded-[24px] border border-slate-200 shadow-[0_4px_12px_rgba(0,0,0,0.02)] p-6 h-full flex flex-col relative overflow-hidden">
            <div class="flex items-center justify-between mb-2 shrink-0">
                <h3 class="text-lg font-extrabold text-gray-900">획득 뱃지</h3>
            </div>
            <div class="flex-1 flex flex-col items-center justify-center text-center pb-4">
                <div class="w-20 h-20 bg-slate-50 rounded-3xl flex items-center justify-center mb-5 rotate-12 border border-slate-100 shadow-sm">
                    <i data-lucide="message-circle-warning" class="w-10 h-10 text-slate-300 -rotate-12"></i>
                </div>
                <p class="text-lg font-extrabold text-gray-500 mb-1">현재는 비어있습니다.</p>
                <p class="text-sm font-medium text-gray-400">열심히 활동해서 뱃지를 모아보세요!</p>
            </div>
        </div>

    </div>
</div>

<script>
    (function () {
        if (window.lucide) lucide.createIcons();
        drawStockChart();

        function ellipsize(str, max) {
            if (!str) return '';
            return str.length > max ? (str.slice(0, max) + '…') : str;
        }

        function normalizeAndSort(items) {
            const arr = Array.isArray(items) ? items.slice() : [];
            arr.sort((a, b) => {
                const pa = Number(a.weightPct ?? 0);
                const pb = Number(b.weightPct ?? 0);
                return pb - pa;
            });
            return arr;
        }

        function renderHtmlLegend(legendEl, fullLabels, shortLabels, colors, data) {
            if (!legendEl) return;
            legendEl.innerHTML = "";

            const ul = document.createElement("ul");
            ul.className = "space-y-2";

            for (let i = 0; i < fullLabels.length; i++) {
                const li = document.createElement("li");
                li.className = "flex items-center gap-2";

                const dot = document.createElement("span");
                dot.className = "inline-block w-2.5 h-2.5 rounded-full shrink-0";
                dot.style.backgroundColor = colors[i] || "#CBD5E1";

                const name = document.createElement("span");
                name.className = "text-xs font-bold text-slate-600 truncate max-w-[150px]";
                name.textContent = shortLabels[i];
                name.title = fullLabels[i];

                const pct = document.createElement("span");
                pct.className = "ml-auto text-[11px] font-extrabold text-slate-400 tabular-nums whitespace-nowrap";
                pct.textContent = (data[i] ?? 0) + "%";

                li.appendChild(dot);
                li.appendChild(name);
                li.appendChild(pct);
                ul.appendChild(li);
            }

            legendEl.appendChild(ul);
        }

        function drawStockChart() {
            const canvas = document.getElementById('stockChart');
            const legendEl = document.getElementById('stockLegend');
            if (!canvas || !legendEl) return;

            const ctx = canvas.getContext('2d');
            const raw = ${not empty chartDataJson ? chartDataJson : '[]'};

            if (window.__stockChartInstance) {
                window.__stockChartInstance.destroy();
                window.__stockChartInstance = null;
            }

            const sorted = normalizeAndSort(raw);

            if (!sorted || sorted.length === 0) {
                legendEl.innerHTML = "";
                window.__stockChartInstance = new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: ['데이터 없음'],
                        datasets: [{ data: [100], backgroundColor: ['#F1F5F9'], borderWidth: 0 }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        animation: false,
                        cutout: '70%',
                        plugins: { legend: { display: false }, tooltip: { enabled: false } }
                    }
                });
                return;
            }

            const fullLabels = sorted.map(item => item.stockName);
            const data = sorted.map(item => item.weightPct);
            const colors = sorted.map(item => item.color);

            const shortLabels = fullLabels.map(name => ellipsize(name, 10));
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
                    animation: false,
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
                                label: function (context) {
                                    const idx = context.dataIndex;
                                    return fullLabels[idx] + ': ' + context.raw + '%';
                                }
                            }
                        }
                    }
                }
            });
        }

        document.body.addEventListener('profile-image-updated', function () {
            const img = document.getElementById('mainProfileImg');
            if (img) img.src = '${cpath}/member/profile-image?ts=' + Date.now();
        });
    })();
</script>
