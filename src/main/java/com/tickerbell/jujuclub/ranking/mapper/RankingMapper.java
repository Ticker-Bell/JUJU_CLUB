package com.tickerbell.jujuclub.ranking.mapper;

import com.tickerbell.jujuclub.ranking.dto.RankingDTO;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RankingMapper {

  /**
   * 총 유저 수 조회
   *
   * @return int
   */
  int getTotalUserCount();
  /**
   * 유저 랭킹 프로필 조회
   *
   * @param userSeq userSeq
   * @return RankingResponse RankingDTO
   */
  RankingDTO.RankingResponse getUserRankingInfo(int userSeq);
  /**
   * 유저 총 자산 순 랭킹 리스트 조회
   *
   * @return List&lt;RankingDTO.RankingListOBA&gt;
   */
  List<RankingDTO.RankingListOBA> getRankingBoardListOBA();
  /**
   * 유저 총 레슨 수 랭킹 리스트 조회
   *
   * @return List&lt;RankingDTO.RankingListOBR&gt;
   */
  List<RankingDTO.RankingListOBR> getRankingBoardListOBR();

}