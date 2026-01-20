package com.tickerbell.jujuclub.invest.util;

public class ColorUtil {

    private ColorUtil(){}
    
    //차트 컬러 유틸(최초 랜더 + AJAX 반영) : 종목 코드별로 지정
    public static String colorByStockCode(String stockCode){
        if(stockCode == null || stockCode.isBlank()){
            return "#BAB0AC"; //default
        }
        int randomData = stockCode.hashCode(); //stockCode별 같은 해시값
        //RGB
        int r = 80 + (randomData & 0x7F);          // 80~207
        int g = 80 + ((randomData >> 7) & 0x7F);   // 80~207
        int b = 80 + ((randomData >> 14) & 0x7F);  // 80~207

        return String.format("#%02X%02X%02X", r, g, b);
    }
}
