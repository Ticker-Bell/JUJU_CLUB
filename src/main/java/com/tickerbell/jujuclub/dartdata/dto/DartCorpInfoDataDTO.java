package com.tickerbell.jujuclub.dartdata.dto;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
@XmlAccessorType(XmlAccessType.FIELD)
public class DartCorpInfoDataDTO {

    //dart 종목 코드 파일에서 받아올 데이터
    //dart api 파일 list 한개

    @XmlElement(name = "corp_code")
    private String corpCode;
    @XmlElement(name = "corp_name")
    private String corpName;
    @XmlElement(name = "stock_code")
    private String stockCode;
    @XmlElement(name = "modify_date")
    private String modifyDate;

}

