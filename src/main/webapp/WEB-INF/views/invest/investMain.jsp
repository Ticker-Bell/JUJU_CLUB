<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                    <jsp:include page="investBuySell.jsp"></jsp:include>
                </div>
                <div class="flex flex-col w-full items-center gap-4 p-2 bg-[#FBFBFB] rounded-[20px] outline outline-2 outline-[#E6E7EB]">

                    <jsp:include page="investChart.jsp"></jsp:include>
                    <div id="stockCorpInfo-container">
                        <jsp:include page="stockCorpInfoCard.jsp"></jsp:include>
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
</script>
