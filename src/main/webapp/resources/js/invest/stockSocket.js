const StockSocket = {
    //연결 및 구독 관리 파일 & 데이터 스로틀링(현재 3초)

    stompClient: null,
    //임시 저장할 변수
    lastestData: {},
    //연결 상태
    isConnected: false,
    //구독한 주식 코드
    subscribeCodes: new Set(),
    updateTimer: null,

    connect: function (contextPath, stockCodes, onMessageCallback) {
        //stockCodes: 데이터를 받을 종목 코드 배열, onMessageCallback: 웹소켓을 연결하고 실행할 함수

        //이미 연결되어있으면 구독만 처리하는 로직
        if (this.isConnected && this.stompClient) {
            console.log("Already Connected");

            stockCodes.forEach(stockCode => {
                if (this.subscribeCodes.has(stockCode)) return;
                this.subscribeStock(stockCode);
            });
            return;
        }

        //웹소켓 연결
        const socket = new SockJS(`${contextPath}/ws-jujuclub`);
        this.stompClient = Stomp.over(socket);

        const self = this;
        this.stompClient.connect({}, function (frame) {
            console.log("connected: " + frame);
            self.isConnected = true;

            stockCodes.forEach(stockCode => {
                self.subscribeStock(stockCode);
            });

            if (!self.updateTimer) {
                self.updateTimer = setInterval(() => {
                    Object.values(self.lastestData).forEach(data => {
                        onMessageCallback?.(data);
                    });
                }, 3000); //화면 업데이트 시간
            }
            const initialRequest = {stockCodes: stockCodes};
            self.stompClient.send("/app/invest/request/chartData", {}, JSON.stringify(initialRequest));
        }, function (error) {
            console.error("websocket error: ", error);
            self.isConnected = false;
        });
    },

    //구독
    subscribeStock: function (stockCode) {
        if (this.subscribeCodes.has(stockCode)) return;

        this.stompClient.subscribe(`/topic/stock/${stockCode}`, (response) => {
            const stockData = JSON.parse(response.body);
            console.log("웹소켓 원본 데이터 수신:", stockData);
            this.lastestData[stockData.stockCode] = stockData;
        });

        this.subscribeCodes.add(stockCode);
        console.log(`${stockCode} 구독 완료`);
    },

    //웹소켓 연결 중지
    disconnect: function () {
        if (this.stompClient) {
            this.stompClient.disconnect();
        }

        clearInterval(this.updateTimer);

        this.stompClient = null;
        this.isConnected = false;
        this.updateTimer = null;
        this.subscribeCodes.clear();
        this.lastestData = {};

        console.log('웹소켓 연결 종료');
    }
};