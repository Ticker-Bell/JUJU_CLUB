package com.tickerbell.jujuclub.utils;

public class StockChartFormatter {

    public static String formatPrice(int price){
        //가격 포맷팅(1,000)
        return String.format("%,d" ,  price);
    }

    public  static String formatTime(String time){
        //체결시간 포맷팅(09:11)
        if(time == null || time.length() !=6){
            return "N/A";
        }
        return time.substring(0,2)+":"+time.substring(2,4);
    }

    public static String formatdayOverDayWithSign(String sign, int change, double rate) {
        //전일 대비 데이터 포맷팅(▲ 2000 +0.22%)
        String signChar;

        switch (sign){
            case "1": signChar = "↑"; break;
            case "2": signChar = "▲"; break;
            case "3": signChar = "-"; break;
            case "4": signChar = "↓"; break;
            case "5": signChar = "▼"; break;
            default: signChar = "?";
        }

        if("3".equals(sign)){
            return String.format("%s", signChar);
        } else {
            return String.format("%s %,d (%+.2f%%)", signChar, change, rate);
        }
    }
}
