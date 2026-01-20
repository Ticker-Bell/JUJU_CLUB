const StockSocket = {
    //연결 및 구독 관리 파일 & 데이터 스로틀링(현재 3초)

    stompClient: null,
    //임시 저장할 변수
    lastestData: {},

    connect: function (contextPath, stockCodes, onMessageCallback) {
        //stockCodes: 데이터를 받을 종목 코드 배열, onMessageCallback: 웹소켓을 연결하고 실행할 함수
        const socket = new SockJS(`${contextPath}/ws-jujuclub`);
        this.stompClient = Stomp.over(socket);

        const self = this;
        this.stompClient.connect({}, function (frame) {
            console.log("connected: " + frame);
            stockCodes.forEach(stockCode => {
                self.stompClient.subscribe(`/topic/stock/${stockCode}`,
                    function (response) {
                        const stockData = JSON.parse(response.body);
                        console.log("웹소켓 원본 데이터 수신:", stockData)
                        self.lastestData[stockData.stockCode] = stockData;
                    });
                console.log(`${stockCode}구독 시작`);
            });

            setInterval(() => {
                Object.values(self.lastestData).forEach(data => {
                    if (onMessageCallback) onMessageCallback(data);
                });
            }, 3000); //3초 간격으로 화면 업데이트
            const initialRequest = {stockCodes: stockCodes};

            self.stompClient.send("/app/invest/request/chartData", {}, JSON.stringify(initialRequest));
        }, function (error) {
            console.error("websocket error: ", error);
        });
    }
};