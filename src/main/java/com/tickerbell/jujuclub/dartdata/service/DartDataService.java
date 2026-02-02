package com.tickerbell.jujuclub.dartdata.service;

import com.tickerbell.jujuclub.dartdata.dto.DartCorpInfoDataDTO;
import com.tickerbell.jujuclub.dartdata.mapper.DartCorpInfoMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class DartDataService {

    private final DartCorpInfoMapper dartCorpInfoMapper;

    /**
     * DART 기업 고유번호(corp_code) 매핑 데이터를 DB에 일괄 저장
     *
     * @param list List&lt;DartCorpInfoDataDTO&gt;
     */
    public void insert(List<DartCorpInfoDataDTO> list){
        try{
            log.info("DART corpCode 데이터 저장 시작 - count={}", (list == null ? 0 : list.size()));
            if(list != null && !list.isEmpty()){
                dartCorpInfoMapper.insert(list);
            }
            log.info("DART corpCode 데이터 저장 완료 - count={}", (list == null ? 0 : list.size()));
        } catch (Exception e){
            log.error("DART corpCode 데이터 저장 실패", e);
            throw new RuntimeException(e);
        }
    }
}
