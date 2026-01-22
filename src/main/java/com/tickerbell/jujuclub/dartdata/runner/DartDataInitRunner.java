//package com.tickerbell.jujuclub.dartdata.runner;
//
//import com.tickerbell.jujuclub.dartdata.dto.DartCorpInfoDataDTO;
//import jakarta.xml.bind.JAXBContext;
//import jakarta.xml.bind.Unmarshaller;
//import org.springframework.beans.factory.annotation.Value;
//
//import java.io.*;
//import java.net.URL;
//import java.util.ArrayList;
//import java.util.List;
//import java.util.zip.ZipEntry;
//import java.util.zip.ZipInputStream;
//
//public class DartDataInitRunner {
//
//    //dart 종목코드 xml 파일을 읽기위해 존재
//    //https://opendart.fss.or.kr/api/corpCode.xml?crtfc_key=발급받은_API_KEY
//    /*파일 구조 : <list>
//                <corp_code>
//                <corp_name>
//                <corp_eng_name>
//                <stock_code>
//                <modify_date>
//     */
//
//    @Value("${dart.appkey}")
//    private String APP_KEY;
//
//    private final String BASE_DIR = System.getProperty("user.dir");
//
//    //DART 기업 고유코드 XML 파일 : 고유코드와 KIS StockCode 매치
//    private void downloadAndUnzipDart() throws IOException {
//        File dir = new File(BASE_DIR + "/dartInfoFiles");
//        if(!dir.exists()) dir.mkdir();
//
//        String zipUrl = "https://opendart.fss.or.kr/api/corpCode.xml?crtfc_key=" + APP_KEY;
//        File zipFile = new File(dir, "corpCode.zip");
//
//        try(InputStream in = new URL(zipUrl).openStream();
//            FileOutputStream fos = new FileOutputStream(zipFile)) {
//            in.transferTo(fos);
//        }
//
//        try(ZipInputStream zis = new ZipInputStream(new FileInputStream(zipFile))) {
//            ZipEntry entry;
//            while( (entry = zis.getNextEntry()) != null ) {
//                File outFile = new File(BASE_DIR + "/dartInfoFiles/" + entry.getName());
//                try(FileOutputStream fos = new FileOutputStream(outFile)) {
//                    zis.transferTo(fos);
//                }
//            }
//        }
//        new File(zipFile).delete();
//    }
//
//    //DartCorpInfoDataDTO = Map<String, String>
//    public List<DartCorpInfoDataDTO> xmlParsing() {
//        File file = new File(BASE_DIR + "/dartInfoFiles/CORPCODE.xml");
//        List<DartCorpInfoDataDTO> list = new ArrayList<DartCorpInfoDataDTO>();
//        try {
//            //JAXBContext 생성
//            JAXBContext context = JAXBContext.newInstance(DartCorpInfoDataDTO.class);
//
//            //Unmarshaller 생성
//            Unmarshaller unmarshaller = context.createUnmarshaller();
//
//            //XML 파일을 Java 객체로 변환
//            DartCorpInfoDataDTO dartCorpInfoXML = (DartCorpInfoDataDTO) unmarshaller.unmarshal(file);
//
//            // 결과 출력
//            for (DartCorpInfoDataDTO data : ) {
//                System.out.println("---------------------------------");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return list;
//    }
//
//}
//
//
