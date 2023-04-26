package com.kinaboot.muscles.domain;

import lombok.Data;

@Data
public class CartDto {
    private Integer cartNo;
    private String userId;
    private String goodsName;
    private String goodsCategory;
    private String goodsCategoryDetail;
    private String goodsImgPath;
    private Integer goodsNo;
    private Integer goodsPrice;
    private Integer goodsQty;
}
