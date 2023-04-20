package com.kinaboot.muscles.domain;

import lombok.Data;

@Data
public class OrderItemDto {
    private int orderNo;
    private int goodsNo;
    private int goodsQty;
    private int goodsPrice;
    private String goodsName;
    private String goodsCategory;
    private String goodsCategoryDetail;
    private String goodsImgPath;
    private boolean hasReview;
}
