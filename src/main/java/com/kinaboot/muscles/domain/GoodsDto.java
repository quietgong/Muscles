package com.kinaboot.muscles.domain;

import lombok.Data;

import java.util.List;

@Data
public class GoodsDto {
    private List<ReviewDto> reviewDtoList;
    private List<GoodsImgDto> goodsImgDtoList;
    private Integer goodsNo;
    private String goodsDescription;
    private String goodsCategory;
    private String goodsCategoryDetail;
    private String goodsName;
    private String goodsImgPath;
    private int goodsPrice;
    private int goodsStock;
    private Double goodsReviewScore;
    private int goodsSales;
}
