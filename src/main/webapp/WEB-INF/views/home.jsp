<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!doctype html>
<html lang="ko">

<!-- =========================================================
     [HEAD] : 라이브러리 로드 / Tailwind 설정 / 분리 CSS 연결
     ========================================================= -->
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>JUJU CLUB - Focused Celebration</title>

	<!-- [LIB] Tailwind CSS (CDN) -->
	<script src="https://cdn.tailwindcss.com"></script>

	<!-- [LIB] Confetti (회원가입 성공 축하 이펙트) -->
	<script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>

	<!-- [CONFIG] Tailwind 커스텀 컬러/애니메이션 설정 -->
	<script>
		tailwind.config = {
			theme: {
				extend: {
					fontFamily: {
						sans: ['SF Pro Display', '-apple-system', 'BlinkMacSystemFont', 'system-ui', 'sans-serif'],
					},
					colors: {
						bg: '#F5F5F7',
						card: '#FFFFFF',
						primary: '#5E45EB',
						'primary-light': '#ECE9FD',
						dark: '#1D1D1F',
					},
					animation: {
						'draw-once': 'drawOnce 1.8s cubic-bezier(0.4, 0, 0.2, 1) forwards',
						'blink': 'blink 1s step-end infinite',
						'bounce-short': 'bounceShort 1s ease-in-out infinite',
						'float-slow': 'floatSlow 3.2s ease-in-out infinite',
					},
					keyframes: {
						drawOnce: {
							'0%': { strokeDashoffset: '500', opacity: '0' },
							'10%': { opacity: '1' },
							'100%': { strokeDashoffset: '0', opacity: '1' },
						},
						blink: {
							'0%, 100%': { opacity: '1' },
							'50%': { opacity: '0' },
						},
						bounceShort: {
							'0%, 100%': { transform: 'translateY(0)' },
							'50%': { transform: 'translateY(-10px)' },
						},
						floatSlow: {
							'0%, 100%': { transform: 'translateY(0)' },
							'50%': { transform: 'translateY(-12px)' },
						}
					}
				}
			}
		}
	</script>

	<!-- [CSS] 분리된 스타일 파일 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main/home.css" />
</head>

<body>

<!-- =========================================================
     [JSP] contextPath 설정 / JS에서 쓸 ctx 주입
     - AJAX 요청 URL (/auth/login.ajax 등)에 필요
     ========================================================= -->
<%--<c:set var="ctx" value="${pageContext.request.contextPath}" />--%>

<%--<script>--%>
<%--	/* [GLOBAL] JS에서 사용할 contextPath */--%>
<%--	window.__CTX__ = "<c:out value='${pageContext.request.contextPath}'/>";--%>
<%--</script>--%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<script>
	window.__CTX__ = "<c:out value='${pageContext.request.contextPath}'/>";
</script>

<!-- =========================================================
     [HEADER 영역] : 상단 고정 네비게이션
     - (좌) 로고
     - (우) 기능소개 버튼 / 로그인 버튼
     ========================================================= -->
<jsp:include page="common/topbar.jsp"/>

<!-- =========================================================
     [HERO 전체 영역] : 첫 화면(메인 히어로)
     - 가운데 타이틀/타이핑/CTA 버튼
     - 오른쪽 로그인 패널 (숨김 상태 -> active 시 표시)
     - 하단 "더 알아보기" 스크롤 아이콘
     ========================================================= -->
<div class="relative h-screen w-full overflow-hidden">

	<!-- =======================================================
	     [HERO - 중앙 메인 래퍼]
	     - 타이틀(주식 / 아는 만큼 / 보인다)
	     - 메인 타이핑 설명 문구
	     - CTA 버튼(주주클럽 시작하기)
	     ======================================================= -->
	<div id="hero-main-wrapper">

		<!-- [HERO - 타이틀/타이핑 영역 묶음] -->
		<div class="flex flex-col items-center">

			<!-- [HERO - 메인 타이틀] -->
			<h1 class="text-5xl md:text-7xl lg:text-8xl font-black tracking-tight leading-tight text-dark flex flex-col md:block items-center justify-center whitespace-nowrap text-center">

				<!-- (좌) "주식" -->
				<span id="title-part-1" class="transition-item inline-block">주식 </span>

				<!-- (중앙) "아는 만큼" ↔ "주주 클럽" 변경되는 단어 + 그래프 라인 -->
				<div class="relative inline-block mx-2 md:mx-4 lg:mx-6 mt-16 md:mt-0 transition-all duration-700">
					<!-- 타이틀 위 그래프 라인(애니메이션) -->
					<div class="absolute -top-28 left-0 w-full h-28 flex items-end justify-center pointer-events-none">
						<svg viewBox="0 0 300 100" class="w-full h-full overflow-visible">
							<path d="M0,95 L70,40 L120,75 L190,20 L240,40 L300,0"
								  fill="none" stroke="#5E45EB" stroke-width="8" stroke-linecap="round" stroke-linejoin="round"
								  class="chart-line animate-draw-once drop-shadow-xl" />
						</svg>
					</div>

					<!-- 실제 바뀌는 텍스트(폭 고정 JS 적용 대상) -->
					<span id="target-holder" class="relative z-20">
           				<span id="target-text" class="text-primary">아는 만큼</span>
          			</span>
				</div>

				<!-- (우) "보인다." -->
				<span id="title-part-2" class="transition-item inline-block">보인다.</span>
			</h1>

			<!-- ===================================================
			     [HERO - 타이핑 문구 영역]
			     - hero-text-area : 메인(중앙) 타이핑
			     - login-text-area : 로그인 패널 열렸을 때 좌측 정렬 타이핑
			     =================================================== -->
			<div class="typing-wrapper">

				<!-- [HERO - 메인 타이핑 문구] -->
				<div id="hero-text-area" class="transition-item">
					<p id="hero-desc" class="text-xl md:text-2xl text-gray-500 font-medium leading-relaxed max-w-2xl mx-auto flex items-center justify-center">
            			<span>
              				<span id="type-content"></span><span id="cursor-main" class="cursor animate-blink"></span>
            			</span>
					</p>
				</div>

				<!-- [LOGIN - 사이드 타이핑 문구] (로그인 패널 열리면 보임) -->
				<div id="login-text-area">
					<div class="text-xl md:text-2xl text-gray-500 font-medium flex flex-col gap-2 items-start">
						<div class="block">
							<span id="login-type-title"></span><span id="cursor-login-title" class="cursor animate-blink"></span>
						</div>
						<div class="block">
							<span id="login-type-sub"></span><span id="cursor-login-sub" class="cursor animate-blink hidden"></span>
						</div>
					</div>
				</div>

			</div>
		</div>

		<!-- [HERO - CTA 버튼 영역] -->
		<div id="hero-btns" class="transition-item pt-10 flex justify-center w-full">
			<button id="btn-start" type="button"
					class="bg-primary text-white px-12 py-6 rounded-full font-bold text-lg hover:scale-105 transition-transform shadow-xl shadow-primary/30">
				주주클럽 시작하기
			</button>
		</div>

	</div>


	<!-- =======================================================
	     [LOGIN PANEL 영역] : 오른쪽 로그인/회원가입 카드
	     - login-section : 패널 컨테이너(숨김 -> active 시 표시)
	     - auth-card : 카드 UI
	     - form-login / form-signup / form-success : 폼 3단계 전환
	     ======================================================= -->
	<div id="login-section" class="absolute top-0 right-0 w-full md:w-[60%] h-full flex items-center justify-center p-8 md:p-16 z-10">
		<div id="auth-card" class="w-full max-w-2xl bg-white p-12 md:p-16 rounded-[48px] shadow-2xl relative border border-gray-100 flex flex-col justify-center min-h-[550px] transition-all duration-500">

			<!-- [FORM-1] 로그인 폼 -->
			<div id="form-login" class="auth-form active-form">
				<div>
					<form onsubmit="event.preventDefault();" class="space-y-8 mt-2">
						<!-- 이메일 -->
						<div>
							<label class="block text-base font-bold text-gray-700 mb-3 ml-1">이메일</label>
							<input id="loginEmail" name="email" type="email"
								   class="w-full px-8 py-6 rounded-3xl bg-gray-50 border-transparent focus:bg-white focus:ring-4 focus:ring-primary/20 focus:border-primary transition-all outline-none font-medium text-xl placeholder-gray-400"
								   placeholder="juju@club.com" autocomplete="username">
						</div>

						<!-- 비밀번호 -->
						<div>
							<label class="block text-base font-bold text-gray-700 mb-3 ml-1">비밀번호</label>
							<input id="loginPassword" name="password" type="password"
								   class="w-full px-8 py-6 rounded-3xl bg-gray-50 border-transparent focus:bg-white focus:ring-4 focus:ring-primary/20 focus:border-primary transition-all outline-none font-medium text-xl"
								   placeholder="••••••••" autocomplete="current-password">
						</div>

						<!-- 자동로그인 / 비밀번호 찾기 -->
						<div class="flex justify-between items-center text-base px-2">
							<label class="flex items-center gap-3 cursor-pointer group">
								<input id="autoLogin" type="checkbox"
									   class="w-5 h-5 text-primary rounded border-gray-300 focus:ring-primary bg-gray-100">
								<span class="text-gray-500 font-medium group-hover:text-primary transition-colors">자동 로그인</span>
							</label>
							<a href="#" class="text-primary font-bold hover:underline">비밀번호 찾기</a>
						</div>

						<!-- 로그인 버튼 -->
						<button id="btn-submit-login" type="button"
								class="w-full bg-primary text-white font-bold py-6 rounded-3xl hover:bg-primary/90 hover:shadow-xl hover:shadow-primary/30 hover:-translate-y-1 transition-all duration-300 text-xl md:text-2xl mt-6">
							로그인하기
						</button>
					</form>

					<!-- 로그인 -> 회원가입 전환 -->
					<div class="mt-10 text-center text-base text-gray-400 font-medium">
						계정이 없으신가요?
						<button id="btn-go-signup" type="button" class="text-primary font-bold hover:underline ml-1">회원가입</button>
					</div>
				</div>
			</div>

			<!-- [FORM-2] 회원가입 폼 -->
			<div id="form-signup" class="auth-form">
				<div>
					<form onsubmit="event.preventDefault();" class="space-y-6 mt-2">
						<!-- 이메일 -->
						<div>
							<label class="block text-base font-bold text-gray-700 mb-2 ml-1">이메일</label>
							<input id="signupEmail" name="email" type="email"
								   class="w-full px-8 py-5 rounded-3xl bg-gray-50 border-transparent focus:bg-white focus:ring-4 focus:ring-primary/20 focus:border-primary transition-all outline-none font-medium text-xl placeholder-gray-400"
								   placeholder="example@email.com" autocomplete="username">
						</div>

						<!-- 닉네임 -->
						<div>
							<label class="block text-base font-bold text-gray-700 mb-2 ml-1">닉네임</label>
							<input id="signupUsername" name="username" type="text"
								   class="w-full px-8 py-5 rounded-3xl bg-gray-50 border-transparent focus:bg-white focus:ring-4 focus:ring-primary/20 focus:border-primary transition-all outline-none font-medium text-xl placeholder-gray-400"
								   placeholder="멋진 주주" autocomplete="nickname">
						</div>

						<!-- 비밀번호 -->
						<div>
							<label class="block text-base font-bold text-gray-700 mb-2 ml-1">비밀번호</label>
							<input id="signupPassword" name="password" type="password"
								   class="w-full px-8 py-5 rounded-3xl bg-gray-50 border-transparent focus:bg-white focus:ring-4 focus:ring-primary/20 focus:border-primary transition-all outline-none font-medium text-xl"
								   placeholder="••••••••" autocomplete="new-password">
						</div>

						<!-- 가입 버튼 -->
						<button id="btn-submit-signup" type="button"
								class="w-full bg-primary text-white font-bold py-6 rounded-3xl hover:bg-primary/90 hover:shadow-xl hover:shadow-primary/30 hover:-translate-y-1 transition-all duration-300 text-xl md:text-2xl mt-4">
							가입 완료
						</button>
					</form>

					<!-- 회원가입 -> 로그인 전환 -->
					<div class="mt-8 text-center text-base text-gray-400 font-medium">
						이미 계정이 있으신가요?
						<button id="btn-go-login" type="button" class="text-primary font-bold hover:underline ml-1">로그인</button>
					</div>
				</div>
			</div>

			<!-- [FORM-3] 가입 성공 화면(축하 + 자동으로 로그인폼 복귀) -->
			<div id="form-success" class="auth-form items-center justify-center text-center">
				<div class="mb-6 animate-bounce-short">
					<div class="w-24 h-24 bg-green-100 rounded-full flex items-center justify-center mx-auto">
						<svg class="w-12 h-12 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
							<path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M5 13l4 4L19 7"></path>
						</svg>
					</div>
				</div>
				<h2 class="text-4xl font-black text-gray-900 mb-4">축하합니다!</h2>
				<p class="text-xl text-gray-500 font-medium">주주클럽의 멤버가 되셨습니다!</p>
			</div>

		</div>
	</div>


	<!-- =======================================================
	     [SCROLL ICON 영역] : "더 알아보기" 버튼
	     - 클릭 시 #home-sections로 스무스 스크롤
	     - 스크롤 조금 내려가면 자동으로 사라짐(JS)
	     ======================================================= -->
	<div class="absolute bottom-10 inset-x-0 flex justify-center">
		<button id="scroll-icon"
				type="button"
				class="transition-item text-gray-400 hover:text-primary transition-colors flex flex-col items-center gap-2 animate-float-slow">
			<span class="text-xs font-bold tracking-widest">더 알아보기</span>
			<svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
				<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 14l-7 7m0 0l-7-7m7 7V3"></path>
			</svg>
		</button>
	</div>

</div>


<!-- =========================================================
     [HOME SECTIONS 영역] : Step01~Step03 기능 소개 섹션 + Footer
     - reveal 클래스: IntersectionObserver로 스크롤 등장 애니메이션
     ========================================================= -->
<section id="home-sections" class="bg-white">

	<!-- [SECTION-STEP01] 로드맵 학습 -->
	<div class="max-w-6xl mx-auto px-6 md:px-10 py-24 md:py-32 grid md:grid-cols-2 gap-14 items-center">
		<!-- (좌) 텍스트 -->
		<div class="reveal">
			<div class="text-sm font-extrabold text-primary/80 mb-3">Step 01</div>
			<h2 class="text-4xl md:text-5xl font-black tracking-tight text-dark leading-tight">
				헤매지 않는<br/>
				체계적인 <span class="text-primary">로드맵 학습</span>
			</h2>
			<p class="mt-6 text-lg md:text-xl text-gray-500 font-medium leading-relaxed max-w-xl">
				주식 용어부터 재무제표 분석까지.<br/>
				초보자도 따라오기만 하면 전문가가 될 수 있는 검증된 커리큘럼을 제공합니다.
			</p>
		</div>
		<!-- (우) 아이콘 -->
		<div class="reveal" data-delay="1">
			<div class="mx-auto w-full max-w-[320px] aspect-square rounded-[44px] bg-[#F3F1FF] flex items-center justify-center p-8">
				<!-- 아이콘 SVG -->
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#5E45EB" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="w-40 h-40">
					<path d="M4 15s1-1 4-1 5 2 8 2 4-1 4-1V3s-1 1-4 1-5-2-8-2-4 1-4 1z"/>
					<line x1="4" y1="22" x2="4" y2="15"/>
				</svg>
			</div>
		</div>
	</div>

	<!-- [SECTION-STEP02] 실전 모의투자 -->
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
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#3B82F6" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="w-40 h-40">
					<polyline points="23 6 13.5 15.5 8.5 10.5 1 18"/>
					<polyline points="17 6 23 6 23 12"/>
				</svg>
			</div>
		</div>
	</div>

	<!-- [SECTION-STEP03] 랭킹 시스템 -->
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
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#F59E0B" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="w-40 h-40">
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

	<!-- [FOOTER] 사이트 정보/링크 -->
	<footer class="border-t border-gray-200/60">
		<div class="max-w-6xl mx-auto px-6 md:px-10 py-16 grid md:grid-cols-4 gap-10 text-sm">
			<div>
				<div class="font-black text-primary text-lg">JUJU CLUB</div>
				<p class="mt-3 text-gray-500 leading-relaxed">
					투자의 시작을 더 쉽고 안전하게.<br/>주주클럽과 함께 성장하세요.
				</p>
			</div>
			<div>
				<div class="font-bold text-gray-700 mb-3">서비스</div>
				<ul class="space-y-2 text-gray-500">
					<li>기능 소개</li>
					<li>모의투자</li>
					<li>랭킹</li>
				</ul>
			</div>
			<div>
				<div class="font-bold text-gray-700 mb-3">고객지원</div>
				<ul class="space-y-2 text-gray-500">
					<li>공지사항</li>
					<li>문의하기</li>
				</ul>
			</div>
			<div>
				<div class="font-bold text-gray-700 mb-3">약관 및 정책</div>
				<ul class="space-y-2 text-gray-500">
					<li>이용약관</li>
					<li>개인정보처리방침</li>
				</ul>
			</div>
		</div>
		<div class="max-w-6xl mx-auto px-6 md:px-10 py-10 text-xs text-gray-400 border-t border-gray-200/60">
			© 2026 JUJU CLUB. All rights reserved.
		</div>
	</footer>

</section>

<!-- =========================================================
     [JS] 분리된 JS 로드 (맨 마지막에서 defer 로딩)
     - DOM이 구성된 후 실행되는 구조라 가장 안전
     ========================================================= -->
<script defer src="${pageContext.request.contextPath}/resources/js/main/home.js"></script>

</body>
</html>