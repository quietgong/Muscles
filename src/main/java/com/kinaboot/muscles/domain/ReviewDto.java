package com.kinaboot.muscles.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class ReviewDto {
    private Integer reviewNo;
    private Integer orderNo;
    private Integer score;
    private String content;
    private String userId;
    private Integer goodsNo;
    private String goodsName;
    private List<ReviewImgDto> reviewImgDtoList;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date createdDate;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date expiredDate;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date modDate;
}
