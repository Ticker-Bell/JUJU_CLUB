<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
        .corpo-info-wrapper {
            margin-top: 16px;
            display: grid;
            grid-template-columns: 1fr;
            gap: 16px;
        }

        @media (min-width: 768px) {
            .corpo-info-wrapper {
                grid-template-columns: 1fr 1fr;
            }
        }

        .corpo-card {
            padding: 16px;
            border-radius: 12px;
            border: 1px solid #F3F4F6;
            background-color: #F9FAFB;
        }

        .corpo-card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .corpo-card-title {
            font-size: 14px;
            font-weight: 800;
            color: #111827;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .corpo-card-title::before {
            content: '';
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background-color: #5E45EB;
        }

        .corpo-card-badge {
            font-size: 10px;
            font-weight: 800;
            color: #5E45EB;
        }

        .corpo-card-badge.gray {
            color: #9CA3AF;
        }

        .corpo-description {
            margin-top: 12px;
            font-size: 12px;
            font-weight: 500;
            color: #4B5563;
            line-height: 1.6;
        }

        .corpo-info-grid {
            margin-top: 16px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
        }

        .corpo-info-item {
            padding: 12px;
            background-color: #fff;
            border-radius: 8px;
            border: 1px solid #F3F4F6;
        }

        .corpo-info-label {
            font-size: 10px;
            font-weight: 800;
            color: #9CA3AF;
        }

        .corpo-info-value {
            font-size: 14px;
            font-weight: 800;
            color: #111827;
        }

        .corpo-info-value.highlight {
            color: #5E45EB;
        }

        .corpo-note {
            margin-top: 12px;
            font-size: 10px;
            font-weight: 700;
            color: #9CA3AF;
        }
    </style>


<div class="corpo-info-wrapper">

    <!-- 기업 정보 -->
    <div class="corpo-card">
        <div class="corpo-card-header">
            <h3 class="corpo-card-title">기업 정보</h3>
            <span class="corpo-card-badge">HIGHLIGHT</span>
        </div>
        <p class="corpo-description" id="corpDescription"></p>
        <div class="corpo-info-grid">
            <div class="corpo-info-item">
                <div class="corpo-info-label">시가총액</div>
                <div class="corpo-info-value highlight" id="hts_avls">${stockCorpInfo.marketCapData} 원</div>
            </div>
            <div class="corpo-info-item">
                <div class="corpo-info-label">상장주식수</div>
                <div class="corpo-info-value" id="lstn_stcn">${stockCorpInfo.listedStockCntData} 주</div>
            </div>
            <div class="corpo-info-item">
                <div class="corpo-info-label">52주 최고/최저</div>
                <div class="corpo-info-value" id="w52_hgpr">${stockCorpInfo.w52HgprData} 원</div>
                <div class="corpo-info-value" id="w52_lwpr">${stockCorpInfo.w52LwprData} 원</div>
            </div>
            <div class="corpo-info-item">
                <div class="corpo-info-label">배당수익률(%)</div>
                <div class="corpo-info-value highlight" id="yield">
                    ${stockCorpInfo.dividendPriceRatio}
                </div>
            </div>
        </div>
    </div>

    <!-- 재무 스냅샷 -->
    <div class="corpo-card">
        <div class="corpo-card-header">
            <h3 class="corpo-card-title">재무 스냅샷</h3>
            <span class="corpo-card-badge gray">마지막 갱신: <span id="update_time">-</span></span>
        </div>
        <div class="corpo-info-grid">
            <div class="corpo-info-item">
                <div class="corpo-info-label">PER</div>
                <div class="corpo-info-value highlight" id="perValue">
                    <c:choose>
                        <c:when test="${stockCorpInfo.per == '데이터가 없습니다.'}">
                            ${stockCorpInfo.per}
                        </c:when>
                        <c:otherwise>
                            ${stockCorpInfo.per} 배
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="corpo-info-item">
                <div class="corpo-info-label">PBR</div>
                <div class="corpo-info-value highlight" id="pbrValue">
                    <c:choose>
                        <c:when test="${stockCorpInfo.pbr == '데이터가 없습니다.'}">
                            ${stockCorpInfo.pbr}
                        </c:when>
                        <c:otherwise>
                            ${stockCorpInfo.pbr} 배
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="corpo-info-item">
                <div class="corpo-info-label">ROE(%)</div>
                <div class="corpo-info-value" id="roeValue">${stockCorpInfo.roe}</div>
            </div>
            <div class="corpo-info-item">
                <div class="corpo-info-label">부채비율(%)</div>
                <div class="corpo-info-value" id="debtRatio">${stockCorpInfo.debtRatio}</div>
            </div>
            <div class="corpo-info-item">
                <div class="corpo-info-label">EPS</div>
                <div class="corpo-info-value" id="epsValue">
                    <c:choose>
                        <c:when test="${stockCorpInfo.eps == '데이터가 없습니다.'}">
                            ${stockCorpInfo.eps}
                        </c:when>
                        <c:otherwise>
                            ${stockCorpInfo.eps} 원
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="corpo-info-item">
                <div class="corpo-info-label">BPS</div>
                <div class="corpo-info-value" id="bpsValue">
                    <c:choose>
                        <c:when test="${stockCorpInfo.bps == '데이터가 없습니다.'}">
                            ${stockCorpInfo.bps}
                        </c:when>
                        <c:otherwise>
                            ${stockCorpInfo.bps} 원
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <p class="corpo-note">KIS, DART API 데이터 반영</p>
    </div>

</div>
