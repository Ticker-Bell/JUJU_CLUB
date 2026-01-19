<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>매도매수</title>
</head>
<body>
<div class="w-full h-full p-2 bg-[#FBFBFB] rounded-[20px] outline outline-2 outline-[#E6E7EB]">
    <div id="tab-header" class="w-1/2 flex my-4 border-b border-[#E6E7EB] ">
        <button onclick="switchTab(this, 'sell')"
                class="tab-item active flex-1 py-2 px-1 border-b-[3px] border-[#5E45EB] border-xs text-[#2D14B8] font-medium text-base transition-all hover:text-[#3819E6]">
            매수
        </button>
        <button onclick="switchTab(this, 'buy')"
                class="tab-item flex-1 py-2 px-1 border-b-[3px] border-transparent border-xs text-[#666666] font-medium text-base transition-all hover:text-[#3819E6]">
            매도
        </button>
    </div>

    <div id="tab-content" class="m-8 px-16">
        <div id="buy-form" class="flex flex-col gap-6">
            <div id="buy-form-item" class="flex justify-between">
                <label class="text-base font-medium text-[#666666]">가격</label>
                <input
                        class="pl-2 border-2 rounded-md border-[#E6E7EB] py-1 focus:border-[#5E45EB] outline-none"
                        type="number"
                        id="priceInput"
                        alt="가격 입력창"
                        oninput="expectedPrice()"
                />
            </div>
            <div id="buy-form-item" class="flex justify-between">
                <label class="text-base font-medium text-[#666666]">수량</label>
                <input
                        class="pl-2 border-2 rounded-md border-[#E6E7EB] py-1 focus:border-[#5E45EB] outline-none"
                        type="number"
                        id="amountInput"
                        alt="수량 입력창"
                        oninput="expectedPrice()"
                />
            </div>
            <div id="buy-form-item" class="flex justify-between">
                <label class="text-sm font-normal text-[#666666]">예상금액</label>
                <div class="flex flex-row gap-2">
                    <p id="expectedPrice" class="text-[#222222]">0</p>
                    <p class="text-[#666666]">원</p>
                </div>
            </div>
            <p id="warningMessage" class="text-[#EB3A3E] text-sm font-normal"></p>
            <button id="buyButton" onclick="buy()"
                    class="mt-6 py-2 border-2 rounded-[20px] bg-[#E6E7EB] text-[#999999] text-base font-medium">
                매수하기
            </button>

        </div>
        <div id="sell-form" class="hidden">매도 양식이 들어갈 자리입니다.</div>
    </div>
</div>

<script>
    function switchTab(element, type) {
        const tabs = document.querySelectorAll('.tab-item');

        tabs.forEach(tab => {
            tab.classList.remove('border-[#5E45EB]', 'text-[#2D14B8]', 'active');
            tab.classList.add('border-transparent', 'text-[#666666]');
        });
        element.classList.add('border-[#5E45EB]', 'text-[#2D14B8]', 'active');
        element.classList.remove('border-transparent', 'text-[#666666]');

        if (type !== 'sell') {
            document.getElementById('sell-form').classList.remove('hidden');
            document.getElementById('buy-form').classList.add('hidden');
        } else {
            document.getElementById('sell-form').classList.add('hidden');
            document.getElementById('buy-form').classList.remove('hidden');
        }
    }

    function expectedPrice() {
        const price = Number(document.getElementById('priceInput').value);
        const amount = Number(document.getElementById('amountInput').value);
        const total = price * amount;

        if (total !== 0 && total !== null) {
            document.getElementById('buyButton').classList.remove('bg-[#E6E7EB]', 'text-[#999999]');
            document.getElementById('buyButton').classList.add('bg-[#EB3A3E]', 'text-[F4F4F4]', 'hover:bg-[#C12F33]');
        }
        document.getElementById('expectedPrice').innerText = total.toLocaleString();
    }

    function buy(){
        document.getElementById('warningMessage').innerText = "매수 금액이 보유 자금을 초과했습니다.";
    }
</script>

</body>
</html>
