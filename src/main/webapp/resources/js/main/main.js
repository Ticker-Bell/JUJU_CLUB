
    // Tailwind 설정은 전역으로 한 번만 선언
    tailwind.config = {
    theme: { extend: { fontFamily:{ sans:['Pretendard','sans-serif'] }, colors:{ primary:'#5E45EB', text:'#191919' } } }
}

    document.addEventListener('DOMContentLoaded', function() {
    const navItems = document.querySelectorAll('.nav-item');
    const mainContainer = document.getElementById('main');

    // [기능 1] 처음 페이지 로드 시 현재 URL에 맞는 메뉴 활성화
    function setActiveMenu() {
    const currentPath = window.location.pathname;
    navItems.forEach(item => {
    // ContextPath가 포함될 수 있으므로 includes를 쓰거나 정확한 href 비교
    if (item.getAttribute('href') === currentPath) {
    item.classList.add('active');
} else {
    item.classList.remove('active');
}
});
}

    // [기능 2] 메뉴 클릭 시 Ajax로 본문만 교체
    navItems.forEach(item => {
    item.addEventListener('click', function(e) {
    e.preventDefault(); // 실제 페이지 이동 차단

    const url = this.getAttribute('href');

    fetch(url)
    .then(response => {
    if(!response.ok) throw new Error("로드 실패");
    return response.text();
})
    .then(html => {
    // 본문 교체
    mainContainer.innerHTML = html;

    // 주소창 URL 변경 (뒤로가기를 가능하게 하려면 필수!)
    history.pushState(null, null, url);

    // 활성화 클래스 교체 (클릭한 녀석에게만 active 부여)
    navItems.forEach(nav => nav.classList.remove('active'));
    this.classList.add('active');
})
    .catch(err => {
    console.error(err);
    mainContainer.innerHTML = "<p class='p-5'>내용을 불러오지 못했습니다.</p>";
});
});
});

    // 초기 실행
    setActiveMenu();
});
