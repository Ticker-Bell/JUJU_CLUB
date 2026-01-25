package com.tickerbell.jujuclub.dartdata.service;

import com.tickerbell.jujuclub.dartdata.dto.DartCorpInfoDataDTO;
import com.tickerbell.jujuclub.dartdata.mapper.DartCorpInfoMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class DartDataService {

    private final DartCorpInfoMapper dartCorpInfoMapper;

    public void insert(List<DartCorpInfoDataDTO> list){
        if(list != null && !list.isEmpty()){
            dartCorpInfoMapper.insert(list);
        }
    }

}
