const contextPath = window.__CTX__ || "";

// DOM이 로드되면 아이콘을 렌더링합니다.
document.addEventListener('DOMContentLoaded', () => {
    if (window.lucide) {
        lucide.createIcons();
    }
});

/**
 * 회원정보 수정 요청
 */
function updateProfile() {
    // 1. 입력값 가져오기
    const userNameInput = document.getElementById('userName');
    const userPwInput = document.getElementById('userPw');

    const userName = userNameInput.value;
    const userPw = userPwInput.value;

    // 2. 유효성 검사 (닉네임 필수)
    if (!userName || userName.trim() === "") {
        alert("닉네임을 입력해주세요.");
        userNameInput.focus();
        return;
    }

    // 3. 전송 데이터 객체 생성
    const requestData = {
        userName: userName
    };

    // 비밀번호는 사용자가 입력했을 때만 전송 데이터에 포함
    if (userPw && userPw.trim() !== "") {
        requestData.userPw = userPw;
    }

    // 버튼 로딩 상태 변경
    const btn = document.querySelector('.btn-primary');
    const originalText = btn.innerText;
    btn.innerText = '저장 중...';
    btn.disabled = true;

    // 4. AJAX 요청
    fetch(contextPath + '/member/updateProfile.ajax', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(requestData)
    })
        .then(async (res) => {
            const text = await res.text(); // 1) 응답을 텍스트로 먼저 받음
            console.log("status:", res.status);
            console.log("response:", text); // 디버깅용 로그

            try {
                return JSON.parse(text); // 2) JSON 파싱 시도
            } catch (e) {
                // HTML(에러페이지)이 반환된 경우 에러 처리
                throw new Error("서버 응답이 올바르지 않습니다. (HTML 반환됨)");
            }
        })
        .then(data => {
            // [수정된 부분] 파싱된 데이터를 받아서 처리하는 로직 추가!
            if (data.ok) {
                alert(data.message || "회원 정보가 성공적으로 수정되었습니다.");
                location.reload(); // 성공 시 새로고침
            } else {
                alert(data.message || "정보 수정에 실패했습니다.");
            }
        })
        .catch(error => {
            console.error("Error:", error);
            alert("서버 통신 중 오류가 발생했습니다: " + error.message);
        })
        .finally(() => {
            // 버튼 상태 원상복구
            btn.innerText = originalText;
            btn.disabled = false;
        });
}

/**
 * 회원 탈퇴 요청
 */
function withdrawMember() {
    const passwordInput = document.getElementById('withdrawPassword');
    const password = passwordInput.value;

    if (!password) {
        alert("본인 확인을 위해 비밀번호를 입력해주세요.");
        passwordInput.focus();
        return;
    }

    if (!confirm("정말로 탈퇴하시겠습니까?\n삭제된 데이터는 복구할 수 없습니다.")) return;

    fetch(contextPath + "/member/withdraw.ajax", {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ password: password })
    })
        .then(async (res) => {
            // withdrawMember 함수도 안전하게 텍스트로 먼저 받도록 수정
            const text = await res.text();
            try {
                return JSON.parse(text);
            } catch (e) {
                throw new Error("서버 응답이 올바르지 않습니다.");
            }
        })
        .then(data => {
            if (data.ok) {
                alert("탈퇴 처리가 완료되었습니다. 이용해 주셔서 감사합니다.");
                location.href = '/'; // 메인 페이지로 이동
            } else {
                alert(data.message);
            }
        })
        .catch(err => {
            console.error("Error:", err);
            alert("오류가 발생했습니다: " + err.message);
        });
}