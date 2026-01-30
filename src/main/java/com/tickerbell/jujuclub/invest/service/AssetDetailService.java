package com.tickerbell.jujuclub.invest.service;

import com.tickerbell.jujuclub.invest.dto.MockTradeDTO;
import com.tickerbell.jujuclub.invest.mapper.AssetDetailMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AssetDetailService {
    private final AssetDetailMapper assetDetailMapper;

    public List<MockTradeDTO> findUserTrades(int userSeq){return assetDetailMapper.findUserTrades(userSeq);}
}
