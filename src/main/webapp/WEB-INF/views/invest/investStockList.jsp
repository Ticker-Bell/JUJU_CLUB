<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Stock List Component</title>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <script src="https://unpkg.com/lucide@latest"></script>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css" />

    <style>

        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Pretendard', sans-serif; background-color: transparent; color: #191919; }
        .num-font { font-feature-settings: "tnum"; letter-spacing: 0; font-weight: 600; }

        .stock-app-container {
            width: 360px; height: 600px;
            background-color: #ffffff; border: 1px solid #E5E7EB; border-radius: 12px;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
            display: flex; flex-direction: column; padding: 16px; overflow: hidden;
        }

        .search-wrapper { position: relative; flex-shrink: 0; }
        .search-icon { position: absolute; left: 0; top: 10px; width: 16px; height: 16px; color: #9CA3AF; }
        .search-input {
            width: 100%; background-color: transparent; border: none; border-bottom: 1px solid #E5E7EB;
            padding: 8px 8px 8px 24px; font-size: 14px; font-weight: 800; color: #111827; outline: none; transition: border-color 0.2s;
        }
        .search-input::placeholder { color: #D1D5DB; }
        .search-input:focus { border-bottom-color: #5E45EB; }

        .tab-wrapper { margin-top: 16px; position: relative; border-bottom: 1px solid #E5E7EB; flex-shrink: 0; }
        .tab-list { display: flex; gap: 24px; align-items: center; }
        .tab-btn {
            background: none; border: none; padding-bottom: 10px; font-weight: 900; font-size: 12px; color: #9CA3AF;
            cursor: pointer; position: relative;
        }
        .tab-btn.active { color: #111827; }

        #left-tab-slider {
            height: 2px; background-color: #5E45EB; position: absolute; bottom: 0; left: 0; transition: all 0.25s ease;
        }

        .stock-list-container { margin-top: 12px; flex: 1; min-height: 0; display: flex; flex-direction: column; }
        .stock-scroll-area { flex: 1; overflow-y: auto; }
        .stock-scroll-area::-webkit-scrollbar { width: 6px; }
        .stock-scroll-area::-webkit-scrollbar-thumb { background: #E5E7EB; border-radius: 10px; }
        .stock-scroll-area::-webkit-scrollbar-thumb:hover { background: #D1D5DB; }

        .stock-item {
            display: flex; justify-content: space-between; align-items: center; padding: 12px;
            border-bottom: 1px solid #F9FAFB; cursor: pointer; transition: background-color 0.15s;
        }
        .stock-item:hover { background-color: #F9FAFB; }
        .text-col { display: flex; flex-direction: column; }
        .items-end { align-items: flex-end; }
        .txt-name { font-size: 14px; font-weight: 800; color: #111827; }
        .txt-code { font-size: 10px; font-weight: 700; color: #9CA3AF; margin-top: 2px; }
        .txt-price { font-size: 14px; font-weight: 800; }
        .txt-rate { font-size: 10px; font-weight: 800; margin-top: 2px; }

        .color-red { color: #DC2626; }
        .color-blue { color: #2563EB; }
        .color-gray { color: #111827; }

        /* 랭크 스타일 (필요시 추가) */
        .rank { font-size: 10px; color: #5E45EB; font-weight: bold; margin-bottom: 2px;}
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
            <button class="tab-btn active" data-sort="interest">관심종목</button>
            <button class="tab-btn" data-sort="volume">거래량</button>
            <button class="tab-btn" data-sort="rising">상승률</button>
            <button class="tab-btn" data-sort="falling">하락률</button>
            <button class="tab-btn" data-sort="marketCap">시가총액</button>
        </div>
        <div id="left-tab-slider"></div>
    </div>

    <div class="stock-list-container">
        <div class="stock-scroll-area" id="stockList">
            <c:if test="${empty stockDTOList}">
                <div style="padding:20px; text-align:center;">관심종목이 없습니다. 관심종목을 추가해보세요.</div>
            </c:if>
            <c:if test="${not empty stockDTOList}">
                <c:forEach items="${stockDTOList}" var="stock">
                    <div class="stock-item" data-code="${stock.stockCode}">
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
                            <span class="txt-price color-red num-font">000000</span>
                            <span class="txt-rate color-red num-font">+0.00%</span>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </div>
</div>

<script>
    const contextPath = "${pageContext.request.contextPath}";

    // 종목 리스트 중 하나를 선택했을때 차트, 기업 정보 출력하는 url에 종목코드 보내기
    $(document).on("click", "stock-item", function () {
        const code = $(this).data("code");

        // 차트에 전달
        $.ajax({
            url: contextPath + "/invest/chart/selectedStockCode",
            type: "GET",
            data: {stockCode: code}
        })

        // 기업정보에 전달
        $.ajax({
            url: contextPath + "/invest/corpoInfo/selectedStockCode",
            type: "GET",
            data: {stockCode: code}
        })
    })


    // jQuery Ready Function
    $(document).ready(function() {
        // 1. 아이콘 초기화
        if(window.lucide) lucide.createIcons();

        // 2. 초기 탭 슬라이더 위치 잡기 (첫 번째 탭 기준)
        updateTabSlider($('.tab-btn.active'));

        // 3. 탭 클릭 이벤트 바인딩
        $('.tab-btn').on('click', function() {
            const $this = $(this);
            const sortType = $this.data('sort'); // data-sort 값 가져오기

            // 탭 활성화 UI 변경
            $('.tab-btn').removeClass('active');
            $this.addClass('active');
            updateTabSlider($this);

            // AJAX 데이터 요청
            fetchStockList(sortType);
        });
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

    // AJAX 데이터 요청 함수 (jQuery $.ajax 사용)
    function fetchStockList(sortType) {
        // URL 생성
        const url = contextPath + '/invest/main/stock/list';

        console.log("요청 URL:", url, "Sort:", sortType);

        $.ajax({
            url: url,
            type: 'GET',
            data: { sortType: sortType }, // 파라미터 전달
            dataType: 'json', // 응답을 JSON으로 기대함
            success: function(data) {
                renderStockList(data, sortType);
            },
            error: function(xhr, status, error) {
                console.error("AJAX Error:", error);
                $('#stockList').html('<div style="padding:20px; text-align:center;">데이터를 불러오지 못했습니다.</div>');
            }
        });
    }

    // 리스트 렌더링 함수
    function renderStockList(data, sortType) {
        const $container = $('#stockList');

        if (!data || data.length === 0) {
            if(sortType === 'interest'){
                $container.html('<div style="padding:20px; text-align:center;">관심종목이 없습니다. 관심종목을 추가해보세요.</div>');
            }else{
                $container.html('<div style="padding:20px; text-align:center;">데이터가 없습니다.</div>');
            }
            return;
        }

        let html = '';

        $.each(data, function(index, item) {
            // [중요 수정] JSP 태그(c:if)는 JS 문자열 안에서 작동 안 함 -> 자바스크립트 변수로 처리
            let rankHtml = '';
            if (item.rank) {
                rankHtml = `<span class="rank">\${item.rank}</span>`;
            }

            // 가격, 등락률 등 데이터 포맷팅 필요 시 여기서 처리
            // 예: let priceClass = (item.rate > 0) ? 'color-red' : 'color-blue';

            html += `
                <div class="stock-item" data-code="\${item.stockCode}">
                    <div class="text-col">
                        \${rankHtml}
                        <span class="txt-name">\${item.stockName}</span>
                        <span class="txt-code num-font">\${item.stockCode}</span>
                    </div>
                    <div class="text-col items-end">
                        <span class="txt-price color-red num-font">000000</span>
                        <span class="txt-rate color-red num-font">+0.00%</span>
                    </div>
                </div>
            `;
        });

        // DOM 업데이트
        $container.html(html);
    }
</script>
</body>
</html>