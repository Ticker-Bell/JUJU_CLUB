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
       <img src="https://img.shields.io/badge/jQuery-0769AD?style=flat&logo=jQuery-0769AD&logoColor=white"/>
       <img src="https://img.shields.io/badge/Htmx-3366CC?style=flat&logo=htmx-3366CC&logoColor=white"/>
       <img src="https://img.shields.io/badge/Tailwind-06B6D4?style=flat&logo=tailwind-06B6D4&logoColor=white"/>
      </td>
    </tr>
  </tbody>
</table>



## 🚀 프로젝트 목표

1. **초보자도 쉽게 배울 수 있는 교육** 

2. **투자의 두려움 해소** 

3. **확장 가능성 확보** 

## ⚙️ 프로젝트 구조
├─.idea                          
├─db-schema
│      schema.sql  
├─src
│  ├─main
│  │  ├─java
│  │  │  └─com
│  │  │      └─tickerbell
│  │  │          └─jujuclub
│  │  │              ├─auth
│  │  │              │  ├─controller 
│  │  │              │  ├─dto    
│  │  │              │  ├─mapper   
│  │  │              │  └─service         
│  │  │              ├─common
│  │  │              │  ├─controller     
│  │  │              │  ├─dto      
│  │  │              │  ├─mapper     
│  │  │              │  └─service        
│  │  │              ├─config    
│  │  │              ├─dartdata
│  │  │              │  ├─dto     
│  │  │              │  ├─mapper      
│  │  │              │  ├─runner    
│  │  │              │  ├─service    
│  │  │              │  └─util      
│  │  │              ├─index     
│  │  │              ├─invest
│  │  │              │  ├─controller     
│  │  │              │  ├─dto      
│  │  │              │  ├─mapper    
│  │  │              │  └─service         
│  │  │              ├─lesson
│  │  │              │  ├─controller      
│  │  │              │  ├─dto    
│  │  │              │  ├─mapper     
│  │  │              │  └─service      
│  │  │              ├─mypage
│  │  │              │  └─controller          
│  │  │              ├─ranking
│  │  │              │  ├─controller      
│  │  │              │  ├─dto    
│  │  │              │  ├─mapper      
│  │  │              │  └─service      
│  │  │              ├─roadMap
│  │  │              │  ├─controller     
│  │  │              │  ├─dto  
│  │  │              │  ├─mapper     
│  │  │              │  └─service       
│  │  │              ├─stockdata
│  │  │              │  ├─dto      
│  │  │              │  ├─mapper     
│  │  │              │  ├─runner     
│  │  │              │  └─service        
│  │  │              └─utils                  
│  │  ├─resources
│  │  │  │  dart.properties
│  │  │  │  db.properties
│  │  │  │  kis.properties
│  │  │  │  log4j.xml
│  │  │  │  mybatis-config.xml
│  │  │  └─mapper    
│  │  └─webapp
│  │      ├─resources
│  │      │  ├─css
│  │      │  │  ├─lesson   
│  │      │  │  ├─main  
│  │      │  │  ├─myPage   
│  │      │  │  ├─ranking     
│  │      │  │  ├─roadMap  
│  │      │  │  └─sidebar     
│  │      │  ├─images
│  │      │  │  ├─navIcons     
│  │      │  │  ├─roadMapIcons    
│  │      │  │  └─stockIcons        
│  │      │  └─js
│  │      │      ├─invest  
│  │      │      ├─lesson     
│  │      │      ├─main  
│  │      │      ├─myPage    
│  │      │      └─roadMap          
│  │      └─WEB-INF
│  │          ├─spring
│  │          │  └─appServlet        
│  │          └─views
│  │              ├─auth    
│  │              ├─common   
│  │              ├─invest 
│  │              ├─lesson
│  │              │  └─common      
│  │              ├─main      
│  │              ├─myPage   
│  │              ├─ranking     
│  │              └─roadMap               


## 📌 주요 기능

### **0. 홈**

<div align="center">
  
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

---
