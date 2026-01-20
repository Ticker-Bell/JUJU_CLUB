<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script>
    window.__CTX__ = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/resources/js/myPageProfile.js"></script>
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://unpkg.com/lucide@latest"></script>
<%--    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css" />--%>

<link rel="stylesheet" type="text/css" href="${cpath}/resources/css/myPage/myPageProfile.css">
<div>

    <div class="card-header">
        <div class="profile-avatar">
            ${loginUser.userName.substring(0,1)}
        </div>

        <h1 class="text-2xl font-extrabold text-gray-900 tracking-tight">
            ${loginUser.userName}
        </h1>

        <div class="user-badge">
            <i data-lucide="award" class="w-3 h-3"></i>
            <span>Level. ${loginUser.userLevel} Investor</span>
        </div>
    </div>

    <form id="profileForm">

        <div class="input-group">
            <label class="input-label">아이디</label>
            <div class="input-wrapper">
                <input type="text" value="${loginUser.userId}" class="input-field" readonly>
                <i data-lucide="mail" class="field-icon"></i>
            </div>
        </div>

        <div class="input-group">
            <label class="input-label">가입일</label>
            <div class="input-wrapper">
                <input type="text" value="${loginUser.createdAt}" class="input-field" readonly>
                <i data-lucide="calendar" class="field-icon"></i>
            </div>
        </div>

        <div class="input-group">
            <label class="input-label text-[#5E45EB]">닉네임</label>
            <div class="input-wrapper">
                <input type="text" id="userName" value="${loginUser.userName}"
                       class="input-field" placeholder="변경할 닉네임을 입력하세요">
                <i data-lucide="smile" class="field-icon"></i>
            </div>
        </div>

        <div class="input-group">
            <label class="input-label text-[#5E45EB]">비밀번호 변경</label>
            <div class="input-wrapper">
                <input type="password" id="userPw"
                       class="input-field" placeholder="변경하려면 입력하세요">
                <i data-lucide="lock" class="field-icon"></i>
            </div>
        </div>

        <button type="button" onclick="updateProfile()" class="btn-primary">
            변경사항 저장하기
        </button>
    </form>

    <div class="danger-zone">
        <details class="group">
            <summary class="danger-trigger">
                    <span class="flex items-center gap-2">
                        <i data-lucide="alert-triangle" class="w-4 h-4"></i>
                        계정 탈퇴하기
                    </span>
                <i data-lucide="chevron-down" class="w-4 h-4 transition-transform group-open:rotate-180"></i>
            </summary>

            <div class="danger-content">
                <p class="text-xs text-red-500 font-bold mb-3">
                    탈퇴 시 복구가 불가능합니다. 신중하게 결정해주세요.
                </p>
                <div class="flex gap-2">
                    <input type="password" id="withdrawPassword" placeholder="비밀번호 확인"
                           class="flex-1 bg-white border border-red-200 rounded-xl px-3 py-2 text-sm outline-none focus:border-red-500">
                    <button type="button" onclick="withdrawMember()" class="btn-danger">
                        탈퇴
                    </button>
                </div>
            </div>
        </details>
    </div>

</div>

<script src="${pageContext.request.contextPath}/resources/js/myPage/myPageProfile.js"></script>

