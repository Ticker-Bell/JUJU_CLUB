-- 1) USERS
CREATE TABLE `USERS`
(
    `user_seq`   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id`    VARCHAR(60) NOT NULL COMMENT '이메일',
    `user_pw`    VARCHAR(60) NOT NULL,
    `user_name`  VARCHAR(50) NOT NULL,
    `created_at` DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `user_level` TINYINT UNSIGNED NULL DEFAULT NULL COMMENT '1/2/3',
    PRIMARY KEY (`user_seq`),
    UNIQUE KEY `UK_USERS_USER_ID` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 2) STOCK_MASTER
CREATE TABLE `STOCK_MASTER`
(
    `stock_seq`   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `stock_code`  VARCHAR(10)  NOT NULL COMMENT 'ex)005930',
    `stock_name`  VARCHAR(100) NOT NULL COMMENT 'ex)에코마켓팅',
    `market_type` VARCHAR(20)  NOT NULL COMMENT 'KOSPI/KOSDAQ',
    `sector`      VARCHAR(50)  NOT NULL COMMENT 'ex)LED',
    PRIMARY KEY (`stock_seq`),
    UNIQUE KEY `UK_STOCK_MASTER_CODE` (`stock_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 3) USER_WATCHLIST
CREATE TABLE `USER_WATCHLIST`
(
    `favorite_seq` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_seq`     INT UNSIGNED NOT NULL,
    `stock_seq`    INT UNSIGNED NOT NULL,
    PRIMARY KEY (`favorite_seq`),
    UNIQUE KEY `UK_USER_WATCHLIST` (`user_seq`, `stock_seq`),
    CONSTRAINT `FK_WATCHLIST_USER`
        FOREIGN KEY (`user_seq`) REFERENCES `USERS` (`user_seq`)
            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_WATCHLIST_STOCK`
        FOREIGN KEY (`stock_seq`) REFERENCES `STOCK_MASTER` (`stock_seq`)
            ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 4) USER_ACCOUNT
CREATE TABLE `USER_ACCOUNT`
(
    `account_seq`  INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_seq`     INT UNSIGNED NOT NULL,
    `account_no`   BIGINT UNSIGNED NOT NULL COMMENT '계좌번호',
    `cash_balance` BIGINT UNSIGNED NOT NULL DEFAULT 1000000,
    `created_at`   DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`   DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`account_seq`),
    UNIQUE KEY `UK_USER_ACCOUNT_ACCOUNT_NO` (`account_no`),
    UNIQUE KEY `UK_USER_ACCOUNT_USER_SEQ` (`user_seq`),
    CONSTRAINT `FK_USER_ACCOUNT_USER`
        FOREIGN KEY (`user_seq`) REFERENCES `USERS` (`user_seq`)
            ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 5) MOCK_TRADE
CREATE TABLE `MOCK_TRADE`
(
    `trade_seq`      INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `stock_seq`      INT UNSIGNED NOT NULL,
    `user_seq`       INT UNSIGNED NOT NULL,
    `trade_type`     CHAR(1)  NOT NULL DEFAULT 'Y' COMMENT '매수/매도 Y/N',
    `trade_price`    INT UNSIGNED NOT NULL COMMENT '5000',
    `trade_quantity` INT UNSIGNED NOT NULL,
    `traded_at`      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`trade_seq`),
    KEY              `IDX_MOCK_TRADE_USER` (`user_seq`),
    KEY              `IDX_MOCK_TRADE_STOCK` (`stock_seq`),
    CONSTRAINT `FK_MOCK_TRADE_USER`
        FOREIGN KEY (`user_seq`) REFERENCES `USERS` (`user_seq`)
            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_MOCK_TRADE_STOCK`
        FOREIGN KEY (`stock_seq`) REFERENCES `STOCK_MASTER` (`stock_seq`)
            ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 6) MOCK_PORTFOLIO
CREATE TABLE `MOCK_PORTFOLIO`
(
    `portfolio_seq` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_seq`      INT UNSIGNED NOT NULL,
    `stock_seq`     INT UNSIGNED NOT NULL,
    `quantity`      INT UNSIGNED NOT NULL COMMENT '증감',
    `avg_price`     INT UNSIGNED NOT NULL COMMENT '평균단가',
    `updated_at`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`portfolio_seq`),
    UNIQUE KEY `UK_MOCK_PORTFOLIO` (`user_seq`, `stock_seq`),
    CONSTRAINT `FK_MOCK_PORTFOLIO_USER`
        FOREIGN KEY (`user_seq`) REFERENCES `USERS` (`user_seq`)
            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_MOCK_PORTFOLIO_STOCK`
        FOREIGN KEY (`stock_seq`) REFERENCES `STOCK_MASTER` (`stock_seq`)
            ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 7) LEARNING_LEVEL
CREATE TABLE `LEARNING_LEVEL`
(
    `level_seq`   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `level_name`  VARCHAR(10) NOT NULL COMMENT '초급/중급/고급',
    `is_domestic` CHAR(1)     NOT NULL COMMENT 'Y/N',
    PRIMARY KEY (`level_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 8) LEARNING_CHAPTER
CREATE TABLE `LEARNING_CHAPTER`
(
    `chapter_id`   VARCHAR(50)  NOT NULL,
    `level_seq`    INT UNSIGNED NOT NULL,
    `chapter_name` VARCHAR(100) NOT NULL,
    `reward_cash`  INT UNSIGNED NOT NULL,
    `test_pay`     INT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (`chapter_id`),
    KEY            `IDX_CHAPTER_LEVEL` (`level_seq`),
    CONSTRAINT `FK_CHAPTER_LEVEL`
        FOREIGN KEY (`level_seq`) REFERENCES `LEARNING_LEVEL` (`level_seq`)
            ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 9) LEARNING_LESSON
CREATE TABLE `LEARNING_LESSON`
(
    `lesson_id`   VARCHAR(50)  NOT NULL,
    `chapter_id`  VARCHAR(50)  NOT NULL,
    `lesson_name` VARCHAR(100) NOT NULL,
    `lesson_type` VARCHAR(20)  NOT NULL COMMENT '이론형/실습형',
    PRIMARY KEY (`lesson_id`),
    KEY           `IDX_LESSON_CHAPTER` (`chapter_id`),
    CONSTRAINT `FK_LESSON_CHAPTER`
        FOREIGN KEY (`chapter_id`) REFERENCES `LEARNING_CHAPTER` (`chapter_id`)
            ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 10) LEARNING_QUESTION
CREATE TABLE `LEARNING_QUESTION`
(
    `question_seq`  INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `lesson_id`     VARCHAR(50) NOT NULL,
    `question_id`   VARCHAR(50) NOT NULL,
    `question_type` VARCHAR(20) NOT NULL COMMENT '개념형,선택형,드래그형,설명형,실습형',
    `question_text` TEXT NULL,
    `options_json`  JSON        NOT NULL COMMENT '문항 유형에 따른 JSON DATA',
    `answer`        JSON NULL COMMENT '정답 JSON + 해설 포함',
    `image`         TEXT NULL COMMENT '실습용 이미지',
    PRIMARY KEY (`question_seq`),
    KEY             `IDX_QUESTION_LESSON` (`lesson_id`),
    CONSTRAINT `FK_QUESTION_LESSON`
        FOREIGN KEY (`lesson_id`) REFERENCES `LEARNING_LESSON` (`lesson_id`)
            ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 11) USER_QUESTION_RESULT
CREATE TABLE `USER_QUESTION_RESULT`
(
    `result_seq`  INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_seq`    INT UNSIGNED NOT NULL,
    `lesson_id`   VARCHAR(50) NOT NULL,
    `started_at`  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `finished_at` DATETIME NULL,
    PRIMARY KEY (`result_seq`),
    KEY           `IDX_UQR_USER` (`user_seq`),
    KEY           `IDX_UQR_LESSON` (`lesson_id`),
    CONSTRAINT `FK_UQR_USER`
        FOREIGN KEY (`user_seq`) REFERENCES `USERS` (`user_seq`)
            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_UQR_LESSON`
        FOREIGN KEY (`lesson_id`) REFERENCES `LEARNING_LESSON` (`lesson_id`)
            ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 12) USER_TEST_RESULT
CREATE TABLE `USER_TEST_RESULT`
(
    `test_result_seq` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `chapter_id`      VARCHAR(50) NOT NULL,
    `user_seq`        INT UNSIGNED NOT NULL,
    `score`           INT UNSIGNED NOT NULL DEFAULT 0,
    `is_pass`         CHAR(1)     NOT NULL DEFAULT 'N' COMMENT 'Y/N',
    `tested_at`       DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`test_result_seq`),
    KEY               `IDX_UTR_USER` (`user_seq`),
    KEY               `IDX_UTR_CHAPTER` (`chapter_id`),
    CONSTRAINT `FK_UTR_USER`
        FOREIGN KEY (`user_seq`) REFERENCES `USERS` (`user_seq`)
            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_UTR_CHAPTER`
        FOREIGN KEY (`chapter_id`) REFERENCES `LEARNING_CHAPTER` (`chapter_id`)
            ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 13) MISSION
CREATE TABLE `MISSION`
(
    `mission_seq`    INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `mission_type`   VARCHAR(50) NOT NULL COMMENT '레슨/모의체결/챕터테스트/관종추/포인트소모',
    `mission_title`  VARCHAR(50) NOT NULL COMMENT '레슨 5개완료하기 etc',
    `mission_reward` INT UNSIGNED NOT NULL COMMENT '500',
    `target_value`   INT UNSIGNED NOT NULL COMMENT '5',
    PRIMARY KEY (`mission_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 14) USER_MISSION
CREATE TABLE `USER_MISSION`
(
    `user_mission_seq` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_seq`         INT UNSIGNED NOT NULL,
    `mission_seq`      INT UNSIGNED NOT NULL,
    `is_completed`     CHAR(1)  NOT NULL DEFAULT 'N' COMMENT 'Y/N',
    `started_at`       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `completed_at`     DATETIME NULL,
    `count`            INT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (`user_mission_seq`),
    UNIQUE KEY `UK_USER_MISSION` (`user_seq`, `mission_seq`),
    CONSTRAINT `FK_USER_MISSION_USER`
        FOREIGN KEY (`user_seq`) REFERENCES `USERS` (`user_seq`)
            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `FK_USER_MISSION_MISSION`
        FOREIGN KEY (`mission_seq`) REFERENCES `MISSION` (`mission_seq`)
            ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;