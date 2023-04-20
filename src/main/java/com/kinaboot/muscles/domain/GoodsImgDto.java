package com.kinaboot.muscles.domain;

import lombok.Data;

@Data
public class GoodsImgDto {
    private Integer imgNo;
    private Integer goodsNo;
    private String uploadPath;
    private String uploadName;
}
