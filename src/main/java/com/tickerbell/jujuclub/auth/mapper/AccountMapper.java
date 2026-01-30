package com.tickerbell.jujuclub.auth.mapper;

import com.tickerbell.jujuclub.auth.dto.AccountDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AccountMapper {
    int checkAccountExist(Integer userSeq);

    /**
     * 레슨 CONCEPT 문항 조회 및 레슨 시작 정보 등록
     *
     * @param account AccountDTO
     * @return int
     */
    int insertAccount(AccountDTO account);
    AccountDTO selectAccountByUserSeq(Integer userSeq);
}
