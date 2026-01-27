package com.tickerbell.jujuclub.utils;

import java.awt.Color;

public class ColorUtil {

    private ColorUtil(){}

    /**
     * 종목 코드를 기반으로 포인트 컬러(#5E45EB)와 톤이 맞는 고유한 색상을 생성합니다.
     * HSB 모델의 채도(S)와 명도(B)를 포인트 컬러와 비슷하게 고정하고,
     * 색상(Hue)만 Golden Angle(137.5도)로 회전시켜 '통일감'과 '구분감'을 동시에 잡습니다.
     */
    public static String colorByStockCode(String stockCode){
        if(stockCode == null || stockCode.isBlank()){
            return "#BAB0AC"; // default (회색)
        }

        // 1. 종목 코드 해시값 (음수 방지 및 비트 연산으로 분산 강화)
        int hash = stockCode.hashCode();
        hash = (hash ^ (hash >>> 16)) & 0x7FFFFFFF;

        // 2. 색상(Hue) 계산
        // Golden Angle (약 137.508도)을 사용하여 색상을 회전시킵니다.
        // 시작점을 포인트 컬러의 Hue(약 250도) 근처로 잡으면 심리적으로 보라색과 어울리는 느낌을 줄 수 있습니다.
        float startHue = 250.0f; // 포인트 컬러(#5E45EB)의 대략적인 Hue 값
        float hue = ((startHue + (hash * 137.508f)) % 360) / 360.0f;

        // 3. 채도(S)와 명도(B)를 포인트 컬러(#5E45EB) 스타일에 맞춤
        // #5E45EB의 HSB -> H:249, S:71%, B:92%
        // 따라서 채도는 70% 내외, 명도는 90% 이상으로 설정하여 "쨍하고 화사한" 톤 유지
        float saturation = 0.70f;  // 70% (선명함)
        float brightness = 0.92f;  // 92% (화사함)

        // 4. HSB -> RGB 변환
        int rgb = Color.HSBtoRGB(hue, saturation, brightness);

        // 5. Hex String(#RRGGBB) 포맷팅
        return String.format("#%06X", (0xFFFFFF & rgb));
    }
}