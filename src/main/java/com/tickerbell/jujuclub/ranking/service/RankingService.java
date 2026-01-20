package com.tickerbell.jujuclub.ranking.service;

import com.tickerbell.jujuclub.ranking.dto.RankingDTO;
import com.tickerbell.jujuclub.ranking.dto.RankingDTO.RankingListOBA;
import com.tickerbell.jujuclub.ranking.dto.RankingDTO.RankingListOBR;
import com.tickerbell.jujuclub.ranking.dto.RankingDTO.RankingResponse;
import com.tickerbell.jujuclub.ranking.mapper.RankingMapper;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class RankingService {

  private final RankingMapper rankingMapper;

  public RankingDTO.RankingResponse getRankingInfo(int userSeq){

    RankingDTO.RankingResponse response = RankingResponse.builder().build();

    int totUserCnt = rankingMapper.getTotalUserCount();

    RankingDTO.RankingResponse rankingResponse = rankingMapper.getUserRankingInfo(userSeq);
    // 총 자산 기준 정렬
    List<RankingListOBA> rankingListOBA = rankingMapper.getRankingBoardListOBA();
    // 누적 수익률 정렬
    List<RankingListOBR> rankingListOBR = rankingMapper.getRankingBoardListOBR();

    response.setUserSeq(rankingResponse.getUserSeq());
    response.setUserId(rankingResponse.getUserId());
    response.setUserName(rankingResponse.getUserName());
    response.setUserAssetRank(rankingResponse.getUserAssetRank());
    response.setUserRevenueRank(rankingResponse.getUserRevenueRank());
    response.setTotalAsset(rankingResponse.getTotalAsset());
    response.setTotalRevenueRate(rankingResponse.getTotalRevenueRate());
    response.setTotUserCnt(totUserCnt);

    response.setRankingBorardListOBA(rankingListOBA);
    response.setRankingBorardListOBR(rankingListOBR);

    return response;
  }



}
