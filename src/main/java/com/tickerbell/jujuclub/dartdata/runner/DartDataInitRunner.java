package com.tickerbell.jujuclub.dartdata.runner;

import com.tickerbell.jujuclub.dartdata.dto.DartCorpInfoDataDTO;
import com.tickerbell.jujuclub.dartdata.dto.DartCorpInfoDataResultDTO;
import com.tickerbell.jujuclub.dartdata.service.DartDataService;
import jakarta.xml.bind.JAXBContext;
import jakarta.xml.bind.Unmarshaller;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Component;

import java.io.*;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

@Component
public class DartDataInitRunner {

    //dart 종목코드 xml 파일을 읽기위해 존재
    //https://opendart.fss.or.kr/api/corpCode.xml?crtfc_key=발급받은_API_KEY
    //DART 기업 고유코드 XML 파일 : 고유코드와 KIS StockCode 매치

//    1. value는 스태틱 필드에 주입 불가능
//    2. for문 안에서 insert 하나하나 하면 오래걸림 -> mybatis foreach로 한번에 넣을 수 있음

    // static 메소드 내부에 @Value 값을 읽히게 하기 위해서 만듦
    // 직접 setter 메소드로 값을 넣어줘야 한다.
    private static String APP_KEY;

    @Value("${dart.appkey}")
    public void setAppKey(String appKey) {
        APP_KEY = appKey;
    }

    private static final String BASE_DIR = System.getProperty("user.dir");

    private static void downloadAndUnzipDart(String APP_KEY) throws IOException {
        File dir = new File(BASE_DIR + "/dartInfoFiles");
        if(!dir.exists()) dir.mkdirs();

        String zipUrl = "https://opendart.fss.or.kr/api/corpCode.xml?crtfc_key=" + APP_KEY;
        String zipPath = BASE_DIR + "/dartInfoFiles/corpCode.zip";

        System.out.println("DART 파일 다운로드 시작...");
        try(InputStream in = new URL(zipUrl).openStream();
            FileOutputStream fos = new FileOutputStream(zipPath)) {
            in.transferTo(fos);
        }

        System.out.println("압축 해제 중...");
        try(ZipInputStream zis = new ZipInputStream(new FileInputStream(zipPath))) {
            ZipEntry entry;
            while( (entry = zis.getNextEntry()) != null ) {
                File outFile = new File(BASE_DIR + "/dartInfoFiles/" + entry.getName());
                try(FileOutputStream fos = new FileOutputStream(outFile)) {
                    zis.transferTo(fos);
                }
            }
        }

        new File(zipPath).delete(); //삭제
    }

    //xml 파일 파싱
    //DartCorpInfoDataDTO = Map<String, String>
    private static List<DartCorpInfoDataDTO> xmlParsing(File file) {
        try {
            System.out.println("XML 파싱 시작...");
            //JAXBContext 생성
            JAXBContext context = JAXBContext.newInstance(DartCorpInfoDataResultDTO.class);
            //Unmarshaller 생성
            Unmarshaller unmarshaller = context.createUnmarshaller();
            //XML 파일을 Java 객체로 변환
            DartCorpInfoDataResultDTO response = (DartCorpInfoDataResultDTO) unmarshaller.unmarshal(file);
            //List<DartCorpInfoDataDTO>
            return response.getDartAPITotalList();

        } catch (Exception e) {
            throw new RuntimeException("DART CORPCODE.xml 파싱 실패", e);
        }
    }

    //List<DartCorpInfoDataDTO> -> Map<stockCode, corpCode>
    private static Map<String, String> matching(List<DartCorpInfoDataDTO> items){
        Map <String,String> map = new HashMap<>();
        for(DartCorpInfoDataDTO data : items){
            String stockCode = data.getStockCode() == null ? "" : data.getStockCode().trim();
            String corpCode = data.getCorpCode() == null ? "" : data.getCorpCode().trim();
            if(stockCode.isEmpty()){
                continue;
            }
            if(stockCode.length() != 6){
                continue;
            }
            map.putIfAbsent(stockCode,corpCode); //중복 요청 시 먼저 들어온 값 유지
        }
        //test
        System.out.println("xml 파싱 갯수 : " + map.size());
        return map;
    }

    public static void main(String[] args) throws IOException {

        File file = new File(BASE_DIR + "/dartInfoFiles/CORPCODE.xml");
        //spring읽기
        ApplicationContext ctx = new GenericXmlApplicationContext("file:src/main/webapp/WEB-INF/spring/root-context.xml");
        ctx.getBean(DartDataInitRunner.class);

        //static필드에 @value 주입 불가능해 대체
        if (APP_KEY == null) {
            System.err.println("키 주입 실패! root-context.xml의 스캔 범위나 프로퍼티 설정을 확인하세요.");
            return;
        }
        try {
            downloadAndUnzipDart(APP_KEY);
        } catch (Exception e) {
            System.out.println("downloadAndUnzipDart 실패: " + e.getMessage());
            e.printStackTrace();
            return; //프로그램 종료
        }

        DartDataService dartDataService = ctx.getBean(DartDataService.class);

        List<DartCorpInfoDataDTO> dartCorpInfoList = xmlParsing(file);

        List<DartCorpInfoDataDTO> dartCorpInfoDTOList  = new ArrayList<>();
        for(DartCorpInfoDataDTO data : dartCorpInfoList){
            //다트종목코드가 8자리
            if(data.getCorpCode().length() != 8){
                continue;
            }
            //우리가 stockcode를 가지고 있는 회사만 넣어주기
            String stockCode = data.getStockCode();
            if(stockCode == null || stockCode.length() != 6 || stockCode.trim().isEmpty()){
                continue;
            }
            //최종객체생성
            DartCorpInfoDataDTO  dartCorpInfoDataDTO = DartCorpInfoDataDTO.builder()
                    .corpCode(data.getCorpCode())
                    .corpName(data.getCorpName())
                    .stockCode(data.getStockCode())
                    .modifyDate(data.getModifyDate())
                    .build();
            dartCorpInfoDTOList.add(dartCorpInfoDataDTO);
        }

        //batch insert: 한번에 적재해야함
        int batchSize = 1000;
        int listSize = dartCorpInfoDTOList.size();
        System.out.println("총 데이터 갯수 : " + listSize);
        for(int i = 0; i<listSize; i += batchSize){
            //subList로 1000개씩 잘라가며 insert
            int cut = Math.min(i+batchSize,listSize);
            List<DartCorpInfoDataDTO> batchList = dartCorpInfoDTOList.subList(i, cut);
            //insert
            dartDataService.insert(batchList);
            System.out.println(cut + "건 적재.");
        }
        System.out.println("dart 데이터 적재 성공");
    }
}


