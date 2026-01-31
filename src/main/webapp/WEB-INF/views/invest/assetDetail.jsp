<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    /* CSS 변수 선언으로 유지보수 용이성 확보 */
    :root {
        --primary-color: #3b82f6;
        --text-color: #1f2937;
        --sub-text-color: #6b7280;
        --bg-color: #ffffff;
        --header-bg: #f9fafb;
        --border-color: #e5e7eb;
        --hover-bg: #f3f4f6;
    }

    .history-container {
        font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
        width: 100%;
        height: 90%;
        max-width: 2000px;
        margin: 0 auto;
        background-color: var(--bg-color);
        border: 1px solid var(--border-color);
        border-radius: 16px;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        overflow: hidden;
    }

    .history-header {
        display: flex;
        flex-direction: row;
        background-color: var(--header-bg);
        border-bottom: 1px solid var(--border-color);
        padding: 16px 25px 16px 20px;
        font-size: 15px;
        font-weight: 600;
        color: var(--sub-text-color);
        letter-spacing: -0.025em;

        position: sticky;
        top: 0;
        z-index: 10;
    }

    .history-list {
        max-height: 800px;
        overflow-y: auto;
    }

    .history-item {
        display: flex;
        flex-direction: row;
        padding: 16px 20px;
        border-bottom: 1px solid var(--border-color);
        font-size: 15px;
        color: var(--text-color);
        transition: background-color 0.2s ease;
        align-items: center;
    }

    .history-item:last-child {
        border-bottom: none;
    }

    .history-item:hover {
        background-color: var(--hover-bg);
        cursor: default;
    }

    .col {
        flex: 1;
        text-align: center;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        padding: 0 8px;
    }

    .col.date {
        flex-basis: 20%;
        text-align: center;
        color: var(--sub-text-color);
        font-size: 14px;
    }

    .col.type {
        flex-basis: 15%;
    }

    .col.typeDetail {
        flex-basis: 15%;
    }

    .col.detail {
        flex-basis: 30%;
        text-align: center;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;  /* 칸 넘어가는 부분 ... 처리 */
    }

    .col.price {
        flex-basis: 15%;
        text-align: center;
        font-weight: 600;
        font-feature-settings: "tnum";
    }

    /* 색상 강조 */
    .positive { color: #ef4444; }
    .negative { color: #3b82f6; }

</style>

<div class="history-container">
    <div class="history-header">
        <span class="col date">날짜</span>
        <span class="col type">유형</span>
        <span class="col typeDetail">유형상세</span>
        <span class="col detail">상세내용</span>
        <span class="col price">금액</span>
    </div>

    <div class="history-list">
        <c:forEach items="${assetDetailDTOList}" var="history">
            <div class="history-item">
                <span class="col date">${history.date}</span>
                <span class="col type">${history.type}</span>
                <c:if test="${history.typeDetail == '매수'}">
                    <span class="col typeDetail negative">${history.typeDetail}</span>
                </c:if>
                <c:if test="${history.typeDetail == '매도'}">
                    <span class="col typeDetail positive">${history.typeDetail}</span>
                </c:if>
                <span class="col detail" title="${history.detail}">${history.detail}</span>
                <c:if test="${history.typeDetail == '매수'}">
                    <span class="col price negative">${history.price}</span>
                </c:if>
                <c:if test="${history.typeDetail == '매도'}">
                    <span class="col price positive">${history.price}</span>
                </c:if>

            </div>
        </c:forEach>

        <c:if test="${empty assetDetailDTOList}">
            <div class="history-item" style="justify-content: center; padding: 40px; color: #9ca3af;">
                내역이 존재하지 않습니다.
            </div>
        </c:if>
    </div>
</div>