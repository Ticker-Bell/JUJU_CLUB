<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
    [모달 래퍼]
    화면 전체를 덮는 배경(backdrop)과 중앙 정렬된 카드 박스
--%>
<div id="profileModal" class="fixed inset-0 z-[100] flex items-center justify-center bg-gray-900/40 backdrop-blur-sm p-4 animate-in fade-in duration-200">

    <%-- 모달 카드 본문 --%>
    <div class="bg-white w-full max-w-[420px] max-h-[90vh] overflow-y-auto custom-scroll rounded-[32px] shadow-2xl relative">

        <%-- 닫기 버튼 --%>
        <button type="button" onclick="document.getElementById('profileModal').remove()"
                class="absolute top-5 right-5 text-gray-400 hover:text-gray-900 transition-colors z-10">
            <i data-lucide="x" class="w-6 h-6"></i>
        </button>

        <%-- 기존 프로필 내용 (padding 추가) --%>
        <div class="p-8 pt-10">

            <script>
                window.__CTX__ = '${pageContext.request.contextPath}';
            </script>
            <%-- JS/CSS 로드 --%>
            <script src="${pageContext.request.contextPath}/resources/js/myPage/myPageProfile.js"></script>
            <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myPage/myPageProfile.css">

            <%-- 헤더 영역 --%>
            <div class="card-header text-center mb-6">
                <div class="profile-avatar w-20 h-20 mx-auto bg-gray-100 rounded-full flex items-center justify-center text-3xl font-bold text-gray-600 mb-3 border-4 border-white shadow-sm">
                    ${loginUser.userName.substring(0,1)}
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

                <%-- 아이디 (읽기 전용) --%>
                <div class="input-group">
                    <label class="input-label text-xs font-bold text-gray-500 mb-1 block">아이디</label>
                    <div class="input-wrapper relative">
                        <input type="text" value="${loginUser.userId}" class="input-field w-full bg-gray-50 text-gray-500 rounded-xl px-4 py-3 pl-10 text-sm font-bold outline-none border border-transparent" readonly>
                        <i data-lucide="mail" class="field-icon w-4 h-4 absolute left-3 top-3.5 text-gray-400"></i>
                    </div>
                </div>

                <%-- [삭제됨] 가입일 부분 제거 완료 --%>

                <%-- 닉네임 변경 --%>
                <div class="input-group">
                    <label class="input-label text-xs font-bold text-primary mb-1 block">닉네임 변경</label>
                    <div class="input-wrapper relative">
                        <input type="text" id="userName" value="${loginUser.userName}"
                               class="input-field w-full bg-white border border-gray-200 rounded-xl px-4 py-3 pl-10 text-sm font-bold outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all"
                               placeholder="변경할 닉네임을 입력하세요">
                        <i data-lucide="smile" class="field-icon w-4 h-4 absolute left-3 top-3.5 text-gray-400"></i>
                    </div>
                </div>

                <%-- 비밀번호 변경 --%>
                <div class="input-group">
                    <label class="input-label text-xs font-bold text-primary mb-1 block">비밀번호 변경</label>
                    <div class="input-wrapper relative">
                        <input type="password" id="userPw"
                               class="input-field w-full bg-white border border-gray-200 rounded-xl px-4 py-3 pl-10 text-sm font-bold outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all"
                               placeholder="변경할 비밀번호를 입력하세요">
                        <i data-lucide="lock" class="field-icon w-4 h-4 absolute left-3 top-3.5 text-gray-400"></i>
                    </div>
                </div>

                <%-- 저장 버튼 --%>
                <button type="button" onclick="updateProfile()" class="btn-primary w-full bg-primary text-white font-bold py-3.5 rounded-xl hover:bg-indigo-600 transition-colors shadow-lg shadow-indigo-200 mt-4">
                    변경사항 저장하기
                </button>
            </form>

            <%-- 회원 탈퇴 (Danger Zone) --%>
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
                            <input type="password" id="withdrawPassword" placeholder="비밀번호 확인"
                                   class="flex-1 bg-white border border-red-200 rounded-xl px-3 py-2 text-sm outline-none focus:border-red-500 focus:ring-2 focus:ring-red-200 transition-all">
                            <button type="button" onclick="withdrawMember()" class="btn-danger bg-red-500 text-white px-4 py-2 rounded-xl text-sm font-bold hover:bg-red-600 transition-colors shadow-lg shadow-red-200">
                                탈퇴
                            </button>
                        </div>
                    </div>
                </details>
            </div>

        </div>
    </div>

    <%-- 모달이 로드된 후 아이콘 다시 그리기 --%>
    <script>
        if(window.lucide) lucide.createIcons();
    </script>
</div>