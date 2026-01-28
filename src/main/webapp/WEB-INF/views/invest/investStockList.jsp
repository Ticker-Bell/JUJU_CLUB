<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    body {
        font-family: 'Pretendard', sans-serif;
        background-color: transparent;
        color: #191919;
    }

    .num-font {
        font-feature-settings: "tnum";
        letter-spacing: 0;
        font-weight: 600;
    }

    .stock-app-container {
        width: 360px;
        height: 600px;
        background-color: #ffffff;
        border: 1px solid #E5E7EB;
        border-radius: 12px;
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
        display: flex;
        flex-direction: column;
        padding: 16px;
        overflow: hidden;
    }

    .search-wrapper {
        position: relative;
        flex-shrink: 0;
    }

    .search-icon {
        position: absolute;
        left: 10px;
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
        padding: 8px 8px 8px 40px;
        font-size: 14px;
        font-weight: 800;
        color: #111827;
        outline: none;
        transition: border-color 0.2s;
    }

    .search-input::placeholder {
        color: #D1D5DB;
    }

    .search-input:focus {
        border-bottom-color: #5E45EB;
    }

    .tab-wrapper {
        position: relative;
        border-bottom: 1px solid #E5E7EB;
        flex-shrink: 0;
        padding-bottom: 0;
    }

    .tab-list {
        display: flex;
        gap: 30px;
        align-items: center;
        justify-content: center;
        width: 100%;
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

    .tab-btn.active {
        color: #111827;
    }

    #left-tab-slider {
        height: 2px;
        background-color: #5E45EB;
        position: absolute;
        bottom: 0;
        left: 0;
        transition: all 0.25s ease;
    }

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

    .stock-scroll-area::-webkit-scrollbar {
        width: 6px;
    }

    .stock-scroll-area::-webkit-scrollbar-thumb {
        background: #E5E7EB;
        border-radius: 10px;
    }

    .stock-scroll-area::-webkit-scrollbar-thumb:hover {
        background: #D1D5DB;
    }

    .stock-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px;
        border-bottom: 1px solid #F9FAFB;
        cursor: pointer;
        transition: background-color 0.15s;
    }

    .stock-item:hover {
        background-color: #F9FAFB;
    }

    .text-col {
        display: flex;
        flex-direction: column;
    }

    .items-end {
        align-items: flex-end;
    }

    .txt-name {
        font-size: 14px;
        font-weight: 800;
        color: #111827;
    }

    .txt-code {
        font-size: 10px;
        font-weight: 700;
        color: #9CA3AF;
        margin-top: 2px;
    }

    .txt-price {
        font-size: 14px;
        font-weight: 800;
    }

    .txt-rate {
        font-size: 10px;
        font-weight: 800;
        margin-top: 2px;
    }

    .color-red {
        color: #DC2626;
    }

    .color-blue {
        color: #2563EB;
    }

    .color-gray {
        color: #111827;
    }

    /* 랭크 스타일 (필요시 추가) */
    .rank {
        font-size: 10px;
        color: #5E45EB;
        font-weight: bold;
        margin-bottom: 2px;
    }


    /* 검색창 감싸는 wrapper */
    .search-wrapper {
        position: relative;
        width: 300px;
        margin: 20px auto 10px auto;
        flex-shrink: 0;
    }

    /* 자동완성 결과 박스 */
    .search-result {
        position: absolute; /* 바로 아래 배치 */
        top: 105%;
        left: 0;
        width: 100%;
        background: white;
        border: 1px solid #e5e7eb;
        z-index: 1000; /* 다른 요소보다 위에 오도록 */
        display: none; /* 평소엔 숨김 */
        max-height: 200px; /* 너무 길면 스크롤 */
        overflow-y: auto;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }

    /* 리스트 아이템 스타일 */
    .result-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 14px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.15s;
        border-bottom: 1px solid #F9FAFB;
    }

    .result-item:hover {
        background-color: #f0f0f0;
    }

    .sub-text {
        font-size: 12px;
        color: #9CA3AF;
        font-weight: 500;
    }

    .stock-item.selected {
        background-color: #F5F3FF;
        box-shadow: inset 0 0 0 2px #5E45EB;
    }

    /* 키보드로 선택된 항목 강조 스타일 */
    .result-item.active {
        background-color: #F5F3FF;
        box-shadow: inset 3px 0 0 0 #5E45EB;
    }

    /* 탭 버튼이 잠겼을 때 적용할 클래스 */
    .tab-btn.locked {
        cursor: not-allowed;
        opacity: 0.5;
        pointer-events: none;
    }


</style>

<div class="stock-app-container">

    <div class="tab-wrapper">
        <div class="tab-list">
            <button class="tab-btn active" data-sort="interest">관심종목</button>
            <button class="tab-btn" data-sort="volume">거래량</button>
            <button class="tab-btn" data-sort="rising">상승률</button>
            <button class="tab-btn" data-sort="falling">하락률</button>
            <button class="tab-btn" data-sort="marketCap">시가총액</button>
        </div>
        <div id="left-tab-slider"></div>
    </div>

    <div class="search-wrapper">
        <i data-lucide="search" class="search-icon"></i>
        <input type="text" placeholder="종목명/코드 검색" class="search-input">
        <div class="search-result"></div>
    </div>

    <div class="stock-list-container">
        <div class="stock-scroll-area" id="stockList">
            <c:if test="${empty stockDTOList}">
                <div style="padding:20px; text-align:center;">관심종목이 없습니다. 관심종목을 추가해보세요.</div>
            </c:if>
            <c:if test="${not empty stockDTOList}">
                <c:forEach items="${stockDTOList}" var="stock">
                    <div class="stock-item" data-code="${stock.stockCode}" data-name="${stock.stockName}">
                        <div class="text-col">
                            <c:catch var="e">
                                <c:if test="${not empty stock.rank}">
                                    <span class="rank">${stock.rank}</span>
                                </c:if>
                            </c:catch>
                            <span class="txt-name">${stock.stockName}</span>
                            <span class="txt-code num-font">${stock.stockCode}</span>
                        </div>
                        <div class="text-col items-end">
                            <c:choose>
                                <c:when test="${fn:startsWith(codeKISDataMap[stock.stockCode].changePct, '+')}">
                                    <span class="txt-price color-red num-font"><fmt:formatNumber
                                            value="${codeKISDataMap[stock.stockCode].currentPrice}"
                                            type="number"/></span>
                                    <span class="txt-rate color-red num-font">${codeKISDataMap[stock.stockCode].changePct}%</span>
                                </c:when>
                                <c:when test="${fn:startsWith(codeKISDataMap[stock.stockCode].changePct, '-')}">
                                    <span class="txt-price color-blue num-font"><fmt:formatNumber
                                            value="${codeKISDataMap[stock.stockCode].currentPrice}"
                                            type="number"/></span>
                                    <span class="txt-rate color-blue num-font">${codeKISDataMap[stock.stockCode].changePct}%</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="txt-price color-gray num-font"><fmt:formatNumber
                                            value="${codeKISDataMap[stock.stockCode].currentPrice}"
                                            type="number"/></span>
                                    <span class="txt-rate color-gray num-font">${codeKISDataMap[stock.stockCode].changePct}%</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </div>
</div>
<div id="investBuySell">
    <div class="min-w-[320px] w-full  min-h-[400px] p-2 bg-[#FBFBFB] rounded-[12px] outline outline-2 outline-[#E6E7EB]">
        <div id="tab-header" class="w-1/2 flex my-4 border-b border-[#E6E7EB] ">
            <button id="buy-button" type="button"
                    class="tab-item active flex-1 py-2 px-1 border-b-[3px] border-[#5E45EB] border-xs text-[#2D14B8] font-medium text-base transition-all hover:text-[#3819E6]">
                매수
            </button>
            <button id="sell-button" type="button"
                    class="tab-item flex-1 py-2 px-1 border-b-[3px] border-transparent border-xs text-[#666666] font-medium text-base transition-all hover:text-[#3819E6]">
                매도
            </button>
        </div>

        <div id="tab-content" class="p-4">
            <div id="buy-form" class="flex flex-col gap-6">
                <div id="buy-form-item" class="flex justify-between">
                    <label class="text-base font-medium text-[#666666]">가격</label>
                    <div class="flex flex-row gap-2">
                        <p id="buyPrice" class="text-[#222222]">-</p>
                        <p class="text-[#666666]">원</p>
                    </div>
                </div>
                <div id="buy-form-item" class="flex justify-between">
                    <label class="text-base font-medium text-[#666666]">수량</label>
                    <input
                            class="pl-2 border-2 rounded-md border-[#E6E7EB] py-1 focus:border-[#5E45EB] outline-none"
                            type="number"
                            id="buyAmountInput"
                            alt="수량 입력창"
                    />
                </div>
                <div id="buy-form-item" class="flex justify-between">
                    <label class="text-sm font-normal text-[#666666]">예상금액</label>
                    <div class="flex flex-row gap-2">
                        <p id="buyExpectedPrice" class="text-[#222222]">-</p>
                        <p class="text-[#666666]">원</p>
                    </div>
                </div>
                <p id="buyErrorMessage" class="text-[#EB3A3E] text-sm font-normal"></p>
                <button id="doBuyButton"
                        class="mt-6 mb-6 py-2 border-2 rounded-[20px] bg-[#E6E7EB] text-[#999999] text-base font-medium">
                    매수하기
                </button>
            </div>

            <div id="sell-form" class="hidden flex flex-col gap-6">
                <div id="sell-form-item" class="flex justify-between">
                    <label class="text-sm font-normal text-[#666666]">보유수량</label>
                    <div class="flex flex-row gap-2">
                        <p id="hasStockQuantity" class="text-[#222222]"></p>
                    </div>
                </div>
                <div id="sell-form-item" class="flex justify-between">
                    <label class="text-base font-medium text-[#666666]">가격</label>
                    <div class="flex flex-row gap-2">
                        <p id="sellPrice" class="text-[#222222]">-</p>
                        <p class="text-[#666666]">원</p>
                    </div>
                </div>
                <div id="sell-form-item" class="flex justify-between">
                    <label class="text-base font-medium text-[#666666]">수량</label>
                    <input
                            class="pl-2 border-2 rounded-md border-[#E6E7EB] py-1 focus:border-[#5E45EB] outline-none"
                            type="number"
                            id="sellAmountInput"
                            alt="수량 입력창" `
                    />
                </div>
                <div id="sell-form-item" class="flex justify-between">
                    <label class="text-sm font-normal text-[#666666]">예상금액</label>
                    <div class="flex flex-row gap-2">
                        <p id="sellExpectedPrice" class="text-[#222222]">-</p>
                        <p class="text-[#666666]">원</p>
                    </div>
                </div>

                <p id="sellErrorMessage" class="text-[#EB3A3E] text-sm font-normal"></p>

                <button id="doSellButton"
                        class="mt-6 mb-6 py-2 border-2 rounded-[20px] bg-[#E6E7EB] text-[#999999] text-base font-medium">
                    매도하기
                </button>

            </div>
        </div>
    </div>
</div>

<script>
    (function () {
        const contextPath = "${pageContext.request.contextPath}";
        let currentStockPrice = '';
        let currentStockChange = '';

        //리스트의 종목 가격을 실시간으로 업데이트
        function initListSocket(stockCodes) {

            if (!stockCodes || stockCodes.length === 0) return;

            // StockSocket 연결 시작
            StockSocket.connect(
                contextPath,      // 서버 주소
                stockCodes,       // 구독할 종목 코드들
                function (stockData) {  // 3초마다 실행될 데이터 처리 함수
                    // 1. 데이터가 도착한 종목의 HTML 박스 찾기
                    const $item = $('.stock-item[data-code="' + stockData.stockCode + '"]');

                    // 해당 종목이 화면에 있다면
                    if ($item.length > 0) {
                        // 2.가격 업데이트 (콤마 찍기)
                        const formattedPrice = stockData.displayPrice;
                        $item.find('.txt-price').text(formattedPrice);

                        // 3.등락률 업데이트 (+- 기호 및 % 붙이기)
                        let rate = stockData.displayRate;
                        $item.find('.txt-rate').text(rate);

                        // 4. 색상 변경 (빨강/파랑/검정)
                        const $priceTexts = $item.find('.txt-price, .txt-rate');

                        if (rate && (rate.startsWith("+") || rate.startsWith("-"))) {

                            // 이때만 기존 색 지우고 다시 입힘
                            $priceTexts.removeClass('color-red color-blue color-gray');

                            if (rate.startsWith("+")) {
                                $priceTexts.addClass('color-red');
                            } else {
                                $priceTexts.addClass('color-blue');
                            }
                        }
                    }
                }
            )
        }

        // 검색창
        $(document).ready(function () {

            let debounceTimer; // 디바운싱을 위한 타이머

            $('.search-input').on('keydown', function (e) {
                const $resultBox = $('.search-result');
                const $items = $resultBox.find('.result-item');
                const $active = $resultBox.find('.result-item.active');

                // 1. 엔터키 (Enter)
                if (e.keyCode === 13) {
                    e.preventDefault(); // 폼 전송 등 막기
                    let keyword = $(this).val().trim();

                    // (1) 입력값이 비어있으면 -> 관심종목 탭 이동
                    if (keyword.length === 0) {
                        $('.tab-btn[data-sort="interest"]').trigger('click');
                        $resultBox.hide();
                        $(this).blur();
                        return;
                    }

                    // (2) 입력값이 있고, 활성화된(강조된) 항목이 있으면 클릭 트리거
                    if ($active.length > 0 && $resultBox.is(':visible')) {
                        $active.trigger('click');
                        $(this).blur();
                    }
                    return;
                }

                // 2. 방향키 아래 (Down Arrow)
                if (e.keyCode === 40) {
                    e.preventDefault(); // 커서가 맨 뒤나 앞으로 튀는 것 방지

                    // 리스트가 없거나 안 보이면 무시
                    if (!$resultBox.is(':visible') || $items.length === 0) return;

                    if ($active.length === 0) {
                        let $first = $items.first();
                        // 선택된 게 없으면 첫 번째 선택
                        $first.addClass('active');
                        // 스크롤 이동
                        $first[0].scrollIntoView({block: 'nearest'});
                    } else {
                        // 다음 항목으로 이동
                        let $next = $active.next('.result-item');
                        if ($next.length > 0) {
                            $active.removeClass('active');
                            $next.addClass('active');

                            // 스크롤이 생겼을 때 따라가게
                            $next[0].scrollIntoView({block: 'nearest'});
                        }
                    }
                }

                // 3. 방향키 위 (Up Arrow)
                if (e.keyCode === 38) {
                    e.preventDefault();

                    if (!$resultBox.is(':visible') || $items.length === 0) return;

                    if ($active.length > 0) {
                        let $prev = $active.prev('.result-item');
                        if ($prev.length > 0) {
                            $active.removeClass('active');
                            $prev.addClass('active');

                            // 이전 항목이 보이도록 스크롤 자동 조정
                            $prev[0].scrollIntoView({block: 'nearest'});
                        }
                    }
                }
            })

            $('.search-input').on('keyup', function (e) {
                // 방향키(37~40)와 엔터(13)는 keyup에서 무시 (keydown에서 처리했으므로)
                if (e.keyCode === 13 || (e.keyCode >= 37 && e.keyCode <= 40)) return;

                let keyword = $(this).val();
                let $resultBox = $('.search-result'); //선택자 캐싱

                // 입력값이 없으면 리스트 숨기기
                if (keyword.length === 0) {
                    clearTimeout(debounceTimer);  // 대기 중이던 요청 취소
                    $resultBox.hide();
                    return;
                }

                // 이전에 예약된 요청이 있다면 취소 (타이머 초기화)
                clearTimeout(debounceTimer);

                // 0.3초 뒤에 실행하도록 예약
                debounceTimer = setTimeout(function () {
                    $.ajax({
                        url: contextPath + "/invest/search/autocomplete",
                        type: 'POST',
                        data: {keyword: keyword},
                        success: function (data) {
                            // 데이터가 있으면 리스트 보여주기
                            if (data.length > 0) {
                                let html = '';
                                $.each(data, function (index, item) {
                                    // 정규식 생성: keyword를 찾되, g(전체 찾기), i(대소문자 무시) 옵션 적용
                                    let regex = new RegExp(keyword, "gi");

                                    // 검색어(종목명) 강조 효과
                                    let highlightName = item.stockName.replace(regex, function (match) {
                                        return '<span style="color:#5E45EB; font-weight:bold;">' + match + '</span>';
                                    });

                                    // 검색어(종목코드) 강조 효과
                                    let highlightCode = item.stockCode.replace(regex, function (match) {
                                        return '<span style="color:#5E45EB; font-weight:bold;">' + match + '</span>';
                                    });

                                    // 화면에 보여줄 HTML 생성
                                    html += '<div class="result-item" data-code="' + item.stockCode + '" data-name="' + item.stockName + '">';
                                    html += '<span>' + highlightName + '</span>';
                                    html += '<span class="sub-text">' + highlightCode + '</span>';
                                    html += '</div>';
                                });

                                $resultBox.html(html).show();
                            } else {
                                $resultBox.hide();
                            }
                        },
                        error: function () {
                            console.log('에러 발생');
                        }
                    });

                }, 300); // 0.3초 대기 시간
            });

            // 마우스 오버 시 active 클래스 이동 (마우스랑 키보드 충돌 방지)
            $(document).on('mouseenter', '.result-item', function () {
                $('.result-item').removeClass('active');
                $(this).addClass('active');
            });

            // 리스트 항목 클릭시 검색창에 값 넣기
            $(document).on('click', '.result-item', function () {
                let selectedName = $(this).data('name');
                let selectedCode = $(this).data('code');

                // 검색창에 이름 넣고 결과창 숨기기
                $('.search-input').val(selectedName);
                $('.search-result').hide();

                // 탭 UI 초기화 (슬라이더 숨기기)
                $('#left-tab-slider').hide();
                $('.tab-btn').removeClass('active');

                $.ajax({
                    url: contextPath + "/invest/stock/selected",
                    type: 'POST',
                    data: {
                        stockCode: selectedCode,
                        stockName: selectedName
                    },
                    success: function (stock) {
                        let colorClass = "color-gray";
                        if (stock.changePct && stock.changePct.startsWith("+")) {
                            colorClass = "color-red";
                        } else if (stock.changePct && stock.changePct.startsWith("-")) {
                            colorClass = "color-blue";
                        }

                        // 숫자 콤마
                        let formattedPrice = Number(stock.currentPrice).toLocaleString();

                        // 메인 리스트에 선택한 항목 1개만 출력하기
                        let singleItemHtml = `
                        <div class="stock-item selected" data-code="\${stock.stockCode}" data-name="\${stock.stockName}" data-price="\${stock.currentPrice}" data-change="\${stock.changePct}">
                            <div class="text-col">
                                <span class="txt-name">\${stock.stockName}</span>
                                <span class="txt-code num-font">\${stock.stockCode}</span>
                            </div>
                            <div class="text-col items-end">
                                <span class="txt-price \${colorClass} num-font">\${formattedPrice}</span>
                                <span class="txt-rate \${colorClass} num-font">\${stock.changePct}%</span>
                            </div>
                        </div>
                    `;

                        $('#stockList').html(singleItemHtml);

                        // 리스트에 그려진 종목을 클릭한 것으로 트리거 발동
                        // 아래에 정의된 .stock-item 클릭 이벤트가 실행되면서 차트/기업정보 AJAX가 나감
                        $('#stockList .stock-item').trigger('click');

                        // 기존 subscribe 모두 unsubscribe
                        const currentSubscribedCodes = Array.from(StockSocket.subscribeCodes.keys());
                        StockSocket.unsubscribe(currentSubscribedCodes);

                        // connect에서는 구독할 종목 코드를 배열로 보내줘야 한다.
                        // 지금은 하나의 종목만 있기 때문에 배열로 변경한 후 보내준다.
                        const converCodeTotList = [selectedCode];

                        StockSocket.connect(
                            contextPath,      // 서버 주소
                            converCodeTotList,       // 구독할 종목 코드들
                            function (stockData) {  // 3초마다 실행될 데이터 처리 함수
                                // 1. 데이터가 도착한 종목의 HTML 박스 찾기
                                const $item = $('.stock-item[data-code="' + stockData.stockCode + '"]');

                                // 해당 종목이 화면에 있다면
                                if ($item.length > 0) {
                                    // 2.가격 업데이트 (콤마 찍기)
                                    const formattedPrice = stockData.displayPrice;
                                    $item.find('.txt-price').text(formattedPrice);

                                    // 3.등락률 업데이트 (+- 기호 및 % 붙이기)
                                    let rate = stockData.displayRate;
                                    $item.find('.txt-rate').text(rate);

                                    // 4. 색상 변경 (빨강/파랑/검정)
                                    const $priceTexts = $item.find('.txt-price, .txt-rate');

                                    if (rate && (rate.startsWith("+") || rate.startsWith("-"))) {

                                        // 이때만 기존 색 지우고 다시 입힘
                                        $priceTexts.removeClass('color-red color-blue color-gray');

                                        if (rate.startsWith("+")) {
                                            $priceTexts.addClass('color-red');
                                        } else {
                                            $priceTexts.addClass('color-blue');
                                        }
                                    }
                                }
                            }
                        )
                    }
                })
            });

            // 검색 결과 외 클릭 시 닫기
            $(document).on('click', function (e) {
                if (!$(e.target).closest('.search-wrapper').length) {
                    $('.search-result').hide();
                }
            });
        });

        let code = '';

        // 종목 리스트 중 하나를 선택했을때 차트, 기업 정보 출력하는 url에 종목코드 보내기
        $(document).on("click", ".stock-item", function () {

            $(".stock-item").removeClass("selected");  // 다른 모든 항목의 선택 효과 제거
            $(this).addClass("selected");  // 현재 클릭한 항목에만 효과 추가

            code = $(this).data("code");
            const name = $(this).data("name");

            currentStockPrice = $(this).data("price");
            currentStockChange = $(this).data("change");

            //investChart 차트데이터 전달
            getSelectedChart(code, name);
            hasQuantity(code);
            // 기업정보에 전달
            getSelectedCorpInfo(code);
        })

        // 탭 잠금 상태 변수
        let isTabLocked = false;

        // 탭 잠금 해제 함수 (공통 사용)
        function unlockTabs() {
            setTimeout(function () {
                isTabLocked = false;
                $('.tab-btn').removeClass('locked');
            }, 2000);
        }

        // jQuery Ready Function
        $(document).ready(function () {
            // 1. 아이콘 초기화
            if (window.lucide) lucide.createIcons();

            // 2. 초기 탭 슬라이더 위치 잡기 (첫 번째 탭 기준)
            updateTabSlider($('.tab-btn.active'));

            // 초기 로딩된 리스트(관심종목)에 대해 소켓 연결
            // 화면에 있는 .stock-item 들을 찾아서 코드를 수집
            let initialCodes = [];
            $('.stock-item').each(function () {
                // data-code 값을 가져와서 배열에 담기
                initialCodes.push($(this).data('code'));
            })

            // 코드가 하나라도 있으면 소켓 연결 시작
            if (initialCodes.length > 0) {
                initListSocket(initialCodes);
            }

            // 3. 탭 클릭 이벤트 바인딩
            $('.tab-btn').on('click', function () {

                // 락이 걸려있으면 (true) 클릭 이벤트를여기서 중단
                if (isTabLocked) {
                    return;
                }

                // 락 걸기
                isTabLocked = true;

                $('.tab-btn').addClass('locked');

                const $this = $(this);
                const sortType = $this.data('sort'); // data-sort 값 가져오기

                // 이미 활성화된 탭을 눌렀을 때도 락
                if ($this.hasClass('active')) return;

                // 슬라이더 다시 보이기 (검색으로 숨겨졌을 수 있으므로)
                $('#left-tab-slider').show();

                // 탭 활성화 UI 변경
                $('.tab-btn').removeClass('active');
                $this.addClass('active');
                updateTabSlider($this);

                // AJAX 데이터 요청
                loadStockList(sortType);
            });

            const $firstItem = $('.stock-item').first();


            // 요소가 있다면 첫번째 종목 클릭처리
            if ($firstItem.length > 0) {
                // 요소가 존재하면 클릭 이벤트 강제 발생
                $firstItem.trigger('click');
            } else { // 없다면 화면에 차트 띄우지 않음
                const code = '';
                const name = '';
                //investChart 차트데이터 전달
                getSelectedChart(code, name);
                hasQuantity(code);
                // 기업정보에 전달
                getSelectedCorpInfo(code);
            }

        });

        // 탭 슬라이더 UI 업데이트 함수
        function updateTabSlider($targetBtn) {
            const $slider = $('#left-tab-slider');
            if ($targetBtn.length && $slider.length) {
                $slider.css({
                    'width': $targetBtn.outerWidth() + 'px',
                    'left': $targetBtn.position().left + 'px'
                });
            }
        }

        // 페이지 로드 시 또는 탭 클릭 시 호출
        function loadStockList(sortType) {
            $('#stockList').empty(); //초기화
            fetchStockBatch(sortType, 0); //0페이지부터 시작
        }

        // AJAX 데이터 요청 함수 (jQuery $.ajax 사용)
        function fetchStockBatch(sortType, page) {
            // URL 생성
            const url = contextPath + '/invest/main/stock/list';

            $.ajax({
                url: url,
                type: 'GET',
                data: {
                    sortType: sortType,
                    page: page  //0,1,2
                }, // 파라미터 전달
                dataType: 'json', // 응답을 JSON으로 기대함
                success: function (data) {
                    if (!data || data.length === 0) {
                        if (sortType === 'interest') {
                            $container.html('<div style="padding:20px; text-align:center;">관심종목이 없습니다. 관심종목을 추가해보세요.</div>');
                        } else {
                            $container.html('<div style="padding:20px; text-align:center;">데이터가 없습니다.</div>');
                        }
                        return;
                    }

                    if (data && data.length > 0) {
                        renderStockList(data, sortType, page);

                        if (data.length === 10 && page < 2) {
                            setTimeout(() => {
                                fetchStockBatch(sortType, page + 1);
                            }, 200);
                        } else {
                            unlockTabs();
                        }
                    } else {
                        unlockTabs();
                    }
                },
                error: function (xhr, status, error) {
                    console.error("AJAX Error:", error);
                    $('#stockList').html('<div style="padding:20px; text-align:center;">데이터를 불러오지 못했습니다.</div>');
                    unlockTabs();
                }
            });
        }

        // 리스트 렌더링 함수
        function renderStockList(data, sortType, page) {
            const $container = $('#stockList');

            let html = '';

            $.each(data, function (index, item) {
                // [중요 수정] JSP 태그(c:if)는 JS 문자열 안에서 작동 안 함 -> 자바스크립트 변수로 처리

                let colorClass = "color-gray";
                if (item.changePct && item.changePct.startsWith("+")) {
                    colorClass = "color-red";
                } else if (item.changePct && item.changePct.startsWith("-")) {
                    colorClass = "color-blue";
                }

                // 숫자 콤마
                let formattedPrice = Number(item.currentPrice).toLocaleString();

                html += `
                <div class="stock-item" data-code="\${item.stockCode}" data-name="\${item.stockName}" data-price="\${item.currentPrice}" data-change="\${item.changePct}">
                    <div class="text-col">
                        <span class="txt-name">\${item.stockName}</span>
                        <span class="txt-code num-font">\${item.stockCode}</span>
                    </div>
                    <div class="text-col items-end">
                        <span class="txt-price \${colorClass} num-font">\${formattedPrice}</span>
                        <span class="txt-rate \${colorClass} num-font">\${item.changePct}%</span>
                    </div>
                </div>
            `;
            });

            // DOM 업데이트
            $container.append(html);

            if (page === 0) {
                // 기존 subscribe 모두 unsubscribe
                const currentSubscribedCodes = Array.from(StockSocket.subscribeCodes.keys());
                StockSocket.unsubscribe(currentSubscribedCodes);
            }

            // 화면에 뿌린 종목들의 코드 긁어오기
            // map을 사용해 data 배열에서 stockCode만 뽑아서 새 배열로 만들기
            const codes = data.map(item => item.stockCode);
            StockSocket.connect(
                contextPath,      // 서버 주소
                codes,       // 구독할 종목 코드들
                function (stockData) {  // 3초마다 실행될 데이터 처리 함수
                    // 1. 데이터가 도착한 종목의 HTML 박스 찾기
                    const $item = $('.stock-item[data-code="' + stockData.stockCode + '"]');

                    // 해당 종목이 화면에 있다면
                    if ($item.length > 0) {
                        // 2.가격 업데이트 (콤마 찍기)
                        const formattedPrice = stockData.displayPrice;
                        $item.find('.txt-price').text(formattedPrice);

                        // 3.등락률 업데이트 (+- 기호 및 % 붙이기)
                        let rate = stockData.displayRate;
                        $item.find('.txt-rate').text(rate);

                        // 4. 색상 변경 (빨강/파랑/검정)
                        const $priceTexts = $item.find('.txt-price, .txt-rate');

                        if (rate && (rate.startsWith("+") || rate.startsWith("-"))) {

                            // 이때만 기존 색 지우고 다시 입힘
                            $priceTexts.removeClass('color-red color-blue color-gray');

                            if (rate.startsWith("+")) {
                                $priceTexts.addClass('color-red');
                            } else {
                                $priceTexts.addClass('color-blue');
                            }
                        }
                    }
                }
            )

            // 리스트 첫 번째 종목 클릭되도록
            if (page === 0) {
                const $firstItem = $container.find('.stock-item').first();

                // 요소가 존재하면 클릭 이벤트 강제 발생
                if ($firstItem.length > 0) {
                    $firstItem.trigger('click');
                }
            }
        }


        //investChart
        let myChartInstance;
        let currentPeriod = 'D';
        let selectedStockState = {
            stockCode: null,
            stockName: null
        };

        window.onload = function () {
            updateButtonUI('D');
        };

        function isOutOfMarketTime() {
            const now = new Date();

            const hours = now.getHours();     // 0~23
            const minutes = now.getMinutes(); // 0~59

            // 분 단위로 변환
            const currentMinutes = hours * 60 + minutes;

            const marketStart = 9 * 60;        // 09:00 → 540
            const marketEnd = 15 * 60 + 30;    // 15:30 → 930

            return currentMinutes < marketStart || currentMinutes > marketEnd;
        }


        function initLikeStatus(stockCode) {
            const likeEl = document.getElementById('header-stockLike');

            fetch(`${pageContext.request.contextPath}/stock/watchlist/isLiked?stockCode=` + stockCode)
                .then(res => res.json())
                .then(data => {
                    updateLikeUI(likeEl, data);
                })
                .catch(err => console.error("초기 상태 로드 실패: ", err));
        }

        function updateLikeUI(likeEl, isLiked) {
            likeEl.src = isLiked
                ? `${pageContext.request.contextPath}/resources/images/stockIcons/filled-heart.svg`
                : `${pageContext.request.contextPath}/resources/images/stockIcons/heart.svg`;
            likeEl.dataset.liked = isLiked.toString();
        }

        function toggleLike() {
            const likeEl = document.getElementById('header-stockLike');
            const isLiked = likeEl.dataset.liked === "true";

            const url = `${pageContext.request.contextPath}/stock/watchlist`;
            const method = isLiked ? "DELETE" : "POST";

            fetch(url, {
                method: method,
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    stockCode: selectedStockState.stockCode
                })
            })
                .then(res => {
                    if (!res.ok) throw new Error("서버 오류");
                    return res;
                })
                .then(() => {
                    updateLikeUI(likeEl, !isLiked);
                })
                .catch(err => {
                    console.error(err);
                });
        }

        function getSelectedChart(stockCode, stockName) {
            //선택된 주식 리스트
            selectedStockState.stockName = stockName;
            selectedStockState.stockCode = stockCode;

            fetch(`${pageContext.request.contextPath}/invest/chart/marketType?stockCode=` + stockCode)
                .then(res => res.text())
                .then(marketType => {
                    updateHeaderStockInfo(stockCode, stockName, marketType);
                });


            //시장 타입 가져오기
            updateHeaderStock(null, currentStockPrice, currentStockChange);
            loadChartData('D', stockCode);

        }

        function loadChartData(periodCode, stockCode) {
            currentPeriod = periodCode;
            updateButtonUI(periodCode);
            initLikeStatus(stockCode);
            //rest api 연결
            const url = `${pageContext.request.contextPath}/api/invest/chartData?periodCode=` + periodCode + "&stockCode=" + stockCode;
            fetch(url)
                .then(response => response.json())
                .then(data => {
                    const formattedData = data.map(item => ({
                        date: item.displayDate,
                        price: parseFloat(item.displayPrice.replace(/,/g, ''))
                    }));
                    if (myChartInstance) {
                        myChartInstance.destroy();
                    }
                    myChartInstance = renderStockChart('myChart', formattedData, periodCode);

                    if (periodCode === 'D') {
                        initSocket(myChartInstance, [stockCode]); //배열 형태의 stockCode가 들어가야함
                    }
                    updateButtonUI(periodCode);
                })
                .catch(error => console.error('Error fetching chart data:', error));
        }


        function updateButtonUI(periodCode) {
            const buttons = document.querySelectorAll('.period-btn');

            buttons.forEach(btn => btn.classList.remove('btn-active'));

            const activeBtn = document.getElementById('btn-' + periodCode);
            if (activeBtn) {
                activeBtn.classList.add('btn-active');
            }
        }

        function updateHeaderStockInfo(stockCode, stockName, market) {
            if (stockCode === '' || stockCode === null) {
                document.getElementById('header-stock').innerText = '-';

            } else {
                document.getElementById('header-stock').innerText = stockCode;

            }
            if (stockName === '' || stockName === null) {
                document.getElementById('header-stockName').innerText = '---';

            } else {
                document.getElementById('header-stockName').innerText = stockName;

            }

            if (market === '' || market === null) {
                document.getElementById('header-marketType').innerText = '-';

            } else {
                document.getElementById('header-marketType').innerText = market;

            }

        }

        function updateHeaderStock(stock, price, change) {
            const priceEl = document.getElementById('header-price');
            const changeEl = document.getElementById('header-change');
            //현재 장 시간이 아닐 때
            if (!stock && isOutOfMarketTime()) {
                priceEl.innerText = "현재 장 시간이 아닙니다\n" +
                    "(09:00-15:30)";
                changeEl.innerText = '';
                priceEl.style.color = '#666';
                return;
            }

            //현재가와 변동값이 있으면 보여줌
            if (stock === null) {
                if (currentStockPrice === null || currentStockPrice === '') {
                    priceEl.innerText = "- 원";
                    changeEl.innerText = '';
                } else {
                    priceEl.innerText = currentStockPrice + "원";
                    changeEl.innerText = currentStockChange;
                    tradePrice(currentStockPrice);
                }
            } else {
                priceEl.innerText = stock.displayPrice + "원";
                changeEl.innerText = stock.displayChange;
                tradePrice(stock.displayPrice);
                const sign = stock.dayOverDaySign;
                let color = "#666"; // 보합
                if (sign === "1" || sign === "2") color = "#bf0f06"; // 빨강
                if (sign === "4" || sign === "5") color = "#0051af"; // 파랑

                changeEl.style.color = color;
            }

        }

        let prevStockCode = null;
        let unsubscribeFn = null;

        function initSocket(targetChart, stockCode) {
            const dataArray = targetChart.data.datasets[0].data;
            const lastIdx = dataArray.length - 1;
            //웹소켓 리스너 연결

            if (prevStockCode === stockCode) return;

            //이전 리스너를 해제
            if (unsubscribeFn) {
                unsubscribeFn();
                unsubscribeFn = null;
            }

            //리스너 등록
            unsubscribeFn = StockSocket.addListener(stockCode, (stockData) => {
                dataArray[lastIdx] = stockData.currentPrice;
                updateHeaderStock(stockData, stockData.currentPrice, stockData.currentChange);
                targetChart.update('none');
            });
            prevStockCode = stockCode;

            const last = StockSocket.lastestData[stockCode];
            if (last) {
                dataArray[lastIdx] = last.currentPrice;
                updateHeaderStock(last, last.currentPrice, last.currentChange);
                targetChart.update('none');
            }


        }

        document.addEventListener('input', (e) => {
            if (e.target.id === 'buyAmountInput') {
                buyExpectedPrice();
            } else if (e.target.id === 'sellAmountInput') {
                sellExpectedPrice();
            }
        })
        document.addEventListener('click', (e) => {
            if (e.target.id === 'header-stockLike') {
                toggleLike();
            }
        });

        document.addEventListener('click', (e) => {
            if (e.target.id === 'btn-D') {
                loadChartData('D', selectedStockState.stockCode);
            }
        });
        document.addEventListener('click', (e) => {
            if (e.target.id === 'btn-W') {
                loadChartData('W', selectedStockState.stockCode);
            }
        });
        document.addEventListener('click', (e) => {
            if (e.target.id === 'btn-M') {
                loadChartData('M', selectedStockState.stockCode);
            }
        });


        // investBuySell
        let currentTradePrice = null;
        let tradeStockCode = null;

        function switchTab(type) {
            const buyBtn = document.getElementById('buy-button');
            const sellBtn = document.getElementById('sell-button');

            //매수 매도 탭 전환
            if (type === 'buy') {
                buyBtn.classList.add('border-[#5E45EB]', 'text-[#2D14B8]', 'active');
                sellBtn.classList.remove('border-[#5E45EB]', 'text-[#2D14B8]', 'active');
                sellBtn.classList.add('border-transparent', 'text-[#666666]');
                buyBtn.classList.remove('border-transparent', 'text-[#666666]');
            } else {
                sellBtn.classList.add('border-[#5E45EB]', 'text-[#2D14B8]', 'active');
                buyBtn.classList.remove('border-[#5E45EB]', 'text-[#2D14B8]', 'active');
                buyBtn.classList.add('border-transparent', 'text-[#666666]');
                sellBtn.classList.remove('border-transparent', 'text-[#666666]');
            }

            if (type !== 'sell') {
                document.getElementById('sell-form').classList.add('hidden');
                document.getElementById('buy-form').classList.remove('hidden');
            } else {
                document.getElementById('sell-form').classList.remove('hidden');
                document.getElementById('buy-form').classList.add('hidden');
                hasQuantity(selectedStockState.stockCode);
            }

        }

        document.addEventListener('click', (e) => {
            if (e.target.id === 'buy-button') {
                switchTab('buy');
            }
            if (e.target.id === 'sell-button') {
                switchTab('sell');
            }
        });

        document.addEventListener('click', (e) => {
            if (e.target.id === 'doBuyButton') {
                trade(code);
            }
            if (e.target.id === 'doSellButton') {
                trade(code);
            }
        });

        function tradePrice(currentPrice) {
            if (currentPrice === undefined) currentPrice = '-';
            currentTradePrice = currentPrice;
            document.getElementById('buyPrice').innerText = currentPrice;
            document.getElementById('sellPrice').innerText = currentPrice;

            buyExpectedPrice();
            sellExpectedPrice();
        }

        function hasQuantity(stockCode) {
            //보유 수량
            fetch(`${pageContext.request.contextPath}/invest/hasStockQuantity?stockCode=` + stockCode)
                .then(res => {
                    if (!res.ok) throw new Error("데이터 조회 실패");
                    return res.json();
                })
                .then(data => {
                    document.getElementById('hasStockQuantity').innerText = data;
                })
                .catch(err => console.error(err));
        }

        function isInvestTabActive() {
            return document.getElementById('investJsp')?.classList.contains('active');
        }


        function buyExpectedPrice() {
            //예상 금액 계산
            const price = currentTradePrice;
            const amount = Number(document.getElementById('buyAmountInput').value);
            let total = price * amount;

            if (isNaN(total)) {
                document.getElementById('buyExpectedPrice').innerText = '-';
                return;
            } else if (isInvestTabActive() && total !== 0 && total !== null) {
                document.getElementById('doBuyButton').classList.remove('bg-[#E6E7EB]', 'text-[#999999]');
                document.getElementById('doBuyButton').classList.add('bg-[#EB3A3E]', 'text-[F4F4F4]', 'hover:bg-[#C12F33]');
            }
            document.getElementById('buyExpectedPrice').innerText = total.toLocaleString();
        }

        function sellExpectedPrice() {
            //예상 금액 계산
            const price = currentTradePrice;
            const amount = Number(document.getElementById('sellAmountInput').value);
            const total = price * amount;
            if (isNaN(total)) {
                document.getElementById('sellExpectedPrice').innerText = '-';
                return;
            } else if (isInvestTabActive() && total !== 0 && total !== null) {

                document.getElementById('doSellButton').classList.remove('bg-[#E6E7EB]', 'text-[#999999]');
                document.getElementById('doSellButton').classList.add('bg-[#EB3A3E]', 'text-[F4F4F4]', 'hover:bg-[#C12F33]');
            }
            document.getElementById('sellExpectedPrice').innerText = total.toLocaleString();
        }

        function trade(stockCode) {
            //매수, 매도 버튼 로직
            let amount;
            tradeStockCode = stockCode;
            const tradeType = document.querySelector('.tab-item.active').innerText.trim() === '매수' ? 'Y' : 'N';

            if (tradeType === 'Y') {
                amount = Number(document.getElementById('buyAmountInput').value);
            } else {
                amount = Number(document.getElementById('sellAmountInput').value);
            }

            const data = {
                stockCode: String(stockCode),
                tradeType: tradeType,
                tradePrice: currentTradePrice,
                tradeQuantity: amount
            };

            fetch(`${pageContext.request.contextPath}/trade/BuySell`, {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(data)
            })
                .then(response => response.json())
                .then(result => {
                    if (result.success) {
                        alert(tradeType === 'Y' ? '매수 완료!' : '매도 완료!');
                        $("#investBuySell").load(location.href + " #investBuySell > *");
                    } else {
                        if (tradeType === 'Y') {
                            document.getElementById('buyErrorMessage').innerText = result.message;
                        } else {
                            document.getElementById('sellErrorMessage').innerText = result.message;
                        }
                    }
                })
                .catch(error => console.log('Error: ' + error));
        }
    })();
</script>
