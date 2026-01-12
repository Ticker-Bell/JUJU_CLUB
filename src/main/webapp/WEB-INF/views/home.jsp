<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>JUJU CLUB - Focused Celebration</title>
	<script src="https://cdn.tailwindcss.com"></script>
	<script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.6.0/dist/confetti.browser.min.js"></script>

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
						'draw-once': 'drawOnce 2s cubic-bezier(0.4, 0, 0.2, 1) forwards',
						'blink': 'blink 1s step-end infinite',
						'bounce-short': 'bounceShort 1s ease-in-out infinite',
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
						}
					}
				}
			}
		}
	</script>

	<style>
		@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700;900&display=swap');

		body {
			font-family: 'Inter', sans-serif;
			background-color: #F5F5F7;
			color: #1D1D1F;
			overflow-x: hidden;
		}

		.chart-line {
			stroke-dasharray: 500;
			stroke-dashoffset: 500;
		}

		.transition-item {
			transition: opacity 0.8s cubic-bezier(0.25, 1, 0.5, 1), transform 0.8s cubic-bezier(0.25, 1, 0.5, 1);
			opacity: 1;
			transform: translate(0, 0);
			will-change: transform, opacity;
		}

		.exit-right { opacity: 0; transform: translateX(60px); }
		.exit-left { opacity: 0; transform: translateX(-60px); }
		.exit-down { opacity: 0; transform: translateY(150px); pointer-events: none; }

		#hero-main-wrapper {
			transition: left 1.2s cubic-bezier(0.16, 1, 0.3, 1), transform 1.2s cubic-bezier(0.16, 1, 0.3, 1);
			position: absolute;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);
			width: 100%;
			max-width: 1200px;
			z-index: 20;
			display: flex;
			flex-direction: column;
			align-items: center;
		}

		#hero-main-wrapper.move-to-side {
			left: 30%;
			transform: translate(-50%, -50%);
		}

		.cursor {
			display: inline-block;
			width: 2px;
			height: 1.2em;
			background-color: #5E45EB;
			vertical-align: middle;
			margin-left: 4px;
			margin-bottom: 4px;
		}
		.cursor.hidden { display: none; }

		#target-holder {
			display: inline-block;
			position: relative;
			text-align: center;
			white-space: nowrap;
		}
		#target-text {
			display: inline-block;
			width: 100%;
			text-align: center;
			transition: opacity 0.3s ease;
		}

		#login-section {
			transition: opacity 1s ease 0.8s, transform 1s cubic-bezier(0.16, 1, 0.3, 1) 0.8s;
			opacity: 0;
			transform: translateX(60px);
			pointer-events: none;
		}
		#login-section.active {
			opacity: 1;
			transform: translateX(0);
			pointer-events: auto;
		}

		.typing-wrapper {
			position: relative;
			width: 100%;
			display: flex;
			margin-top: 4.5rem;
			min-height: 9rem;
		}

		#hero-text-area {
			position: absolute;
			top: 0;
			width: 100%;
			text-align: center;
		}

		#login-text-area {
			position: absolute;
			top: 0;
			width: 100%;
			text-align: left;
		}

		.auth-form {
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			display: flex;
			flex-direction: column;
			justify-content: center;
			opacity: 0;
			transform: translateY(10px);
			pointer-events: none;
			transition: opacity 0.4s ease, transform 0.4s ease;
		}
		.auth-form.active-form {
			position: relative;
			opacity: 1;
			transform: translateY(0);
			pointer-events: auto;
		}
	</style>
</head>

<body>

<header class="fixed top-0 w-full p-6 md:p-8 flex justify-between items-center z-50 bg-white/70 backdrop-blur-md border-b border-gray-200/50 transition-all duration-500">
	<div class="text-xl font-black tracking-tighter cursor-pointer hover:opacity-80 transition-opacity text-primary">
		JUJU CLUB
	</div>
	<div class="flex gap-4">
		<button class="hidden md:block text-sm font-bold text-gray-500 hover:text-black transition-colors">기능 소개</button>
		<button class="bg-primary text-white px-6 py-2.5 rounded-full text-sm font-bold hover:bg-primary/90 transition-colors shadow-lg shadow-primary/20">
			로그인
		</button>
	</div>
</header>

<div class="relative h-screen w-full overflow-hidden">

	<div id="hero-main-wrapper">
		<div class="flex flex-col items-center">
			<h1 class="text-5xl md:text-7xl lg:text-8xl font-black tracking-tight leading-tight text-dark flex flex-col md:block items-center justify-center whitespace-nowrap text-center">
				<span id="title-part-1" class="transition-item inline-block">주식 </span>

				<div class="relative inline-block mx-2 md:mx-4 lg:mx-6 mt-16 md:mt-0 transition-all duration-1000">
					<div class="absolute -top-28 left-0 w-full h-28 flex items-end justify-center pointer-events-none">
						<svg viewBox="0 0 300 100" class="w-full h-full overflow-visible">
							<path d="M0,95 L70,40 L120,75 L190,20 L240,40 L300,0"
								  fill="none" stroke="#5E45EB" stroke-width="8" stroke-linecap="round" stroke-linejoin="round"
								  class="chart-line animate-draw-once drop-shadow-xl" />
						</svg>
					</div>
					<span id="target-holder" class="relative z-20">
                        <span id="target-text" class="text-primary">아는 만큼</span>
                    </span>
				</div>

				<span id="title-part-2" class="transition-item inline-block">보인다.</span>
			</h1>

			<div class="typing-wrapper">
				<div id="hero-text-area" class="transition-item">
					<p id="hero-desc" class="text-xl md:text-2xl text-gray-500 font-medium leading-relaxed max-w-2xl mx-auto flex items-center justify-center">
                        <span>
                            <span id="type-content"></span><span id="cursor-main" class="cursor animate-blink"></span>
                        </span>
					</p>
				</div>

				<div id="login-text-area" class="hidden opacity-0 transition-opacity duration-500">
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

		<div id="hero-btns" class="transition-item pt-10 flex flex-col md:flex-row gap-4 justify-center">
			<button id="btn-start" class="bg-primary text-white px-12 py-6 rounded-full font-bold text-lg hover:scale-105 transition-transform shadow-xl shadow-primary/30">
				주주클럽 시작하기
			</button>
			<button class="bg-white text-black px-12 py-6 rounded-full font-bold text-lg hover:bg-gray-50 transition-colors shadow-soft">
				더 알아보기 ↓
			</button>
		</div>
	</div>

	<div id="login-section" class="absolute top-0 right-0 w-full md:w-[60%] h-full flex items-center justify-center p-8 md:p-16 z-10">

		<div id="auth-card" class="w-full max-w-2xl bg-white p-12 md:p-16 rounded-[48px] shadow-2xl relative border border-gray-100 flex flex-col justify-center min-h-[550px] transition-all duration-500">

			<div id="form-login" class="auth-form active-form">
				<div>
					<form onsubmit="event.preventDefault();" class="space-y-8 mt-2">
						<div>
							<label class="block text-base font-bold text-gray-700 mb-3 ml-1">이메일</label>
							<input type="email" class="w-full px-8 py-6 rounded-3xl bg-gray-50 border-transparent focus:bg-white focus:ring-4 focus:ring-primary/20 focus:border-primary transition-all outline-none font-medium text-xl placeholder-gray-400" placeholder="juju@club.com">
						</div>
						<div>
							<label class="block text-base font-bold text-gray-700 mb-3 ml-1">비밀번호</label>
							<input type="password" class="w-full px-8 py-6 rounded-3xl bg-gray-50 border-transparent focus:bg-white focus:ring-4 focus:ring-primary/20 focus:border-primary transition-all outline-none font-medium text-xl" placeholder="••••••••">
						</div>
						<div class="flex justify-between items-center text-base px-2">
							<label class="flex items-center gap-3 cursor-pointer group">
								<input type="checkbox" class="w-5 h-5 text-primary rounded border-gray-300 focus:ring-primary bg-gray-100">
								<span class="text-gray-500 font-medium group-hover:text-primary transition-colors">자동 로그인</span>
							</label>
							<a href="#" class="text-primary font-bold hover:underline">비밀번호 찾기</a>
						</div>
						<button class="w-full bg-primary text-white font-bold py-6 rounded-3xl hover:bg-primary/90 hover:shadow-xl hover:shadow-primary/30 hover:-translate-y-1 transition-all duration-300 text-xl md:text-2xl mt-6">
							로그인하기
						</button>
					</form>
					<div class="mt-10 text-center text-base text-gray-400 font-medium">
						계정이 없으신가요? <button id="btn-go-signup" class="text-primary font-bold hover:underline ml-1">회원가입</button>
					</div>
				</div>
			</div>

			<div id="form-signup" class="auth-form">
				<div>
					<form onsubmit="event.preventDefault();" class="space-y-6 mt-2">
						<div>
							<label class="block text-base font-bold text-gray-700 mb-2 ml-1">이메일</label>
							<input type="email" class="w-full px-8 py-5 rounded-3xl bg-gray-50 border-transparent focus:bg-white focus:ring-4 focus:ring-primary/20 focus:border-primary transition-all outline-none font-medium text-xl placeholder-gray-400" placeholder="example@email.com">
						</div>
						<div>
							<label class="block text-base font-bold text-gray-700 mb-2 ml-1">닉네임</label>
							<input type="text" class="w-full px-8 py-5 rounded-3xl bg-gray-50 border-transparent focus:bg-white focus:ring-4 focus:ring-primary/20 focus:border-primary transition-all outline-none font-medium text-xl placeholder-gray-400" placeholder="멋진 주주">
						</div>
						<div>
							<label class="block text-base font-bold text-gray-700 mb-2 ml-1">비밀번호</label>
							<input type="password" class="w-full px-8 py-5 rounded-3xl bg-gray-50 border-transparent focus:bg-white focus:ring-4 focus:ring-primary/20 focus:border-primary transition-all outline-none font-medium text-xl" placeholder="••••••••">
						</div>

						<button id="btn-submit-signup" class="w-full bg-primary text-white font-bold py-6 rounded-3xl hover:bg-primary/90 hover:shadow-xl hover:shadow-primary/30 hover:-translate-y-1 transition-all duration-300 text-xl md:text-2xl mt-4">
							가입 완료
						</button>
					</form>
					<div class="mt-8 text-center text-base text-gray-400 font-medium">
						이미 계정이 있으신가요? <button id="btn-go-login" class="text-primary font-bold hover:underline ml-1">로그인</button>
					</div>
				</div>
			</div>

			<div id="form-success" class="auth-form items-center justify-center text-center">
				<div class="mb-6 animate-bounce-short">
					<div class="w-24 h-24 bg-green-100 rounded-full flex items-center justify-center mx-auto">
						<svg class="w-12 h-12 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M5 13l4 4L19 7"></path></svg>
					</div>
				</div>
				<h2 class="text-4xl font-black text-gray-900 mb-4">축하합니다!</h2>
				<p class="text-xl text-gray-500 font-medium">주주클럽의 멤버가 되셨습니다!</p>
			</div>

		</div>
	</div>

	<div id="scroll-icon" class="transition-item absolute bottom-10 left-1/2 -translate-x-1/2 animate-bounce text-gray-400">
		<svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 14l-7 7m0 0l-7-7m7 7V3"></path></svg>
	</div>

</div>

<script>
	const btnStart = document.getElementById('btn-start');
	const heroMainWrapper = document.getElementById('hero-main-wrapper');

	const targetHolder = document.getElementById('target-holder');
	const targetText = document.getElementById('target-text');
	const titlePart1 = document.getElementById('title-part-1');
	const titlePart2 = document.getElementById('title-part-2');

	const heroTextArea = document.getElementById('hero-text-area');
	const heroBtns = document.getElementById('hero-btns');
	const scrollIcon = document.getElementById('scroll-icon');

	const loginTextArea = document.getElementById('login-text-area');
	const loginSection = document.getElementById('login-section');
	const authCard = document.getElementById('auth-card'); // 흰색 카드 요소

	const typingWrapper = document.querySelector('.typing-wrapper');

	// 폼 요소
	const formLogin = document.getElementById('form-login');
	const formSignup = document.getElementById('form-signup');
	const formSuccess = document.getElementById('form-success');

	const btnGoSignup = document.getElementById('btn-go-signup');
	const btnGoLogin = document.getElementById('btn-go-login');
	const btnSubmitSignup = document.getElementById('btn-submit-signup');

	// --- 1. 메인 타이핑 로직 ---
	const typeContent = document.getElementById('type-content');
	const textSequence = [
		{ text: "주식 시장의 언어를 배우고,", type: "text" },
		{ text: "break", type: "br" },
		{ text: "리스크 없는 환경에서 당신의 투자를 실험하세요. ", type: "text" },
		{ text: "break", type: "br" },
		{ text: "주주클럽", type: "strong" },
		{ text: "이 함께합니다.", type: "text" }
	];

	function wait(ms) { return new Promise(resolve => setTimeout(resolve, ms)); }

	async function typeWriter(element, sequence, speed = 80) {
		element.innerHTML = "";
		for (const item of sequence) {
			if (item.type === 'text') {
				for (let char of item.text) {
					element.insertAdjacentText('beforeend', char);
					await wait(speed);
				}
			} else if (item.type === 'br') {
				element.insertAdjacentHTML('beforeend', '<br/>');
				await wait(300);
			} else if (item.type === 'strong') {
				const strongTag = document.createElement('strong');
				strongTag.className = "text-primary";
				element.appendChild(strongTag);
				for (let char of item.text) {
					strongTag.insertAdjacentText('beforeend', char);
					await wait(speed);
				}
			}
		}
	}

	// --- 2. 왼쪽 사이드 타이핑 로직 ---
	let typingState = { id: 0 };

	async function startSideTyping(title, sub) {
		typingState.id++;
		const currentId = typingState.id;

		const titleEl = document.getElementById('login-type-title');
		const subEl = document.getElementById('login-type-sub');
		const cursorTitle = document.getElementById('cursor-login-title');
		const cursorSub = document.getElementById('cursor-login-sub');

		titleEl.textContent = "";
		subEl.textContent = "";
		cursorTitle.classList.remove('hidden');
		cursorSub.classList.add('hidden');

		for (let char of title) {
			if(typingState.id !== currentId) return;
			titleEl.insertAdjacentText('beforeend', char);
			await wait(80);
		}

		if(typingState.id !== currentId) return;
		await wait(200);
		cursorTitle.classList.add('hidden');
		cursorSub.classList.remove('hidden');

		for (let char of sub) {
			if(typingState.id !== currentId) return;
			subEl.insertAdjacentText('beforeend', char);
			await wait(40);
		}
	}

	// --- 3. 정렬 및 초기화 ---
	function lockTargetWidth() {
		const measurer = document.createElement('span');
		measurer.style.position = 'absolute';
		measurer.style.visibility = 'hidden';
		measurer.style.whiteSpace = 'nowrap';
		measurer.style.fontSize = getComputedStyle(targetText).fontSize;
		measurer.style.fontWeight = getComputedStyle(targetText).fontWeight;
		measurer.style.fontFamily = getComputedStyle(targetText).fontFamily;
		document.body.appendChild(measurer);

		const candidates = ["아는 만큼", "주주 클럽"];
		let maxWidth = 0;
		candidates.forEach(txt => {
			measurer.textContent = txt;
			const w = measurer.getBoundingClientRect().width;
			if (w > maxWidth) maxWidth = w;
		});
		document.body.removeChild(measurer);
		targetHolder.style.width = (Math.ceil(maxWidth) + 4) + "px";
	}

	function alignLoginText() {
		const holderRect = targetHolder.getBoundingClientRect();
		const wrapperRect = typingWrapper.getBoundingClientRect();

		let offset = holderRect.left - wrapperRect.left;
		const additionalSpacing = 24;
		offset += additionalSpacing;

		loginTextArea.style.paddingLeft = Math.max(0, offset) + 'px';
	}

	window.addEventListener('load', () => {
		lockTargetWidth();
		alignLoginText();
		setTimeout(() => typeWriter(typeContent, textSequence), 800);
	});

	window.addEventListener('resize', () => {
		lockTargetWidth();
		alignLoginText();
	});

	// --- 4. 메인 화면 전환 ---
	btnStart.addEventListener('click', () => {
		alignLoginText();

		titlePart1.classList.add('exit-right');
		titlePart2.classList.add('exit-left');
		heroTextArea.classList.add('exit-down');
		heroBtns.classList.add('exit-down');
		scrollIcon.classList.add('exit-down');

		setTimeout(() => {
			heroMainWrapper.classList.add('move-to-side');

			targetText.style.opacity = '0';
			setTimeout(() => {
				targetText.innerText = "주주 클럽";
				targetText.style.opacity = '1';

				loginTextArea.classList.remove('hidden');
				loginTextArea.style.opacity = '1';

				alignLoginText();
				startSideTyping("만나서 반갑습니다.", "성공적인 투자의 여정을 이어가세요.");
			}, 300);

			loginSection.classList.add('active');
		}, 800);
	});

	// --- 5. 폼 전환 로직 ---
	function switchForm(toSignup) {
		const outgoing = toSignup ? formLogin : formSignup;
		const incoming = toSignup ? formSignup : formLogin;

		const newTitle = toSignup ? "환영합니다." : "만나서 반갑습니다.";
		const newSub = toSignup ? "새로운 여정을 시작해보세요." : "성공적인 투자의 여정을 이어가세요.";
		startSideTyping(newTitle, newSub);

		outgoing.style.opacity = '0';
		outgoing.style.transform = 'translateY(10px)';
		outgoing.style.pointerEvents = 'none';

		setTimeout(() => {
			outgoing.classList.remove('active-form');
			incoming.classList.add('active-form');

			setTimeout(() => {
				incoming.style.opacity = '1';
				incoming.style.transform = 'translateY(0)';
				incoming.style.pointerEvents = 'auto';
			}, 50);
		}, 400);
	}

	btnGoSignup.addEventListener('click', () => switchForm(true));
	btnGoLogin.addEventListener('click', () => switchForm(false));

	// --- 6. [Updated] 가입 완료 및 집중된 축하 효과 ---
	btnSubmitSignup.addEventListener('click', () => {
		// 회원가입 폼 숨기기
		formSignup.style.opacity = '0';
		formSignup.style.transform = 'translateY(10px)';
		formSignup.style.pointerEvents = 'none';

		setTimeout(() => {
			formSignup.classList.remove('active-form');
			formSuccess.classList.add('active-form');

			// 축하 메시지 등장
			setTimeout(() => {
				formSuccess.style.opacity = '1';
				formSuccess.style.transform = 'translateY(0)';

				// [New] 집중 폭죽 효과 (Focused Confetti)
				// 카드의 위치를 계산하여 그 주변에서 발사
				const rect = authCard.getBoundingClientRect();

				// 화면 전체 기준 좌표 (0~1)로 변환
				// 카드 왼쪽 끝
				const x1 = rect.left / window.innerWidth;
				// 카드 오른쪽 끝
				const x2 = rect.right / window.innerWidth;
				// 카드 중간 높이
				const y = (rect.top + rect.height / 2) / window.innerHeight;

				var duration = 1000; // [수정] 1초로 짧게 설정
				var end = Date.now() + duration;

				(function frame() {
					// 왼쪽 발사 (카드 왼쪽 가장자리에서 안쪽으로)
					confetti({
						particleCount: 5,
						angle: 60,
						spread: 55,
						origin: { x: x1, y: y },
						colors: ['#5E45EB', '#ECE9FD'],
						zIndex: 9999
					});
					// 오른쪽 발사 (카드 오른쪽 가장자리에서 안쪽으로)
					confetti({
						particleCount: 5,
						angle: 120,
						spread: 55,
						origin: { x: x2, y: y },
						colors: ['#5E45EB', '#ECE9FD'],
						zIndex: 9999
					});

					if (Date.now() < end) {
						requestAnimationFrame(frame);
					}
				}());

			}, 50);

			// 3초 후 로그인으로 자동 복귀
			setTimeout(() => {
				// 성공 메시지 퇴장
				formSuccess.style.opacity = '0';
				formSuccess.style.transform = 'translateY(10px)';

				// 왼쪽 텍스트 복귀
				startSideTyping("만나서 반갑습니다.", "성공적인 투자의 여정을 이어가세요.");

				setTimeout(() => {
					formSuccess.classList.remove('active-form');
					formLogin.classList.add('active-form');

					setTimeout(() => {
						formLogin.style.opacity = '1';
						formLogin.style.transform = 'translateY(0)';
						formLogin.style.pointerEvents = 'auto';
					}, 50);
				}, 400);

			}, 3000);

		}, 400);
	});

</script>

</body>
</html>

