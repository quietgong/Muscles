package com.kinaboot.muscles.domain;

import lombok.Data;

@Data
public class CartDto {
    private int cartNo;
    private String userId;
    private String goodsName;
    private String goodsCategory;
    private String goodsCategoryDetail;
    private String goodsImgPath;
    private int goodsNo;
    private int goodsPrice;
    private int goodsQty;
}
