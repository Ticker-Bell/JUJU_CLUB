<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="stock" class="flex flex-row justify-between w-full gap-8">

    <div id="investComponents" class="flex flex-col gap-8">
        <jsp:include page="investStockList.jsp"></jsp:include>
    </div>

    <div class="flex flex-col w-full items-center gap-4 p-2 bg-[#FBFBFB] rounded-[12px] outline outline-2 outline-[#E6E7EB]">

        <jsp:include page="investChart.jsp" ></jsp:include>

        <div id="stockCorpInfo-container" class="w-full">
            <jsp:include page="stockCorpInfoCard.jsp" ></jsp:include>
        </div>
    </div>
</div>