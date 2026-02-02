const contextPath = window.__CTX__ || "";

document.addEventListener('DOMContentLoaded', () => {
    if (window.lucide) lucide.createIcons();
});

/* ============================================================
 * 1. 결과 모달 제어 공통 함수
 * ============================================================ */
function showResultModal(type, title, desc, callback, cancelCallback) {
    const modal = document.getElementById('resultModal');
    if (!modal) {
        if (type === 'confirm') {
            if (confirm(desc.replace(/<br>/g, "\n"))) callback();
        } else {
            alert(desc.replace(/<br>/g, "\n"));
            if (callback) callback();
        }
        return;
    }

    const iconContainer = document.getElementById('modalIcon');
    const titleEl = document.getElementById('modalTitle');
    const descEl = document.getElementById('modalDesc');
    const actionBtn = document.getElementById('modalActionBtn');
    const cancelBtn = document.getElementById('modalCancelBtn');
    const modalBar = document.getElementById('modalBar');

    // 1) 텍스트 설정
    if (titleEl) titleEl.innerText = title;
    if (descEl) descEl.innerHTML = desc;

    // 2) 초기화 (클래스 리셋)
    if (iconContainer) iconContainer.className = "w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-5 text-4xl shadow-lg transition-transform";
    if (actionBtn) actionBtn.className = "flex-1 py-3.5 rounded-xl text-white font-extrabold shadow-lg hover:brightness-105 transition-all";
    // ^ w-full 제거하고 flex-1 유지 (JSP 수정과 매칭)

    if (modalBar) modalBar.className = "h-2 w-full";
    if (cancelBtn) cancelBtn.classList.add('hidden');

    // 3) 타입별 스타일 적용
    if (type === 'success') {
        // ✅ [수정] 성공 시 연두색(green) -> 포인트 컬러(primary)로 변경
        setModalTheme(iconContainer, modalBar, actionBtn, 'bg-primary', 'check', 'shadow-primary/30');
        actionBtn.innerText = "확인";

    } else if (type === 'error') {
        // 에러는 빨간색 유지
        setModalTheme(iconContainer, modalBar, actionBtn, 'bg-red-500', 'x', 'shadow-red-500/30');
        actionBtn.innerText = "다시 시도";

    } else if (type === 'confirm') {
        // 탈퇴 확인 등 (빨간색)
        setModalTheme(iconContainer, modalBar, actionBtn, 'bg-red-500', 'alert-triangle', 'shadow-red-500/30');
        actionBtn.innerText = "탈퇴하기";

        if (cancelBtn) {
            cancelBtn.classList.remove('hidden');
            cancelBtn.onclick = function () {
                closeModal();
                if (cancelCallback) cancelCallback();
            }
        }

    } else { // warning
        // 경고는 주황색 유지
        setModalTheme(iconContainer, modalBar, actionBtn, 'bg-orange-400', 'alert-circle', 'shadow-orange-400/30');
        actionBtn.innerText = "확인";
    }

    // 아이콘 렌더링
    if (window.lucide) lucide.createIcons();

    // 버튼 이벤트
    actionBtn.onclick = function () {
        closeModal();
        if (callback && typeof callback === 'function') callback();
    };

    // 모달 표시
    modal.classList.remove('hidden');
    modal.classList.add('flex');
}

// 테마 적용 헬퍼 함수
function setModalTheme(icon, bar, btn, colorClass, iconName, shadowClass) {
    if (icon) {
        icon.innerHTML = `<i data-lucide="${iconName}" class="w-10 h-10 text-white"></i>`;
        icon.classList.add(colorClass);
    }
    if (bar) bar.classList.add(colorClass);
    if (btn) btn.classList.add(colorClass, shadowClass);
}

// 모달 닫기
function closeModal() {
    const modal = document.getElementById('resultModal');
    if (modal) {
        modal.classList.add('hidden');
        modal.classList.remove('flex');
    }
}
window.closeModal = closeModal;

/* ============================================================
 * 2. 회원정보 수정
 * ============================================================ */
function updateProfile() {
    const userNameInput = document.getElementById('userName');
    const userPwInput = document.getElementById('userPw');
    const userName = userNameInput.value;
    const userPw = userPwInput.value;

    if (!userName || userName.trim() === "") {
        showResultModal('warning', '입력 확인', '닉네임을 입력해주세요.', () => userNameInput.focus());
        return;
    }

    const requestData = { userName: userName };
    if (userPw && userPw.trim() !== "") requestData.userPw = userPw;

    const btn = document.querySelector('.btn-primary');
    let originalText = btn ? btn.innerText : "";
    if (btn) { btn.innerText = '저장 중...'; btn.disabled = true; }

    fetch(contextPath + '/member/updateProfile.ajax', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(requestData)
    })
        .then(async (res) => {
            try { return JSON.parse(await res.text()); } catch (e) { throw new Error("서버 응답 오류"); }
        })
        .then(data => {
            if (data.ok) showResultModal('success', '수정 완료', '회원 정보가 성공적으로 수정되었습니다.', () => location.reload());
            else showResultModal('error', '수정 실패', data.message || "정보 수정에 실패했습니다.");
        })
        .catch(error => showResultModal('error', '오류 발생', error.message))
        .finally(() => { if (btn) { btn.innerText = originalText; btn.disabled = false; } });
}

/* ============================================================
 * 3. 회원 탈퇴
 * ============================================================ */
function withdrawMember() {
    const passwordInput = document.getElementById('withdrawPassword');
    const password = passwordInput.value;

    if (!password) {
        showResultModal('warning', '입력 확인', '본인 확인을 위해<br>비밀번호를 입력해주세요.', () => passwordInput.focus());
        return;
    }

    showResultModal(
        'confirm',
        '탈퇴 확인',
        '정말로 탈퇴하시겠습니까?<br>삭제된 데이터는 복구할 수 없습니다.',
        function () {
            realWithdraw(password);
        }
    );
}

function realWithdraw(password) {
    fetch(contextPath + "/member/withdraw.ajax", {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ password: password })
    })
        .then(async (res) => {
            try { return JSON.parse(await res.text()); } catch (e) { throw new Error("서버 응답 오류"); }
        })
        .then(data => {
            if (data.ok) {
                showResultModal('success', '탈퇴 완료', '이용해 주셔서 감사합니다.', () => {
                    window.location.href = contextPath + "/";
                });
            } else {
                showResultModal('error', '탈퇴 실패', data.message || '비밀번호가 일치하지 않습니다.');
            }
        })
        .catch(err => showResultModal('error', '오류 발생', err.message));
}