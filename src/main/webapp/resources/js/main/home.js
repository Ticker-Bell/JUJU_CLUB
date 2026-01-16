/* ==========================================================================
   JUJU CLUB - home.js (Final V11: Auto Focus on Email)
   ========================================================================== */

document.addEventListener("DOMContentLoaded", () => {
    const ctx = window.__CTX__ || "";
    if (history.scrollRestoration) history.scrollRestoration = "manual";
    window.scrollTo(0, 0);

    /* Elements */
    const $ = (id) => document.getElementById(id);
    const btnStart = $("btn-start");
    const heroMainWrapper = $("hero-main-wrapper");
    const targetHolder = $("target-holder"), targetText = $("target-text");
    const titlePart1 = $("title-part-1"), titlePart2 = $("title-part-2"), chartLine = document.querySelector(".chart-line");
    const btnHeaderLogin = $("btn-header-login");
    const heroTextArea = $("hero-text-area"), heroBtns = $("hero-btns"), scrollIcon = $("scroll-icon");
    const loginTextArea = $("login-text-area"), loginSection = $("login-section"), authCard = $("auth-card");
    const typingWrapper = document.querySelector(".typing-wrapper");
    const formLogin = $("form-login"), formSignup = $("form-signup"), formSuccess = $("form-success");
    const formSurvey = $("form-survey"), formAccountSuccess = $("form-account-success"), formFinalReady = $("form-final-ready");

    const btnSubmitSurvey = $("btn-submit-survey"), btnGoMain = $("btn-go-main");
    const btnGoSignup = $("btn-go-signup"), btnGoLogin = $("btn-go-login");
    const btnSubmitLogin = $("btn-submit-login"), btnSubmitSignup = $("btn-submit-signup");
    const btnBackLogin = $("btn-back-home-login"), btnBackSignup = $("btn-back-home-signup");

    const btnToFinal = $("btn-to-final");
    const btnStartLearning = $("btn-start-learning");

    const cursorMain = $("cursor-main"), cursorLoginTitle = $("cursor-login-title"), cursorLoginSub = $("cursor-login-sub");
    const typeContent = $("type-content");

    /* Utils */
    let timeouts = [];
    function setCleanTimeout(cb, delay) { const id = setTimeout(cb, delay); timeouts.push(id); return id; }
    function clearAllTimeouts() { timeouts.forEach(id => clearTimeout(id)); timeouts = []; }
    const wait = (ms) => new Promise(res => setTimeout(res, ms));

    /* Reset */
    function resetForm(formEl) {
        if (!formEl) return;
        const inputs = formEl.querySelectorAll("input");
        inputs.forEach(el => {
            if(el.type === 'radio') el.checked = false;
            else {
                el.value = "";
                el.classList.remove("border-red-500", "ring-red-200", "ring-2", "border-blue-500", "ring-blue-200", "shake");
                el.classList.add("focus:ring-primary/20", "focus:border-primary");
            }
        });
        const checkboxes = formEl.querySelectorAll("input[type='checkbox']");
        checkboxes.forEach(cb => cb.checked = false);
        const msgs = formEl.querySelectorAll("p[id^='msg-']");
        msgs.forEach(p => { p.innerText = ""; p.classList.add("hidden"); p.classList.remove("text-red-600", "text-blue-500"); });
        clearInlineError(formEl);
        if (formEl.id === "form-signup") disableSignupButton();
    }

    /* Error Display */
    function showInlineError(formEl, msg) {
        if (formEl.id === "form-login") {
            const errorP = $("msg-login-error");
            if (errorP) {
                errorP.innerText = msg || "정보를 확인해주세요.";
                errorP.classList.remove("hidden");
                errorP.classList.add("text-red-600");
                $("loginEmail").classList.add("shake");
                $("loginPassword").classList.add("shake");
                setTimeout(() => { $("loginEmail").classList.remove("shake"); $("loginPassword").classList.remove("shake"); }, 500);
            }
        } else {
            let box = formEl.querySelector(".form-error");
            if (!box) { box = document.createElement("div"); box.className="form-error mt-4 text-sm font-bold text-red-600 absolute bottom-20 w-full text-center"; formEl.querySelector("form").appendChild(box); }
            box.textContent = msg || "오류 발생";
        }
    }
    function clearInlineError(formEl) {
        if (formEl.id === "form-login") {
            const errorP = $("msg-login-error");
            if(errorP) { errorP.classList.add("hidden"); errorP.innerText = ""; }
            ["loginEmail", "loginPassword"].forEach(id => {
                const el = $(id); if(el) el.classList.remove("border-red-500", "ring-2", "ring-red-200");
            });
        }
        const box = formEl.querySelector(".form-error"); if(box) box.remove();
    }

    /* Signup State */
    function updateSignupButtonState() {
        const eM = $("msg-email-error"), nM = $("msg-nickname-error"), pM = $("msg-password-error");
        const ok = (el) => el && !el.classList.contains("hidden") && el.classList.contains("text-blue-500");
        if (ok(eM) && ok(nM) && ok(pM)) enableSignupButton(); else disableSignupButton();
    }
    function enableSignupButton() {
        if(!btnSubmitSignup) return;
        btnSubmitSignup.disabled = false;
        btnSubmitSignup.classList.remove("bg-gray-300", "text-gray-500", "cursor-not-allowed");
        btnSubmitSignup.classList.add("bg-primary", "text-white", "hover:bg-primary/90", "hover:shadow-xl", "hover:-translate-y-1");
    }
    function disableSignupButton() {
        if(!btnSubmitSignup) return;
        btnSubmitSignup.disabled = true;
        btnSubmitSignup.classList.remove("bg-primary", "text-white", "hover:bg-primary/90", "hover:shadow-xl", "hover:-translate-y-1");
        btnSubmitSignup.classList.add("bg-gray-300", "text-gray-500", "cursor-not-allowed");
    }

    /* Validation Bindings */
    function bindPasswordValidation() {
        const pwInput = $("signupPassword");
        const pwMsg = $("msg-password-error");
        if (!pwInput || !pwMsg) return;

        pwInput.addEventListener("keyup", () => {
            const val = pwInput.value;
            const regex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_~]).{8,16}$/;
            if (!val) {
                pwMsg.classList.add("hidden");
                pwInput.classList.remove("border-red-500", "ring-red-200", "border-blue-500", "ring-blue-200");
                updateSignupButtonState(); return;
            }
            pwMsg.classList.remove("hidden");
            if (regex.test(val)) {
                pwMsg.innerText = "사용가능한 비밀번호 입니다";
                pwMsg.classList.remove("text-red-500", "text-red-600");
                pwMsg.classList.add("text-blue-500");
                pwInput.classList.remove("border-red-500", "ring-red-200");
                pwInput.classList.add("border-blue-500", "ring-2", "ring-blue-200");
            } else {
                pwMsg.innerText = "8~16자 영문, 숫자, 특수문자를 혼합해주세요.";
                pwMsg.classList.remove("text-blue-500", "text-red-600");
                pwMsg.classList.add("text-red-500");
                pwInput.classList.add("border-red-500", "ring-2", "ring-red-200");
                pwInput.classList.remove("border-blue-500", "ring-blue-200");
            }
            updateSignupButtonState();
        });
    }

    function bindEmailValidation() {
        const emailInput = $("signupEmail");
        const emailMsg = $("msg-email-error");
        if (!emailInput || !emailMsg) return;

        emailInput.addEventListener("keyup", () => {
            const val = emailInput.value.trim();
            const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            if (!val) {
                emailMsg.classList.add("hidden");
                emailInput.classList.remove("border-red-500", "ring-red-200", "border-blue-500", "ring-blue-200");
                updateSignupButtonState();
                return;
            }

            if (!regex.test(val)) {
                emailMsg.innerText = "올바른 이메일 형식이 아닙니다.";
                emailMsg.classList.remove("hidden", "text-blue-500");
                emailMsg.classList.add("text-red-500");
                emailInput.classList.add("border-red-500", "ring-2", "ring-red-200");
                emailInput.classList.remove("border-blue-500", "ring-blue-200");
            } else {
                emailMsg.classList.add("hidden");
                emailInput.classList.remove("border-red-500", "ring-red-200");
            }
            updateSignupButtonState();
        });
    }

    function checkDuplicate(url, inputId, msgId) {
        const inputEl = $(inputId); const msgEl = $(msgId);
        if(!inputEl || !msgEl) return;

        inputEl.addEventListener("blur", () => {
            const val = inputEl.value.trim();
            inputEl.classList.remove("shake");

            if(!val) {
                msgEl.classList.add("hidden");
                inputEl.classList.remove("border-red-500", "ring-red-200", "border-blue-500", "ring-blue-200");
                updateSignupButtonState(); return;
            }

            if(inputId === "signupEmail") {
                const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                if(!regex.test(val)) return;
            }

            fetch(ctx + url + encodeURIComponent(val))
                .then(r => r.json())
                .then(d => {
                    msgEl.innerText = d.message; msgEl.classList.remove("hidden");
                    if(d.ok) {
                        msgEl.classList.remove("text-red-500"); msgEl.classList.add("text-blue-500");
                        inputEl.classList.remove("border-red-500", "ring-red-200"); inputEl.classList.add("border-blue-500", "ring-2", "ring-blue-200");
                    } else {
                        msgEl.classList.remove("text-blue-500"); msgEl.classList.add("text-red-500");
                        inputEl.classList.add("border-red-500", "ring-2", "ring-red-200", "shake");
                        inputEl.classList.remove("focus:ring-primary/20", "focus:border-primary");
                        setTimeout(() => inputEl.classList.remove("shake"), 500);
                    }
                    updateSignupButtonState();
                }).catch(e => console.error(e));
        });
    }

    /* Signup */
    async function handleSignup() {
        if(btnSubmitSignup.disabled) return;
        const em = $("signupEmail")?.value?.trim(), nm = $("signupUsername")?.value?.trim(), pw = $("signupPassword")?.value;
        let hasError = false;
        if (!$("msg-email-error").classList.contains("text-blue-500")) { $("signupEmail").classList.add("shake"); hasError = true; }
        if (!$("msg-nickname-error").classList.contains("text-blue-500")) { $("signupUsername").classList.add("shake"); hasError = true; }
        if (!$("msg-password-error").classList.contains("text-blue-500")) { $("signupPassword").classList.add("shake"); hasError = true; }
        if (hasError) {
            setTimeout(() => { $("signupEmail").classList.remove("shake"); $("signupUsername").classList.remove("shake"); $("signupPassword").classList.remove("shake"); }, 500);
            return;
        }
        btnSubmitSignup.disabled = true;
        const res = await postJson(ctx + "/auth/signin.ajax", {email:em, username:nm, password:pw});
        if(!res.ok) { showInlineError(formSignup, res.message); updateSignupButtonState(); return; }

        formSignup.style.opacity="0"; formSignup.style.transform="translateY(10px)"; formSignup.style.pointerEvents="none";
        setCleanTimeout(() => {
            formSignup.classList.remove("active-form"); formSuccess.classList.add("active-form");
            setCleanTimeout(() => {
                formSuccess.style.opacity="1"; formSuccess.style.transform="translateY(0)";
                const r = authCard.getBoundingClientRect();
                const x1 = r.left/window.innerWidth, x2 = r.right/window.innerWidth, y = (r.top+r.height/2)/window.innerHeight;
                const cf = {spread:70, ticks:100, gravity:1.2, decay:0.94, startVelocity:30, colors:["#5E45EB","#ECE9FD"], zIndex:9999};
                confetti({...cf, particleCount:50, angle:60, origin:{x:x1, y:y}}); confetti({...cf, particleCount:50, angle:120, origin:{x:x2, y:y}});
            }, 50);
            setCleanTimeout(() => {
                formSuccess.style.opacity="0"; formSuccess.style.transform="translateY(10px)";
                startSideTyping("만나서 반갑습니다.", "성공적인 투자의 여정을 이어가세요.");
                setCleanTimeout(() => {
                    formSuccess.classList.remove("active-form"); formLogin.classList.add("active-form");
                    setCleanTimeout(()=>{ formLogin.style.opacity="1"; formLogin.style.transform="translateY(0)"; formLogin.style.pointerEvents="auto"; }, 50);
                }, 400);
            }, 2500);
        }, 400);
    }

    async function postJson(url, d) {
        try { const r = await fetch(url, {method:"POST", headers:{"Content-Type":"application/json"}, body:JSON.stringify(d)});
            const t = await r.text(); try { return JSON.parse(t); } catch(e) { return {ok:false, message:t}; }
        } catch(e) { return {ok:false, message:"통신 오류"}; }
    }

    /* Login */
    async function handleLogin() {
        const em = $("loginEmail")?.value?.trim(), pw = $("loginPassword")?.value;
        if(!em || !pw) { showInlineError(formLogin, "이메일과 비밀번호를 입력해주세요."); return; }

        btnSubmitLogin.disabled=true; btnSubmitLogin.classList.add("opacity-60");
        const res = await postJson(ctx+"/auth/login.ajax", {email:em, password:pw});
        btnSubmitLogin.disabled=false; btnSubmitLogin.classList.remove("opacity-60");

        if(!res.ok) {
            showInlineError(formLogin, res.message);
            return;
        }

        if(btnHeaderLogin && res.userName) {
            const nameSpan = document.createElement("div");
            nameSpan.className = "text-base font-extrabold text-gray-800 mr-6 self-center transition-item flex items-center";
            nameSpan.innerHTML = `<span class="text-primary mr-1">${res.userName}</span>님`;
            const parent = btnHeaderLogin.parentElement;
            parent.classList.add("flex", "items-center");
            if(parent.querySelector("div.text-base")) parent.querySelector("div.text-base").remove();
            parent.insertBefore(nameSpan, btnHeaderLogin);

            btnHeaderLogin.innerText = "로그아웃";
            btnHeaderLogin.removeEventListener("click", openLoginPanel);
            btnHeaderLogin.addEventListener("click", () => {
                window.location.href = ctx + "/auth/logout";
            });
        }

        if (res.nextAction === "main") {
            window.location.href = res.redirectUrl;
        } else {
            openSurvey();
        }
    }

    /* Open Login Panel with Auto Focus */
    function openLoginPanel() {
        clearAllTimeouts(); if (scrollPoller) cancelAnimationFrame(scrollPoller);

        if (formSignup) { formSignup.classList.remove("active-form"); formSignup.style.opacity="0"; formSignup.style.transform="translateY(10px)"; formSignup.style.pointerEvents="none"; }
        if (formLogin) { formLogin.classList.add("active-form"); formLogin.style.opacity="1"; formLogin.style.transform="translateY(0)"; formLogin.style.pointerEvents="auto"; }
        resetForm(formLogin); resetForm(formSignup);

        titlePart1.classList.add("exit-right"); titlePart2.classList.add("exit-left"); if(chartLine) chartLine.style.opacity="0";
        heroTextArea.classList.add("exit-down"); heroBtns.classList.add("exit-down"); if(scrollIcon) scrollIcon.classList.add("exit-down");
        heroMainWrapper.classList.remove("slow-restore");

        const run = () => {
            lockScroll(); heroMainWrapper.classList.add("move-to-side");
            targetText.style.transition=`all 0.4s cubic-bezier(0.19, 1, 0.22, 1)`; targetText.style.opacity="0"; targetText.style.transform="translateY(-20px) scale(0.95) blur(4px)";
            setCleanTimeout(() => {
                targetText.innerText="주주 클럽"; targetText.style.opacity="1"; targetText.style.transform="translateY(0) scale(1) blur(0)";
                loginTextArea.classList.remove("exit-down"); loginTextArea.classList.add("visible"); alignLoginText();
                startSideTyping("만나서 반갑습니다.", "성공적인 투자의 여정을 이어가세요.");

                // [추가] 로그인 폼 이메일 필드 포커싱
                const loginInput = $("loginEmail");
                if(loginInput) setTimeout(() => loginInput.focus(), 100);

            }, 250);
            loginSection.classList.add("active");
        };
        if(window.scrollY > 5) { window.scrollTo({top:0, behavior:"smooth"}); const check = () => { if(window.scrollY<=5) setCleanTimeout(run, 50); else scrollPoller=requestAnimationFrame(check); }; scrollPoller=requestAnimationFrame(check); } else setCleanTimeout(run, 600);
    }

    function closeLoginPanel() {
        if (!loginSection.classList.contains("active")) return; clearAllTimeouts();
        loginSection.classList.remove("active"); loginTextArea.classList.remove("visible"); loginTextArea.classList.add("exit-down");
        setCleanTimeout(() => {
            heroMainWrapper.classList.remove("move-to-side"); targetText.style.transition=`all 0.4s cubic-bezier(0.19, 1, 0.22, 1)`;
            targetText.style.opacity="0"; targetText.style.transform="translateY(-20px) scale(0.95) blur(4px)";
            setCleanTimeout(() => { targetText.innerText="아는 만큼"; targetText.style.opacity="1"; targetText.style.transform="translateY(0) scale(1) blur(0)"; }, 250);
        }, 400);
        setCleanTimeout(() => {
            [titlePart1, titlePart2, heroBtns, scrollIcon].forEach(el => el && (el.classList.add("slow-restore"), el.classList.remove("exit-down", "exit-left", "exit-right")));
            if(chartLine) chartLine.style.opacity="1";
            if(heroTextArea) { heroTextArea.classList.add("slow-restore"); heroTextArea.classList.remove("exit-down"); heroTextArea.style.opacity=""; heroTextArea.style.transform=""; }
            typeContent.innerHTML=""; startMainTyping(); unlockScroll();
            setCleanTimeout(() => {
                resetForm(formLogin); resetForm(formSignup);
                if(formSignup) { formSignup.classList.remove("active-form"); formSignup.style.opacity="0"; formSignup.style.transform="translateY(10px)"; formSignup.style.pointerEvents="none"; }
                if(formLogin) { formLogin.classList.add("active-form"); formLogin.style.opacity="1"; formLogin.style.transform="translateY(0)"; formLogin.style.pointerEvents="auto"; }
            }, 1400);
        }, 900);
    }

    /* Switch Form with Focus */
    function switchForm(toSignup) {
        const outF = toSignup ? formLogin : formSignup; const inF = toSignup ? formSignup : formLogin;
        startSideTyping(toSignup ? "환영합니다." : "만나서 반갑습니다.", toSignup ? "새로운 여정을 시작해보세요." : "성공적인 투자의 여정을 이어가세요.");
        outF.style.opacity="0"; outF.style.transform="translateY(10px)"; outF.style.pointerEvents="none";
        setCleanTimeout(() => {
            outF.classList.remove("active-form"); resetForm(outF);
            inF.classList.add("active-form"); resetForm(inF);
            setCleanTimeout(() => {
                inF.style.opacity="1"; inF.style.transform="translateY(0)"; inF.style.pointerEvents="auto";

                // [추가] 폼 전환 시 해당 이메일 필드 포커싱
                const targetId = toSignup ? "signupEmail" : "loginEmail";
                const targetInput = $(targetId);
                if(targetInput) setTimeout(() => targetInput.focus(), 50);

            }, 50);
        }, 400);
    }

    function openSurvey() {
        clearAllTimeouts();
        heroMainWrapper.classList.add("hero-hide-complete");
        loginTextArea.style.opacity = "0"; loginTextArea.style.transform = "translateY(-20px)";
        formLogin.style.opacity = "0"; formLogin.style.transform = "translateY(10px)"; formLogin.style.pointerEvents = "none";

        setCleanTimeout(() => {
            loginSection.classList.add("center-stage");
            setCleanTimeout(() => {
                loginSection.classList.remove("center-stage"); loginSection.classList.add("section-expanded"); authCard.classList.add("card-expanded");
                setCleanTimeout(() => {
                    formLogin.classList.remove("active-form"); formSurvey.classList.add("active-form");
                    startSideTyping("투자 성향 파악", "성공적인 투자를 위한 첫 걸음입니다.");
                    formSurvey.style.opacity = "1"; formSurvey.style.transform = "translateY(0)"; formSurvey.style.pointerEvents = "auto";
                }, 200);
            }, 300);
        }, 500);
    }

    /* Survey Logic */
    async function handleSurveySubmit() {
        let totalScore = 0;
        let answeredCount = 0;
        for(let i=1; i<=6; i++) {
            const radio = document.querySelector(`input[name="q${i}"]:checked`);
            if(radio) { totalScore += parseInt(radio.value); answeredCount++; }
        }
        if(answeredCount < 6) { alert("모든 문항에 답해주세요."); return; }

        let levelInt = 1;
        let levelText = "LV.1 입문 투자자";
        if (totalScore <= 14) { levelInt = 1; levelText = "LV.1 입문 투자자"; }
        else if (totalScore <= 22) { levelInt = 2; levelText = "LV.2 중급 투자자"; }
        else { levelInt = 3; levelText = "LV.3 실전 투자자"; }

        btnSubmitSurvey.disabled=true;
        btnSubmitSurvey.classList.add("opacity-60");
        const originalBtnText = btnSubmitSurvey.innerText;
        btnSubmitSurvey.innerText = "결과 분석 및 계좌 개설 중...";

        try {
            const [levelRes, accountRes] = await Promise.all([
                postJson(ctx + "/auth/updateLevel.ajax", { level: levelInt }),
                postJson(ctx + "/account/create.ajax", {})
            ]);

            if (!levelRes.ok || !accountRes.ok) {
                const msg = !levelRes.ok ? levelRes.message : accountRes.message;
                alert("오류 발생: " + msg);
                throw new Error(msg);
            }

            const levelBadge = document.getElementById("user-level-badge");
            if(levelBadge) levelBadge.innerText = levelText;

            if (accountRes.accountNo) {
                const rawNo = String(accountRes.accountNo);
                const formattedNo = rawNo.replace(/(\d{6})(\d{2})(\d{6})/, '$1-$2-$3');
                const accountDisplay = document.getElementById("display-account-no");
                if(accountDisplay) accountDisplay.innerText = formattedNo;
            }

            const balanceDisplay = document.getElementById("display-balance");
            if(balanceDisplay) balanceDisplay.innerText = "1,000,000 원";

            await wait(1000);

            formSurvey.style.opacity="0"; formSurvey.style.transform="translateY(10px)"; formSurvey.style.pointerEvents="none";
            setCleanTimeout(() => {
                formSurvey.classList.remove("active-form"); formAccountSuccess.classList.add("active-form");
                setCleanTimeout(() => {
                    formAccountSuccess.style.opacity="1";
                    formAccountSuccess.style.transform="translateY(0)";
                    confetti({particleCount:150, spread:80, origin:{y:0.6}});
                }, 50);
            }, 400);

        } catch (e) {
            console.error(e);
            btnSubmitSurvey.disabled = false;
            btnSubmitSurvey.classList.remove("opacity-60");
            btnSubmitSurvey.innerText = originalBtnText;
        }
    }
    //주석
    function goToFinalStep() {
        formAccountSuccess.style.opacity = "0";
        formAccountSuccess.style.transform = "translateY(10px)";
        formAccountSuccess.style.pointerEvents = "none";

        setCleanTimeout(() => {
            formAccountSuccess.classList.remove("active-form");
            formFinalReady.classList.add("active-form");

            setCleanTimeout(() => {
                formFinalReady.style.opacity = "1";
                formFinalReady.style.transform = "translateY(0)";
                formFinalReady.style.pointerEvents = "auto";
            }, 50);
        }, 400);
    }

    let mainTypingState = {id: 0}, typingState = {id: 0};
    async function startMainTyping() {
        mainTypingState.id++; const cid = mainTypingState.id; typeContent.innerHTML = ""; if (cursorMain) cursorMain.classList.remove("hidden");
        const seq = [{text: "주식 시장의 언어를 배우고,", type: "text"}, {type: "br"}, {text: "리스크 없는 환경에서 당신의 투자를 실험하세요. ", type: "text"}, {type: "br"}, {text: "주주클럽", type: "strong"}, {text: "이 함께합니다.", type: "text"}];
        for (const i of seq) {
            if (mainTypingState.id !== cid) return;
            if (i.type === "text") for (const c of i.text) { if (mainTypingState.id !== cid) return; typeContent.insertAdjacentText("beforeend", c); await wait(45); }
            if (i.type === "br") { typeContent.insertAdjacentHTML("beforeend", "<br/>"); await wait(200); }
            if (i.type === "strong") { const s = document.createElement("strong"); s.className = "text-primary"; typeContent.appendChild(s); for (const c of i.text) { if (mainTypingState.id !== cid) return; s.insertAdjacentText("beforeend", c); await wait(45); } }
        }
        if (mainTypingState.id === cid && cursorMain) { await wait(500); cursorMain.classList.add("hidden"); }
    }
    async function startSideTyping(title, sub) {
        typingState.id++; const cid = typingState.id;
        $("login-type-title").textContent = ""; $("login-type-sub").textContent = "";
        if(cursorLoginTitle) cursorLoginTitle.classList.remove("hidden"); if(cursorLoginSub) cursorLoginSub.classList.add("hidden");
        for (const c of title) { if (typingState.id !== cid) return; $("login-type-title").insertAdjacentText("beforeend", c); await wait(45); }
        if (typingState.id !== cid) return; await wait(200);
        if(cursorLoginTitle) cursorLoginTitle.classList.add("hidden"); if(cursorLoginSub) cursorLoginSub.classList.remove("hidden");
        for (const c of sub) { if (typingState.id !== cid) return; $("login-type-sub").insertAdjacentText("beforeend", c); await wait(45); }
        if (typingState.id === cid && cursorLoginSub) { await wait(500); cursorLoginSub.classList.add("hidden"); }
    }

    function lockTargetWidth() {
        const m = document.createElement("span"); m.style.cssText = "position:absolute;visibility:hidden;white-space:nowrap;font-size:"+getComputedStyle(targetText).fontSize+";font-weight:"+getComputedStyle(targetText).fontWeight;
        document.body.appendChild(m); let maxW = 0; ["아는 만큼", "주주 클럽"].forEach(t => { m.textContent = t; const w = m.getBoundingClientRect().width; if(w > maxW) maxW = w; });
        document.body.removeChild(m); targetHolder.style.width = Math.ceil(maxW)+4+"px";
    }
    function alignLoginText() {
        loginTextArea.style.paddingLeft = Math.max(0, targetHolder.getBoundingClientRect().left - typingWrapper.getBoundingClientRect().left + 24) + "px";
    }
    function lockScroll() { document.body.classList.add("lock-scroll"); }
    function unlockScroll() { document.body.classList.remove("lock-scroll"); }

    const snappyBezier = "cubic-bezier(0.19, 1, 0.22, 1)";
    let scrollPoller = null;

    window.addEventListener("load", () => { window.scrollTo(0,0); lockTargetWidth(); alignLoginText(); setTimeout(startMainTyping, 600); });
    window.addEventListener("resize", () => { lockTargetWidth(); alignLoginText(); });

    if(btnStart) btnStart.addEventListener("click", openLoginPanel);
    if(btnHeaderLogin) btnHeaderLogin.addEventListener("click", openLoginPanel);
    if(btnBackLogin) btnBackLogin.addEventListener("click", closeLoginPanel);
    if(btnBackSignup) btnBackSignup.addEventListener("click", closeLoginPanel);
    if(btnGoSignup) btnGoSignup.addEventListener("click", () => switchForm(true));
    if(btnGoLogin) btnGoLogin.addEventListener("click", () => switchForm(false));
    if(btnSubmitLogin) btnSubmitLogin.addEventListener("click", handleLogin);
    if(btnSubmitSignup) btnSubmitSignup.addEventListener("click", handleSignup);
    if(btnSubmitSurvey) btnSubmitSurvey.addEventListener("click", handleSurveySubmit);
    if(btnGoMain) btnGoMain.addEventListener("click", () => window.location.href=ctx+"/main");
    if(btnToFinal) btnToFinal.addEventListener("click", goToFinalStep);
    if(btnStartLearning) btnStartLearning.addEventListener("click", () => window.location.href=ctx+"/roadMap/main.do");

    ['loginEmail', 'loginPassword'].forEach(id => { const el=$(id); if(el) el.addEventListener("keyup", e=>{if(e.key==="Enter") handleLogin();}); });
    ['signupEmail', 'signupUsername', 'signupPassword'].forEach(id => { const el=$(id); if(el) el.addEventListener("keyup", e=>{if(e.key==="Enter") handleSignup();}); });

    checkDuplicate("/auth/check-email?email=", "signupEmail", "msg-email-error");
    checkDuplicate("/auth/check-nickname?nickname=", "signupUsername", "msg-nickname-error");
    bindPasswordValidation();
    bindEmailValidation();

    if(scrollIcon) {
        scrollIcon.addEventListener("click",()=>{const t=$("home-sections"); if(t)t.scrollIntoView({behavior:"smooth",block:"start"});});
        let h=false; window.addEventListener("scroll",()=>{if(h)return; if(window.scrollY>20){h=true; scrollIcon.classList.add("exit-down");}},{passive:true});
    }
    const els=document.querySelectorAll(".reveal"); const io=new IntersectionObserver(e=>{e.forEach(i=>{if(i.isIntersecting){i.target.classList.add("is-visible");io.unobserve(i.target);}});},{threshold:0.22, rootMargin:"0px 0px -35% 0px"}); els.forEach(e=>io.observe(e));
});