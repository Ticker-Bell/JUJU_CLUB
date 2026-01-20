<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>마이페이지 | JUJU CLUB</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard-dynamic-subset.css" />

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: { sans: ['Pretendard', 'sans-serif'] },
                    colors: { primary: '#5E45EB', secondary: '#F1F5F9' }
                }
            }
        }
    </script>

    <style>
        body { background-color: #F8FAFC; color: #1E293B; }
        .dashboard-card {
            background: #FFFFFF;
            border-radius: 20px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
            border: 1px solid #F1F5F9;
            overflow: hidden;
        }
    </style>
</head>

<body class="min-h-screen p-8">

<div class="max-w-7xl mx-auto">
    <div class="mb-8">
        <h1 class="text-2xl font-extrabold text-gray-900">마이페이지</h1>
        <p class="text-sm text-gray-500 font-medium mt-1">내 자산 현황과 활동 기록을 확인하세요.</p>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-12 gap-6">

        <div class="col-span-1 md:col-span-4 lg:col-span-3">
            <div class="dashboard-card p-6 relative">

                <div class="flex items-center gap-4 mb-6">
                    <div class="w-14 h-14 rounded-full bg-gradient-to-br from-indigo-500 to-purple-600 flex items-center justify-center text-white text-xl font-black shadow-lg shadow-indigo-200">
                        ${loginUser.userName.substring(0,1)}
                    </div>
                    <div class="overflow-hidden">
                        <h2 class="text-lg font-extrabold text-gray-900 truncate">${loginUser.userName}</h2>
                        <p class="text-xs text-gray-500 font-medium truncate">${loginUser.userId}</p>
                        <span class="inline-flex items-center mt-1 px-2 py-0.5 rounded bg-indigo-50 text-indigo-600 text-[10px] font-bold">
                                Lv. ${loginUser.userLevel} Investor
                            </span>
                    </div>
                </div>

                <hr class="border-gray-100 my-5">

                <div class="space-y-3">
                    <div class="p-4 bg-slate-50 rounded-2xl border border-slate-100">
                        <div class="flex items-center gap-2 mb-1">
                            <i data-lucide="pie-chart" class="w-3.5 h-3.5 text-gray-400"></i>
                            <span class="text-xs font-bold text-gray-500">총 자산 (평가금)</span>
                        </div>
                        <div class="text-xl font-black text-gray-900 tracking-tight">
                            15,400,000 <span class="text-sm font-bold text-gray-400">원</span>
                        </div>
                    </div>

                    <div class="p-4 bg-slate-50 rounded-2xl border border-slate-100">
                        <div class="flex items-center gap-2 mb-1">
                            <i data-lucide="wallet" class="w-3.5 h-3.5 text-gray-400"></i>
                            <span class="text-xs font-bold text-gray-500">예수금 (현금)</span>
                        </div>
                        <div class="text-lg font-black text-gray-900 tracking-tight">
                            3,200,000 <span class="text-sm font-bold text-gray-400">원</span>
                        </div>
                    </div>
                </div>

                <div class="mt-6">
                    <a href="${pageContext.request.contextPath}/myPage/profile"
                       class="flex items-center justify-center w-full py-3 rounded-xl border border-gray-200 text-sm font-bold text-gray-600 hover:bg-gray-50 hover:text-primary hover:border-primary/30 transition-all group">
                        <i data-lucide="settings" class="w-4 h-4 mr-2 text-gray-400 group-hover:text-primary transition-colors"></i>
                        내 정보 수정
                    </a>
                </div>
            </div>
        </div>

    </div>
</div>

<script>
    // 아이콘 실행
    lucide.createIcons();
</script>
</body>
</html>