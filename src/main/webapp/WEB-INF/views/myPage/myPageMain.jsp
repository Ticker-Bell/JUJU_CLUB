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
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>마이페이지 | JUJU CLUB</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://unpkg.com/htmx.org@1.9.10"></script>

    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css" />

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: { sans: ['Pretendard', 'sans-serif'] },
                    colors: { primary: '#5E45EB', secondary: '#F8FAFC' }
                }
            }
        }
    </script>

    <style>
        body {
            background-color: #F8FAFC;
            color: #1E293B;
            height: 100vh;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }
        /* 스크롤바 커스텀 */
        .custom-scroll::-webkit-scrollbar { width: 4px; }
        .custom-scroll::-webkit-scrollbar-track { background: transparent; }
        .custom-scroll::-webkit-scrollbar-thumb { background: #E2E8F0; border-radius: 4px; }
    </style>
</head>

<body class="flex flex-col">

<div class="w-full max-w-[1600px] mx-auto h-full flex flex-col p-5">

    <div class="flex-1 grid grid-cols-2 grid-rows-2 gap-5 min-h-0">

        <div class="bg-white rounded-[24px] border border-slate-200 shadow-[0_4px_12px_rgba(0,0,0,0.02)] p-6 h-full flex flex-col relative justify-center">
            <div class="flex-1 flex flex-col items-center justify-center relative z-10">
                <div class="w-24 h-24 rounded-full bg-white border-4 border-slate-50 flex items-center justify-center text-white shadow-xl mb-4 relative group cursor-pointer">
                    <div class="absolute inset-0 rounded-full bg-gradient-to-br from-indigo-500 to-purple-600 opacity-90"></div>
                    <i data-lucide="user" class="w-10 h-10 relative z-10"></i>

                    <%-- 모달 호출용 HTMX 버튼 --%>
                    <div class="absolute bottom-0 right-0 bg-gray-900 p-1.5 rounded-full border-2 border-white hover:bg-primary transition-colors cursor-pointer"
                         hx-get="${pageContext.request.contextPath}/myPage/profile"
                         hx-target="body"
                         hx-swap="beforeend">
                        <i data-lucide="settings-2" class="w-4 h-4 text-white"></i>
                    </div>
                </div>

                <h2 class="text-2xl font-extrabold text-gray-900 mb-1">${loginUser.userName}</h2>
                <p class="text-sm text-gray-400 font-medium mb-3">${loginUser.userId}</p>

                <div class="flex items-center gap-2 mb-6">
                    <span class="px-3 py-1 rounded-full bg-slate-100 text-slate-600 text-xs font-bold border border-slate-200">
                        Lv. ${not empty loginUser.userLevel ? loginUser.userLevel : 'Beginner'} Investor
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
                            <c:when test="${not empty userAsset and userAsset.totalReturnPct >= 0}">
                                <span class="text-xs font-bold text-red-500 flex items-center">
                                    <i data-lucide="trending-up" class="w-3 h-3 mr-1"></i>
                                    +<fmt:formatNumber value="${userAsset.totalReturnPct}" pattern="#,##0.1"/>%
                                </span>
                            </c:when>
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
                <span class="text-xs font-bold text-gray-400 bg-gray-100 px-2 py-1 rounded">보유 비중</span>
            </div>
            <div id="chartContainer" class="flex-1 relative w-full min-h-0 flex items-center justify-center p-2">
                <canvas id="stockChart"></canvas>
            </div>
        </div>

        <jsp:include page="myPageMission.jsp" />

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
    // [중요] 즉시 실행 함수(IIFE)로 감싸서 변수 충돌 방지 및 즉시 실행 보장
    (function() {
        // 1. 아이콘 로드 (HTMX로 들어왔을 때 아이콘이 깨지는 현상 방지)
        if (window.lucide) lucide.createIcons();

        // 2. 차트 그리기 함수
        function drawStockChart() {
            // 차트 부모 컨테이너 찾기
            const container = document.getElementById('chartContainer');
            // 컨테이너가 없으면 실행 중단 (오류 방지)
            if (!container) return;

            // [Nuclear Option]
            // 캔버스 영역을 강제로 비우고 새로 만듭니다.
            // HTMX로 페이지를 왔다 갔다 할 때 꼬이는 차트 문제를 100% 방지합니다.
            container.innerHTML = '';

            const newCanvas = document.createElement('canvas');
            newCanvas.id = 'stockChart';
            container.appendChild(newCanvas);

            const ctx = newCanvas.getContext('2d');

            // 서버 데이터 로드 (JSP 변수 -> JS 변수)
            const chartDataFromServer = ${not empty chartDataJson ? chartDataJson : '[]'};

            // 차트 옵션 설정
            const commonOptions = {
                responsive: true,
                maintainAspectRatio: false,
                animation: false, // 깜빡임 방지를 위해 애니메이션 끔
                cutout: '65%',
                layout: { padding: 10 }
            };

            if (chartDataFromServer.length === 0) {
                // 데이터 없음 (회색 도넛)
                new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: ['데이터 없음'],
                        datasets: [{ data: [100], backgroundColor: ['#F1F5F9'], borderWidth: 0 }]
                    },
                    options: {
                        ...commonOptions,
                        cutout: '70%',
                        plugins: { legend: { display: false }, tooltip: { enabled: false } }
                    }
                });
            } else {
                // 실제 데이터 차트 그리기
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
                                    font: { family: 'Pretendard', size: 12, weight: 'bold' },
                                    usePointStyle: true, boxWidth: 8, padding: 15, color: '#64748B'
                                }
                            },
                            tooltip: {
                                backgroundColor: 'rgba(30, 41, 59, 0.95)',
                                padding: 12, cornerRadius: 8, displayColors: false,
                                bodyFont: { family: 'Pretendard', size: 14 },
                                callbacks: {
                                    label: function(context) {
                                        return context.label + ': ' + context.raw + '%';
                                    }
                                }
                            }
                        }
                    }
                });
            }
        }

        // [핵심 수정] 이벤트 리스너 없이 바로 실행!
        // HTMX가 이 HTML을 화면에 끼워 넣자마자 이 코드가 실행되어 차트를 그립니다.
        drawStockChart();

    })(); // 함수 끝
</script>
</body>
</html>