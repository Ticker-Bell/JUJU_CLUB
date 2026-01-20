function initRoadMapDropdowns() {
    const wrappers = document.querySelectorAll('.select-wrapper');

    // 1. 초기화: 모든 드롭다운에 기본 동작 연결
    wrappers.forEach(wrapper => {
        const button = wrapper.querySelector('button.control-item');
        const list = wrapper.querySelector('.optionList');
        const items = list.querySelectorAll('.optionItem');
        const textSpan = button.querySelector('.btn-text');

        // 기존에 이벤트가 붙어있을 수 있으므로 복제해서 초기화 (선택사항, 안전장치)
        // 여기서는 간단하게 기존 로직 유지

        // 버튼 클릭 시 토글
        button.onclick = (e) => { // addEventListener 대신 onclick을 쓰면 중복 이벤트 방지에 유리함
            e.stopPropagation();
            closeAllDropdowns(button);
            button.classList.toggle('active');
            list.classList.toggle('show');
        };

        // 각 항목(li)에 클릭 이벤트 연결
        items.forEach(item => {
            setupOptionItem(item, button, list, textSpan);
        });
    });

    // 2. 항목 클릭 이벤트 설정 함수
    function setupOptionItem(item, button, list, textSpan) {
        item.onclick = (e) => {
            e.stopPropagation();

            textSpan.textContent = item.textContent;

            const value = item.getAttribute('data-value');

            // 스타일 업데이트
            const siblings = list.querySelectorAll('.optionItem');
            siblings.forEach(i => i.classList.remove('selected'));
            item.classList.add('selected');

            button.classList.remove('active');
            list.classList.remove('show');

            // 레벨 선택 시 챕터 목록 갱신 트리거
            if (button.id === 'levelSelect') {
                fetchChapters(value);
            }
        };
    }

    // 3. 서버에서 챕터 데이터 가져오기
    function fetchChapters(levelId) {
        const chapterBtn = document.getElementById('chapterSelect');
        const chapterSpan = chapterBtn.querySelector('.btn-text');
        const chapterListUl = document.getElementById('chapterListContainer');

        // URL 연결 방식 + 사용 확인 완료
        fetch('/roadMapApi/chapters?levelId=' + levelId)
            .then(response => {
                if (!response.ok) throw new Error('Network response was not ok');
                return response.json();
            })
            .then(data => {
                chapterListUl.innerHTML = ''; // 기존 목록 비우기

                if (data.length === 0 || data[0].chapterId == null) {
                    chapterSpan.textContent = "챕터가 없습니다.";
                    return;
                }

                chapterSpan.textContent = "챕터 선택";

                data.forEach(chapter => {
                    const li = document.createElement('li');
                    li.className = 'optionItem';
                    li.textContent = chapter.chapterName;
                    li.setAttribute('data-value', chapter.chapterId);

                    // 동적으로 생성된 요소에도 이벤트 연결
                    setupOptionItem(li, chapterBtn, chapterListUl, chapterSpan);
                    chapterListUl.appendChild(li);
                });
            })
            .catch(error => {
                console.error('Error fetching chapters:', error);
                chapterSpan.textContent = "불러오기 실패";
            });
    }

    // 4. 외부 클릭 시 닫기 (문서 전체에 거는 이벤트는 중복 방지 필요)
    // 기존 리스너 제거 후 다시 등록 (HTMX 특성상 페이지 전환 시 누적될 수 있음)
    document.removeEventListener('click', closeAllDropdowns);
    document.addEventListener('click', closeAllDropdowns);

    function closeAllDropdowns(e) {
        // e가 undefined일 경우(직접 호출) 처리
        const target = e ? e.target : null;

        // 클릭된 곳이 드롭다운 내부라면 닫지 않음 (필요 시 로직 추가)

        document.querySelectorAll('.select-wrapper').forEach(wrapper => {
            const btn = wrapper.querySelector('button.control-item');
            const list = wrapper.querySelector('.optionList');

            // 현재 클릭된 버튼이 아니면 닫기
            if (btn && btn !== target && !btn.contains(target)) {
                btn.classList.remove('active');
                list.classList.remove('show');
            }
        });
    }
}

// DOMContentLoaded 제거하고 함수를 즉시 실행
initRoadMapDropdowns();