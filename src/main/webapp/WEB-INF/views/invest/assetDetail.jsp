<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div>

    <div>
        날짜 /  유형  /  유형상세  /  상세 내용  /  금액
    </div>
    <c:forEach items="${assetDetailDTOList}" var="history">
        <div class="history-item">
            ${history.date}/ ${history.type} / ${history.typeDetail} / ${history.detail} / ${history.price}
        </div>
    </c:forEach>

</div>

