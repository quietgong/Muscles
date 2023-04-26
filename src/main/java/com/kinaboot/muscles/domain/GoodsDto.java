package com.kinaboot.muscles.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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
    private Integer goodsPrice;
    private Integer goodsStock;
    private Double goodsReviewScore;
    private Integer goodsSales;
}
