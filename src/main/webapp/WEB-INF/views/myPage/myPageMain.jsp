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

<c:set var="cpath" value="${pageContext.request.contextPath}" />
<c:set var="defaultProfile" value="${cpath}/resources/images/default-profile.png" />

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
    }
</script>

<div class="w-full max-w-[1600px] mx-auto h-full flex flex-col p-5">
    <div class="flex-1 grid grid-cols-2 grid-rows-2 gap-5 min-h-0">

        <div class="bg-white rounded-[24px] border border-slate-200 shadow-[0_4px_12px_rgba(0,0,0,0.02)] p-6 h-full flex flex-col relative justify-center">
            <div class="flex items-center justify-between mb-2 shrink-0">
                <h3 class="text-lg font-extrabold text-gray-900">프로필</h3>
            </div>

            <div class="flex-1 flex flex-col items-center justify-center relative z-10">

                <%-- ✅ 프로필 이미지: DB에 있으면 /member/profile-image 가 200, 없으면 404 -> onerror로 기본이미지 --%>
                <div class="w-24 h-24 rounded-full bg-white border-4 border-slate-50 shadow-xl mb-4 relative group cursor-pointer overflow-hidden">
                    <img
                            id="mainProfileImg"
                            src="${cpath}/member/profile-image?ts=<%=System.currentTimeMillis()%>"
                            alt="profile"
                            class="w-full h-full object-cover"
                            loading="lazy"
                            onerror="this.onerror=null; this.src='${defaultProfile}';"
                    />

                    <!-- ✅ 설정 버튼 -->
                    <div class="absolute bottom-1 right-1 bg-gray-900 p-1.5 rounded-full border-2 border-white hover:bg-primary transition-colors cursor-pointer z-20"
                         hx-get="${cpath}/myPage/profile"
                         hx-target="body"
                         hx-swap="beforeend">
                        <i data-lucide="settings-2" class="w-4 h-4 text-white"></i>
                    </div>
                </div>

                <h2 class="text-2xl font-extrabold text-gray-900 mb-1">${loginUser.userName}</h2>
                <p class="text-sm text-gray-400 font-medium mb-3">${loginUser.userId}</p>

                <div class="flex items-center gap-2 mb-6">
                    <span class="px-3 py-1 rounded-full bg-slate-100 text-slate-600 text-xs font-bold border border-slate-200">
                        Lv.${loginUser.userLevel} ${loginUser.userLevel == 1 ? '초급': loginUser.userLevel == 2 ? '중급': loginUser.userLevel == 3 ? '고급' : '초급'}
                    </span>
                    <span class="w-1 h-1 rounded-full bg-gray-300"></span>
                    <p class="text-xs text-gray-500 font-bold">
                        함께한 지 <span class="text-primary"><%= dayCount %>일</span>
                    </p>
                </div>
            </div>

            <div class="flex w-full border-t border-slate-100 py-6">
                <div class="flex-1 flex flex-col items-center justify-center border-r border-slate-100">
                    <span class="text-sm font-bold text-gray-400 mb-1">총 자산</span>
                    <p class="text-2xl font-black text-slate-800 tracking-tight">
                        <c:choose>
                            <c:when test="${not empty userAsset}">
                                <fmt:formatNumber value="${userAsset.totalAsset}" pattern="#,###"/>
                            </c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                        <span class="text-base font-bold text-gray-400">원</span>
                    </p>
                    <div class="mt-1">
                        <c:choose>
                            <c:when test="${not empty userAsset and userAsset.totalReturnPct < 0}">
                                <span class="text-xs font-bold text-blue-500 flex items-center">
                                    <i data-lucide="trending-down" class="w-3 h-3 mr-1"></i>
                                    <fmt:formatNumber value="${userAsset.totalReturnPct}" pattern="#,##0.1"/>%
                                </span>
                            </c:when>
                        </c:choose>
                    </div>
                </div>

                <div class="flex-1 flex flex-col items-center justify-center">
                    <span class="text-sm font-bold text-gray-400 mb-1">예수금</span>
                    <p class="text-2xl font-black text-primary tracking-tight">
                        <c:choose>
                            <c:when test="${not empty userAsset}">
                                <fmt:formatNumber value="${userAsset.cashBalance}" pattern="#,###"/>
                            </c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                        <span class="text-base font-bold text-indigo-300">원</span>
                    </p>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-[24px] border border-slate-200 shadow-[0_4px_12px_rgba(0,0,0,0.02)] p-6 h-full flex flex-col">
            <div class="flex items-center justify-between mb-2 shrink-0">
                <h3 class="text-lg font-extrabold text-gray-900">내 포트폴리오</h3>
            </div>
            <div id="chartContainer" class="flex-1 relative w-full min-h-0 flex flex-col p-2">
                <div class="flex justify-end mb-2">
                    <span class="text-xs font-bold text-gray-400 bg-gray-100 px-2 py-1 rounded">보유 비중</span>
                </div>
                <div class="flex-1 min-h-0 flex items-center justify-center">
                    <canvas id="stockChart"></canvas>
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

        function drawStockChart() {
            const container = document.getElementById('chartContainer');
            if (!container) return;

            container.innerHTML = '';

            // ✅ 라벨 다시 추가 (innerHTML 비워서 사라짐 방지)
            const labelRow = document.createElement('div');
            labelRow.className = "flex justify-end mb-2";
            labelRow.innerHTML = '<span class="text-xs font-bold text-gray-400 bg-gray-100 px-2 py-1 rounded">보유 비중</span>';
            container.appendChild(labelRow);

            // ✅ 차트 래퍼
            const chartWrap = document.createElement('div');
            chartWrap.className = "flex-1 min-h-0 flex items-center justify-center";
            container.appendChild(chartWrap);

            const newCanvas = document.createElement('canvas');
            newCanvas.id = 'stockChart';
            chartWrap.appendChild(newCanvas);

            const ctx = newCanvas.getContext('2d');
            const chartDataFromServer = ${not empty chartDataJson ? chartDataJson : '[]'};

            const commonOptions = {
                responsive: true,
                maintainAspectRatio: false,
                animation: false,
                cutout: '65%',
                layout: {padding: 10}
            };

            if (chartDataFromServer.length === 0) {
                new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: ['데이터 없음'],
                        datasets: [{data: [100], backgroundColor: ['#F1F5F9'], borderWidth: 0}]
                    },
                    options: {
                        ...commonOptions,
                        cutout: '70%',
                        plugins: {legend: {display: false}, tooltip: {enabled: false}}
                    }
                });
            } else {
                const labels = chartDataFromServer.map(item => item.stockName);
                const data = chartDataFromServer.map(item => item.weightPct);
                const colors = chartDataFromServer.map(item => item.color);

                new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: labels,
                        datasets: [{
                            data: data,
                            backgroundColor: colors,
                            borderWidth: 0,
                            hoverOffset: 15
                        }]
                    },
                    options: {
                        ...commonOptions,
                        plugins: {
                            legend: {
                                position: 'right',
                                labels: {
                                    font: {family: 'Pretendard', size: 12, weight: 'bold'},
                                    usePointStyle: true, boxWidth: 8, padding: 15, color: '#64748B'
                                }
                            },
                            tooltip: {
                                backgroundColor: 'rgba(30, 41, 59, 0.95)',
                                padding: 12, cornerRadius: 8, displayColors: false,
                                bodyFont: {family: 'Pretendard', size: 14},
                                callbacks: {
                                    label: function (context) {
                                        return context.label + ': ' + context.raw + '%';
                                    }
                                }
                            }
                        }
                    }
                });
            }
        }

        //✅ (선택) 모달에서 이미지 업로드 후 메인 프로필도 즉시 갱신하고 싶으면:
        document.body.addEventListener('profile-image-updated', function(){
        const img = document.getElementById('mainProfileImg');
        if (img) img.src = '${cpath}/member/profile-image?ts=' + Date.now();
        });
    })();
</script>