<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <style>
        .btn-active {
            background-color: #bf0f06;
            color: white;
            border-color: #bf0f06;
            font-weight: 700;
        }

        .period-btn {
            background-color: white;
            color: #4b5563; /* gray-600 */
            border-color: #d1d5db; /* gray-300 */
            font-weight: 500;
        }

        .period-btn.btn-active {
            background-color: #bf0f06;
            color: white;
            border-color: #bf0f06;
            font-weight: 700;
        }

    </style>

<div class="flex flex-col w-full gap-4">
    <div class="p-6 border-bottom border-gray-100 stock-info-header">
        <div class="flex flex-row justify-between">
            <div class="flex items-center gap-4">
                <h2 id="header-stockName" class="text-lg font-extrabold tracking-tight text-gray-900 ">---</h2>
                <span id="header-stock"
                      class="px-2 rounded-md bg-[#D9D9D9] text-gray-500 text-sm font-medium">-</span>
                <span id="header-marketType" class="px-2 rounded-md bg-[#5E45EB] text-[#F4F4F4] text-sm font-medium">-</span>
                <img id="header-stockLike" data-liked="false"
                     class="w-5 h-5 cursor-pointer" src="${cpath}/resources/images/stockIcons/heart.svg" alt="하트아이콘">
            </div>
            <div id="button-group"
                 class="flex justify-end gap-2 p-4 bg-gray-50/50 border-y border-gray-100 period-buttons">
                <button id="btn-D"
                        class="period-btn px-4 py-1.5 rounded-full border text-sm transition-all duration-200 shadow-sm">
                    일별
                </button>

                <button id="btn-W"
                        class="period-btn px-4 py-1.5 rounded-full border text-sm transition-all duration-200 shadow-sm">
                    주별
                </button>

                <button id="btn-M"
                        class="period-btn px-4 py-1.5 rounded-full border text-sm transition-all duration-200 shadow-sm">
                    월별
                </button>

            </div>

        </div>

        <div class="flex items-baseline gap-4 mt-4">
            <h2 id="header-price" class="text-2xl font-extrabold tracking-tight text-gray-900">- 원</h2>
            <div class="change-info">
                <span id="header-change" class="text-sm font-semibold">-</span>
            </div>
        </div>
    </div>

    <div class="p-4 h-[400px]">
        <canvas id="myChart"></canvas>
    </div>
</div>
