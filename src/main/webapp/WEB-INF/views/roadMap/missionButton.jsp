<%--
  Created by IntelliJ IDEA.
  User: 퍼스트존 아카데미02
  Date: 2026-01-16
  Time: 오후 2:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .mission-fab {
        position: absolute;
        top: 24px;
        right: 32px;
        z-index: 35;
    }

    *

    1
    . 버튼

    (
    Trigger

    )
    스타일 *

    /
    .control-item {
        height: 52px;
        background: rgba(255, 255, 255, 0.9); /* 반투명 배경 */
        border: 1px solid rgba(229, 231, 235, 1);
        box-shadow: 0 12px 24px rgba(17, 24, 39, 0.08);
        border-radius: 99px; /* 둥근 모양 */
        padding: 0 20px;
        display: flex;
        align-items: center;
        justify-content: space-between; /* 텍스트-화살표 정렬 */
        font-family: 'Pretendard', sans-serif;
        font-size: 15px;
        font-weight: 800;
        color: #191919;
        cursor: pointer;
        user-select: none;
        backdrop-filter: blur(8px);
        transition: all .2s ease;
        text-align: left;
        outline: none;
    }

    /* 버튼 Hover 및 Active 효과 */
    .control-item:hover {
        background: #fff;
        transform: translateY(-2px);
        box-shadow: 0 16px 36px rgba(17, 24, 39, 0.12);
    }

    .control-item.active {
        border-color: #5E45EB; /* 활성화 시 보라색 테두리 */
        background: #fff;
        box-shadow: 0 0 0 3px rgba(94, 69, 235, 0.1);
    }

    /* 화살표 아이콘 (CSS로 구현) */
    .control-item::after {
        content: '';
        display: block;
        width: 16px;
        height: 16px;
        margin-left: 10px;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%23191919' stroke-width='3' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='m6 9 6 6 6-6'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: center;
        transition: transform 0.2s cubic-bezier(0.16, 1, 0.3, 1);
    }

    /* 드롭다운 열렸을 때 화살표 회전 */
    .control-item.active::after {
        transform: rotate(180deg);
    }

    /* 2. 드롭다운 목록 (UL) 스타일 */
    .optionList {
        position: absolute;
        top: 60px; /* 버튼 높이 + 간격 */
        left: 0;
        width: 100%;
        min-width: 100%;
        background: #fff;
        border: 1px solid #e5e7eb;
        border-radius: 16px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        padding: 6px;
        margin: 0;
        list-style: none; /* 기본 ul 스타일 제거 */
        z-index: 100;

        /* 숨김 처리 (애니메이션용) */
        opacity: 0;
        visibility: hidden;
        transform: translateY(-10px);
        transition: all 0.2s cubic-bezier(0.16, 1, 0.3, 1);
    }

    /* 드롭다운 보이기 */
    .optionList.show {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
    }

    /* 3. 리스트 아이템 (LI) 스타일 */
    .optionItem {
        padding: 10px 14px;
        border-radius: 10px;
        font-size: 14px;
        font-weight: 600;
        color: #374151;
        cursor: pointer;
        transition: background 0.1s;
    }

    .optionItem:hover {
        background: #f3f4f6;
        color: #111;
    }

    .optionItem.selected {
        background: rgba(94, 69, 235, 0.08);
        color: #5E45EB;
    }

    /* 4. 기타 버튼 스타일 */
    .btn-move {
        background: #191919;
        color: #fff;
        border: none;
        justify-content: center; /* 텍스트 중앙 정렬 */
        padding: 0 24px;
    }

    .btn-move:hover {
        background: #333;
        color: #fff;
    }

    /* 이동 버튼은 화살표 아이콘 제거 */
    .btn-move::after {
        display: none;
    }

    .btn-mission {
        width: 52px;
        padding: 0;
        position: relative;
        justify-content: center;
    }

    /* 미션 버튼도 화살표 제거 */
    .btn-mission::after {
        display: none;
    }

    .mission-dot {
        position: absolute;
        top: 10px;
        right: 10px;
        width: 10px;
        height: 10px;
        border-radius: 999px;
        background: #5E45EB;
        box-shadow: 0 0 0 4px #fff;
    }

    /* ---------------------------------------------------- */
    /* ✅ Animations & Scrolls                              */
    /* ---------------------------------------------------- */
    @keyframes floaty {
        0%, 100% {
            transform: translateY(0px);
        }
        50% {
            transform: translateY(-10px);
        }
    }

    .floaty {
        animation: floaty 3.8s ease-in-out infinite;
    }

    .floaty.d2 {
        animation-delay: -1.2s;
    }

    .floaty.d3 {
        animation-delay: -2.1s;
    }

    @keyframes twinkle {
        0%, 100% {
            opacity: .45;
            transform: scale(0.92);
        }
        50% {
            opacity: 1;
            transform: scale(1.12);
        }
    }

    .twinkle {
        transform-box: fill-box;
        transform-origin: center;
        animation: twinkle 2.8s ease-in-out infinite;
    }

    @keyframes shooting {
        0% {
            opacity: 0;
            transform: translate(0px, 0px);
        }
        8% {
            opacity: 1;
        }
        55% {
            opacity: 1;
        }
        100% {
            opacity: 0;
            transform: translate(520px, 240px);
        }
    }

    .shooting {
        transform-box: fill-box;
        transform-origin: center;
        animation: shooting 7.2s linear infinite;
    }

    /* 스크롤바 커스텀 */
    ::-webkit-scrollbar {
        width: 6px;
        height: 6px;
    }

    ::-webkit-scrollbar-thumb {
        background: #E5E7EB;
        border-radius: 10px;
    }

    ::-webkit-scrollbar-thumb:hover {
        background: #D1D5DB;
    }

    .custom-scroll {
        max-height: 280px;
        overflow-y: auto;
    }

    .custom-scroll::-webkit-scrollbar {
        width: 4px;
    }

    .custom-scroll::-webkit-scrollbar-thumb {
        background: #e5e7eb;
        border-radius: 10px;
    }
</style>

<div class="mission-fab">
    <button id="openMissionBtn" type="button" class="control-item btn-mission" aria-label="일일 미션">
        <span class="mission-dot" id="missionDot"></span>
        <img class="w-5 h-5 stroke-[2]" src="${cpath}/resources/images/roadMapIcons/target.svg" alt="미션아이콘">
    </button>
</div>

