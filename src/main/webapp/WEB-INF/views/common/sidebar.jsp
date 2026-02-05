<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common.jsp"%>
<c:set var="defaultProfile" value="${cpath}/resources/images/default-profile.png" scope="request"/>
<link rel="stylesheet" type="text/css" href="${cpath}/resources/css/sidebar/sidebar.css">
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css" />
<aside class="w-[220px] bg-primary/5 flex flex-col flex-shrink-0 z-40 py-8 pl-4 border-r border-transparent h-full overflow-y-auto transition-all duration-300">
    <div class="flex-shrink-0"></div>

    <%-- 로드맵  --%>
    <nav class="flex flex-col justify-center gap-5 w-full pr-4 my-auto">
        <a href="${cpath}/roadMap/main.do" class="nav-item group"
            hx-get="${cpath}/roadMap/main.do"
            hx-target="#main"
            hx-swap="innerHTML"
            hx-push-url="true"
            hx-on::after-request="location.reload();">
            <div class="nav-icon-box"><img class="w-5 h-5 stroke-[2]" src="${cpath}/resources/images/navIcons/map.svg" alt="맵아이콘"></div>
            <span class="text-sm font-bold mt-0.5">학습 로드맵</span>
        </a>
        <a href="${cpath}/invest/main.do" class="nav-item group"
           hx-get="${cpath}/invest/main.do"
           hx-target="#main"
           hx-swap="innerHTML"
           hx-push-url="true">
            <div class="nav-icon-box"><img src="${cpath}/resources/images/navIcons/bar-chart.svg" alt="차트아이콘" class="w-5 h-5 stroke-[2]"></div>
            <span class="text-sm font-bold mt-0.5">모의투자</span>
        </a>
        <a href="${cpath}/ranking/main.do" class="nav-item group"
           hx-get="${cpath}/ranking/main.do"
           hx-target="#main"
           hx-swap="innerHTML"
           hx-push-url="true">
            <div class="nav-icon-box"><img src="${cpath}/resources/images/navIcons/trophy-outline.svg" alt="랭킹아이콘" class="w-5 h-5 stroke-[2]"></div>
            <span class="text-sm font-bold mt-0.5">랭킹</span>
        </a>
        <a href="${cpath}/myPage/main.do" class="nav-item group"
           hx-get="${cpath}/myPage/main.do"
           hx-target="#main"
           hx-swap="innerHTML"
           hx-push-url="true">
            <div class="nav-icon-box"><img src="${cpath}/resources/images/navIcons/user.svg" alt="마이아이콘" class="w-5 h-5 stroke-[2]"></div>
            <span class="text-sm font-bold mt-0.5">마이페이지</span>
        </a>
    </nav>

    <footer class="mt-auto pr-4 pt-6 pb-2">
        <div class="text-center text-[10px] font-extrabold text-gray-400 leading-relaxed">
            <div class="text-gray-500">© 2026 JUJU CLUB</div>
            <div class="mt-1">모의투자 서비스</div>
            <div class="mt-1">학습 로드맵</div>
            <div class="mt-1">문의: support@jujuclub.example</div>
        </div>
    </footer>
</aside>

<!-- 마이페이지 dotlottie 충돌 방지 스크립트 -->
<script>
    (function () {
        if (window.__jujuGlobalEnhancersBound) return;
        window.__jujuGlobalEnhancersBound = true;

        function kickDotLottie(root) {
            const scope = root || document;
            const els = scope.querySelectorAll('dotlottie-wc');
            if (!els || els.length === 0) return;

            els.forEach(el => {
                const src = el.getAttribute('src');
                if (src) el.setAttribute('src', src);
                try { if (el.load) el.load(); } catch(e) {}
                try { if (el.play) el.play(); } catch(e) {}
            });
        }

        function ensureDotLottieReady(root) {
            if (!window.customElements || !customElements.whenDefined) {
                setTimeout(() => kickDotLottie(root), 80);
                return;
            }
            customElements.whenDefined('dotlottie-wc').then(() => {
                requestAnimationFrame(() => kickDotLottie(root));
            }).catch(() => setTimeout(() => kickDotLottie(root), 120));
        }

        function refreshLucide(root) {
            if (!window.lucide) return;
            try { lucide.createIcons(root || document); } catch(e) {}
        }

        // 최초 1회
        document.addEventListener('DOMContentLoaded', () => {
            refreshLucide(document);
            ensureDotLottieReady(document);
        });

        // ✅ HTMX로 main이 교체될 때마다 dotlottie + lucide 보장
        document.body.addEventListener('htmx:afterSwap', (evt) => {
            if (evt.detail && evt.detail.target && evt.detail.target.id === 'main') {
                refreshLucide(evt.detail.target);
                ensureDotLottieReady(evt.detail.target);
            }
        });

        document.body.addEventListener('htmx:load', (evt) => {
            if (evt.target && evt.target.id === 'main') {
                refreshLucide(evt.target);
                ensureDotLottieReady(evt.target);
            }
        });
    })();
</script>