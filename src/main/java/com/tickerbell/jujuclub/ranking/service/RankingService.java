package com.tickerbell.jujuclub.ranking.service;

import com.tickerbell.jujuclub.ranking.dto.RankingDTO;
import com.tickerbell.jujuclub.ranking.dto.RankingDTO.RankingListOBA;
import com.tickerbell.jujuclub.ranking.dto.RankingDTO.RankingListOBR;
import com.tickerbell.jujuclub.ranking.dto.RankingDTO.RankingResponse;
import com.tickerbell.jujuclub.ranking.mapper.RankingMapper;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j

public class RankingService {

  private final RankingMapper rankingMapper;

  /**
   * 유저 랭킹 조회
   *
   * @param userSeq int
   * @return RankingResponse RankingDTO
   */
  public RankingDTO.RankingResponse getRankingInfo(int userSeq) {

    RankingDTO.RankingResponse response;

    try {

      log.info("[{}] 유저 랭킹 리스트 조회 - 총 유저 수 DB 조회 시작", userSeq);

      int totUserCnt = rankingMapper.getTotalUserCount();

      log.info("[{}] 유저 랭킹 리스트 조회 - 총 유저 수 DB 조회 종료", userSeq);

      log.info("[{}] 유저 랭킹 리스트 조회 - 유저 랭킹 프로필 DB 조회 시작", userSeq);

      RankingDTO.RankingResponse rankingResponse = rankingMapper.getUserRankingInfo(userSeq);

      log.info("[{}] 유저 랭킹 리스트 조회 - 유저 랭킹 프로필 DB 조회 종료", userSeq);

      log.info("[{}] 유저 랭킹 리스트 조회 - 유저 총 자산 순 랭킹 리스트 DB 조회 시작 ", userSeq);
      // 총 자산 기준 정렬
      List<RankingListOBA> rankingListOBA = rankingMapper.getRankingBoardListOBA();

      log.info("[{}] 유저 랭킹 리스트 조회 - 유저 총 자산 순 랭킹 리스트 DB 조회 종료", userSeq);

      log.info("[{}] 유저 랭킹 리스트 조회 - 유저 총 레슨 수 랭킹 리스트 DB 조회 시작", userSeq);
      // 누적 수익률 정렬
      List<RankingListOBR> rankingListOBR = rankingMapper.getRankingBoardListOBR();

      log.info("[{}] 유저 랭킹 리스트 조회 - 유저 총 레슨 수 랭킹 리스트 DB 조회 종료", userSeq);

      response = RankingResponse.builder()
          .userSeq(rankingResponse.getUserSeq())
          .userId(rankingResponse.getUserId())
          .userName(rankingResponse.getUserName())
          .userAssetRank(rankingResponse.getUserAssetRank())
          .cashBalance(rankingResponse.getCashBalance())
          .userLssnCnt(rankingResponse.getUserLssnCnt())
          .userLssnRank(rankingResponse.getUserLssnRank())
          .totUserCnt(totUserCnt)
          .RankingBorardListOBA(rankingListOBA)
          .RankingBorardListOBR(rankingListOBR)
          .build();
    } catch (Exception e) {
      log.error("[{}] 유저 랭킹 리스트 조회 실패", userSeq);
      throw new RuntimeException(e);
    }
    return response;
  }
}
