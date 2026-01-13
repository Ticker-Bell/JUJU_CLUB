package com.tickerbell.jujuclub.stockdata.runner;

import com.tickerbell.jujuclub.stockdata.dto.StockDataDTO;
import com.tickerbell.jujuclub.stockdata.service.StockDataService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;


import java.io.*;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;



public class StockDataInitRunner{

    static String BASE_DIR = System.getProperty("user.dir");

    // 파일에 존재하는 헤더 정보 중 앞 3개
    static String[] part1Columns = {"단축코드", "표준코드", "한글명"};

    // 그 외 kospi 파일에 존재하는 헤더 정보
    static String[] part2ColumnsKospi = {"그룹코드", "시가총액규모", "지수업종대분류", "지수업종중분류", "지수업종소분류",
            "제조업", "저유동성", "지배구조지수종목", "KOSPI200섹터업종", "KOSPI100",
            "KOSPI50", "KRX", "ETP", "ELW발행", "KRX100",
            "KRX자동차", "KRX반도체", "KRX바이오", "KRX은행", "SPAC",
            "KRX에너지화학", "KRX철강", "단기과열", "KRX미디어통신", "KRX건설",
            "Non1", "KRX증권", "KRX선박", "KRX섹터_보험", "KRX섹터_운송",
            "SRI", "기준가", "매매수량단위", "시간외수량단위", "거래정지",
            "정리매매", "관리종목", "시장경고", "경고예고", "불성실공시",
            "우회상장", "락구분", "액면변경", "증자구분", "증거금비율",
            "신용가능", "신용기간", "전일거래량", "액면가", "상장일자",
            "상장주수", "자본금", "결산월", "공모가", "우선주",
            "공매도과열", "이상급등", "KRX300", "KOSPI", "매출액",
            "영업이익", "경상이익", "당기순이익", "ROE", "기준년월",
            "시가총액", "그룹사코드", "회사신용한도초과", "담보대출가능", "대주가능"
    };

    // 그 외 kosdaq 파일에 존재하는 헤더 정보
    static String[] part2ColumnsKosdaq = {
            "증권그룹구분코드","시가총액규모","지수업종대분류","지수업종중분류","지수업종소분류",
            "벤처기업","저유동성","KRX","ETP","KRX100",
            "KRX자동차","KRX반도체","KRX바이오","KRX은행","SPAC",
            "KRX에너지화학","KRX철강","단기과열","KRX미디어통신","KRX건설",
            "투자주의환기","KRX증권","KRX선박","KRX보험","KRX운송",
            "KOSDAQ150","기준가","정규수량단위","시간외수량단위","거래정지",
            "정리매매","관리종목","시장경고","경고예고","불성실공시",
            "우회상장","락구분","액면변경","증자구분","증거금비율",
            "신용가능","신용기간","전일거래량","액면가","상장일자",
            "상장주수","자본금","결산월","공모가","우선주",
            "공매도과열","이상급등","KRX300","매출액","영업이익",
            "경상이익","당기순이익","ROE","기준년월","시가총액",
            "그룹사코드","회사신용한도초과","담보대출가능","대주가능"
    };

    static int[] fieldSpecsKospi = {
            3,1,4,4,4,1,1,1,1,1,1,
            1,1,1,1,1,1,1,1,1,1,1,
            1,1,1,1,1,1,1,1,1,9,5,
            5,1,1,1,2,1,1,1,2,2,2,
            3,1,3,12,12,8,15,21,2,
            7,1,1,1,1,1,9,9,9,5,9,
            8,9,3,1,1,1
    };

    static int[] fieldSpecsKosdaq = {
            3,1,4,4,4,1,1,1,1,1,
            1,1,1,1,1,1,1,1,1,1,
            1,1,1,1,1,1,9,5,5,1,
            1,1,2,1,1,1,2,2,2,3,
            1,3,12,12,8,15,21,2,7,1,
            1,1,1,9,9,9,5,9,8,9,
            3,1,1,1
    };

    public static void main(String[] args) throws IOException {

        // 스프링 컨테이너 로드
        ApplicationContext ctx = new GenericXmlApplicationContext("file:src/main/webapp/WEB-INF/spring/root-context.xml");
        // 빈 가져오기
        StockDataService stockDataService = ctx.getBean(StockDataService.class);

        downloadAndUnzipKospi();
        downloadAndUnzipKosdaq();
        List<Map<String, String>> kospiStocks = parseKospiMst();
        List<Map<String, String>> kosdaqStocks = parseKosdaqMst();

        List<StockDataDTO> stockDataDTOList = new ArrayList<>();

        for(Map<String, String> stock : kospiStocks){
            if(stock.get("단축코드").length() != 6) continue;
            StockDataDTO stockDataDTO = StockDataDTO.builder()
                    .stock_code(stock.get("단축코드"))
                    .stock_name(stock.get("한글명"))
                    .market_type("KOSPI")
                    .sector(stock.get("지수업종대분류"))
                    .build();
            stockDataDTOList.add(stockDataDTO);
        }

        for(Map<String, String> stock : kosdaqStocks){
            if(stock.get("단축코드").length() != 6) continue;
            StockDataDTO stockDataDTO = StockDataDTO.builder()
                    .stock_code(stock.get("단축코드"))
                    .stock_name(stock.get("한글명"))
                    .market_type("KOSDAQ")
                    .sector(stock.get("지수업종대분류"))
                    .build();
            stockDataDTOList.add(stockDataDTO);
        }

        for(StockDataDTO stockDataDTO : stockDataDTOList){
            int result = stockDataService.insert(stockDataDTO);
            if(result == 0){
                System.out.println("DB insert failed");
                return;
            }
        }

        System.out.println("DB insert success");
    }

    static void downloadAndUnzipKospi() throws IOException { // 한투 사이트에서 코스피종목정보 zip파일 stockInfoFiles폴더에 다운로드 후 압축해제

        File dir = new File(BASE_DIR + "/stockInfoFiles");
        if(!dir.exists()) dir.mkdir();

        String zipUrl = "https://new.real.download.dws.co.kr/common/master/kospi_code.mst.zip";
        String zipPath = BASE_DIR + "/stockInfoFiles/kospi_code.mst.zip";

        try(InputStream in = new URL(zipUrl).openStream();
            FileOutputStream fos = new FileOutputStream(zipPath)) {
            in.transferTo(fos);
        }

        try(ZipInputStream zis = new ZipInputStream(new FileInputStream(zipPath))) {
            ZipEntry entry;
            while( (entry = zis.getNextEntry()) != null ) {
                File outFile = new File(BASE_DIR + "/stockInfoFiles/" + entry.getName());
                try(FileOutputStream fos = new FileOutputStream(outFile)) {
                    zis.transferTo(fos);
                }
            }
        }
        new File(zipPath).delete();

    }

    static void downloadAndUnzipKosdaq() throws IOException { // 한투 사이트에서 코스닥종목정보 zip파일 stockInfoFiles폴더에 다운로드 후 압축해제
        File dir = new File(BASE_DIR + "/stockInfoFiles");
        if(!dir.exists()) dir.mkdir();

        String zipUrl = "https://new.real.download.dws.co.kr/common/master/kosdaq_code.mst.zip";
        String zipPath = BASE_DIR + "/stockInfoFiles/kosdaq_code.mst.zip";

        try(InputStream in = new URL(zipUrl).openStream();
            FileOutputStream fos = new FileOutputStream(zipPath)) {
            in.transferTo(fos);
        }

        try(ZipInputStream zis = new ZipInputStream(new FileInputStream(zipPath))) {
            ZipEntry entry;
            while( (entry = zis.getNextEntry()) != null ) {
                File outFile = new File(BASE_DIR + "/stockInfoFiles/" + entry.getName());
                try(FileOutputStream fos = new FileOutputStream(outFile)) {
                    zis.transferTo(fos);
                }
            }
        }
        new File(zipPath).delete();
    }

    static List<Map<String, String>> parseKospiMst() throws IOException { // stockInfoFiles에 저장된 kospi_code.mst 파일 키,값 밸류로 정리
        File file = new File(BASE_DIR + "/stockInfoFiles/kospi_code.mst");
        List<Map<String, String>> result = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file),Charset.forName("MS949")))) {

            String line;
            while( (line = br.readLine()) != null ) {

                if(line.length() < 228) continue;

                Map<String, String> row = new LinkedHashMap<>();

                //part1
                String rf1 = line.substring(0, line.length() - 228);
                row.put("단축코드", rf1.substring(0, 9).trim());
                row.put("표준코드", rf1.substring(9, 21).trim());
                row.put("한글명", rf1.substring(21).trim());

                //part2
                String rf2 = line.substring(line.length() - 228);
                int pos = 0;

                for (int i = 0; i < fieldSpecsKospi.length; i++) {
                    int w = fieldSpecsKospi[i];
                    String value = rf2.substring(pos, pos + w).trim();
                    row.put(part2ColumnsKospi[i], value);
                    pos += w;
                }

                result.add(row);
            }
        }
        return result;
    }

    static List<Map<String, String>> parseKosdaqMst() throws IOException { // stockInfoFiles에 저장된 kosdaq_code.mst 파일 키,값 밸류로 정리
        File file = new File(BASE_DIR + "/stockInfoFiles/kosdaq_code.mst");
        List<Map<String, String>> result = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file),Charset.forName("MS949")))) {

            String line;
            while( (line = br.readLine()) != null ) {

                if(line.length() < 222) continue;

                Map<String, String> row = new LinkedHashMap<>(); //순서 유지하기 위해

                //part1
                String rf1 = line.substring(0, line.length() - 222);
                row.put("단축코드", rf1.substring(0, 9).trim());
                row.put("표준코드", rf1.substring(9, 21).trim());
                row.put("한글명", rf1.substring(21).trim());

                //part2
                String rf2 = line.substring(line.length() - 222);
                int pos = 0;

                for (int i = 0; i < fieldSpecsKosdaq.length; i++) {
                    int w = fieldSpecsKosdaq[i];
                    String value = rf2.substring(pos, pos + w).trim();
                    row.put(part2ColumnsKosdaq[i], value);
                    pos += w;
                }

                result.add(row);
            }
        }
        return result;
    }
}
