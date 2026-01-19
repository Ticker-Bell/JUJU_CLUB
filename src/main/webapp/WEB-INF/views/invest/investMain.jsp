
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div>

    <div id="stock-list-box">
        <jsp:include page="investStockList.jsp"></jsp:include>
    </div>

    <!-- 테스트용  나중에 제거하기-->
    <div>
        차트
        <span id="chartStockCode">종목코드</span>
        <span id="chartStockName">종목이름</span>
    </div>
    <div>
        기업정보
        <span id="infoStockCode">종목코드</span>
    </div>

</div>