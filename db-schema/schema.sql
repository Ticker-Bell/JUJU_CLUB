-- 1. 유저
CREATE TABLE `USERS` (
                         `USER_SEQ`	INT UNSIGNED	NOT NULL AUTO_INCREMENT,
                         `USER_ID`	VARCHAR(60)	NOT NULL	COMMENT '이메일',
                         `USER_PW`	VARCHAR(60)	NOT NULL,
                         `USER_NAME`	VARCHAR(50)	NOT NULL,
                         `CREATED_AT`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
                         `USER_LEVEL`	TINYINT UNSIGNED	NULL	DEFAULT NULL	COMMENT '1/2/3',
                         `USER_IMAGE`	MEDIUMBLOB	NULL	DEFAULT NULL,
                         PRIMARY KEY (`USER_SEQ`)
) ENGINE = INNODB DEFAULT CHARSET = UTF8MB4;

-- 2. 학습 난이도
CREATE TABLE `LEARNING_LEVEL` (
                                  `LEVEL_SEQ`	INT UNSIGNED	NOT NULL AUTO_INCREMENT,
                                  `LEVEL_NAME`	VARCHAR(10)	NOT NULL	COMMENT '초급/중급/고급',
                                  `IS_DOMESTIC`	CHAR(1)	NOT NULL	COMMENT 'Y/N',
                                  PRIMARY KEY (`LEVEL_SEQ`)
) ENGINE = INNODB DEFAULT CHARSET = UTF8MB4;

-- 3. 주식 종목 마스터
CREATE TABLE `STOCK_MASTER` (
                                `STOCK_SEQ` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                                `STOCK_CODE` VARCHAR(10) NOT NULL COMMENT 'EX)005930',
                                `STOCK_NAME` VARCHAR(100) NOT NULL COMMENT 'EX)에코마켓팅',
                                `MARKET_TYPE` VARCHAR(20) NOT NULL COMMENT 'KOSPI/KOSDAQ',
                                `SECTOR` VARCHAR(50) NOT NULL COMMENT 'EX)LED',
                                PRIMARY KEY (`STOCK_SEQ`),
                                CONSTRAINT `UK_STOCK_MASTER_CODE`
                                    UNIQUE (`STOCK_CODE`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;


-- 4. 미션
CREATE TABLE `MISSION` (
                           `MISSION_SEQ`	INT UNSIGNED	NOT NULL AUTO_INCREMENT,
                           `MISSION_TYPE`	VARCHAR(50)	NOT NULL	COMMENT '레슨/모의체결/챕터테스트/관종추',
                           `MISSION_TITLE`	VARCHAR(50)	NOT NULL	COMMENT '레슨 5개완료하기 ETC',
                           `MISSION_REWARD`	INT UNSIGNED	NOT NULL	COMMENT '500',
                           `TARGET_VALUE`	INT UNSIGNED	NOT NULL	COMMENT '5',
                           PRIMARY KEY (`MISSION_SEQ`)
) ENGINE = INNODB DEFAULT CHARSET = UTF8MB4;

-- 5. DART 기업 매핑
CREATE TABLE `DART_CORP_MAP` (
                                 `DART_MAP_SEQ`	INT UNSIGNED	NOT NULL AUTO_INCREMENT,
                                 `CORP_CODE`	VARCHAR(10)	NOT NULL	COMMENT 'EX)00126380',
                                 `CORP_NAME`	VARCHAR(200)	NOT NULL	COMMENT 'EX)삼성전자',
                                 `STOCK_CODE`	VARCHAR(10)	NOT NULL	COMMENT 'EX)005930',
                                 `MODIFY_DATE`	VARCHAR(8)	NOT NULL	COMMENT 'EX)20251201',
                                 PRIMARY KEY (`DART_MAP_SEQ`)
) ENGINE = INNODB DEFAULT CHARSET = UTF8MB4;

-- 6. 학습 챕터
CREATE TABLE `LEARNING_CHAPTER` (
                                    `CHAPTER_ID`	VARCHAR(50)	NOT NULL,
                                    `LEVEL_SEQ`	INT UNSIGNED	NOT NULL,
                                    `CHAPTER_NAME`	VARCHAR(100)	NOT NULL,
                                    `REWARD_CASH`	INT UNSIGNED	NOT NULL,
                                    `TEST_PAY`	INT UNSIGNED	NOT NULL	DEFAULT 0,
                                    PRIMARY KEY (`CHAPTER_ID`),
                                    CONSTRAINT `FK_CHAPTER_LEVEL` FOREIGN KEY (`LEVEL_SEQ`) REFERENCES `LEARNING_LEVEL` (`LEVEL_SEQ`) ON DELETE CASCADE
) ENGINE = INNODB DEFAULT CHARSET = UTF8MB4;

-- 7. 학습 레슨
CREATE TABLE `LEARNING_LESSON` (
                                   `LESSON_ID`	VARCHAR(50)	NOT NULL,
                                   `CHAPTER_ID`	VARCHAR(50)	NOT NULL,
                                   `LESSON_NAME`	VARCHAR(100)	NOT NULL,
                                   `LESSON_TYPE`	VARCHAR(20)	NOT NULL	COMMENT 'THEORY / PRACTICE / TEST',
                                   `DESCRIPTION`	VARCHAR(100)	NULL,
                                   PRIMARY KEY (`LESSON_ID`),
                                   CONSTRAINT `FK_LESSON_CHAPTER` FOREIGN KEY (`CHAPTER_ID`) REFERENCES `LEARNING_CHAPTER` (`CHAPTER_ID`) ON DELETE CASCADE
) ENGINE = INNODB DEFAULT CHARSET = UTF8MB4;

-- 8. 학습 문제
CREATE TABLE `LEARNING_QUESTION` (
                                     `QUESTION_SEQ`	INT UNSIGNED	NOT NULL AUTO_INCREMENT,
                                     `LESSON_ID`	VARCHAR(50)	NOT NULL,
                                     `QUESTION_ID`	VARCHAR(50)	NOT NULL,
                                     `QUESTION_TYPE`	VARCHAR(20)	NOT NULL	COMMENT '개념형,선택형,드래그형,설명형,실습형',
                                     `QUESTION_TEXT`	TEXT	NULL,
                                     `OPTIONS`	JSON	NOT NULL	COMMENT '문항 유형에 따른 JSON DATA(개념형 포함)',
                                     `ANSWER`	JSON	NULL	COMMENT '정답 JSON + 해설 포함',
                                     `IMAGE`	TEXT	NULL	COMMENT '실습용 이미지',
                                     PRIMARY KEY (`QUESTION_SEQ`),
                                     CONSTRAINT `FK_QUESTION_LESSON` FOREIGN KEY (`LESSON_ID`) REFERENCES `LEARNING_LESSON` (`LESSON_ID`) ON DELETE CASCADE
) ENGINE = INNODB DEFAULT CHARSET = UTF8MB4;

-- 9. 유저 계좌
CREATE TABLE `USER_ACCOUNT` (
                                `ACCOUNT_SEQ`	INT UNSIGNED	NOT NULL AUTO_INCREMENT,
                                `USER_SEQ`	INT UNSIGNED	NOT NULL,
                                `ACCOUNT_NO`	VARCHAR(30)	NOT NULL	COMMENT '계좌번호',
                                `CASH_BALANCE`	BIGINT	NOT NULL,
                                `CREATED_AT`	DATETIME	NOT NULL,
                                `UPDATED_AT`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
                                PRIMARY KEY (`ACCOUNT_SEQ`),
                                CONSTRAINT `FK_ACCOUNT_USER` FOREIGN KEY (`USER_SEQ`) REFERENCES `USERS` (`USER_SEQ`) ON DELETE CASCADE
) ENGINE = INNODB DEFAULT CHARSET = UTF8MB4;

-- 10. 유저 문제 풀이 결과
CREATE TABLE `USER_QUESTION_RESULT` (
                                        `RESULT_SEQ`	INT UNSIGNED	NOT NULL AUTO_INCREMENT,
                                        `USER_SEQ`	INT UNSIGNED	NOT NULL,
                                        `LESSON_ID`	VARCHAR(50)	NOT NULL,
                                        `STARTED_AT`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
                                        `FINISHED_AT`	DATETIME	NULL,
                                        PRIMARY KEY (`RESULT_SEQ`),
                                        CONSTRAINT `FK_Q_RESULT_USER` FOREIGN KEY (`USER_SEQ`) REFERENCES `USERS` (`USER_SEQ`) ON DELETE CASCADE,
                                        CONSTRAINT `FK_Q_RESULT_LESSON` FOREIGN KEY (`LESSON_ID`) REFERENCES `LEARNING_LESSON` (`LESSON_ID`) ON DELETE CASCADE
) ENGINE = INNODB DEFAULT CHARSET = UTF8MB4;

-- 11. 유저 챕터 테스트 결과
CREATE TABLE `USER_TEST_RESULT` (
                                    `TEST_RESULT_SEQ`	INT UNSIGNED	NOT NULL AUTO_INCREMENT,
                                    `CHAPTER_ID`	VARCHAR(50)	NOT NULL,
                                    `USER_SEQ`	INT UNSIGNED	NOT NULL,
                                    `SCORE`	INT UNSIGNED	NOT NULL	DEFAULT 0,
                                    `IS_PASS`	CHAR(1)	NOT NULL	DEFAULT 'N'	COMMENT 'Y/N',
                                    `TESTED_AT`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
                                    PRIMARY KEY (`TEST_RESULT_SEQ`),
                                    CONSTRAINT `FK_T_RESULT_USER` FOREIGN KEY (`USER_SEQ`) REFERENCES `USERS` (`USER_SEQ`) ON DELETE CASCADE,
                                    CONSTRAINT `FK_T_RESULT_CHAPTER` FOREIGN KEY (`CHAPTER_ID`) REFERENCES `LEARNING_CHAPTER` (`CHAPTER_ID`) ON DELETE CASCADE
) ENGINE = INNODB DEFAULT CHARSET = UTF8MB4;

-- 12. 모의 주식 거래
CREATE TABLE `MOCK_TRADE` (
                              `TRADE_SEQ`	INT UNSIGNED	NOT NULL AUTO_INCREMENT,
                              `STOCK_SEQ`	INT UNSIGNED	NOT NULL,
                              `USER_SEQ`	INT UNSIGNED	NOT NULL,
                              `TRADE_TYPE`	CHAR(1)	NOT NULL	DEFAULT 'Y'	COMMENT '매수/매도 Y/N',
                              `TRADE_PRICE`	INT UNSIGNED	NOT NULL	COMMENT '5000',
                              `TRADE_QUANTITY`	INT UNSIGNED	NOT NULL,
                              `TRADED_AT`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
                              PRIMARY KEY (`TRADE_SEQ`),
                              CONSTRAINT `FK_TRADE_USER` FOREIGN KEY (`USER_SEQ`) REFERENCES `USERS` (`USER_SEQ`) ON DELETE CASCADE,
                              CONSTRAINT `FK_TRADE_STOCK` FOREIGN KEY (`STOCK_SEQ`) REFERENCES `STOCK_MASTER` (`STOCK_SEQ`) ON DELETE CASCADE
) ENGINE = INNODB DEFAULT CHARSET = UTF8MB4;

-- 13. 모의 포트폴리오
CREATE TABLE `MOCK_PORTFOLIO` (
                                  `PORTFOLIO_SEQ`	INT UNSIGNED	NOT NULL AUTO_INCREMENT,
                                  `USER_SEQ`	INT UNSIGNED	NOT NULL,
                                  `STOCK_SEQ`	INT UNSIGNED	NOT NULL,
                                  `QUANTITY`	INT UNSIGNED	NOT NULL	COMMENT '증감',
                                  `AVG_PRICE`	INT UNSIGNED	NOT NULL	COMMENT '평균단가',
                                  `UPDATED_AT`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
                                  PRIMARY KEY (`PORTFOLIO_SEQ`),
                                  CONSTRAINT `FK_PORTFOLIO_USER` FOREIGN KEY (`USER_SEQ`) REFERENCES `USERS` (`USER_SEQ`) ON DELETE CASCADE,
                                  CONSTRAINT `FK_PORTFOLIO_STOCK` FOREIGN KEY (`STOCK_SEQ`) REFERENCES `STOCK_MASTER` (`STOCK_SEQ`) ON DELETE CASCADE
) ENGINE = INNODB DEFAULT CHARSET = UTF8MB4;

-- 14. 유저 관심 종목
CREATE TABLE `USER_WATCHLIST` (
                                  `FAVORITE_SEQ`	INT UNSIGNED	NOT NULL AUTO_INCREMENT,
                                  `USER_SEQ`	INT UNSIGNED	NOT NULL,
                                  `STOCK_SEQ`	INT UNSIGNED	NOT NULL,
                                  `CREATED_AT`	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
                                  PRIMARY KEY (`FAVORITE_SEQ`),
                                  CONSTRAINT `FK_WATCHLIST_USER` FOREIGN KEY (`USER_SEQ`) REFERENCES `USERS` (`USER_SEQ`) ON DELETE CASCADE,
                                  CONSTRAINT `FK_WATCHLIST_STOCK` FOREIGN KEY (`STOCK_SEQ`) REFERENCES `STOCK_MASTER` (`STOCK_SEQ`) ON DELETE CASCADE
) ENGINE = INNODB DEFAULT CHARSET = UTF8MB4;

-- 15. 유저 미션 현황
CREATE TABLE `USER_MISSION` (
                                `USER_MISSION_SEQ`	INT UNSIGNED	NOT NULL AUTO_INCREMENT,
                                `USER_SEQ`	INT UNSIGNED	NOT NULL,
                                `MISSION_SEQ`	INT UNSIGNED	NOT NULL,
                                `STARTED_AT`	DATETIME	NOT NULL	COMMENT '매일 자정 초기화',
                                `IS_COMPLETED`	CHAR(1)	NOT NULL	DEFAULT 'N'	COMMENT 'Y/N',
                                `IS_REWARDED`	CHAR(1)	NOT NULL	DEFAULT 'N'	COMMENT 'Y/N',
                                `PROGRESS`	INT UNSIGNED	NOT NULL	DEFAULT 0,
                                PRIMARY KEY (`USER_MISSION_SEQ`),
                                CONSTRAINT `FK_MISSION_USER` FOREIGN KEY (`USER_SEQ`) REFERENCES `USERS` (`USER_SEQ`) ON DELETE CASCADE,
                                CONSTRAINT `FK_MISSION_MASTER` FOREIGN KEY (`MISSION_SEQ`) REFERENCES `MISSION` (`MISSION_SEQ`) ON DELETE CASCADE
) ENGINE = INNODB DEFAULT CHARSET = UTF8MB4;
