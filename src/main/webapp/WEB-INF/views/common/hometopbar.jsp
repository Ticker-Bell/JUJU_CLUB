<%--
  Created by IntelliJ IDEA.
  User: 퍼스트존 아카데미02
  Date: 2026-01-13
  Time: 오후 2:42
  To change this template use File | Settings | File Templates.
--%>
<%-- 1. 라이브러리 선언은 유지 (에러 방지) --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 2. common.jsp include를 제거하는 대신, 필요한 변수만 안전하게 선언 --%>
<c:if test="${empty cpath}">
    <c:set var="cpath" value="${pageContext.request.contextPath}" />
</c:if>

<!-- Top Bar -->
<div class="w-full h-20 flex flex-shrink-0 fixed top-0 z-50 bg-[#E6E3F6]">
    <!-- logo -->
    <div class="w-[220px] flex items-center pl-6 transition-all duration-300">
        <div class="flex items-center gap-3">
            <div class="w-9 h-9 bg-primary rounded-xl flex items-center justify-center text-white font-bold shadow-lg shadow-primary/30 text-lg">
                J
            </div>
            <span class="text-lg font-extrabold text-text tracking-tight">JUJU CLUB</span>
        </div>
    </div>

    <!-- top bar navigation -->
    <header class="flex-1 flex items-center justify-end px-10 gap-6">
        <%-- TODO: 로그인 처리 로직 추가 후 수정 필요  --%>
        <!-- 로그인 전 -->
        <c:if test="${empty user}">
            <div class="flex gap-4">
                <button id="btn-header-login" class="bg-primary text-white px-6 py-2.5 rounded-full text-sm font-bold hover:bg-primary/90 transition-colors shadow-lg shadow-primary/20">
                    로그인
                </button>
            </div>
        </c:if>
        <!-- 로그인 후 -->
        <c:if test="${not empty user}">
            <div class="flex items-center gap-6">
                <div class="text-right">
                    <div class="text-[10px] font-extrabold text-gray-500">총 자산</div>
                    <div class="text-sm font-extrabold num-font text-gray-900">
                        ₩ <fmt:formatNumber value="${user.cashBalance}" type="number" />
                    </div>
                </div>
                <div class="flex items-center">
        <span id="userLevelBadge"
              class="px-3 py-1 rounded-full bg-primary/10 text-primary text-[11px] font-extrabold border border-primary/20">
          <c:choose>
              <c:when test="${user.userLevel == 1}">
                  <%-- 초급: 기본 테마 --%>
                  <c:set var="levelClass" value="bg-primary/10 text-primary border-primary/20"/>
                  초급
              </c:when>
              <c:when test="${user.userLevel == 2}">
                  <%-- 중급: 녹색 계열 (예시) --%>
                  <c:set var="levelClass" value="bg-green-100 text-green-600 border-green-200"/>
                  중급
              </c:when>
              <c:when test="${user.userLevel == 3}">
                  <%-- 고급: 주황/금색 계열 (예시) --%>
                  <c:set var="levelClass" value="bg-orange-100 text-orange-600 border-orange-200"/>
                  고급
              </c:when>
              <c:otherwise>
                  <%-- 예외 케이스 --%>
                  <c:set var="levelClass" value="bg-gray-100 text-gray-600 border-gray-200"/>
                  일반
              </c:otherwise>
          </c:choose>
        </span>
                </div>

                <div class="text-right">
                    <span class="block text-sm font-extrabold text-text">${user.userName} 님</span>
                </div>
            </div>

            <!-- 구분선 -->
            <div class="w-[1px] h-4 bg-primary/20"></div>

            <%-- TODO: 로그아웃 경로로 수정 필요 --%>
            <button onclick="location.href='/main/rankingMain.do'" class="flex items-center gap-2 text-gray-500 hover:text-red-500 transition-colors group">
                <span class="text-xs font-bold">로그아웃</span>
                <div class="w-8 h-8 rounded-full flex items-center justify-center bg-white group-hover:bg-red-50 transition-colors shadow-sm">
                    <img src="${cpath}/resources/images/navIcons/exit-outline.svg" alt="나가기아이콘" class="w-4 h-4">
                </div>
            </button>
        </c:if>
    </header>
</div>