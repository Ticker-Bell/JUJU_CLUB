<%--
  Created by IntelliJ IDEA.
  User: 퍼스트존 아카데미02
  Date: 2026-01-13
  Time: 오후 2:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<header class="fixed top-0 w-full p-6 md:p-8 flex justify-between items-center z-50 bg-white/70 backdrop-blur-md border-b border-gray-200/50 transition-all duration-500">--%>
<%--    <div class="text-xl font-black tracking-tighter cursor-pointer hover:opacity-80 transition-opacity text-primary">--%>
<%--        JUJU CLUB--%>
<%--    </div>--%>
<%--    <div class="flex gap-4">--%>
<%--        <button class="hidden md:block text-sm font-bold text-gray-500 hover:text-black transition-colors">기능 소개</button>--%>
<%--        <button class="bg-primary text-white px-6 py-2.5 rounded-full text-sm font-bold hover:bg-primary/90 transition-colors shadow-lg shadow-primary/20">--%>
<%--            로그인--%>
<%--        </button>--%>
<%--    </div>--%>
<%--</header>--%>

<!-- Top Bar -->
<div class="w-full h-20 flex flex-shrink-0 fixed top-0 z-50">
    <!-- logo -->
    <div class="w-[220px] bg-primary/15 flex items-center pl-6 border-r border-transparent transition-all duration-300">
        <div class="flex items-center gap-3">
            <div class="w-9 h-9 bg-primary rounded-xl flex items-center justify-center text-white font-bold shadow-lg shadow-primary/30 text-lg">J</div>
            <span class="text-lg font-extrabold text-text tracking-tight">JUJU CLUB</span>
        </div>
    </div>
    <!-- top bar navigation -->
    <header class="flex-1 bg-primary/10 flex items-center justify-end px-10 gap-6">
        <div class="flex items-center gap-6">
            <div class="grid grid-cols-2 gap-4">
                <div class="text-right">
                    <div class="text-[10px] font-extrabold text-gray-500">총 자산</div>
                    <div class="text-sm font-extrabold num-font text-gray-900">₩ 12,450,000</div>
                </div>
                <div class="text-right">
                    <div class="text-[10px] font-extrabold text-gray-500">예수금</div>
                    <div class="text-sm font-extrabold num-font text-gray-900">₩ 3,200,000</div>
                </div>
            </div>

            <div class="flex items-center">
        <span id="userLevelBadge" class="px-3 py-1 rounded-full bg-primary/10 text-primary text-[11px] font-extrabold border border-primary/20">
          초급
        </span>
            </div>

            <div class="text-right">
                <span class="block text-sm font-extrabold text-text">김주린</span>
            </div>
        </div>

        <div class="w-[1px] h-4 bg-primary/20"></div>

        <button class="flex items-center gap-2 text-gray-500 hover:text-red-500 transition-colors group">
            <span class="text-xs font-bold">로그아웃</span>
            <div class="w-8 h-8 rounded-full flex items-center justify-center bg-white group-hover:bg-red-50 transition-colors shadow-sm">
                <i data-lucide="log-out" class="w-4 h-4"></i>
            </div>
        </button>
    </header>
</div>