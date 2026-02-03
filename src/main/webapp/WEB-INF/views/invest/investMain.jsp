<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://unpkg.com/htmx.org@1.9.10"></script>
<script src="https://unpkg.com/@lottiefiles/dotlottie-wc@0.8.11/dist/dotlottie-wc.js" type="module"></script>

<%@ include file="/WEB-INF/views/lesson/common/resultModal.jsp" %>

<style>

    .indicator-center-down{
        height: 100%;
        display: flex;
        flex-direction: column;
        justify-content: center;   /* 세로 중앙 */
        align-items: center;       /* 가로 중앙 */
        transform: translateY(60px); /* 아래로 이동 (원하는 만큼 조절) */
    }

    /* 탭 네비게이션 스타일 */
    .tab-nav {
        display: flex;
        border-bottom: 2px solid #E6E7EB;
        margin-bottom: 20px;
        gap: 5px;
    }

    .tab-container {
        position: relative;
        min-height: 600px; /* 로딩 중 레이아웃 무너짐 방지 */
    }

    /* 탭 컨텐츠 전환 애니메이션 */
    .tab-content {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        opacity: 0;
        transform: translateY(10px);
        pointer-events: none;
        transition: opacity 0.25s ease, transform 0.25s ease;
    }

    .tab-content.active {
        opacity: 1;
        transform: translateY(0);
        pointer-events: auto;
    }

    /* 탭 버튼 스타일 */
    .tab-nav button {
        text-decoration: none;
        color: #888888;
        font-size: 24px;
        font-weight: 700;
        padding: 10px;
        background: none;
        border: none;
        cursor: pointer;
    }

    .tab-nav button.active {
        color: #3819E6;
        border-bottom: 3px solid #3819E6;
    }

    /* HTMX 로딩 인디케이터 스타일 (Lottie 적용) */
    .htmx-indicator {
        display: none; /* 기본적으로 숨김 */
        width: 100%;
        height: 500px;
        flex-direction: column; /* 세로 정렬 */
        justify-content: center;
        align-items: center;
        opacity: 0;
        transition: opacity 0.3s ease-in;
    }

    /* HTMX 요청 중일 때 표시 (flex로 변경) */
    .htmx-request .htmx-indicator {
        display: flex;
        opacity: 1;
    }
    .htmx-request.htmx-indicator {
        display: flex;
        opacity: 1;
    }

    /* 로딩 텍스트 애니메이션 */
    .loading-text {
        margin-top: -20px;
        font-size: 18px;
        font-weight: 700;
        color: #5E45EB;
        animation: pulse 1.5s infinite;
    }

    @keyframes pulse {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.6; }
    }
</style>

<div class="w-full flex flex-col px-[24]">
    <nav class="tab-nav">
        <button id="myTab" class="active" onclick="changeTab('my')">마이</button>

        <button id="investTab"
                hx-get="${pageContext.request.contextPath}/invest/tab/invest"
                hx-target="#investJsp"
                hx-trigger="click once"
                onclick="changeTab('invest')">
            투자
        </button>

        <button id="assetDetailTab"
                hx-get="${pageContext.request.contextPath}/invest/tab/history"
                hx-target="#assetDetailJsp"
                hx-trigger="click once"
                onclick="changeTab('asset')">
            거래 내역
        </button>
    </nav>

    <div class="tab-container">
        <div id="myJsp" class="tab-content active"
             hx-get="${pageContext.request.contextPath}/invest/tab/my"
             hx-trigger="load"
             hx-swap="innerHTML">

            <div class="htmx-indicator indicator-center-down">
                <dotlottie-wc src="https://lottie.host/9e98724c-0c84-4ae2-9077-a73ca14f2509/g4PyzuhGLb.lottie"
                              style="width: 300px; height: auto;"
                              autoplay loop>
                </dotlottie-wc>
                <p class="loading-text" style="margin-top: 0px;">
                    <%--inline scriptlet - 로딩 문구 랜덤으로 띄우기--%>
                    <%
                        String[] messages = {
                                "투자 금고를 열고 있어요 💰",
                                "내 보물을 확인하는 중이에요 ✨",
                                "포트폴리오를 불러오고 있어요 📊",
                                "수익률을 계산하고 있어요 🧮",
                                "주식 요정이 데이터를 가져오는 중 🧚‍♀️",
                                "내 재산을 정리하고 있어요 📦",
                                "투자 일기장을 펼치는 중 📖",
                                "돈 주머니를 꺼내고 있어요 👛",
                                "금고 문을 여는 중이에요 🔐",
                                "보물 상자를 확인하는 중 🎁",
                                "내 재산을 세는 중이에요 🪙",
                                "투자 레벨을 확인하고 있어요 ⭐",
                                "오늘의 수익을 집계하는 중 📈",
                                "부자가 되는 중입니다 💎",
                                "잠시만요, 거의 다 왔어요! 🚀",
                                "내 통장을 들여다보는 중 💳",
                                "수익 현황판을 켜는 중 💡",
                                "투자 일지를 펼치고 있어요 📝",
                                "돈나무를 확인하는 중 🌳"
                        };
                        out.print(messages[(int)(Math.random() * messages.length)]);
                    %>
                </p>
            </div>
        </div>

        <div id="investJsp" class="tab-content">
            <div class="htmx-indicator">
                <dotlottie-wc src="https://lottie.host/9e98724c-0c84-4ae2-9077-a73ca14f2509/g4PyzuhGLb.lottie"
                              style="width: 300px; height: auto;"
                              autoplay loop>
                </dotlottie-wc>
                <p class="loading-text">실시간 시장 데이터를 분석중입니다...</p>
            </div>
        </div>

        <div id="assetDetailJsp" class="tab-content">
            <div class="htmx-indicator">
                <dotlottie-wc src="https://lottie.host/9e98724c-0c84-4ae2-9077-a73ca14f2509/g4PyzuhGLb.lottie"
                              style="width: 300px; height: auto;"
                              autoplay loop>
                </dotlottie-wc>
                <p class="loading-text">거래 기록을 분석하여 가져오는 중입니다...</p>
            </div>
        </div>
    </div>
</div>

<script>
    // ==========================================
    // ✅ 1. 웹소켓 관리 로직 (과거 코드 복원 및 수정)
    // ==========================================

    // 웹소켓 연결 시작
    function startWebSocket() {
        // HTMX로 로드된 컨텐츠 내부에서 .stock-item을 찾아 초기 구독
        let initialCodes = [];
        // jQuery($) 대신 바닐라 JS 사용 권장 (HTMX와 혼용 시)
        document.querySelectorAll('.stock-item').forEach(function (el) {
            const code = el.getAttribute('data-code');
            if(code) initialCodes.push(code);
        });

        if (initialCodes.length > 0) {
            // initListSocket 함수는 외부 JS나 로드된 페이지에 정의되어 있다고 가정
            if(typeof initListSocket === 'function') {
                initListSocket(initialCodes);
            }
        }
    }

    // 웹소켓 구독 해제 및 연결 종료
    function disconnectWebsocket() {
        // 1) 구독 해제
        if (typeof StockSocket !== 'undefined') {
            const currentCodes = Array.from(StockSocket.subscribeCodes.keys());
            if (currentCodes.length > 0) {
                StockSocket.unsubscribe(currentCodes);
            }
            // 2) 연결 물리적 종료
            if (typeof StockSocket.disconnect === 'function') {
                StockSocket.disconnect();
            }
        }
    }

    // 페이지를 완전히 떠날 때 연결 종료
    window.addEventListener('beforeunload', function () {
        disconnectWebsocket();
    });


    // ==========================================
    // ✅ 2. 탭 UI 전환 및 웹소켓 제어
    // ==========================================
    function changeTab(type) {
        const tabs = ['my', 'invest', 'asset'];

        // 탭 전환 처리
        tabs.forEach(t => {
            // 1. 컨텐츠 ID 매핑 수정 (asset -> assetDetailJsp)
            let contentId = t + 'Jsp';
            if (t === 'asset') contentId = 'assetDetailJsp';

            const content = document.getElementById(contentId);

            // 2. 버튼 ID 매핑
            let btnId = t + 'Tab';
            if (t === 'asset') btnId = 'assetDetailTab';

            const btn = document.getElementById(btnId);

            if (t === type) {
                // 해당 탭 활성화
                if(content) content.classList.add('active');
                if(btn) btn.classList.add('active');
            } else {
                // 다른 탭 비활성화
                if(content) content.classList.remove('active');
                if(btn) btn.classList.remove('active');
            }
        });

        // 웹소켓 제어 로직
        if (type === 'invest') {
            setTimeout(startWebSocket, 100);
        } else {
            disconnectWebsocket();
        }
    }


    // ==========================================
    // ✅ 3. HTMX 이벤트 연동 (중요)
    // ==========================================

    // HTMX가 "투자" 탭 내용을 서버에서 가져와 교체(Swap)한 직후 실행
    document.body.addEventListener('htmx:afterSwap', function(evt) {
        // 교체된 타겟이 investJsp인 경우에만 웹소켓 시작
        if (evt.detail.target.id === 'investJsp') {
            startWebSocket();
        }
    });


    // ==========================================
    // ✅ 4. 기존 유틸리티 함수들
    // ==========================================

    // stockCorpInfoCard.jsp에서 사용하는 함수
    function getSelectedCorpInfo(stockCode) {
        fetch('${cpath}/invest/corpInfo?stockCode=' + encodeURIComponent(stockCode))
            .then(res => res.text())
            .then(html => {
                const container = document.getElementById('stockCorpInfo-container');
                if(container) container.innerHTML = html;

                // 시간 업데이트
                const now = new Date();
                const timeString = now.toLocaleTimeString('ko-KR', {hour12: false});
                const timeEl = document.getElementById('update_time');
                if(timeEl) timeEl.innerText = timeString;
            })
            .catch(error => {
                console.error('기업정보로딩실패 : ', error);
                const container = document.getElementById('stockCorpInfo-container');
                if(container) container.innerHTML = '<p style="padding:10px;">정보를 불러오지 못했습니다.</p>';
            });
    }
</script>