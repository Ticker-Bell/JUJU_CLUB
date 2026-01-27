<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<style>
    /* 탭 네비게이션 */
    .tab-nav {
        display: flex;
        border-bottom: 2px solid #E6E7EB;
        margin-bottom: 20px;
        gap: 5px;
    }

    .tab-container {
        position: relative;
    }

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
        transition: opacity 0.25s ease,
        transform 0.25s ease;
    }

    .tab-nav button {
        text-decoration: none;
        color: #888888;
        font-size: 24px;
        font-weight: 700;
        padding: 10px;
    }

    .tab-nav button.active {
        color: #3819E6;
        border-bottom: 3px solid #3819E6;
    }
</style>

<div class="w-full flex flex-col px-[24]">
    <!-- 탭 네비게이션 -->
    <nav class="tab-nav">
        <button id="myTab" class="active" onclick="changeJsp(this, 'my')">마이</button>
        <button id="investTab" onclick="changeJsp(this, 'invest')">투자</button>
    </nav>
    <div class="tab-container">
        <div id="myJsp" class="tab-content active">
            <jsp:include page="my.jsp"></jsp:include>
        </div>
        <div id="investJsp" class="tab-content">
            <div id="stock" class="flex flex-row justify-between w-full gap-16">
                <div id="investComponents" class="flex flex-col gap-16">
                    <jsp:include page="investStockList.jsp"></jsp:include>
                </div>
                <div class="flex flex-col w-full items-center gap-4 p-2 bg-[#FBFBFB] rounded-[12px] outline outline-2 outline-[#E6E7EB]">
                    <jsp:include page="investChart.jsp" ></jsp:include>
                    <div id="stockCorpInfo-container" class="w-full">
                    <jsp:include page="stockCorpInfoCard.jsp" ></jsp:include>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function changeJsp(element, type) {

        if (type === 'my') {
            myJsp.classList.add('active');
            investJsp.classList.remove('active');

            myTab.classList.add('active');
            investTab.classList.remove('active');
        } else {
            investJsp.classList.add('active');
            myJsp.classList.remove('active');

            investTab.classList.add('active');
            myTab.classList.remove('active');
        }
    }
    //stockCorpInfoCard.jsp에 있던 script
    function getSelectedCorpInfo(stockCode) {
        //stockCode에 빈문자열이 들어올 경우
        // document.getElementById('stockCorpInfo-container').innerHTML = '';
        // const timeEl = document.getElementById('update_time');
        // if(stockCode.trim() === "" || !stockCode){
        //     if(timeEl){
        //         timeEl.innerText = '';
        //     }
        //     return;
        // }

        //fetch로 html을 받아와서 stockCorpInfo-container 안에 넣어준다.
        fetch('${cpath}' + '/invest/corpInfo?stockCode=' + encodeURIComponent(stockCode))
            .then(res =>
                res.text() //html 값 요청, 다음 then으로 결과 토스
            )
            .then(html => {
                //html 갈기(화면바꾸기)
                document.getElementById('stockCorpInfo-container').innerHTML = html;
                //시간찍기(html이랑 순서 바뀌면, 표시 X)
                const now = new Date();
                const timeString = now.toLocaleTimeString('ko-KR', {hour12: false});
                const timeEl = document.getElementById('update_time');
                if(timeEl){
                    timeEl.innerText = timeString;
                }
            })
            .catch(error => {
                console.error('기업정보로딩실패 : ', error);
                document.getElementById('stockCorpInfo-container').innerHTML = '<p style="padding:10px;">정보를 불러오지 못했습니다.</p>';
            });
    }
</script>
