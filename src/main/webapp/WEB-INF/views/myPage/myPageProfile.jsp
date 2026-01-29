<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />
<c:set var="defaultProfile" value="${cpath}/resources/images/default-profile.png" />

<div id="profileModal"
     class="fixed inset-0 z-[100] flex items-center justify-center bg-gray-900/60 backdrop-blur-sm p-4 animate-in fade-in duration-200">

    <!-- ✅ 카드 폭/라운드/스크롤 균형 조정 -->
    <div class="bg-white w-full max-w-[440px] max-h-[90vh] overflow-y-auto custom-scroll rounded-[28px] shadow-2xl relative">

        <button type="button"
                onclick="document.getElementById('profileModal').remove()"
                class="absolute top-5 right-5 text-gray-400 hover:text-gray-900 transition-colors z-10">
            <i data-lucide="x" class="w-6 h-6"></i>
        </button>

        <!-- ✅ 내부 패딩 균형 조정 -->
        <div class="px-8 py-8">

            <script>
              window.__CTX__ = '${cpath}';
            </script>

            <script src="${cpath}/resources/js/myPage/myPageProfile.js"></script>

            <!-- ✅ myPageProfile.css 내용을 JSP에 인라인으로 이관 -->
            <style>
              /* [기본 설정: Pure White Theme] */

              /* [플로팅 UI 카드] */
              .profile-card {
                width: 100%;
                max-width: 480px;
                background: #ffffff;
                border-radius: 24px;
                box-shadow: 0 10px 40px -10px rgba(0, 0, 0, 0.08);
                border: 1px solid #F1F5F9;
                padding: 40px;
                position: relative;
                z-index: 10;
              }

              /* [헤더 영역] */
              .card-header {
                text-align: center;
                margin-bottom: 20px;
              }

              .profile-avatar {
                width: 80px;
                height: 80px;
                margin: 0 auto 16px;
                border-radius: 50%;
                background: linear-gradient(135deg, #5E45EB 0%, #8B5CF6 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 32px;
                font-weight: 800;
                color: #fff;
                box-shadow: 0 8px 20px rgba(94, 69, 235, 0.25);
              }

              .user-badge {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 6px 12px;
                background-color: #F5F3FF;
                color: #5E45EB;
                border-radius: 99px;
                font-size: 12px;
                font-weight: 700;
                margin-top: 8px;
              }

              /* [입력 필드 스타일] */
              .input-group {
                margin-bottom: 14px; /* ✅ 간격 살짝 컴팩트 */
                position: relative;
              }

              .input-label {
                display: block;
                font-size: 13px;
                font-weight: 700;
                color: #64748B;
                margin-bottom: 8px;
              }

              .input-wrapper {
                position: relative;
              }

              /* ✅ 아이콘 제거에 맞춰 padding-left(46px) 제거 + 높이/폰트 균형 */
              .input-field {
                width: 100%;
                background-color: #F8FAFC;
                border: 1px solid #E2E8F0;
                border-radius: 16px;
                padding: 14px 16px; /* ✅ 핵심 */
                font-size: 14px;
                font-weight: 700;
                color: #1E293B;
                transition: all 0.2s ease;
                outline: none;
                box-sizing: border-box;
              }

              .input-field:focus {
                background-color: #ffffff;
                border-color: #5E45EB;
                box-shadow: 0 0 0 4px rgba(94, 69, 235, 0.1);
              }

              .input-field[readonly] {
                background-color: #F1F5F9;
                color: #94A3B8;
                cursor: default;
                border-color: transparent;
              }

              /* (아이콘은 현재 미사용이지만, 기존 코드 호환을 위해 남겨둠) */
              .field-icon {
                position: absolute;
                left: 16px;
                top: 50%;
                transform: translateY(-50%);
                width: 20px;
                height: 20px;
                color: #94A3B8;
                pointer-events: none;
                transition: color 0.2s;
              }

              /* [메인 버튼] */
              .btn-primary {
                width: 100%;
                padding: 16px; /* ✅ 살짝 컴팩트 */
                background-color: #5E45EB;
                color: #ffffff;
                font-size: 15px;
                font-weight: 800;
                border: none;
                border-radius: 16px;
                cursor: pointer;
                transition: all 0.2s;
                box-shadow: 0 4px 12px rgba(94, 69, 235, 0.2);
                margin-top: 10px;
              }

              .btn-primary:hover {
                background-color: #4F46E5;
                transform: translateY(-1px);
                box-shadow: 0 8px 20px rgba(94, 69, 235, 0.3);
              }

              .btn-primary:active { transform: translateY(0); }

              /* [위험 구역 - 탈퇴] */
              .danger-zone {
                margin-top: 18px; /* ✅ 폼과 과한 간격 제거 */
                border-top: 1px solid #F1F5F9;
                padding-top: 16px;
              }

              .danger-trigger {
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-size: 13px;
                font-weight: 700;
                color: #EF4444;
                cursor: pointer;
                list-style: none;
                transition: opacity 0.2s;
              }
              .danger-trigger:hover { opacity: 0.85; }

              .danger-content {
                margin-top: 12px;
                padding: 14px;
                background-color: #FEF2F2;
                border-radius: 12px;
                border: 1px solid #FEE2E2;
              }

              .btn-danger {
                background-color: #EF4444;
                color: white;
                border: none;
                padding: 0 16px;
                border-radius: 12px;
                font-weight: 800;
                font-size: 13px;
                cursor: pointer;
                transition: background 0.2s;
                height: 40px; /* ✅ 인풋과 높이 맞춤 */
                white-space: nowrap;
              }
              .btn-danger:hover { background-color: #DC2626; }
            </style>

            <!-- ✅ 헤더(프로필/이름/레벨) 간격 정돈 -->
            <div class="card-header text-center">
                <div class="relative w-20 h-20 mx-auto mb-3 overflow-visible">
                    <div class="w-20 h-20 rounded-full overflow-hidden bg-gray-100">
                        <img
                                id="profileAvatarImg"
                                src="${cpath}/member/profile-image?ts=<%=System.currentTimeMillis()%>"
                                alt="profile"
                                class="w-full h-full object-cover"
                                loading="lazy"
                                onerror="this.onerror=null; this.src='${defaultProfile}';"
                        />
                    </div>

                    <input id="profileImageInput" type="file" accept="image/*" class="hidden" />

                    <div class="absolute -bottom-1 -right-1 group">
                        <button id="profileEditBtn"
                                type="button"
                                onclick="openProfileImagePicker()"
                                class="bg-gray-900 p-1.5 rounded-full hover:bg-primary transition-colors cursor-pointer z-30 flex items-center justify-center disabled:opacity-60 disabled:cursor-not-allowed"
                                aria-label="프로필 사진 변경">
                            <i data-lucide="pencil" class="w-4 h-4 text-white"></i>
                        </button>

                        <div class="pointer-events-none absolute right-0 bottom-12 opacity-0 translate-y-1 group-hover:opacity-100 group-hover:translate-y-0 transition-all">
                            <div class="whitespace-nowrap text-[11px] font-bold text-white bg-gray-900/95 px-3 py-2 rounded-xl shadow-xl">
                                프로필 사진 변경 (최대 2MB)
                                <div class="absolute right-3 -bottom-1 w-2 h-2 bg-gray-900/95 rotate-45"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <h1 class="text-2xl font-extrabold text-gray-900 tracking-tight mb-2">
                    ${loginUser.userName}
                </h1>

                <!-- ✅ 레벨 뱃지 (Lv.1/2/3 + 기본값) -->
                <div class="flex items-center justify-center">
                    <c:choose>
                        <c:when test="${loginUser.userLevel == 1}">
                            <span class="px-3 py-1 rounded-full bg-primary/10 text-primary text-[11px] font-extrabold border border-primary/20">
                                Lv.1 초급
                            </span>
                        </c:when>

                        <c:when test="${loginUser.userLevel == 2}">
                            <span class="px-3 py-1 rounded-full bg-green-100 text-green-600 text-[11px] font-extrabold border border-green-200">
                                Lv.2 중급
                            </span>
                        </c:when>

                        <c:when test="${loginUser.userLevel == 3}">
                            <span class="px-3 py-1 rounded-full bg-orange-100 text-orange-600 text-[11px] font-extrabold border border-orange-200">
                                Lv.3 고급
                            </span>
                        </c:when>

                        <c:otherwise>
                            <span class="px-3 py-1 rounded-full bg-gray-100 text-gray-600 text-[11px] font-extrabold border border-gray-200">
                                일반
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- ✅ 폼: 헤더 아래 여백 확보 -->
            <form id="profileForm" class="mt-6">

                <!-- ✅ 아이디 -->
                <div class="input-group flex items-center gap-3">
                    <label class="input-label text-xs font-bold text-gray-500 mb-0 block w-24 shrink-0">
                        아이디
                    </label>
                    <input type="text"
                           value="${loginUser.userId}"
                           class="input-field flex-1 w-full bg-gray-50 text-gray-500 rounded-xl px-4 py-3 text-sm font-bold outline-none border border-transparent"
                           readonly>
                </div>

                <!-- ✅ 닉네임 변경 -->
                <div class="input-group flex items-center gap-3">
                    <label class="input-label text-xs font-bold text-primary mb-0 block w-24 shrink-0">
                        닉네임 변경
                    </label>
                    <input type="text"
                           id="userName"
                           value="${loginUser.userName}"
                           class="input-field flex-1 w-full bg-white border border-gray-200 rounded-xl px-4 py-3 text-sm font-bold outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all"
                           placeholder="변경할 닉네임을 입력하세요">
                </div>

                <!-- ✅ 비밀번호 변경 -->
                <div class="input-group flex items-center gap-3">
                    <label class="input-label text-xs font-bold text-primary mb-0 block w-24 shrink-0">
                        비밀번호 변경
                    </label>
                    <input type="password"
                           id="userPw"
                           class="input-field flex-1 w-full bg-white border border-gray-200 rounded-xl px-4 py-3 text-sm font-bold outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all"
                           placeholder="변경할 비밀번호를 입력하세요">
                </div>

                <button type="button"
                        onclick="updateProfile()"
                        class="btn-primary w-full bg-primary text-white font-bold py-3.5 rounded-xl hover:bg-indigo-600 transition-colors shadow-lg shadow-indigo-200 mt-3">
                    변경사항 저장하기
                </button>
            </form>

            <!-- ✅ 위험 구역: 폼과 간격/정렬 정돈 -->
            <div class="danger-zone mt-6 pt-5 border-t border-gray-100">
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

                        <!-- ✅ 탈퇴 입력/버튼 높이 맞춤 -->
                        <div class="flex gap-2 items-center">
                            <input type="password"
                                   id="withdrawPassword"
                                   placeholder="비밀번호 확인"
                                   class="h-10 flex-1 bg-white border border-red-200 rounded-xl px-3 text-sm outline-none focus:border-red-500 focus:ring-2 focus:ring-red-200 transition-all">
                            <button type="button"
                                    onclick="withdrawMember()"
                                    class="btn-danger bg-red-500 text-white px-4 rounded-xl text-sm font-bold hover:bg-red-600 transition-colors shadow-lg shadow-red-200">
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

        input.onchange = async function () {
          const file = input.files && input.files[0];
          if (!file) return;

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
          fd.append("userImage", file);

          try {
            if (btn) btn.disabled = true;

            const res = await fetch(window.__CTX__ + "/member/updateProfileImage.ajax", {
              method: "POST",
              body: fd,
              credentials: "same-origin"
            });

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

            if (img) img.src = window.__CTX__ + "/member/profile-image?ts=" + Date.now();

            // ✅ main 이미지도 즉시 갱신(메인에서 리스너 쓰는 경우)
            document.body.dispatchEvent(new Event('profile-image-updated'));

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
