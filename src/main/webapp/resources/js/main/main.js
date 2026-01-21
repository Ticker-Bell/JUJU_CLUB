// Tailwind 설정
tailwind.config = {
    theme: {extend: {fontFamily: {sans: ['Pretendard', 'sans-serif']}, colors: {primary: '#5E45EB', text: '#191919'}}}
}

// 사이드바 활성화 함수
function updateActiveMenu() {
    const navItems = document.querySelectorAll('.nav-item');
    const currentPath = window.location.pathname;

    navItems.forEach(item => {
        const itemPath = item.getAttribute('href');

        // 단순 비교 로직 유지
        const isExactMatch = (itemPath === currentPath);
        const isDefaultPage = currentPath.endsWith('/main') && itemPath.includes('roadMapMain.do');

        if (isExactMatch || isDefaultPage) {
            item.classList.add('active');
        } else {
            item.classList.remove('active');
        }
    });
}

// 1. 초기 실행
document.addEventListener('DOMContentLoaded', updateActiveMenu);

// 2. HTMX가 컨텐츠를 로드할 때마다 실행 (클릭 이동, 뒤로 가기 등 모든 상황 커버)
document.body.addEventListener('htmx:load', updateActiveMenu);

// 3. 뒤로 가기 실행
window.addEventListener('popstate', updateActiveMenu);
