package com.tickerbell.jujuclub.ranking.dto;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.ibatis.type.Alias;

public class RankingDTO {
  @Alias("RankingResponse")
  @Builder
  @Data
  @NoArgsConstructor
  @AllArgsConstructor
  public static class RankingResponse{

    private int userSeq;
    private String userId;
    private String userName;
    private int cashBalance;
    private int userAssetRank;
    private int userLssnCnt;
    private int userLssnRank;
    private int totUserCnt;
    List<RankingListOBA> RankingBorardListOBA;
    List<RankingListOBR> RankingBorardListOBR;
  }
  @Alias("RankingRequest")
  @Builder
  @Data
  @NoArgsConstructor
  @AllArgsConstructor
  public static class RankingRequest{

    private int userSeq;
  }
  @Alias("RankingListOBA")
  @Builder
  @Data
  @NoArgsConstructor
  @AllArgsConstructor
  public static class RankingListOBA{

    private int userSeq;
    private String userId;
    private String userName;
    private int cashBalance;
    private int userLssnCnt;
    private int userAssetRank;
  }

  @Alias("RankingListOBR")
  @Builder
  @Data
  @NoArgsConstructor
  @AllArgsConstructor
  public static class RankingListOBR {

    private int userSeq;
    private String userName;
    private int cashBalance;
    private int userLssnCnt;
    private int userLssnRank;
  }

}
