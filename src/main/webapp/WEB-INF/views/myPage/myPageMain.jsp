<%@ page import="java.util.Date" %>
<%@ page import="com.tickerbell.jujuclub.auth.dto.MemberDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
    long dayCount = 1;
    if (user != null && user.getCreatedAt() != null) {
        long diff = new Date().getTime() - user.getCreatedAt().getTime();
        dayCount = diff / (1000 * 60 * 60 * 24) + 1;
    }
%>

<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<c:set var="defaultProfile" value="${cpath}/resources/images/default-profile.png"/>

<style>
    /* 로딩 텍스트 애니메이션 */
    .loading-text {
        font-size: 18px;
        font-weight: 700;
        color: #5E45EB;
        animation: pulse 1.5s infinite;
    }
    @keyframes pulse {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.6; }
    }
    .mypage-loading-dots{
        display: inline-block;
        min-width: 1.8em;
        text-align: left;
        white-space: pre;
    }

    dotlottie-wc {
        display: block;
        width: 150px;
        height: 150px;
        flex: 0 0 150px;
    }
</style>

<div class="w-full max-w-[1600px] mx-auto h-full flex flex-col p-5">
    <div class="flex-1 grid grid-cols-2 grid-rows-2 gap-5 min-h-0">

        <div class="bg-white rounded-[24px] border border-slate-200 shadow-[0_4px_12px_rgba(0,0,0,0.02)] p-6 h-full flex flex-col relative">
            <div class="flex items-center justify-between mb-2 shrink-0">
                <h3 class="text-xl font-extrabold text-gray-900">프로필</h3>
            </div>

            <div class="flex-1 flex flex-col items-center justify-center relative z-10 min-h-0">
                <div class="relative mb-4">
                    <div class="w-24 h-24 rounded-full relative overflow-visible bg-transparent">
                        <div class="w-full h-full rounded-full overflow-hidden bg-transparent shadow-sm">
                            <img id="mainProfileImg"
                                 src="${cpath}/member/profile-image?ts=<%=System.currentTimeMillis()%>"
                                 alt="profile"
                                 class="w-full h-full object-cover"
                                 loading="lazy"
                                 onerror="this.onerror=null;this.src='${defaultProfile}';"/>
                        </div>
                        <div class="absolute bottom-0 right-0 bg-gray-900 p-1.5 rounded-full hover:bg-primary transition-colors cursor-pointer z-30"
                             hx-get="${cpath}/myPage/profile" hx-target="body" hx-swap="beforeend">
                            <i data-lucide="settings-2" class="w-4 h-4 text-white"></i>
                        </div>
                    </div>
                </div>

                <h2 class="text-2xl font-extrabold text-gray-900 mb-1">${loginUser.userName}</h2>
                <p class="text-sm text-gray-500 font-medium mb-4">${loginUser.userId}</p>

                <div class="flex items-center gap-2 mb-2">
                    <c:choose>
                        <c:when test="${loginUser.userLevel == 1}"><span class="px-3 py-1 rounded-full bg-primary/10 text-primary text-xs font-bold border border-primary/20">Lv.1 초급</span></c:when>
                        <c:when test="${loginUser.userLevel == 2}"><span class="px-3 py-1 rounded-full bg-green-100 text-green-600 text-xs font-bold border border-green-200">Lv.2 중급</span></c:when>
                        <c:when test="${loginUser.userLevel == 3}"><span class="px-3 py-1 rounded-full bg-orange-100 text-orange-600 text-xs font-bold border border-orange-200">Lv.3 고급</span></c:when>
                        <c:otherwise><span class="px-3 py-1 rounded-full bg-gray-100 text-gray-600 text-xs font-bold border border-gray-200">일반</span></c:otherwise>
                    </c:choose>
                    <span class="w-1 h-1 rounded-full bg-gray-300"></span>
                    <p class="text-xs text-gray-500 font-bold">함께한 지 <span class="text-primary"><%= dayCount %>일</span></p>
                </div>
            </div>

            <div class="flex w-full border-t border-slate-100 pt-5 mt-4">

                <div class="flex-1 flex items-center justify-center gap-2 border-r border-slate-100 pr-4">
                    <div class="flex items-center gap-2">
                        <span class="text-lg font-bold text-gray-500 whitespace-nowrap">총 자산 :</span>

                        <div class="flex items-center"
                             hx-get="${cpath}/myPage/asset"
                             hx-trigger="load"
                             hx-select="#totalAssetPartial"
                             hx-swap="innerHTML">
                            <span class="loading-text text-slate-400">
                                계산 중...
                            </span>
                        </div>
                    </div>
                </div>

                <div class="flex-1 flex items-center justify-center gap-2 pl-4">
                    <div class="flex items-center gap-2">
                        <span class="text-lg font-bold text-gray-500 whitespace-nowrap">예수금 :</span>

                        <div class="flex items-center gap-0.5">
                            <p class="text-lg font-bold text-primary tracking-tight whitespace-nowrap">
                                <fmt:formatNumber value="${userCashBalance}" pattern="#,###"/>
                            </p>
                            <span class="text-lg font-bold text-primary">원</span>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <div class="bg-white rounded-[24px] border border-slate-200 shadow-[0_4px_12px_rgba(0,0,0,0.02)] p-6 h-full flex flex-col">
            <div class="flex items-center justify-between mb-2 shrink-0">
                <h3 class="text-xl font-extrabold text-gray-900">내 포트폴리오</h3>
            </div>

            <div id="chartContainer"
                 class="flex-1 relative w-full min-h-0 flex flex-col p-2"
                 hx-get="${cpath}/myPage/asset"
                 hx-trigger="load"
                 hx-select="#portfolioPartial"
                 hx-swap="innerHTML">

                <div class="flex flex-col items-center justify-center h-full gap-2">
                    <dotlottie-wc
                            src="https://lottie.host/9e98724c-0c84-4ae2-9077-a73ca14f2509/g4PyzuhGLb.lottie"
                            autoplay
                            loop>
                    </dotlottie-wc>

                    <p class="loading-text -mt-5">
                        분석 중...
                    </p>
                </div>
            </div>
        </div>

        <jsp:include page="myPageMission.jsp"/>

        <div class="bg-white rounded-[24px] border border-slate-200 shadow-[0_4px_12px_rgba(0,0,0,0.02)] p-6 h-full flex flex-col relative overflow-hidden">
            <div class="flex items-center justify-between mb-2 shrink-0">
                <h3 class="text-xl font-extrabold text-gray-900">획득 뱃지</h3>
            </div>
            <div class="flex-1 flex flex-col items-center justify-center text-center pb-4">
                <div class="w-16 h-16 bg-slate-50 rounded-2xl flex items-center justify-center mb-4 rotate-12 border border-slate-100 shadow-sm">
                    <i data-lucide="message-circle-warning" class="w-8 h-8 text-slate-300 -rotate-12"></i>
                </div>
                <p class="text-lg font-extrabold text-gray-500 mb-0.5">비어있습니다</p>
                <p class="text-sm font-medium text-gray-400">열심히 활동해 보세요!</p>
            </div>
        </div>

    </div>
</div>

<script>
    (function () {
        // dots 애니메이션
        function initLoadingDots() {
            if (window.__mypageDotsInterval) return;

            const states = [".", "..", "..."];
            let idx = 0;

            const render = () => {
                document.querySelectorAll(".mypage-loading-dots").forEach(el => {
                    el.textContent = states[idx];
                });
            };

            render();
            window.__mypageDotsInterval = setInterval(() => {
                idx = (idx + 1) % states.length;
                render();
            }, 500);
        }

        // dotlottie 강제 재생
        function kickDotLottie(scope) {
            const root = scope || document;
            const els = root.querySelectorAll("dotlottie-wc");
            if (!els || els.length === 0) return;

            els.forEach(el => {
                const src = el.getAttribute("src");
                if (src) el.setAttribute("src", src); // 렌더 트리거
                try { if (el.load) el.load(); } catch (e) {}
                try { if (el.play) el.play(); } catch (e) {}
            });
        }

        function ensureDotLottieReady(scope) {
            if (!window.customElements || !customElements.whenDefined) {
                setTimeout(() => kickDotLottie(scope), 80);
                return;
            }

            customElements.whenDefined("dotlottie-wc")
                .then(() => requestAnimationFrame(() => kickDotLottie(scope)))
                .catch(() => setTimeout(() => kickDotLottie(scope), 120));
        }

        // lucide 아이콘도 방어적으로(있으면)
        function refreshIcons(scope) {
            if (!window.lucide) return;
            try { lucide.createIcons(scope || document); } catch (e) {}
        }

        // ✅ fragment 환경에서도 즉시 실행 1회
        initLoadingDots();
        refreshIcons(document);
        ensureDotLottieReady(document);

        // ✅ HTMX swap 후에도 다시
        document.body.addEventListener("htmx:afterSwap", function (evt) {
            const target = evt.detail && evt.detail.target ? evt.detail.target : document;
            initLoadingDots();
            refreshIcons(target);
            ensureDotLottieReady(target);
        });
    })();
</script>