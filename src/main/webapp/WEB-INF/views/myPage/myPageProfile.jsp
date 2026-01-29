<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />
<c:set var="defaultProfile" value="${cpath}/resources/images/default-profile.png" />

<div id="profileModal" class="fixed inset-0 z-[100] flex items-center justify-center bg-gray-900/40 backdrop-blur-sm p-4 animate-in fade-in duration-200">

    <div class="bg-white w-full max-w-[420px] max-h-[90vh] overflow-y-auto custom-scroll rounded-[32px] shadow-2xl relative">

        <button type="button"
                onclick="document.getElementById('profileModal').remove()"
                class="absolute top-5 right-5 text-gray-400 hover:text-gray-900 transition-colors z-10">
            <i data-lucide="x" class="w-6 h-6"></i>
        </button>

        <div class="p-8 pt-10">

            <script>
                window.__CTX__ = '${cpath}';
            </script>

            <script src="${cpath}/resources/js/myPage/myPageProfile.js"></script>
            <link rel="stylesheet" type="text/css" href="${cpath}/resources/css/myPage/myPageProfile.css">

            <div class="card-header text-center mb-6">

                <%-- ✅ 프로필 이미지 + 수정 버튼(툴팁/업로드) --%>
                <div class="relative w-20 h-20 mx-auto mb-3">

                    <div class="profile-avatar w-20 h-20 bg-gray-100 rounded-full border-4 border-white shadow-sm overflow-hidden">
                        <%-- ✅ 핵심: src 속성 안에 JSTL 태그 넣지 말고, 무조건 profile-image로 호출 + 404면 onerror로 기본이미지 --%>
                        <img
                                id="profileAvatarImg"
                                src="${cpath}/member/profile-image?ts=<%=System.currentTimeMillis()%>"
                                alt="profile"
                                class="w-full h-full object-cover"
                                loading="lazy"
                                onerror="this.onerror=null; this.src='${defaultProfile}';"
                        />
                    </div>

                    <%-- 숨김 파일 인풋 --%>
                    <input
                            id="profileImageInput"
                            type="file"
                            accept="image/*"
                            class="hidden"
                    />

                    <%-- 수정 버튼 + 툴팁 --%>
                    <div class="absolute -bottom-2 -right-2 group">
                        <button id="profileEditBtn"
                                type="button"
                                onclick="openProfileImagePicker()"
                                class="w-9 h-9 rounded-full bg-gray-900 text-white flex items-center justify-center border-2 border-white shadow-lg hover:bg-primary transition-colors disabled:opacity-60 disabled:cursor-not-allowed">
                            <i data-lucide="pencil" class="w-4 h-4"></i>
                        </button>

                        <div class="pointer-events-none absolute right-0 bottom-12 opacity-0 translate-y-1 group-hover:opacity-100 group-hover:translate-y-0 transition-all">
                            <div class="whitespace-nowrap text-[11px] font-bold text-white bg-gray-900/95 px-3 py-2 rounded-xl shadow-xl">
                                프로필 사진 변경 (최대 2MB)
                                <div class="absolute right-3 -bottom-1 w-2 h-2 bg-gray-900/95 rotate-45"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <h1 class="text-2xl font-extrabold text-gray-900 tracking-tight mb-1">
                    ${loginUser.userName}
                </h1>

                <div class="user-badge inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-slate-100 text-slate-600 text-xs font-bold">
                    <i data-lucide="award" class="w-3 h-3"></i>
                    <span>Level. ${loginUser.userLevel} Investor</span>
                </div>
            </div>

            <form id="profileForm" class="space-y-4">

                <div class="input-group">
                    <label class="input-label text-xs font-bold text-gray-500 mb-1 block">아이디</label>
                    <div class="input-wrapper relative">
                        <input type="text"
                               value="${loginUser.userId}"
                               class="input-field w-full bg-gray-50 text-gray-500 rounded-xl px-4 py-3 pl-10 text-sm font-bold outline-none border border-transparent"
                               readonly>
                        <i data-lucide="mail" class="field-icon w-4 h-4 absolute left-3 top-3.5 text-gray-400"></i>
                    </div>
                </div>

                <div class="input-group">
                    <label class="input-label text-xs font-bold text-primary mb-1 block">닉네임 변경</label>
                    <div class="input-wrapper relative">
                        <input type="text"
                               id="userName"
                               value="${loginUser.userName}"
                               class="input-field w-full bg-white border border-gray-200 rounded-xl px-4 py-3 pl-10 text-sm font-bold outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all"
                               placeholder="변경할 닉네임을 입력하세요">
                        <i data-lucide="smile" class="field-icon w-4 h-4 absolute left-3 top-3.5 text-gray-400"></i>
                    </div>
                </div>

                <div class="input-group">
                    <label class="input-label text-xs font-bold text-primary mb-1 block">비밀번호 변경</label>
                    <div class="input-wrapper relative">
                        <input type="password"
                               id="userPw"
                               class="input-field w-full bg-white border border-gray-200 rounded-xl px-4 py-3 pl-10 text-sm font-bold outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all"
                               placeholder="변경할 비밀번호를 입력하세요">
                        <i data-lucide="lock" class="field-icon w-4 h-4 absolute left-3 top-3.5 text-gray-400"></i>
                    </div>
                </div>

                <button type="button"
                        onclick="updateProfile()"
                        class="btn-primary w-full bg-primary text-white font-bold py-3.5 rounded-xl hover:bg-indigo-600 transition-colors shadow-lg shadow-indigo-200 mt-4">
                    변경사항 저장하기
                </button>
            </form>

            <div class="danger-zone mt-8 pt-6 border-t border-gray-100">
                <details class="group">
                    <summary class="danger-trigger flex items-center justify-between cursor-pointer list-none text-gray-400 hover:text-red-500 transition-colors text-xs font-bold">
            <span class="flex items-center gap-2">
              <i data-lucide="alert-triangle" class="w-4 h-4"></i>
              계정 탈퇴하기
            </span>
                        <i data-lucide="chevron-down" class="w-4 h-4 transition-transform group-open:rotate-180"></i>
                    </summary>

                    <div class="danger-content mt-3 animate-in fade-in slide-in-from-top-1 duration-200">
                        <p class="text-xs text-red-500 font-bold mb-3 bg-red-50 p-3 rounded-lg border border-red-100">
                            탈퇴 시 모든 정보가 삭제되며 복구가 불가능합니다.
                        </p>
                        <div class="flex gap-2">
                            <input type="password"
                                   id="withdrawPassword"
                                   placeholder="비밀번호 확인"
                                   class="flex-1 bg-white border border-red-200 rounded-xl px-3 py-2 text-sm outline-none focus:border-red-500 focus:ring-2 focus:ring-red-200 transition-all">
                            <button type="button"
                                    onclick="withdrawMember()"
                                    class="btn-danger bg-red-500 text-white px-4 py-2 rounded-xl text-sm font-bold hover:bg-red-600 transition-colors shadow-lg shadow-red-200">
                                탈퇴
                            </button>
                        </div>
                    </div>
                </details>
            </div>

        </div>
    </div>

    <script>
        // ✅ 모달 로드 후 아이콘 다시 그리기
        if (window.lucide) lucide.createIcons();

        function openProfileImagePicker() {
            const input = document.getElementById('profileImageInput');
            if (!input) return;
            input.click();
        }

        (function bindProfileUpload() {
            const input = document.getElementById('profileImageInput');
            const btn = document.getElementById('profileEditBtn');
            const img = document.getElementById('profileAvatarImg');

            if (!input) return;

            // ✅ 중복 바인딩 방지: onchange 덮어쓰기
            input.onchange = async function () {
                const file = input.files && input.files[0];
                if (!file) return;

                // ✅ 2MB 제한
                const maxBytes = 2 * 1024 * 1024;
                if (file.size > maxBytes) {
                    alert("이미지 용량이 너무 큽니다. (최대 2MB)");
                    input.value = "";
                    return;
                }
                if (!file.type || !file.type.startsWith("image/")) {
                    alert("이미지 파일만 업로드할 수 있습니다.");
                    input.value = "";
                    return;
                }

                const fd = new FormData();
                fd.append("userImage", file); // 컨트롤러 @RequestParam("userImage")와 동일해야 함

                try {
                    if (btn) btn.disabled = true;

                    const res = await fetch(window.__CTX__ + "/member/updateProfileImage.ajax", {
                        method: "POST",
                        body: fd,
                        credentials: "same-origin" // ✅ 세션 쿠키 포함
                    });

                    // 응답이 JSON이 아닐 수도 있어서 안전 처리
                    const ct = res.headers.get("content-type") || "";
                    let data;

                    if (ct.includes("application/json")) {
                        data = await res.json();
                    } else {
                        const text = await res.text();
                        throw new Error("서버 응답이 JSON이 아닙니다. status=" + res.status + " body=" + text);
                    }

                    if (!data || !data.ok) {
                        alert((data && data.message) ? data.message : "업로드 실패");
                        input.value = "";
                        return;
                    }

                    // ✅ 업로드 성공 -> 이미지 새로고침(캐시 방지)
                    if (img) img.src = window.__CTX__ + "/member/profile-image?ts=" + Date.now();

                    alert(data.message || "프로필 이미지가 저장되었습니다.");
                    input.value = "";
                } catch (e) {
                    console.error(e);
                    alert("이미지 업로드 중 오류가 발생했습니다.");
                    input.value = "";
                } finally {
                    if (btn) btn.disabled = false;
                }
            };
        })();
    </script>
</div>