package com.kinaboot.muscles.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonIgnoreProperties
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
