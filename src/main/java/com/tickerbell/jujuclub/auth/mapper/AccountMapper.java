package com.tickerbell.jujuclub.auth.mapper;

import com.tickerbell.jujuclub.auth.dto.AccountDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AccountMapper {
    int checkAccountExist(Integer userSeq);

    /**
     * 유저 계좌 등록
     *
     * @param account AccountDTO
     * @return int
     */
    int insertAccount(AccountDTO account);

    /**
     * 유저 계좌 조회
     *
     * @param userSeq Integer
     * @return AccountDTO
     */
    AccountDTO selectAccountByUserSeq(Integer userSeq);
}
