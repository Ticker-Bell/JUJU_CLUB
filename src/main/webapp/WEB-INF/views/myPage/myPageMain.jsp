<%@ page import="java.util.Date" %>
<%@ page import="com.tickerbell.jujuclub.auth.dto.MemberDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    // 가입일 D-Day 계산
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
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css" />

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: { sans: ['Pretendard', 'sans-serif'] },
                    colors: {
                        primary: '#5E45EB',
                        secondary: '#F8FAFC'
                    }
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

        .dashboard-card {
            background: #FFFFFF;
            border-radius: 24px;
            border: 1px solid #E2E8F0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.02);
            padding: 24px;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .progress-bar-fill { transition: width 1.5s ease-in-out; }
    </style>
</head>

<body class="flex flex-col">

<div class="w-full max-w-[1600px] mx-auto h-full flex flex-col p-5">

    <div class="flex items-center justify-between mb-4 shrink-0">
        <button onclick="history.back()" class="flex items-center gap-2 group">
            <div class="w-10 h-10 rounded-full bg-white border border-gray-200 flex items-center justify-center shadow-sm group-hover:bg-gray-50 transition-colors">
                <i data-lucide="arrow-left" class="w-5 h-5 text-gray-600 group-hover:text-gray-900"></i>
            </div>
            <span class="text-sm font-bold text-gray-500 group-hover:text-gray-900 transition-colors">뒤로가기</span>
        </button>

        <a href="/" class="flex items-center gap-1.5 text-sm font-bold text-gray-400 hover:text-primary transition-colors">
            <i data-lucide="home" class="w-4 h-4"></i>
            메인으로
        </a>
    </div>

    <div class="flex-1 grid grid-cols-2 grid-rows-2 gap-5 min-h-0">

        <div class="dashboard-card relative justify-center">

            <div class="flex flex-col items-center justify-center relative z-10">
                <div class="w-24 h-24 rounded-full bg-white border-4 border-slate-50 flex items-center justify-center text-white shadow-xl mb-4 relative group cursor-pointer">
                    <div class="absolute inset-0 rounded-full bg-gradient-to-br from-indigo-500 to-purple-600 opacity-90"></div>
                    <i data-lucide="user" class="w-10 h-10 relative z-10"></i>

                    <a href="${pageContext.request.contextPath}/myPage/profile" class="absolute bottom-0 right-0 bg-gray-900 p-1.5 rounded-full border-2 border-white hover:bg-primary transition-colors">
                        <i data-lucide="settings-2" class="w-4 h-4 text-white"></i>
                    </a>
                </div>

                <h2 class="text-2xl font-extrabold text-gray-900 mb-1">${loginUser.userName}</h2>
                <p class="text-sm text-gray-400 font-medium mb-3">${loginUser.userId}</p>

                <div class="flex items-center gap-2 mb-8">
                    <span class="px-3 py-1 rounded-full bg-slate-100 text-slate-600 text-xs font-bold border border-slate-200">
                        Lv. ${not empty loginUser.userLevel ? loginUser.userLevel : 'Beginner'} Investor
                    </span>
                    <span class="w-1 h-1 rounded-full bg-gray-300"></span>
                    <p class="text-xs text-gray-500 font-bold">
                        함께한 지 <span class="text-primary"><%= dayCount %>일</span>
                    </p>
                </div>
            </div>

            <div class="flex w-full border-t border-slate-100 pt-8">
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

        <div class="dashboard-card">
            <div class="flex items-center justify-between mb-2 shrink-0">
                <h3 class="text-lg font-extrabold text-gray-900">내 포트폴리오</h3>
                <span class="text-xs font-bold text-gray-400 bg-gray-100 px-2 py-1 rounded">보유 비중</span>
            </div>

            <div class="flex-1 relative w-full min-h-0 flex items-center justify-center p-2">
                <canvas id="stockChart"></canvas>
            </div>
        </div>

        <div class="dashboard-card">
            <div class="flex items-center justify-between mb-4 shrink-0">
                <h3 class="text-lg font-extrabold text-gray-900">미션 달성 현황</h3>
            </div>

            <div class="flex-1 flex flex-col justify-around py-2">
                <div>
                    <div class="flex justify-between text-sm font-bold mb-1.5">
                        <span class="text-gray-600">일간 미션</span>
                        <span class="text-primary font-extrabold">80%</span>
                    </div>
                    <div class="w-full bg-slate-100 rounded-full h-4">
                        <div class="bg-primary h-4 rounded-full progress-bar-fill shadow-sm" style="width: 80%"></div>
                    </div>
                    <p class="text-xs text-gray-400 mt-1.5 truncate">오늘 접속하기, 관심종목 추가</p>
                </div>

                <div>
                    <div class="flex justify-between text-sm font-bold mb-1.5">
                        <span class="text-gray-600">주간 미션</span>
                        <span class="text-emerald-500 font-extrabold">45%</span>
                    </div>
                    <div class="w-full bg-slate-100 rounded-full h-4">
                        <div class="bg-emerald-500 h-4 rounded-full progress-bar-fill shadow-sm" style="width: 45%"></div>
                    </div>
                    <p class="text-xs text-gray-400 mt-1.5 truncate">수익률 3% 달성 도전</p>
                </div>

                <div>
                    <div class="flex justify-between text-sm font-bold mb-1.5">
                        <span class="text-gray-600">월간 미션</span>
                        <span class="text-amber-500 font-extrabold">20%</span>
                    </div>
                    <div class="w-full bg-slate-100 rounded-full h-4">
                        <div class="bg-amber-500 h-4 rounded-full progress-bar-fill shadow-sm" style="width: 20%"></div>
                    </div>
                    <p class="text-xs text-gray-400 mt-1.5 truncate">누적 거래액 500만원</p>
                </div>
            </div>
        </div>

        <div class="dashboard-card relative overflow-hidden">
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
    lucide.createIcons();

    // 1. 서버(Controller)에서 넘겨준 JSON 데이터 받기
    const chartDataFromServer = ${not empty chartDataJson ? chartDataJson : '[]'};
    const ctx = document.getElementById('stockChart').getContext('2d');

    console.log("차트 데이터:", chartDataFromServer); // [디버깅용 로그]

    // 2. 데이터 유무에 따른 차트 그리기
    if (chartDataFromServer.length === 0) {
        // 데이터가 없을 경우: 회색 원
        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['데이터 없음'],
                datasets: [{
                    data: [100],
                    backgroundColor: ['#F1F5F9'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '70%',
                plugins: { legend: { display: false }, tooltip: { enabled: false } }
            }
        });
    } else {
        // 데이터가 있을 경우: 정상 차트
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
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'right',
                        labels: {
                            font: { family: 'Pretendard', size: 12, weight: 'bold' },
                            usePointStyle: true,
                            boxWidth: 8,
                            padding: 15,
                            color: '#64748B'
                        }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(30, 41, 59, 0.95)',
                        padding: 12,
                        cornerRadius: 8,
                        displayColors: false,
                        bodyFont: { family: 'Pretendard', size: 14 },
                        callbacks: {
                            label: function(context) {
                                return context.label + ': ' + context.raw + '%';
                            }
                        }
                    }
                },
                cutout: '65%',
                layout: { padding: 10 }
            }
        });
    }
</script>
</body>
</html>