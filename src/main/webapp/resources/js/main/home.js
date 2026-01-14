/* ==========================================================================
   JUJU CLUB - home.js
   - 역할: 홈 화면의 모든 인터랙션/애니메이션/폼 전환/통신 담당
   - 목적: "기능별로 분리된 함수" + "주석으로 의도/흐름"을 명확히 해 유지보수하기 쉽게
   ========================================================================== */

(() => {
    /* ------------------------------------------------------------------------
       0) 전역/환경값
       ------------------------------------------------------------------------ */

    // ✅ JSP에서 window.__CTX__로 주입한 contextPath
    // - 예) /myapp
    // - API 호출, 정적 리소스 경로, 라우팅에 사용
    const ctx = window.__CTX__ || "";

    // ✅ 새로고침 시 스크롤 위치 복원 방지 (항상 맨 위에서 시작)
    // - 로그인 패널 애니메이션이 "맨 위 기준"으로 설계되어 있어
    //   이전 스크롤 위치가 복원되면 UX가 어긋날 수 있음
    if (history.scrollRestoration) history.scrollRestoration = "manual";
    window.scrollTo(0, 0);

    /* ------------------------------------------------------------------------
       1) DOM 요소 캐싱
       - querySelector/getElementById 호출을 흩뿌리지 않고
         상단에 모아두면 유지보수/리팩토링이 쉬움
       ------------------------------------------------------------------------ */

    const $ = (id) => document.getElementById(id);

    // Hero / Title
    const btnStart = $("btn-start");
    const heroMainWrapper = $("hero-main-wrapper");
    const targetHolder = $("target-holder");
    const targetText = $("target-text");
    const titlePart1 = $("title-part-1");
    const titlePart2 = $("title-part-2");

    // Header buttons
    const btnHeaderLogin = $("btn-header-login");
    const btnHeaderFeatures = $("btn-header-features");

    // Hero text/buttons
    const heroTextArea = $("hero-text-area");
    const heroBtns = $("hero-btns");
    const scrollIcon = $("scroll-icon");

    // Login area
    const loginTextArea = $("login-text-area");
    const loginSection = $("login-section");
    const authCard = $("auth-card");
    const typingWrapper = document.querySelector(".typing-wrapper");

    // Forms
    const formLogin = $("form-login");
    const formSignup = $("form-signup");
    const formSuccess = $("form-success");

    // Form switches
    const btnGoSignup = $("btn-go-signup");
    const btnGoLogin = $("btn-go-login");

    // Submit buttons
    const btnSubmitLogin = $("btn-submit-login");
    const btnSubmitSignup = $("btn-submit-signup");

    // Main typing
    const typeContent = $("type-content");

    /* ------------------------------------------------------------------------
       2) 타이머/애니메이션 제어 유틸
       - 화면 전환 중 연속 클릭/빠른 전환이 발생하면
         setTimeout이 겹쳐 애니메이션이 꼬일 수 있음
       - 그래서 "등록한 timeout을 모두 추적하고"
         전환 시작 시 전부 클리어하는 방식으로 안정성 확보
       ------------------------------------------------------------------------ */

    let timeouts = [];

    function setCleanTimeout(cb, delay) {
        const id = setTimeout(cb, delay);
        timeouts.push(id);
        return id;
    }

    function clearAllTimeouts() {
        timeouts.forEach((id) => clearTimeout(id));
        timeouts = [];
    }

    // ✅ async 타이핑에서 await로 쓰는 sleep
    const wait = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

    /* ------------------------------------------------------------------------
       3) 메인 타이핑(히어로 문장)
       - textSequence의 구성대로 타이핑 출력
       - strong/줄바꿈까지 지원
       - mainTypingState.id를 통해 "이전 타이핑 작업 취소" 가능하게 함
       ------------------------------------------------------------------------ */

    const textSequence = [
        { text: "주식 시장의 언어를 배우고,", type: "text" },
        { type: "br" },
        { text: "리스크 없는 환경에서 당신의 투자를 실험하세요. ", type: "text" },
        { type: "br" },
        { text: "주주클럽", type: "strong" },
        { text: "이 함께합니다.", type: "text" },
    ];

    let mainTypingState = { id: 0 };

    async function startMainTyping() {
        mainTypingState.id++;
        const currentId = mainTypingState.id;

        typeContent.innerHTML = "";

        const cursorMain = $("cursor-main");
        if (cursorMain) cursorMain.classList.remove("hidden");

        for (const item of textSequence) {
            if (mainTypingState.id !== currentId) return;

            if (item.type === "text") {
                for (const char of item.text) {
                    if (mainTypingState.id !== currentId) return;
                    typeContent.insertAdjacentText("beforeend", char);
                    await wait(45);
                }
            }

            if (item.type === "br") {
                typeContent.insertAdjacentHTML("beforeend", "<br/>");
                await wait(200);
            }

            if (item.type === "strong") {
                const strongTag = document.createElement("strong");
                strongTag.className = "text-primary";
                typeContent.appendChild(strongTag);

                for (const char of item.text) {
                    if (mainTypingState.id !== currentId) return;
                    strongTag.insertAdjacentText("beforeend", char);
                    await wait(45);
                }
            }
        }
    }

    /* ------------------------------------------------------------------------
       4) 사이드 타이핑(로그인 패널의 2줄 문장)
       - openLoginPanel() 또는 switchForm()에서 호출
       - 타이핑 도중 문장이 바뀌면 이전 타이핑을 취소해야 하므로
         typingState.id로 취소 가능한 구조
       ------------------------------------------------------------------------ */

    let typingState = { id: 0 };

    async function startSideTyping(title, sub) {
        typingState.id++;
        const currentId = typingState.id;

        const titleEl = $("login-type-title");
        const subEl = $("login-type-sub");
        const cursorTitle = $("cursor-login-title");
        const cursorSub = $("cursor-login-sub");

        titleEl.textContent = "";
        subEl.textContent = "";

        cursorTitle.classList.remove("hidden");
        cursorSub.classList.add("hidden");

        for (const char of title) {
            if (typingState.id !== currentId) return;
            titleEl.insertAdjacentText("beforeend", char);
            await wait(45);
        }

        if (typingState.id !== currentId) return;
        await wait(200);

        cursorTitle.classList.add("hidden");
        cursorSub.classList.remove("hidden");

        for (const char of sub) {
            if (typingState.id !== currentId) return;
            subEl.insertAdjacentText("beforeend", char);
            await wait(45);
        }
    }

    /* ------------------------------------------------------------------------
       5) 레이아웃 안정화(타이틀 가운데 텍스트 폭 고정)
       - "아는 만큼" ↔ "주주 클럽" 텍스트 변경 시
         가운데 단어 폭이 달라지면 타이틀 전체가 흔들릴 수 있음
       - 가장 긴 단어 기준으로 width를 고정해 흔들림 제거
       ------------------------------------------------------------------------ */

    function lockTargetWidth() {
        const measurer = document.createElement("span");
        measurer.style.position = "absolute";
        measurer.style.visibility = "hidden";
        measurer.style.whiteSpace = "nowrap";
        measurer.style.fontSize = getComputedStyle(targetText).fontSize;
        measurer.style.fontWeight = getComputedStyle(targetText).fontWeight;
        measurer.style.fontFamily = getComputedStyle(targetText).fontFamily;

        document.body.appendChild(measurer);

        const candidates = ["아는 만큼", "주주 클럽"];
        let maxWidth = 0;

        candidates.forEach((txt) => {
            measurer.textContent = txt;
            const w = measurer.getBoundingClientRect().width;
            if (w > maxWidth) maxWidth = w;
        });

        document.body.removeChild(measurer);

        targetHolder.style.width = `${Math.ceil(maxWidth) + 4}px`;
    }

    /* ------------------------------------------------------------------------
       6) 로그인 타이핑 영역의 "시작 위치" 정렬
       - 로그인 문장은 left-aligned가 요구됨
       - 그런데 화면 중앙 기준으로 시작하면 어색하니
         가운데 단어(target-holder) 위치 기준으로 padding-left를 계산해
         "자연스럽게 이어지는" 인상을 주도록 맞춘다.
       ------------------------------------------------------------------------ */

    function alignLoginText() {
        const holderRect = targetHolder.getBoundingClientRect();
        const wrapperRect = typingWrapper.getBoundingClientRect();

        // holder의 좌측이 wrapper 기준에서 얼마나 떨어져 있는지 계산
        let offset = holderRect.left - wrapperRect.left;

        // 미세한 감각 보정(원본 유지)
        offset += 24;

        loginTextArea.style.paddingLeft = `${Math.max(0, offset)}px`;
    }

    /* ------------------------------------------------------------------------
       7) 스크롤 잠금/해제
       - 로그인 패널 활성화 시 배경 스크롤이 되면
         포커스가 깨지고, 전환 애니메이션 기준점(상단)이 흔들릴 수 있음
       ------------------------------------------------------------------------ */

    function lockScroll() {
        document.body.classList.add("lock-scroll");
    }
    function unlockScroll() {
        document.body.classList.remove("lock-scroll");
    }

    /* ------------------------------------------------------------------------
       8) 로그인 패널 열기/닫기 (핵심 UX)
       - 요구사항: "로그인창 먼저 사라지고 → 글자 이동" 등 단계적 제어
       - openLoginPanel() : 히어로 요소를 사라지게 하고, 패널을 활성화
       - closeLoginPanel(): 패널을 비활성화하고, 히어로를 원복
       ------------------------------------------------------------------------ */

    const snappyBezier = "cubic-bezier(0.19, 1, 0.22, 1)";
    let scrollPoller = null;

    function openLoginPanel() {
        clearAllTimeouts();
        if (scrollPoller) cancelAnimationFrame(scrollPoller);

        // (1) 먼저 히어로 영역 요소들을 퇴장시키기 (즉시 반응)
        titlePart1.classList.add("exit-right");
        titlePart2.classList.add("exit-left");
        heroTextArea.classList.add("exit-down");
        heroBtns.classList.add("exit-down");
        if (scrollIcon) scrollIcon.classList.add("exit-down");

        heroMainWrapper.classList.remove("slow-restore");

        // (2) 로그인 패널 애니메이션 본체
        const runPanelAnimation = () => {
            lockScroll();
            heroMainWrapper.classList.add("move-to-side");

            // 가운데 단어 교체(아는 만큼 -> 주주 클럽)
            targetText.style.transition = `all 0.4s ${snappyBezier}`;
            targetText.style.opacity = "0";
            targetText.style.transform = "translateY(-20px) scale(0.95) blur(4px)";

            setCleanTimeout(() => {
                targetText.innerText = "주주 클럽";
                targetText.style.opacity = "1";
                targetText.style.transform = "translateY(0) scale(1) blur(0)";

                // 로그인 타이핑 영역 표시
                loginTextArea.classList.remove("exit-down");
                loginTextArea.classList.add("visible");

                // 위치 맞추고 타이핑 시작
                alignLoginText();
                startSideTyping("만나서 반갑습니다.", "성공적인 투자의 여정을 이어가세요.");
            }, 250);

            // 패널 표시
            loginSection.classList.add("active");
        };

        // (3) 스크롤이 내려가 있는 상태라면
        //     "상단으로 부드럽게 이동한 뒤" 패널을 열어야 자연스럽다.
        if (window.scrollY > 5) {
            window.scrollTo({ top: 0, behavior: "smooth" });

            const checkScrollPosition = () => {
                if (window.scrollY <= 5) {
                    setCleanTimeout(runPanelAnimation, 50);
                } else {
                    scrollPoller = requestAnimationFrame(checkScrollPosition);
                }
            };
            scrollPoller = requestAnimationFrame(checkScrollPosition);
        } else {
            // 맨 위에서 시작하면 약간의 템포를 주고 시작
            setCleanTimeout(runPanelAnimation, 600);
        }
    }

    function closeLoginPanel() {
        if (!loginSection.classList.contains("active")) return;

        clearAllTimeouts();

        // (1) 로그인 패널부터 먼저 숨기기
        loginSection.classList.remove("active");
        loginTextArea.classList.remove("visible");
        loginTextArea.classList.add("exit-down");

        // (2) 히어로 패널 원복 + 가운데 단어 원복(주주 클럽 -> 아는 만큼)
        setCleanTimeout(() => {
            heroMainWrapper.classList.remove("move-to-side");

            targetText.style.transition = `all 0.4s ${snappyBezier}`;
            targetText.style.opacity = "0";
            targetText.style.transform = "translateY(-20px) scale(0.95) blur(4px)";

            setCleanTimeout(() => {
                targetText.innerText = "아는 만큼";
                targetText.style.opacity = "1";
                targetText.style.transform = "translateY(0) scale(1) blur(0)";
            }, 250);
        }, 400);

        // (3) 텍스트/버튼/스크롤아이콘을 천천히 원복
        setCleanTimeout(() => {
            const elementsToRestore = [titlePart1, titlePart2, heroBtns, scrollIcon];

            elementsToRestore.forEach((el) => {
                if (!el) return;
                el.classList.add("slow-restore");
                el.classList.remove("exit-down", "exit-left", "exit-right");
            });

            // heroTextArea도 원복
            if (heroTextArea) {
                heroTextArea.classList.add("slow-restore");
                heroTextArea.classList.remove("exit-down");
                heroTextArea.style.opacity = "";
                heroTextArea.style.transform = "";
            }

            // 메인 타이핑 다시 시작
            typeContent.innerHTML = "";
            startMainTyping();

            unlockScroll();

            // slow-restore 클래스를 일정 시간 후 제거(다음 전환에 영향 없게)
            setCleanTimeout(() => {
                elementsToRestore.forEach((el) => el && el.classList.remove("slow-restore"));
                heroTextArea && heroTextArea.classList.remove("slow-restore");
            }, 1400);
        }, 900);
    }

    /* ------------------------------------------------------------------------
       9) 폼 전환 (로그인 <-> 회원가입)
       - 화면 전환은 auth-form의 active-form 클래스로 관리
       - 전환 시 타이핑 문구도 함께 교체해 "상태 변화"를 더 명확히 전달
       ------------------------------------------------------------------------ */

    function switchForm(toSignup) {
        const outgoing = toSignup ? formLogin : formSignup;
        const incoming = toSignup ? formSignup : formLogin;

        const newTitle = toSignup ? "환영합니다." : "만나서 반갑습니다.";
        const newSub = toSignup ? "새로운 여정을 시작해보세요." : "성공적인 투자의 여정을 이어가세요.";
        startSideTyping(newTitle, newSub);

        // outgoing을 먼저 fade-out
        outgoing.style.opacity = "0";
        outgoing.style.transform = "translateY(10px)";
        outgoing.style.pointerEvents = "none";

        setCleanTimeout(() => {
            outgoing.classList.remove("active-form");
            incoming.classList.add("active-form");

            // incoming을 다시 fade-in
            setCleanTimeout(() => {
                incoming.style.opacity = "1";
                incoming.style.transform = "translateY(0)";
                incoming.style.pointerEvents = "auto";
            }, 50);
        }, 400);
    }

    /* ------------------------------------------------------------------------
       10) 폼 에러 표시 유틸
       - 서버 응답 오류/유효성 오류를 "폼 내부"에 인라인으로 표시
       - 기존 UI 스타일을 해치지 않도록 minimal한 DOM 추가 방식 사용
       ------------------------------------------------------------------------ */

    function showInlineError(formEl, msg) {
        let box = formEl.querySelector(".form-error");
        if (!box) {
            box = document.createElement("div");
            box.className = "form-error mt-4 text-sm font-bold text-red-500";
            formEl.querySelector("form").appendChild(box);
        }
        box.textContent = msg || "처리 중 오류가 발생했습니다.";
    }

    function clearInlineError(formEl) {
        const box = formEl.querySelector(".form-error");
        if (box) box.remove();
    }

    /* ------------------------------------------------------------------------
       11) API 호출 유틸(fetch)
       - 서버가 JSON을 주는 경우/아닌 경우에 대비
       - 응답이 JSON이 아니면 message로 text를 내려받아 표시
       ------------------------------------------------------------------------ */

    async function postJson(url, data) {
        const r = await fetch(url, {
            method: "POST",
            credentials: 'same-origin',
            headers: { "Content-Type": "application/json", "Accept": "application/json" },
            body: JSON.stringify(data),
        });

        const text = await r.text();

        try {
            return JSON.parse(text);
        } catch (e) {
            return { ok: false, message: text || "서버 응답 오류" };
        }
    }

    /* ------------------------------------------------------------------------
       12) 로그인/회원가입 submit 이벤트
       - 입력값 검증 -> 버튼 disabled -> 서버 호출 -> 실패면 인라인 에러 -> 성공 처리
       ------------------------------------------------------------------------ */

    async function handleLogin() {
        clearInlineError(formLogin);

        const email = $("loginEmail")?.value?.trim();
        const password = $("loginPassword")?.value;

        if (!email || !password) {
            showInlineError(formLogin, "이메일/비밀번호를 입력해 주세요.");
            return;
        }

        btnSubmitLogin.disabled = true;
        btnSubmitLogin.classList.add("opacity-60");

        const res = await postJson(ctx + "/auth/login.ajax", { email, password });

        btnSubmitLogin.disabled = false;
        btnSubmitLogin.classList.remove("opacity-60");

        if (!res.ok) {
            showInlineError(formLogin, res.message);
            return;
        }

        /**
         *
         * 로그인 성공 시:
         * 서버에서 보내준 redirectUrl을 사용
         *
         */
            window.location.href = res.redirectUrl;
    }

    async function handleSignup() {
        clearInlineError(formSignup);

        const email = $("signupEmail")?.value?.trim();
        const username = $("signupUsername")?.value?.trim();
        const password = $("signupPassword")?.value;

        if (!email || !username || !password) {
            showInlineError(formSignup, "이메일/닉네임/비밀번호를 모두 입력해 주세요.");
            return;
        }

        btnSubmitSignup.disabled = true;
        btnSubmitSignup.classList.add("opacity-60");

        const res = await postJson(ctx + "/auth/signin.ajax", { email, username, password });

        btnSubmitSignup.disabled = false;
        btnSubmitSignup.classList.remove("opacity-60");

        if (!res.ok) {
            showInlineError(formSignup, res.message);
            return;
        }

        // ✅ 회원가입 성공 UX:
        // 1) signup 폼 fade-out
        // 2) success 화면 fade-in
        // 3) confetti + 잠시 보여준 뒤 다시 로그인 폼으로 복귀
        formSignup.style.opacity = "0";
        formSignup.style.transform = "translateY(10px)";
        formSignup.style.pointerEvents = "none";

        setCleanTimeout(() => {
            formSignup.classList.remove("active-form");
            formSuccess.classList.add("active-form");

            setCleanTimeout(() => {
                formSuccess.style.opacity = "1";
                formSuccess.style.transform = "translateY(0)";

                // confetti 분사 위치 계산(카드 양쪽에서 쏘는 느낌)
                const rect = authCard.getBoundingClientRect();
                const x1 = rect.left / window.innerWidth;
                const x2 = rect.right / window.innerWidth;
                const y = (rect.top + rect.height / 2) / window.innerHeight;

                const duration = 1000;
                const end = Date.now() + duration;

                (function frame() {
                    confetti({ particleCount: 5, angle: 60, spread: 55, origin: { x: x1, y }, colors: ["#5E45EB", "#ECE9FD"], zIndex: 9999 });
                    confetti({ particleCount: 5, angle: 120, spread: 55, origin: { x: x2, y }, colors: ["#5E45EB", "#ECE9FD"], zIndex: 9999 });
                    if (Date.now() < end) requestAnimationFrame(frame);
                })();
            }, 50);

            setCleanTimeout(() => {
                // 성공 화면을 잠시 보여준 뒤 로그인 폼으로 복귀
                formSuccess.style.opacity = "0";
                formSuccess.style.transform = "translateY(10px)";

                startSideTyping("만나서 반갑습니다.", "성공적인 투자의 여정을 이어가세요.");

                setCleanTimeout(() => {
                    formSuccess.classList.remove("active-form");
                    formLogin.classList.add("active-form");

                    setCleanTimeout(() => {
                        formLogin.style.opacity = "1";
                        formLogin.style.transform = "translateY(0)";
                        formLogin.style.pointerEvents = "auto";
                    }, 50);
                }, 400);
            }, 2500);
        }, 400);
    }

    /* ------------------------------------------------------------------------
       13) 스크롤 아이콘 동작 + 스크롤시 아이콘 숨김
       - "더 알아보기" 클릭 -> 아래 섹션으로 smooth scroll
       - 스크롤이 조금만 내려가면 아이콘은 자연스럽게 사라짐
       ------------------------------------------------------------------------ */

    function bindScrollIcon() {
        if (!scrollIcon) return;

        scrollIcon.addEventListener("click", () => {
            const target = document.getElementById("home-sections");
            if (target) target.scrollIntoView({ behavior: "smooth", block: "start" });
        });

        let arrowHidden = false;
        window.addEventListener(
            "scroll",
            () => {
                if (arrowHidden) return;
                if (window.scrollY > 20) {
                    arrowHidden = true;
                    scrollIcon.classList.add("exit-down");
                }
            },
            { passive: true }
        );
    }

    /* ------------------------------------------------------------------------
       14) 섹션 reveal(IntersectionObserver)
       - 스크롤로 내려갈 때 Step01/02/03가 부드럽게 등장
       - 한번 보이면 observe 해제(성능)
       ------------------------------------------------------------------------ */

    function initReveal() {
        const revealEls = document.querySelectorAll(".reveal");

        const io = new IntersectionObserver(
            (entries) => {
                entries.forEach((entry) => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add("is-visible");
                        io.unobserve(entry.target);
                    }
                });
            },
            { threshold: 0.22, rootMargin: "0px 0px -35% 0px" }
        );

        revealEls.forEach((el) => io.observe(el));
    }

    /* ------------------------------------------------------------------------
       15) 이벤트 바인딩 & 초기화
       ------------------------------------------------------------------------ */

    function bindEvents() {
        btnStart?.addEventListener("click", openLoginPanel);
        btnHeaderLogin?.addEventListener("click", openLoginPanel);
        btnHeaderFeatures?.addEventListener("click", closeLoginPanel);

        btnGoSignup?.addEventListener("click", () => switchForm(true));
        btnGoLogin?.addEventListener("click", () => switchForm(false));

        btnSubmitLogin?.addEventListener("click", handleLogin);
        btnSubmitSignup?.addEventListener("click", handleSignup);
    }

    window.addEventListener("load", () => {
        window.scrollTo(0, 0);
        lockTargetWidth();
        alignLoginText();

        // 메인 타이핑 시작 (원본 타이밍 유지)
        setTimeout(startMainTyping, 600);
    });

    window.addEventListener("resize", () => {
        lockTargetWidth();
        alignLoginText();
    });

    // 즉시 초기화 실행
    bindEvents();
    bindScrollIcon();
    initReveal();
})();