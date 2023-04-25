package com.kinaboot.muscles.domain;

import lombok.Data;

@Data
public class ReviewImgDto {
    private Integer reviewImgNo;
    private Integer reviewNo;
    private Integer goodsNo;
    private String uploadPath;
    private String fileName;
}
