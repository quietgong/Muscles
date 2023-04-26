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
    private Integer orderNo;
    private Integer goodsNo;
    private Integer goodsQty;
    private Integer goodsPrice;
    private String goodsName;
    private String goodsCategory;
    private String goodsCategoryDetail;
    private String goodsImgPath;
    private boolean hasReview;
}
