<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>매도매수</title>
</head>
<body>
<div class="min-w-[320px] w-full  min-h-[400px] p-2 bg-[#FBFBFB] rounded-[12px] outline outline-2 outline-[#E6E7EB]">
    <div id="tab-header" class="w-1/2 flex my-4 border-b border-[#E6E7EB] ">
        <button onclick="switchTab(this, 'buy')"
                class="tab-item active flex-1 py-2 px-1 border-b-[3px] border-[#5E45EB] border-xs text-[#2D14B8] font-medium text-base transition-all hover:text-[#3819E6]">
            매수
        </button>
        <button onclick="switchTab(this, 'sell')"
                class="tab-item flex-1 py-2 px-1 border-b-[3px] border-transparent border-xs text-[#666666] font-medium text-base transition-all hover:text-[#3819E6]">
            매도
        </button>
    </div>

    <div id="tab-content" class="p-4">
        <div id="buy-form" class="flex flex-col gap-6">
            <div id="buy-form-item" class="flex justify-between">
                <label class="text-base font-medium text-[#666666]">가격</label>
                <label
                        class="pl-2 border-2 rounded-md border-[#E6E7EB] py-1 focus:border-[#5E45EB] outline-none"
                        id="buyPrice"
                ></label>
            </div>
            <div id="buy-form-item" class="flex justify-between">
                <label class="text-base font-medium text-[#666666]">수량</label>
                <input
                        class="pl-2 border-2 rounded-md border-[#E6E7EB] py-1 focus:border-[#5E45EB] outline-none"
                        type="number"
                        id="buyAmountInput"
                        alt="수량 입력창"
                        oninput="buyExpectedPrice()"
                />
            </div>
            <div id="buy-form-item" class="flex justify-between">
                <label class="text-sm font-normal text-[#666666]">예상금액</label>
                <div class="flex flex-row gap-2">
                    <p id="buyExpectedPrice" class="text-[#222222]">0</p>
                    <p class="text-[#666666]">원</p>
                </div>
            </div>
            <p id="buyErrorMessage" class="text-[#EB3A3E] text-sm font-normal"></p>
            <button id="buyButton" onclick="trade()"
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
                <label
                        class="pl-2 border-2 rounded-md border-[#E6E7EB] py-1 focus:border-[#5E45EB] outline-none"
                        id="sellPrice"
                ></label>
            </div>
            <div id="sell-form-item" class="flex justify-between">
                <label class="text-base font-medium text-[#666666]">수량</label>
                <input
                        class="pl-2 border-2 rounded-md border-[#E6E7EB] py-1 focus:border-[#5E45EB] outline-none"
                        type="number"
                        id="sellAmountInput"
                        alt="수량 입력창"
                        oninput="sellExpectedPrice()"
                />
            </div>
            <div id="sell-form-item" class="flex justify-between">
                <label class="text-sm font-normal text-[#666666]">예상금액</label>
                <div class="flex flex-row gap-2">
                    <p id="sellExpectedPrice" class="text-[#222222]">0</p>
                    <p class="text-[#666666]">원</p>
                </div>
            </div>

            <p id="sellErrorMessage" class="text-[#EB3A3E] text-sm font-normal"></p>

            <button id="sellButton" onclick="trade()"
                    class="mt-6 mb-6 py-2 border-2 rounded-[20px] bg-[#E6E7EB] text-[#999999] text-base font-medium">
                매도하기
            </button>

        </div>
    </div>
</div>
<script>
    let currentTradePrice = null;
    function switchTab(element, type) {
        //매수 매도 탭 전환
        const tabs = document.querySelectorAll('.tab-item');

        tabs.forEach(tab => {
            tab.classList.remove('border-[#5E45EB]', 'text-[#2D14B8]', 'active');
            tab.classList.add('border-transparent', 'text-[#666666]');
        });
        element.classList.add('border-[#5E45EB]', 'text-[#2D14B8]', 'active');
        element.classList.remove('border-transparent', 'text-[#666666]');

        if (type !== 'sell') {
            document.getElementById('sell-form').classList.add('hidden');
            document.getElementById('buy-form').classList.remove('hidden');
        } else {
            document.getElementById('sell-form').classList.remove('hidden');
            document.getElementById('buy-form').classList.add('hidden');
            hasQuantity(selectedStockState.stockCode);
        }
    }

    function tradePrice(currentPrice) {
        if(currentPrice === undefined) currentPrice='-';
        currentTradePrice=currentPrice;
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
                console.log("받은 데이터: " + data);
                document.getElementById('hasStockQuantity').innerText = data;
            })
            .catch(err => console.error(err));
    }

    function buyExpectedPrice() {
        //예상 금액 계산
        const price =currentTradePrice;
        const amount = Number(document.getElementById('buyAmountInput').value);
        let total = price * amount;


        if (total !== 0 && total !== null) {
            document.getElementById('buyButton').classList.remove('bg-[#E6E7EB]', 'text-[#999999]');
            document.getElementById('buyButton').classList.add('bg-[#EB3A3E]', 'text-[F4F4F4]', 'hover:bg-[#C12F33]');
        }
        document.getElementById('buyExpectedPrice').innerText = total.toLocaleString();
    }

    function sellExpectedPrice() {
        //예상 금액 계산
        const price = currentTradePrice;
        const amount = Number(document.getElementById('sellAmountInput').value);
        const total = price * amount;

        if (total !== 0 && total !== null) {

            document.getElementById('sellButton').classList.remove('bg-[#E6E7EB]', 'text-[#999999]');
            document.getElementById('sellButton').classList.add('bg-[#EB3A3E]', 'text-[F4F4F4]', 'hover:bg-[#C12F33]');
        }
        document.getElementById('sellExpectedPrice').innerText = total.toLocaleString();
    }

    function trade(stockCode) {
        //매수, 매도 버튼 로직
        let tradeStockCode = stockCode;
        let amount;
        const tradeType = document.querySelector('.tab-item.active').innerText.trim() === '매수' ? 'Y' : 'N';

        if (tradeType === 'Y') {
            amount = Number(document.getElementById('buyAmountInput').value);
        } else {
            amount = Number(document.getElementById('sellAmountInput').value);
        }
console.log("tradestockCode"+ tradeStockCode);

        const data = {
            stockCode: String(tradeStockCode),
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
                    location.reload();
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
</script>

</body>
</html>
