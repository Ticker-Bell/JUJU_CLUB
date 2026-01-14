// Tailwind 설정
tailwind.config = {
    theme: { extend: { fontFamily:{ sans:['Pretendard','sans-serif'] }, colors:{ primary:'#5E45EB', text:'#191919' } } }
}

document.addEventListener('DOMContentLoaded', function() {
    const navItems = document.querySelectorAll('.nav-item');

    function updateActiveMenu() {
        // 현재 브라우저 주소
        const currentPath = window.location.pathname;

        navItems.forEach(item => {
            const itemPath = item.getAttribute('href');

            // 주소가 정확히 일치하는 경우 (기본 로직)
            const isExactMatch = (itemPath === currentPath);

            // /main 으로 접속했고, 이 메뉴가 '로드맵'인 경우 (디폴트 처리)
            // contextPath가 있을 수 있으므로 끝부분(/main)으로 체크
            const isDefaultPage = currentPath.endsWith('/main') && itemPath.includes('roadMapMain.do');

            if (isExactMatch || isDefaultPage) {
                item.classList.add('active');
            } else {
                item.classList.remove('active');
            }
        });
    }

    // 1. 초기 실행
    updateActiveMenu();

    // 2. HTMX 화면 전환 후 실행
    document.body.addEventListener('htmx:pushed-into-history', function() {
        updateActiveMenu();
    });

    // 3. 뒤로 가기 실행
    window.addEventListener('popstate', function() {
        updateActiveMenu();
    });
});