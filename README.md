# 🧚JUJUCLUB
주식 초보자들의 가이드

## ✍️ 프로젝트 개요

- **프로젝트명:** JUJUCLUB
- **팀:** 티커벨
- **프로젝트 기간:** 2025.1 ~ 2025.02
- **프로젝트 형태:** 신한DS 1차 프로젝트
- **목표:** 레슨과 테스트를 통해 단계적으로 금융 개념을 학습하고, 가상 시드머니를 활용한 모의 투자 경험을 통해 실제 투자 흐름을 이해
- **주요 타겟 사용자:**  금융 투자 경험이 없는 사용자


## ✍️ 프로젝트 소개

### 프로젝트 배경

1. **자금의 한계** 

2. **정보의 방대함** 

3. **어려운 금융 지식** 

**JUJUCLUB**은 위 문제를 해결하기 위해 단계 시스템을 도입하여 초보자도 눈높이에 맞는 교육을 제공하고 모의 자금으로 부담없이 투자할 수 있는 기회를 제공하여 주식 투자에 대한 부담과 두려움을 없애고자 하였습니다.

## 🧑‍💻 팀원 소개

| **이름**    | **역할**        | 
|:-----------:|:---------------:|
| 장현호      | 로드맵 레슨, 챕터테스트, 유저 랭킹 보드| 
|김종권      | 홈, 로그인, 회원가입, 온보딩, 마이페이지| 
|김동한      | 모의투자 주식 종목 리스트, 모의투자 거래 내역, 키 발급| 
|문지현      |모의투자 마이, 기업 정보| 
|이유경      | 공통 레이아웃, 로드맵 메인 페이지, 일일 미션| 
|김윤선      | 모의투자 실시간 주식 차트, 주식 매수| 



## ⚙️ 기술 스택

<table>
  <thead>
    <tr>
      <th>분류</th>
      <th>기술 스택</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>프론트엔드</td>
      <td>
        <img src="https://img.shields.io/badge/Javascript-F7DF1E?style=flat&logo=javascript&logoColor=white"/>
       <img src="https://img.shields.io/badge/Html-E34F26?style=flat&logo=html5&logoColor=white"/>
       <img src="https://img.shields.io/badge/jQuery-0769AD?style=flat&logo=jQuery&logoColor=white"/>
       <img src="https://img.shields.io/badge/Htmx-3366CC?style=flat&logo=htmx&logoColor=white"/>
       <img src="https://img.shields.io/badge/Tailwind-06B6D4?style=flat&logo=tailwindcss&logoColor=white"/>
      </td>
    </tr>
    <tr>
      <td>백엔드</td>
      <td>
        <img src="https://img.shields.io/badge/Spring-6DB33F?style=flat&logo=spring&logoColor=white"/>
       <img src="https://img.shields.io/badge/Mysql-4479A1?style=flat&logo=mysql&logoColor=white"/>
      </td>
    </tr>
      <tr>
      <td>툴</td>
      <td>
        <img src="https://img.shields.io/badge/Figma-F24E1E?style=flat&logo=Figma&logoColor=white"/>
       <img src="https://img.shields.io/badge/Git-F05032?style=flat&logo=git&logoColor=white"/>
     <img src="https://img.shields.io/badge/GitHub-181717?style=flat&logo=github&logoColor=white"/>
    <img src="https://img.shields.io/badge/Slack-4A154B?style=flat&logo=slack&logoColor=white"/>
       <img src="https://img.shields.io/badge/Notion-000000?style=flat&logo=notion&logoColor=white"/>
       <img src="https://img.shields.io/badge/Intellij-000000?style=flat&logo=intellijidea&logoColor=white"/>
      </td>
    </tr>
  </tbody>
</table>



## 🚀 프로젝트 목표

1. **초보자도 쉽게 배울 수 있는 교육** 

2. **투자의 두려움 해소** 

3. **확장 가능성 확보**


## 📌 주요 기능

### **0. 홈**

<div align="center">
<img src ="https://github.com/user-attachments/assets/52f3e766-82ed-4270-8fbd-5571eb3188c8"/>
</div>

### **1. 회원가입 | 로그인**

#### **회원가입**

<div align="center">
  
</div>

#### **로그인**

<div align="center">
  
</div>

#### **레벨테스트**

<div align="center">
  
</div>

#### **온보딩**

<div align="center">
  
</div>

### **2.로드맵**

#### **로드맵**
<div align="center">
  
</div>

#### **레슨**
<div align="center">
  
</div>

#### **챕터테스트**
<div align="center">
  
</div>

### **3.모의투자**

#### **마이**
<div align="center">
  
</div>

#### **투자**
<div align="center">
  
</div>

#### **거래내역**
<div align="center">
  
</div>

### **4.랭킹**
<div align="center">
  
</div>

### **5.마이페이지**
<div align="center">
  
</div>



## ⚙️ 프로젝트 구조
```
src
 ┣ main
 ┃ ┣ java
 ┃ ┃ ┗ com
 ┃ ┃ ┃ ┗ tickerbell
 ┃ ┃ ┃ ┃ ┗ jujuclub
 ┃ ┃ ┃ ┃ ┃ ┣ auth
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ controller
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ AccountController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ MemberController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ SigninController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ SignupController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ dto
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ AccountDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ MemberDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ SigninDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ SignupDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ mapper
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ AccountMapper.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ MemberMapper.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ SigninMapper.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ SignupMapper.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ service
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ AccountService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ MemberService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ SigninService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ SignupService.java
 ┃ ┃ ┃ ┃ ┃ ┣ common
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ controller
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ HtmxLayoutInterceptor.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ LoginCheckInterceptor.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ LogoutCheckInterceptor.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ dto
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ UserInfoDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ mapper
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ UserInfoMapper.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ service
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ UserInfoService.java
 ┃ ┃ ┃ ┃ ┃ ┣ config
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ WebSocketConfig.java
 ┃ ┃ ┃ ┃ ┃ ┣ dartdata
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ dto
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ DartCorpInfoDataDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ DartCorpInfoDataResultDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ mapper
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ DartCorpInfoMapper.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ runner
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ DartDataInitRunner.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ service
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ DartDataService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ util
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ ReadProperties.java
 ┃ ┃ ┃ ┃ ┃ ┣ index
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ HomeController.java
 ┃ ┃ ┃ ┃ ┃ ┣ invest
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ controller
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockChartController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockCorpInfoController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockListController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockMyRestController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockWatchListController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ TradeController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ dto
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ AssetDetailDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ DARTCorpInfoDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ KISCorpInfoDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ KISDataDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ MockPortfolioDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ MockTradeDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ PortfolioDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockChartDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockChartRestDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockCorpInfoDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockRankingDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ TradeDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ UserInvestSummeryDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ WatchListDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ mapper
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ AssetDetailMapper.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ CodeMappingMapper.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ PortfolioMapper.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockChartDataMapper.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockMapper.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ TradeMapper.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ UserAssetMapper.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ service
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ AssetDetailService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ DARTApiService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ KISApiService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ PortfolioService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockChartDataService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockChartRestService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockChartService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockCorpInfoService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockRankingService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ TradeService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ UserAssetService.java
 ┃ ┃ ┃ ┃ ┃ ┣ lesson
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ controller
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ LessonController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ dto
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ LessonDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ QstChatMsgDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ mapper
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ LessonMapper.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ service
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ LessonJsonParse.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ LessonService.java
 ┃ ┃ ┃ ┃ ┃ ┣ mypage
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ controller
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ MyPageController.java
 ┃ ┃ ┃ ┃ ┃ ┣ ranking
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ controller
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ RankingController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ dto
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ RankingDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ mapper
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ RankingMapper.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ service
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ RankingService.java
 ┃ ┃ ┃ ┃ ┃ ┣ roadMap
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ controller
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ RoadMapController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ dto
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ ChapterDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ ChapterResultDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ LevelChapterLessonDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ LevelDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ MissionCheckDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ MissionDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ UserLessonDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ mapper
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ RoadMapMapper.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ service
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ RoadMapService.java
 ┃ ┃ ┃ ┃ ┃ ┣ stockdata
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ dto
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ StockDataDTO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ mapper
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ StockDataMapper.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ runner
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ StockDataInitRunner.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ service
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ StockDataService.java
 ┃ ┃ ┃ ┃ ┃ ┗ utils
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ ColorUtil.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ GetValidAccessToken.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ GetValidApprovalKey.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ RequestNewAccessToken.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ RequestNewApprovalKey.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ StockChartFormatter.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ StockChartParser.java
 ┃ ┣ resources
 ┃ ┃ ┣ mapper
 ┃ ┃ ┃ ┣ accountMapper.xml
 ┃ ┃ ┃ ┣ assetDetailMapper.xml
 ┃ ┃ ┃ ┣ codeMappingMapper.xml
 ┃ ┃ ┃ ┣ dartCorpInfoMapper.xml
 ┃ ┃ ┃ ┣ lessonMapper.xml
 ┃ ┃ ┃ ┣ memberMapper.xml
 ┃ ┃ ┃ ┣ portpolioMapper.xml
 ┃ ┃ ┃ ┣ rankingMapper.xml
 ┃ ┃ ┃ ┣ roadMapMapper.xml
 ┃ ┃ ┃ ┣ signinMapper.xml
 ┃ ┃ ┃ ┣ signupMapper.xml
 ┃ ┃ ┃ ┣ stockChartDataMapper.xml
 ┃ ┃ ┃ ┣ stockDataMapper.xml
 ┃ ┃ ┃ ┣ stockMapper.xml
 ┃ ┃ ┃ ┣ tradeMapper.xml
 ┃ ┃ ┃ ┣ userAssetMapper.xml
 ┃ ┃ ┃ ┗ userInfoMapper.xml
 ┃ ┃ ┣ dart.properties
 ┃ ┃ ┣ db.properties
 ┃ ┃ ┣ kis.properties
 ┃ ┃ ┣ log4j.xml
 ┃ ┃ ┗ mybatis-config.xml
 ┃ ┗ webapp
 ┃ ┃ ┣ resources
 ┃ ┃ ┃ ┣ css
 ┃ ┃ ┃ ┃ ┣ lesson
 ┃ ┃ ┃ ┃ ┃ ┣ chapterTest.css
 ┃ ┃ ┃ ┃ ┃ ┣ lesson.css
 ┃ ┃ ┃ ┃ ┃ ┣ lessonchat.css
 ┃ ┃ ┃ ┃ ┃ ┣ lessonDrag.css
 ┃ ┃ ┃ ┃ ┃ ┣ lessonMatch.css
 ┃ ┃ ┃ ┃ ┃ ┗ lessonSelect.css
 ┃ ┃ ┃ ┃ ┣ main
 ┃ ┃ ┃ ┃ ┃ ┣ home.css
 ┃ ┃ ┃ ┃ ┃ ┗ main.css
 ┃ ┃ ┃ ┃ ┣ myPage
 ┃ ┃ ┃ ┃ ┃ ┗ myPageProfile.css
 ┃ ┃ ┃ ┃ ┣ ranking
 ┃ ┃ ┃ ┃ ┃ ┗ rankingMain.css
 ┃ ┃ ┃ ┃ ┣ roadMap
 ┃ ┃ ┃ ┃ ┃ ┣ dropDown.css
 ┃ ┃ ┃ ┃ ┃ ┣ missionButton.css
 ┃ ┃ ┃ ┃ ┃ ┗ roadMap.css
 ┃ ┃ ┃ ┃ ┗ sidebar
 ┃ ┃ ┃ ┃ ┃ ┗ sidebar.css
 ┃ ┃ ┃ ┣ images
 ┃ ┃ ┃ ┃ ┣ navIcons
 ┃ ┃ ┃ ┃ ┃ ┣ bar-chart.svg
 ┃ ┃ ┃ ┃ ┃ ┣ exit-outline.svg
 ┃ ┃ ┃ ┃ ┃ ┣ map.svg
 ┃ ┃ ┃ ┃ ┃ ┣ trophy-outline.svg
 ┃ ┃ ┃ ┃ ┃ ┗ user.svg
 ┃ ┃ ┃ ┃ ┣ roadMapIcons
 ┃ ┃ ┃ ┃ ┃ ┣ chapter-complete.png
 ┃ ┃ ┃ ┃ ┃ ┣ chapter-completed.png
 ┃ ┃ ┃ ┃ ┃ ┣ chapter-current.png
 ┃ ┃ ┃ ┃ ┃ ┣ chapter-locked.png
 ┃ ┃ ┃ ┃ ┃ ┣ close.svg
 ┃ ┃ ┃ ┃ ┃ ┣ flag.png
 ┃ ┃ ┃ ┃ ┃ ┣ left-Icon.svg
 ┃ ┃ ┃ ┃ ┃ ┣ money1.png
 ┃ ┃ ┃ ┃ ┃ ┣ money2.png
 ┃ ┃ ┃ ┃ ┃ ┣ money3.png
 ┃ ┃ ┃ ┃ ┃ ┣ right-Icon.svg
 ┃ ┃ ┃ ┃ ┃ ┣ roadMap-bg.png
 ┃ ┃ ┃ ┃ ┃ ┗ target.svg
 ┃ ┃ ┃ ┃ ┣ stockIcons
 ┃ ┃ ┃ ┃ ┃ ┣ filled-heart.svg
 ┃ ┃ ┃ ┃ ┃ ┗ heart.svg
 ┃ ┃ ┃ ┃ ┣ default-profile.png
 ┃ ┃ ┃ ┃ ┗ Rocketship.gif
 ┃ ┃ ┃ ┗ js
 ┃ ┃ ┃ ┃ ┣ invest
 ┃ ┃ ┃ ┃ ┃ ┣ portfolioDonutChart.js
 ┃ ┃ ┃ ┃ ┃ ┣ stockLineChart.js
 ┃ ┃ ┃ ┃ ┃ ┗ stockSocket.js
 ┃ ┃ ┃ ┃ ┣ lesson
 ┃ ┃ ┃ ┃ ┃ ┗ lessonchat.js
 ┃ ┃ ┃ ┃ ┣ main
 ┃ ┃ ┃ ┃ ┃ ┣ home.js
 ┃ ┃ ┃ ┃ ┃ ┗ main.js
 ┃ ┃ ┃ ┃ ┣ myPage
 ┃ ┃ ┃ ┃ ┃ ┣ myPageMain.js
 ┃ ┃ ┃ ┃ ┃ ┗ myPageProfile.js
 ┃ ┃ ┃ ┃ ┗ roadMap
 ┃ ┃ ┃ ┃ ┃ ┗ dropDown.js
 ┃ ┃ ┗ WEB-INF
 ┃ ┃ ┃ ┣ spring
 ┃ ┃ ┃ ┃ ┣ appServlet
 ┃ ┃ ┃ ┃ ┃ ┗ servlet-context.xml
 ┃ ┃ ┃ ┃ ┣ root-context.xml
 ┃ ┃ ┃ ┃ ┗ root-contextDB.xml
 ┃ ┃ ┃ ┣ views
 ┃ ┃ ┃ ┃ ┣ auth
 ┃ ┃ ┃ ┃ ┃ ┗ login.jsp
 ┃ ┃ ┃ ┃ ┣ common
 ┃ ┃ ┃ ┃ ┃ ┣ common.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ hometopbar.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ main.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ onBoard.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ sidebar.jsp
 ┃ ┃ ┃ ┃ ┃ ┗ topbar.jsp
 ┃ ┃ ┃ ┃ ┣ invest
 ┃ ┃ ┃ ┃ ┃ ┣ assetDetail.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ investChart.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ investMain.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ investMy.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ investStockList.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ investTab.jsp
 ┃ ┃ ┃ ┃ ┃ ┗ stockCorpInfoCard.jsp
 ┃ ┃ ┃ ┃ ┣ lesson
 ┃ ┃ ┃ ┃ ┃ ┣ common
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ lessonCommon.jsp
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ resultModal.jsp
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ resultModal2.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ chapterTest.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ lessonInfo.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ qst2.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ qst3.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ qst4.jsp
 ┃ ┃ ┃ ┃ ┃ ┗ qst5.jsp
 ┃ ┃ ┃ ┃ ┣ main
 ┃ ┃ ┃ ┃ ┃ ┗ onboard.jsp
 ┃ ┃ ┃ ┃ ┣ myPage
 ┃ ┃ ┃ ┃ ┃ ┣ myPageAsset.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ myPageMain.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ myPageMission.jsp
 ┃ ┃ ┃ ┃ ┃ ┗ myPageProfile.jsp
 ┃ ┃ ┃ ┃ ┣ ranking
 ┃ ┃ ┃ ┃ ┃ ┗ rankingMain.jsp
 ┃ ┃ ┃ ┃ ┣ roadMap
 ┃ ┃ ┃ ┃ ┃ ┣ dropDown.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ missionButton.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ missionModal.jsp
 ┃ ┃ ┃ ┃ ┃ ┣ roadMapMain.jsp
 ┃ ┃ ┃ ┃ ┃ ┗ toolTip.jsp
 ┃ ┃ ┃ ┃ ┗ home.jsp
 ┃ ┃ ┃ ┗ web.xml
```
