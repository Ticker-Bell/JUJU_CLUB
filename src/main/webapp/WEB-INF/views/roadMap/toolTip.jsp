<%--
  Created by IntelliJ IDEA.
  User: 퍼스트존 아카데미02
  Date: 2026-01-22
  Time: 오전 9:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="tooltip" class="tip">
    <div class="flex flex-col gap-2 w-full">
        <div class="flex items-center justify-between w-full">
            <div class="flex items-center gap-2">
                <span class="w-2 h-2 rounded-full bg-primary"></span>
                <div id="tip-chapter" class="text-xs font-extrabold text-gray-400">일일 미션</div>
            </div>

            <div id="tip-badge" class="shrink-0"></div>
        </div>

        <div>
            <div id="tip-title" class="text-sm font-extrabold text-gray-900 break-words"></div>
            <div id="tip-desc" class="mt-1 text-[11px] font-semibold text-gray-500 leading-relaxed break-words"></div>
        </div>
    </div>
    <div id="tip-info" class="mt-3 grid grid-cols-2 gap-2"></div>

    <div class="mt-4 pt-4 border-t border-gray-100 flex items-center justify-between gap-2">
        <button id="tipCloseBtn"
                class="px-3 py-2 rounded-xl bg-white border border-gray-200 text-gray-600 font-extrabold text-xs hover:bg-gray-50 transition">
            닫기
        </button>
        <button id="startBtn"
                class="flex-1 bg-indigo-600 text-white font-bold py-2.5 rounded-xl hover:bg-indigo-700 transition shadow-lg shadow-indigo-200 text-sm">
            시작하기
        </button>
    </div>
</div>