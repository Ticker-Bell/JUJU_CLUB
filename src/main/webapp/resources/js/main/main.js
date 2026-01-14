// Tailwind 설정
tailwind.config = {
    theme: { extend: { fontFamily:{ sans:['Pretendard','sans-serif'] }, colors:{ primary:'#5E45EB', text:'#191919' } } }
}

document.addEventListener('DOMContentLoaded', function() {
    const navItems = document.querySelectorAll('.nav-item');

    // 현재 주소(URL)와 비교해서 메뉴 색상 변경
    function updateActiveMenu() {
        const currentPath = window.location.pathname;

        navItems.forEach(item => {
            const itemPath = item.getAttribute('href');

            // 현재 주소와 메뉴의 링크가 일치하면 active 클래스 추가
            if (itemPath === currentPath) {
                item.classList.add('active');
            } else {
                item.classList.remove('active');
            }
        });
    }

    // 1. 처음 접속했을 때 실행 (새로고침 시 적용)
    updateActiveMenu();

    // 2. HTMX가 화면을 바꾸고 URL을 변경했을 때 실행
    document.body.addEventListener('htmx:pushed-into-history', function() {
        updateActiveMenu();
    });

    // 3. 브라우저 뒤로가기 버튼 눌렀을 때 실행
    window.addEventListener('popstate', function() {
        updateActiveMenu();
    });
});