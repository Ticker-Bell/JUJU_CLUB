package com.tickerbell.jujuclub.auth.service;

import com.tickerbell.jujuclub.auth.dto.AccountDTO;
import com.tickerbell.jujuclub.auth.mapper.AccountMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AccountService {

    private final AccountMapper accountMapper;

    // [수정] void -> Long (생성된 계좌번호 반환)
    public Long createAccount(String userId) {
        // 1. 중복 계좌 확인
        if (accountMapper.checkAccountExist(userId) > 0) {
            return null; // 이미 존재하면 null 반환 (혹은 예외 처리)
        }

        // 2. 계좌번호 생성 (14자리)
        long accountNo = generateRandomAccountNo();

        // 3. DTO 생성 (초기 자본금 100만원 설정)
        AccountDTO account = AccountDTO.builder()
                .userId(userId)
                .accountNo(accountNo)
                .cashBalance(1000000L) // [수정] 1,000,000원
                .build();

        // 4. DB 저장
        accountMapper.insertAccount(account);

        // [추가] 생성된 번호 반환
        return accountNo;
    }

    private Long generateRandomAccountNo() {
        // 14자리 랜덤 숫자 (10조 ~ 99조 사이)
        return (long) (Math.random() * 90000000000000L) + 10000000000000L;
    }
}