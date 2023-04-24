package com.kinaboot.muscles.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class GoodsImgDto {
    private Integer imgNo;
    private Integer goodsNo;
    private String uploadPath;
    private String uploadName;
}
