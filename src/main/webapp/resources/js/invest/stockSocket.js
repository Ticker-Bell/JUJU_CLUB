const StockSocket = {
    //연결 및 구독 관리 파일 & 데이터 스로틀링(현재 3초)

    stompClient: null,
    //임시 저장할 변수
    lastestData: {},
    //연결 상태
    isConnected: false,
    //구독한 주식 코드 , 구독 해지를 위해 객체를 저장할 Map 형태 (종목코드:구독객체)
    subscribeCodes: new Map(),
    updateTimer: null,

    connect: function (contextPath, stockCodes, onMessageCallback) {
        //stockCodes: 데이터를 받을 종목 코드 배열, onMessageCallback: 웹소켓을 연결하고 실행할 함수
        const self = this;

        //이미 연결되어있으면 구독만 처리하는 로직
        if (this.isConnected && this.stompClient) {
            const newCodes = stockCodes.filter(stockCode => !self.subscribeCodes.has(stockCode));
            newCodes.forEach(newCode => self.subscribeStock(newCode));

            //새로 구독하는 게 있으면 데이터 요청
            if (newCodes.length > 0) {
                const payload = {stockCodes: Array.isArray(stockCodes) ? stockCodes : [stockCodes], tr_type: "1"}
                self.stompClient.send("/app/invest/request/chartData", {}, JSON.stringify(payload));
            }
            return;
        }

        //웹소켓 연결
        const socket = new SockJS(`${contextPath}/ws-jujuclub`);
        this.stompClient = Stomp.over(socket);

        this.stompClient.connect({}, function (frame) {
            console.log("connected: " + frame);
            self.isConnected = true;

            stockCodes.forEach(stockCode => {
                self.subscribeStock(stockCode);
            });

            if (!self.updateTimer) {
                self.updateTimer = setInterval(() => {
                    Object.values(self.lastestData).forEach(data => {
                        onMessageCallback?.(data); //callback 함수에 data 삽입
                    });
                }, 3000); //화면 업데이트 시간
            }

            const payload = {
                stockCodes: Array.isArray(stockCodes) ? stockCodes : [stockCodes], tr_type: "1"
            }; //stockCodes로 메시지 보냄

            self.stompClient.send("/app/invest/request/chartData", {}, JSON.stringify(payload));

        }, function (error) {
            console.error("websocket error: ", error);
            self.isConnected = false;
        });
    },

    //구독
    subscribeStock: function (stockCode) {
        if (this.subscribeCodes.has(stockCode)) return;

        const subscription = this.stompClient.subscribe(`/topic/stock/${stockCode}`, (response) => {
            const stockData = JSON.parse(response.body);
            console.log("웹소켓 원본 데이터 수신:", stockData);
            this.lastestData[stockData.stockCode] = stockData;
        });

        //구독 객체를 저장
        this.subscribeCodes.set(stockCode, subscription);
        console.log(`${stockCode} 구독 완료`);
    },

    //구독 해제
    unsubscribe: function (stockCodeList) {
        //웹소켓이 연결되어있지 않으면 종료
        if (!this.stompClient || !this.isConnected) return;

        const codesToUnsubscribe = Array.isArray(stockCodeList) ? stockCodeList : [stockCodeList];

        codesToUnsubscribe.forEach(stockCode => {
            const subscription = this.subscribeCodes.get(stockCode);

            if (subscription) {
                subscription.unsubscribe(); //클라이언트 콜백 함수에서 제거

                this.subscribeCodes.delete(stockCode); //구독 리스트에서 제거
                delete this.lastestData[stockCode]; //화면에 업데이트할 대상에서 제거

                //구독 해제 요청
                const payload = {stockCodes: [stockCode], tr_type: "2"};
                this.stompClient.send("/app/invest/request/chartData", {}, JSON.stringify(payload));

                console.log(`${stockCode} 구독 해제 및 데이터 삭제 완료`);
            }
        });
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