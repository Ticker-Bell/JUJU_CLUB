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

<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>마이페이지 | JUJU CLUB</title>

<script src="https://cdn.tailwindcss.com"></script>
<script src="https://unpkg.com/lucide@latest"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://unpkg.com/htmx.org@1.9.10"></script>

<link rel="stylesheet" as="style" crossorigin
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css"/>

<!-- ✅ dotlottie 다시 추가 (dotlottie-wc 커스텀 엘리먼트 등록용) -->
<script type="module" src="https://unpkg.com/@lottiefiles/dotlottie-wc@latest/dist/dotlottie-wc.js"></script>

<script>
    tailwind.config = {
        theme: {
            extend: {
                fontFamily: {sans: ['Pretendard', 'sans-serif']},
                colors: {primary: '#5E45EB', secondary: '#F8FAFC'}
            }
        }
    };
</script>

<style>
    /* ✅ 로딩 점(.) 애니메이션 - JS로 제어 */
    .mypage-loading-dots{
        display: inline-block;
        min-width: 1.8em; /* ".", "..", "..." 폭 확보 */
        text-align: left;
        white-space: pre;
    }

    /* ✅ dotlottie가 "로드/업그레이드" 되면서 레이아웃 흔들리는 것 방지:
       커스텀 엘리먼트가 업그레이드 전/후에도 동일한 크기를 갖도록 고정 */
    dotlottie-wc{
        display: block;
        width: 150px;
        height: 150px;
        flex: 0 0 150px;
    }

    /* [유지] 스크롤바 스타일 */
    .mypage-scrollbar {
        overflow-y: auto !important;
        scrollbar-width: thin;
        scrollbar-color: transparent transparent;
    }
    .mypage-scrollbar:hover {
        scrollbar-color: #cbd5e1 transparent;
    }
    .mypage-scrollbar::-webkit-scrollbar {
        width: 4px;
    }
    .mypage-scrollbar::-webkit-scrollbar-track {
        background: transparent;
    }
    .mypage-scrollbar::-webkit-scrollbar-thumb {
        background-color: transparent;
        border-radius: 4px;
    }
    .mypage-scrollbar:hover::-webkit-scrollbar-thumb {
        background-color: #cbd5e1;
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
                            <span class="text-lg font-bold text-slate-400">계산 중</span>
                            <span class="text-lg font-bold text-slate-400 mypage-loading-dots"></span>
                        </div>
                    </div>
                </div>

                <div class="flex-1 flex items-center justify-center gap-2 pl-4">
                    <div class="flex items-center gap-2">
                        <span class="text-lg font-bold text-gray-500 whitespace-nowrap">예수금 :</span>

                        <div class="flex items-center gap-0.5">
                            <p class="text-lg font-bold text-primary tracking-tight whitespace-nowrap">
                                <c:choose>
                                    <c:when test="${not empty userAsset}">
                                        <fmt:formatNumber value="${userAsset.cashBalance}" pattern="#,###"/>
                                    </c:when>
                                    <c:otherwise>0</c:otherwise>
                                </c:choose>
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
                    <!-- ✅ dotlottie-wc 정상 동작 (스크립트 포함 + 크기 고정) -->
                    <dotlottie-wc
                            src="https://lottie.host/9e98724c-0c84-4ae2-9077-a73ca14f2509/g4PyzuhGLb.lottie"
                            autoplay
                            loop>
                    </dotlottie-wc>

                    <p class="text-lg font-bold text-slate-400">
                        분석 중
                        <span class="mypage-loading-dots"></span>
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
        if (window.lucide) lucide.createIcons();

        // ✅ "." -> ".." -> "..." 무한 반복 (초기 진입 + HTMX 로드 모두 대응)
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

            document.body.addEventListener("htmx:load", render);
            document.body.addEventListener("htmx:afterSwap", render);
        }
        initLoadingDots();

        document.body.addEventListener('profile-image-updated', function () {
            const img = document.getElementById('mainProfileImg');
            if (img) img.src = '${cpath}/member/profile-image?ts=' + Date.now();
        });
    })();
</script>
