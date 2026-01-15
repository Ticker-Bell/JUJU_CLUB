<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Stock List Component</title>

    <script src="https://unpkg.com/lucide@latest"></script>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css" />

    <style>
        /* [1] 기본 초기화 */
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Pretendard', sans-serif;
            /* 배경색은 메인 레이아웃에 맞춰 투명하거나 흰색으로 둠 */
            background-color: transparent;
            color: #191919;
            /* 중요: body에 padding이나 margin을 주지 않아 전체 레이아웃에 영향을 주지 않음 */
        }

        .num-font {
            font-feature-settings: "tnum";
            letter-spacing: 0;
            font-weight: 600;
        }

        /* [2] 메인 컨테이너 (고정 크기 복구) */
        .stock-app-container {
            width: 360px;   /* 너비 고정 */
            height: 600px;  /* 높이 고정 */

            background-color: #ffffff;
            border: 1px solid #E5E7EB;
            border-radius: 12px;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);

            display: flex;
            flex-direction: column;
            padding: 16px;
            overflow: hidden;

            /* (선택사항) 만약 화면 중앙에 두고 싶다면 margin: 0 auto; 추가 */
        }

        /* [3] 검색 영역 */
        .search-wrapper {
            position: relative;
            flex-shrink: 0;
        }
        .search-icon {
            position: absolute;
            left: 0;
            top: 10px;
            width: 16px;
            height: 16px;
            color: #9CA3AF;
        }
        .search-input {
            width: 100%;
            background-color: transparent;
            border: none;
            border-bottom: 1px solid #E5E7EB;
            padding: 8px 8px 8px 24px;
            font-size: 14px;
            font-weight: 800;
            color: #111827;
            outline: none;
            transition: border-color 0.2s;
        }
        .search-input::placeholder { color: #D1D5DB; }
        .search-input:focus { border-bottom-color: #5E45EB; }

        /* [4] 탭 메뉴 영역 */
        .tab-wrapper {
            margin-top: 16px;
            position: relative;
            border-bottom: 1px solid #E5E7EB;
            flex-shrink: 0;
        }
        .tab-list {
            display: flex;
            gap: 24px;
            align-items: center;
        }
        .tab-btn {
            background: none;
            border: none;
            padding-bottom: 10px;
            font-weight: 900;
            font-size: 12px;
            color: #9CA3AF;
            cursor: pointer;
            position: relative;
        }
        .tab-btn.active { color: #111827; }

        #left-tab-slider {
            height: 2px;
            background-color: #5E45EB;
            position: absolute;
            bottom: 0;
            left: 0;
            transition: all 0.25s ease;
        }

        /* [5] 주식 목록 영역 */
        .stock-list-container {
            margin-top: 12px;
            flex: 1;
            min-height: 0;
            display: flex;
            flex-direction: column;
        }

        .stock-scroll-area {
            flex: 1;
            overflow-y: auto;
        }

        /* 스크롤바 스타일 */
        .stock-scroll-area::-webkit-scrollbar { width: 6px; }
        .stock-scroll-area::-webkit-scrollbar-thumb { background: #E5E7EB; border-radius: 10px; }
        .stock-scroll-area::-webkit-scrollbar-thumb:hover { background: #D1D5DB; }

        /* [6] 리스트 아이템 스타일 */
        .stock-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px;
            border-bottom: 1px solid #F9FAFB;
            cursor: pointer;
            transition: background-color 0.15s;
        }
        .stock-item:hover { background-color: #F9FAFB; }

        .stock-item.selected {
            background-color: rgba(239, 246, 255, 0.5);
            border-left: 2px solid #5E45EB;
        }

        .text-col { display: flex; flex-direction: column; }
        .items-end { align-items: flex-end; }

        .txt-name { font-size: 14px; font-weight: 800; color: #111827; }
        .txt-code { font-size: 10px; font-weight: 700; color: #9CA3AF; margin-top: 2px; }

        .txt-price { font-size: 14px; font-weight: 800; }
        .txt-rate { font-size: 10px; font-weight: 800; margin-top: 2px; }

        .color-red { color: #DC2626; }
        .color-blue { color: #2563EB; }
        .color-gray { color: #111827; }
        .color-gray-light { color: #9CA3AF; }

    </style>
</head>
<body>

<div class="stock-app-container">

    <div class="search-wrapper">
        <i data-lucide="search" class="search-icon"></i>
        <input type="text" placeholder="종목명/코드 검색" class="search-input">
    </div>

    <div class="tab-wrapper">
        <div class="tab-list">
            <button id="left-tab-0" class="tab-btn active" onclick="switchLeftTab(0)">관심종목</button>
            <button id="left-tab-1" class="tab-btn" onclick="switchLeftTab(1)">거래량</button>
            <button id="left-tab-2" class="tab-btn" onclick="switchLeftTab(2)">상승률</button>
            <button id="left-tab-3" class="tab-btn" onclick="switchLeftTab(3)">하락률</button>
            <button id="left-tab-4" class="tab-btn" onclick="switchLeftTab(4)">시가총액</button>
        </div>
        <div id="left-tab-slider"></div>
    </div>

    <div class="stock-list-container">
        <div class="stock-scroll-area" id="stockList">
            <c:forEach items="${stockDTOList}" var="stock" varStatus="status">
                <div class="stock-item">
                    <div class="text-col">
                        <span class="txt-name">${stock.stockName}</span>
                        <span class="txt-code num-font">${stock.stockCode}</span>
                    </div>
                    <div class="text-col items-end">
                        <span class="txt-price color-red num-font">000000</span>
                        <span class="txt-rate color-red num-font">+0.00%</span>
                    </div>
                </div>

            </c:forEach>
            <div class="stock-item selected">
                <div class="text-col">
                    <span class="txt-name">삼성전자</span>
                    <span class="txt-code num-font">005930</span>
                </div>
                <div class="text-col items-end">
                    <span class="txt-price color-red num-font">000000</span>
                    <span class="txt-rate color-red num-font">+0.00%</span>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function switchLeftTab(idx) {
        const slider = document.getElementById('left-tab-slider');

        // 요소가 실제로 존재하는지 체크 (안전장치)
        if(!slider) return;

        for (let i = 0; i < 5; i++) {
            const el = document.getElementById('left-tab-' + i);
            if (el) el.classList.remove('active');
        }
        const activeBtn = document.getElementById('left-tab-' + idx);
        if (activeBtn) {
            activeBtn.classList.add('active');
            slider.style.width = activeBtn.offsetWidth + 'px';
            slider.style.left = activeBtn.offsetLeft + 'px';
        }
    }

    // 2. 초기화 함수
    function initStockComponent(){
        // 아이콘 생성(이미 로드된 상태라도 강제로 다시 그림)
        if(window.lucide){
            lucide.createIcons();
        }

        // 0번 탭 활성화
        switchLeftTab(0);
    }

    // 만약 이 파일이 단독으로 실행된 경우 (새로고침 직후)
    if (document.readyState === 'complete') {
        initStockComponent();
    } else {
        // 아직 페이지 로딩 중이라면 이벤트 리스너 등록
        window.addEventListener('load', initStockComponent);
    }

    // AJAX나 JSP include로 나중에 불러와진 경우를 위해
    // 스크립트가 읽히자마자 즉시 실행 시도
    initStockComponent();

</script>
</body>
</html>

