<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <style>

        /* 탭 네비게이션 */
        .tab-nav {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
            border-bottom: 2px solid #e0e0e0;
            padding-bottom: 10px;
        }

        .tab-nav a {
            text-decoration: none;
            color: #999;
            font-size: 18px;,7
            font-weight: 500;
            padding-bottom: 10px;
            position: relative;
        }

        .tab-nav a.active {
            color: #0046ff;
            font-weight: 800;
        }

        .tab-nav a.active::after {
            content: '';
            position: absolute;
            bottom: -12px;
            left: 0;
            width: 100%;
            height: 3px;
            background-color: #ffc107;
        }
    </style>

<div class="w-full h-full flex flex-col">
    <!-- 탭 네비게이션 -->
    <nav class="tab-nav">
        <button id="tabButton" onclick="changeJsp(this, 'my')">마이</button>
        <button id="tabButton" onclick="changeJsp(this, 'invest')">투자</button>
    </nav>
    <div id="myJsp">
        <jsp:include page="my.jsp"></jsp:include>
    </div>
    <div id="investJsp" class="hidden">
        <div id="stock" class="flex flex-row gap-4">
            <div id="investComponents" class="flex flex-col gap-4">
                <jsp:include page="investStockList.jsp"></jsp:include>
                <jsp:include page="investBuySell.jsp"></jsp:include>
            </div>
            <div class="flex flex-col gap-4 flex-1">
            <jsp:include page="investChart.jsp"></jsp:include>
                <div id="stockCorpInfo-container">
                    <jsp:include page="stockCorpInfoCard.jsp"></jsp:include>
                </div>
            </div>
        </div>
    </div>


</div>
<script>
    function changeJsp(element, type) {

        if (type === 'my') {
            document.getElementById('myJsp').classList.remove('hidden');
            document.getElementById('investJsp').classList.add('hidden');
        } else {
            document.getElementById('investJsp').classList.remove('hidden');
            document.getElementById('myJsp').classList.add('hidden');
        }
    }
</script>
