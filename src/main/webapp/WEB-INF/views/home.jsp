<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<!doctype html>
<html lang="ko">

<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>JUJU CLUB - Focused Celebration</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: { sans: ['SF Pro Display', 'sans-serif'] },
                    colors: {
                        bg: '#F5F5F7', card: '#FFFFFF',
                        primary: '#5E45EB', 'primary-light': '#ECE9FD', dark: '#1D1D1F',
                    },
                    animation: {
                        'draw-once': 'drawOnce 1.8s cubic-bezier(0.4, 0, 0.2, 1) forwards',
                        'bounce-short': 'bounceShort 1s ease-in-out infinite',
                        'float-slow': 'floatSlow 3.2s ease-in-out infinite',
                    },
                    keyframes: {
                        drawOnce: { '0%': {strokeDashoffset: '500', opacity: '0'}, '10%': {opacity: '1'}, '100%': {strokeDashoffset: '0', opacity: '1'} },
                        bounceShort: { '0%, 100%': {transform: 'translateY(0)'}, '50%': {transform: 'translateY(-10px)'} },
                        floatSlow: { '0%, 100%': {transform: 'translateY(0)'}, '50%': {transform: 'translateY(-12px)'} }
                    }
                }
            }
        }
    </script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main/home.css"/>

    <style>
        #hero-main-wrapper { top: 54% !important; }
        #login-section { padding-top: 8vh !important; }

        #auth-card.card-expanded {
            transition:
                    width 0.8s cubic-bezier(0.19, 1, 0.22, 1),
                    max-width 0.8s cubic-bezier(0.19, 1, 0.22, 1),
                    height 0.8s cubic-bezier(0.19, 1, 0.22, 1) !important;
        }

        .typing-cursor { display: inline-block; width: 2px; height: 1.2em; background-color: currentColor; margin-left: 2px; vertical-align: middle; animation: blink 1s step-end infinite; }
        .typing-cursor.hidden { display: none; }
        @keyframes blink { 0%, 100% { opacity: 1; } 50% { opacity: 0; } }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-4px); }
            20%, 40%, 60%, 80% { transform: translateX(4px); }
        }
        .shake { animation: shake 0.4s cubic-bezier(.36,.07,.19,.97) both; border-color: #DC2626 !important; box-shadow: 0 0 0 2px #FECACA !important; }

        #login-text-area { z-index: 40 !important; pointer-events: none; }

        .scale-radio:checked + div { background-color: #5E45EB; color: white; border-color: #5E45EB; }
    </style>
</head>

<body>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script>window.__CTX__ = "<c:out value='${pageContext.request.contextPath}'/>";</script>

<jsp:include page="common/hometopbar.jsp"/>

<div class="relative h-screen w-full overflow-hidden">

    <div id="hero-main-wrapper">
        <div class="flex flex-col items-center justify-center gap-10 md:gap-14">
            <h1 class="text-5xl md:text-7xl lg:text-8xl font-black tracking-tight leading-tight text-dark flex flex-col md:block items-center justify-center whitespace-nowrap text-center">
                <span id="title-part-1" class="transition-item inline-block">주식 </span>
                <div class="relative inline-block mx-2 md:mx-4 lg:mx-6 mt-16 md:mt-0 transition-all duration-700">
                    <div class="absolute -top-28 left-0 w-full h-28 flex items-end justify-center pointer-events-none">
                        <svg viewBox="0 0 300 100" class="w-full h-full overflow-visible">
                            <path d="M0,95 L70,40 L120,75 L190,20 L240,40 L300,0" fill="none" stroke="#5E45EB" stroke-width="8" stroke-linecap="round" stroke-linejoin="round" class="chart-line animate-draw-once drop-shadow-xl"/>
                        </svg>
                    </div>
                    <span id="target-holder" class="relative z-20"><span id="target-text" class="text-primary">아는 만큼</span></span>
                </div>
                <span id="title-part-2" class="transition-item inline-block">보인다.</span>
            </h1>

            <div class="typing-wrapper relative z-40">
                <div id="hero-text-area" class="transition-item">
                    <p id="hero-desc" class="text-xl md:text-2xl text-gray-500 font-medium leading-relaxed max-w-2xl mx-auto flex items-center justify-center">
                        <span><span id="type-content"></span><span id="cursor-main" class="typing-cursor"></span></span>
                    </p>
                </div>
                <div id="login-text-area" class="relative z-40">
                    <div class="text-xl md:text-2xl text-gray-600 font-medium flex flex-col gap-3 items-start pl-2">
                        <div class="block"><span id="login-type-title"></span><span id="cursor-login-title" class="typing-cursor"></span></div>
                        <div class="block"><span id="login-type-sub"></span><span id="cursor-login-sub" class="typing-cursor hidden"></span></div>
                    </div>
                </div>
            </div>
        </div>

        <div id="hero-btns" class="transition-item pt-12 flex justify-center w-full relative z-50">
            <button id="btn-start" type="button" class="bg-primary text-white px-12 py-6 rounded-full font-bold text-lg hover:scale-105 transition-transform shadow-xl shadow-primary/30 cursor-pointer">주주클럽 시작하기</button>
        </div>
    </div>

    <div id="login-section" class="absolute top-0 right-0 w-full md:w-[60%] h-full flex items-center justify-center p-8 md:p-16 z-10">
        <div id="auth-card" class="w-full max-w-2xl bg-white rounded-[48px] shadow-2xl relative border border-gray-100 flex flex-col justify-center transition-all duration-500 overflow-visible">
            <div class="w-full h-full flex flex-col justify-center px-8 md:px-14 py-10">

                <div id="form-login" class="auth-form active-form w-full">
                    <form onsubmit="event.preventDefault();" class="w-full">
                        <div class="relative mb-10">
                            <label class="block text-sm font-bold text-gray-700 mb-2 ml-1">이메일</label>
                            <input id="loginEmail" name="email" type="email" class="w-full px-6 py-4 rounded-3xl bg-gray-50 border-transparent focus:bg-white focus:ring-4 focus:ring-primary/20 focus:border-primary transition-all outline-none font-medium text-lg placeholder-gray-400" placeholder="juju@club.com" autocomplete="username">
                        </div>
                        <div class="relative mb-10">
                            <label class="block text-sm font-bold text-gray-700 mb-2 ml-1">비밀번호</label>
                            <input id="loginPassword" name="password" type="password" maxlength="16" class="w-full px-6 py-4 rounded-3xl bg-gray-50 border-transparent focus:bg-white focus:ring-4 focus:ring-primary/20 focus:border-primary transition-all outline-none font-medium text-lg" placeholder="••••••••" autocomplete="current-password">
                        </div>
                        <div class="relative flex justify-between items-center text-sm px-2 mb-12">
                            <label class="flex items-center gap-2 cursor-pointer group">
                                <input id="autoLogin" type="checkbox" class="w-4 h-4 text-primary rounded border-gray-300 focus:ring-primary bg-gray-100">
                                <span class="text-gray-500 font-medium group-hover:text-primary transition-colors">자동 로그인</span>
                            </label>
                            <a href="#" class="text-primary font-bold hover:underline">비밀번호 찾기</a>
                            <p id="msg-login-error" class="absolute -bottom-8 left-0 w-full text-center text-sm font-bold text-red-600 hidden"></p>
                        </div>
                        <button id="btn-submit-login" type="button" class="w-full bg-primary text-white font-bold py-4 rounded-3xl hover:bg-primary/90 hover:shadow-xl hover:shadow-primary/30 hover:-translate-y-1 transition-all duration-300 text-xl mt-12">로그인하기</button>
                    </form>
                    <div class="mt-10 text-center text-sm text-gray-400 font-medium">계정이 없으신가요? <button id="btn-go-signup" type="button" class="text-primary font-bold hover:underline ml-1">회원가입</button></div>
                    <div class="mt-10 text-center"><button id="btn-back-home-login" type="button" class="text-xs text-gray-400 hover:text-dark transition-colors border-b border-transparent hover:border-gray-300 pb-0.5">초기화면으로 돌아가기</button></div>
                </div>

                <div id="form-signup" class="auth-form w-full">
                    <form onsubmit="event.preventDefault();" class="w-full">
                        <div class="relative mb-10">
                            <label class="block text-sm font-bold text-gray-700 mb-2 ml-1">이메일</label>
                            <input id="signupEmail" name="email" type="email" class="w-full px-6 py-4 rounded-3xl bg-gray-50 border-transparent focus:bg-white focus:ring-4 focus:ring-primary/20 focus:border-primary transition-all outline-none font-medium text-lg placeholder-gray-400" placeholder="example@email.com" autocomplete="username">
                            <p id="msg-email-error" class="absolute -bottom-7 left-2 text-xs font-bold hidden transition-all"></p>
                        </div>
                        <div class="relative mb-10">
                            <label class="block text-sm font-bold text-gray-700 mb-2 ml-1">닉네임</label>
                            <input id="signupUsername" name="username" type="text" class="w-full px-6 py-4 rounded-3xl bg-gray-50 border-transparent focus:bg-white focus:ring-4 focus:ring-primary/20 focus:border-primary transition-all outline-none font-medium text-lg placeholder-gray-400" placeholder="멋진 주주" autocomplete="nickname">
                            <p id="msg-nickname-error" class="absolute -bottom-7 left-2 text-xs font-bold hidden transition-all"></p>
                        </div>
                        <div class="relative mb-10">
                            <label class="block text-sm font-bold text-gray-700 mb-2 ml-1">비밀번호</label>
                            <input id="signupPassword" name="password" type="password" maxlength="16" class="w-full px-6 py-4 rounded-3xl bg-gray-50 border-transparent focus:bg-white focus:ring-4 focus:ring-primary/20 focus:border-primary transition-all outline-none font-medium text-lg" placeholder="8~16자 (영문, 숫자, 특수문자)" autocomplete="new-password">
                            <p id="msg-password-error" class="absolute -bottom-7 left-2 text-xs font-bold hidden transition-all"></p>
                        </div>
                        <button id="btn-submit-signup" type="button" disabled class="w-full bg-gray-300 text-gray-500 cursor-not-allowed font-bold py-4 rounded-3xl transition-all duration-300 text-xl mt-8">가입 완료</button>
                    </form>
                    <div class="mt-10 text-center text-sm text-gray-400 font-medium">이미 계정이 있으신가요? <button id="btn-go-login" type="button" class="text-primary font-bold hover:underline ml-1">로그인</button></div>
                    <div class="mt-8 text-center"><button id="btn-back-home-signup" type="button" class="text-xs text-gray-400 hover:text-dark transition-colors border-b border-transparent hover:border-gray-300 pb-0.5">초기화면으로 돌아가기</button></div>
                </div>

                <div id="form-success" class="auth-form items-center justify-center text-center w-full">
                    <div class="mb-6 animate-bounce-short">
                        <div class="w-24 h-24 bg-green-100 rounded-full flex items-center justify-center mx-auto">
                            <svg class="w-12 h-12 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M5 13l4 4L19 7"></path></svg>
                        </div>
                    </div>
                    <h2 class="text-4xl font-black text-gray-900 mb-4">축하합니다!</h2>
                    <p class="text-xl text-gray-500 font-medium leading-relaxed">
                        주주클럽의 멤버가 되셨습니다!<br/>
                        <span class="text-base text-gray-400 mt-2 block">로그인을 하고 설문과 계좌 생성을 진행해주세요.</span>
                    </p>
                </div>

                <div id="form-survey" class="auth-form w-full h-full">
                    <div class="w-full h-full flex flex-col justify-center">
                        <div class="text-center mb-6 flex-shrink-0">
                            <h2 class="text-2xl font-black text-gray-900 mb-1">투자 레벨 진단</h2>
                            <p class="text-sm text-gray-500">본인의 주식 지식 수준을 1(전혀 그렇지 않다) ~ 5(매우 그렇다) 단계로 평가해주세요.</p>
                        </div>
                        <div class="flex-grow overflow-y-auto px-2 custom-scrollbar" style="max-height: 420px;">
                            <form id="survey-form" onsubmit="event.preventDefault();" class="space-y-8 py-2 px-1">
                                <c:forEach var="item" items="${['주식 투자를 경험해 본 적이 있나요?', 'PER, PBR, EPS 등 재무 지표의 의미를 알고 있나요?', '캔들 차트, 이동평균선 등 기술적 분석이 가능한가요?', '금리, 환율이 주가에 미치는 영향을 이해하나요?', 'ETF, 리츠 등 다양한 금융 상품을 알고 있나요?', '손절매 기준과 분산 투자 원칙을 세우고 있나요?']}" varStatus="status">
                                    <div class="space-y-3">
                                        <label class="block text-base font-bold text-gray-700">${status.count}. ${item}</label>
                                        <div class="flex justify-between items-center gap-2 bg-gray-50 p-4 rounded-2xl border border-gray-100">
                                            <span class="text-xs text-gray-400 font-medium whitespace-nowrap">전혀 그렇지 않다</span>
                                            <div class="flex justify-between w-full px-2">
                                                <c:forEach begin="1" end="5" var="score">
                                                    <label class="cursor-pointer flex flex-col items-center gap-1 group relative">
                                                        <input type="radio" name="q${status.count}" value="${score}" class="scale-radio w-0 h-0 opacity-0 absolute">
                                                        <div class="w-8 h-8 rounded-full border-2 border-gray-300 flex items-center justify-center text-sm font-bold text-gray-400 transition-all group-hover:border-primary group-hover:text-primary">
                                                                ${score}
                                                        </div>
                                                    </label>
                                                </c:forEach>
                                            </div>
                                            <span class="text-xs text-gray-400 font-medium whitespace-nowrap">매우 그렇다</span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </form>
                        </div>
                        <div class="mt-6 pt-4 border-t border-gray-100 flex-shrink-0">
                            <button id="btn-submit-survey" type="button" class="w-full bg-dark text-white font-bold py-4 rounded-3xl hover:bg-black hover:shadow-xl hover:-translate-y-1 transition-all duration-300 text-lg">진단 완료 및 계좌 생성</button>
                        </div>
                    </div>
                </div>

                <div id="form-account-success" class="auth-form items-center justify-center text-center w-full">
                    <div class="w-full max-w-sm mx-auto bg-gray-50 rounded-3xl p-6 border border-gray-200/60 shadow-inner mb-8">
                        <div class="flex justify-between items-center mb-6">
                            <span class="font-black text-gray-400 text-xs tracking-widest">JUJU BANK</span>
                            <div class="w-8 h-8 rounded-full bg-gray-200/50 flex items-center justify-center">
                                <svg class="w-4 h-4 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" /></svg>
                            </div>
                        </div>
                        <div class="text-left mb-8">
                            <p class="text-sm text-gray-500 font-medium mb-1">내 투자 계좌</p>
                            <p id="display-balance" class="text-2xl font-black text-dark tracking-tight">1,000,000 원</p>
                            <p id="display-account-no" class="text-xs text-gray-400 mt-1 font-mono">계좌 개설 중...</p>
                        </div>
                        <div class="bg-white rounded-2xl p-4 border border-gray-100">
                            <div class="flex justify-between items-center">
                                <div class="text-left">
                                    <p class="text-sm font-bold text-gray-800">입금</p>
                                    <p class="text-xs text-gray-400">가입 축하금</p>
                                </div>
                                <div class="text-right">
                                    <p class="text-sm font-bold text-blue-600">+1,000,000</p>
                                    <p class="text-xs text-gray-400">방금 전</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <h2 class="text-2xl font-black text-gray-900 mb-2">가상 계좌 개설 완료!</h2>
                    <p class="text-base text-gray-500 mb-8">성공적인 투자의 첫걸음을 뗀 것을 축하합니다!<br/>시드머니로 실전 같은 투자를 경험해보세요.</p>
                    <button id="btn-to-final" type="button" class="w-full max-w-sm bg-primary text-white font-bold py-4 rounded-3xl hover:bg-primary/90 hover:shadow-xl hover:-translate-y-1 transition-all duration-300 text-lg">다음</button>
                </div>

                <div id="form-final-ready" class="auth-form items-center justify-center text-center w-full">
                    <div class="mb-8 animate-bounce-short">
                        <div class="w-24 h-24 bg-indigo-100 rounded-full flex items-center justify-center mx-auto">
                            <svg class="w-12 h-12 text-indigo-600" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"></path></svg>
                        </div>
                    </div>
                    <p id="user-level-badge" class="inline-block px-4 py-1.5 bg-primary/10 text-primary text-sm font-bold rounded-full mb-6">LV.1 입문 투자자</p>

                    <h2 class="text-3xl md:text-4xl font-black text-gray-900 mb-4 leading-tight">학습을 시작할 준비가<br/>모두 끝났습니다!</h2>
                    <p class="text-xl text-gray-500 font-medium mb-10">우리 시작해볼까요?</p>
                    <button id="btn-start-learning" type="button" class="w-full max-w-sm bg-dark text-white font-bold py-4 rounded-3xl hover:bg-black hover:shadow-xl hover:-translate-y-1 transition-all duration-300 text-lg">시작하기</button>
                </div>

            </div>
        </div>
    </div>

    <div class="absolute bottom-10 inset-x-0 flex justify-center">
        <button id="scroll-icon" type="button" class="transition-item text-gray-400 hover:text-primary transition-colors flex flex-col items-center gap-2 animate-float-slow">
            <span class="text-xs font-bold tracking-widest">더 알아보기</span>
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 14l-7 7m0 0l-7-7m7 7V3"></path></svg>
        </button>
    </div>
</div>

<section id="home-sections" class="bg-white">
    <div class="max-w-6xl mx-auto px-6 md:px-10 py-24 md:py-32 grid md:grid-cols-2 gap-14 items-center">
        <div class="reveal">
            <div class="text-sm font-extrabold text-primary/80 mb-3">Step 01</div>
            <h2 class="text-4xl md:text-5xl font-black tracking-tight text-dark leading-tight">헤매지 않는<br/>체계적인 <span class="text-primary">로드맵 학습</span></h2>
            <p class="mt-6 text-lg md:text-xl text-gray-500 font-medium leading-relaxed max-w-xl">주식 용어부터 재무제표 분석까지.<br/>초보자도 따라오기만 하면 전문가가 될 수 있는 검증된 커리큘럼을 제공합니다.</p>
        </div>
        <div class="reveal" data-delay="1">
            <div class="mx-auto w-full max-w-[320px] aspect-square rounded-[44px] bg-[#F3F1FF] flex items-center justify-center p-8">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#5E45EB" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="w-40 h-40"><path d="M4 15s1-1 4-1 5 2 8 2 4-1 4-1V3s-1 1-4 1-5-2-8-2-4 1-4 1z"/><line x1="4" y1="22" x2="4" y2="15"/></svg>
            </div>
        </div>
    </div>

    <div class="max-w-6xl mx-auto px-6 md:px-10 py-24 md:py-32 grid md:grid-cols-2 gap-14 items-center">
        <div class="reveal md:order-2">
            <div class="text-sm font-extrabold text-blue-500/90 mb-3">Step 02</div>
            <h2 class="text-4xl md:text-5xl font-black tracking-tight text-dark leading-tight">
                리스크 없이 경험하는<br/>
                <span class="text-blue-500">실전 모의투자</span>
            </h2>
            <p class="mt-6 text-lg md:text-xl text-gray-500 font-medium leading-relaxed max-w-xl">
                배운 내용을 바로 시장에 적용해보세요.<br/>
                가상의 자금으로 실시간 데이터를 거래하며 나만의 투자 전략을 완성할 수 있습니다.
            </p>
        </div>
        <div class="reveal md:order-1" data-delay="1">
            <div class="mx-auto w-full max-w-[320px] aspect-square rounded-[44px] bg-[#EEF3FF] flex items-center justify-center p-8">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#3B82F6"
                     stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="w-40 h-40">
                    <polyline points="23 6 13.5 15.5 8.5 10.5 1 18"/>
                    <polyline points="17 6 23 6 23 12"/>
                </svg>
            </div>
        </div>
    </div>

    <div class="max-w-6xl mx-auto px-6 md:px-10 py-24 md:py-32 grid md:grid-cols-2 gap-14 items-center">
        <div class="reveal">
            <div class="text-sm font-extrabold text-amber-500/90 mb-3">Step 03</div>
            <h2 class="text-4xl md:text-5xl font-black tracking-tight text-dark leading-tight">
                수익으로 증명하는<br/>
                <span class="text-amber-500">랭킹 시스템</span>
            </h2>
            <p class="mt-6 text-lg md:text-xl text-gray-500 font-medium leading-relaxed max-w-xl">
                단순한 학습을 넘어 경쟁하세요.<br/>
                수익률 랭킹에 이름을 올리고 주주클럽의 명예 투자자가 되어보세요.
            </p>
        </div>
        <div class="reveal" data-delay="1">
            <div class="mx-auto w-full max-w-[320px] aspect-square rounded-[44px] bg-[#FFF7DD] flex items-center justify-center p-8">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#F59E0B"
                     stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="w-40 h-40">
                    <path d="M6 9H4.5a2.5 2.5 0 0 1 0-5H6"/>
                    <path d="M18 9h1.5a2.5 2.5 0 0 0 0-5H18"/>
                    <path d="M4 22h16"/>
                    <path d="M10 14.66V17c0 .55-.47.98-.97 1.21C7.85 18.75 7 20.24 7 22"/>
                    <path d="M14 14.66V17c0 .55.47.98.97 1.21C16.15 18.75 17 20.24 17 22"/>
                    <path d="M18 2H6v7a6 6 0 0 0 12 0V2Z"/>
                </svg>
            </div>
        </div>
    </div>

    <footer class="border-t border-gray-200/60">
        <div class="max-w-6xl mx-auto px-6 md:px-10 py-16 grid md:grid-cols-4 gap-10 text-sm">
            <div><div class="font-black text-primary text-lg">JUJU CLUB</div><p class="mt-3 text-gray-500 leading-relaxed">투자의 시작을 더 쉽고 안전하게.</p></div>
            <div><div class="font-bold text-gray-700 mb-3">서비스</div><ul class="space-y-2 text-gray-500"><li>기능 소개</li><li>모의투자</li><li>랭킹</li></ul></div>
            <div><div class="font-bold text-gray-700 mb-3">고객지원</div><ul class="space-y-2 text-gray-500"><li>공지사항</li><li>문의하기</li></ul></div>
            <div><div class="font-bold text-gray-700 mb-3">약관 및 정책</div><ul class="space-y-2 text-gray-500"><li>이용약관</li><li>개인정보처리방침</li></ul></div>
        </div>
        <div class="max-w-6xl mx-auto px-6 md:px-10 py-10 text-xs text-gray-400 border-t border-gray-200/60">© 2026 JUJU CLUB. All rights reserved.</div>
    </footer>
</section>

<script defer src="${pageContext.request.contextPath}/resources/js/main/home.js"></script>

</body>
</html>