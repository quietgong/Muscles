package com.kinaboot.muscles.domain;

import java.util.List;

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

    public GoodsDto() {
    }

    public GoodsDto(String goodsCategory, String goodsName, int goodsPrice, int goodsStock, Double goodsReviewScore) {
        this.goodsCategory = goodsCategory;
        this.goodsName = goodsName;
        this.goodsPrice = goodsPrice;
        this.goodsStock = goodsStock;
        this.goodsReviewScore = goodsReviewScore;
    }

    public GoodsDto(String goodsCategory, String goodsName, int goodsPrice, int goodsStock) {
        this.goodsCategory = goodsCategory;
        this.goodsName = goodsName;
        this.goodsPrice = goodsPrice;
        this.goodsStock = goodsStock;
    }

    public List<ReviewDto> getReviewDtoList() {
        return reviewDtoList;
    }

    public void setReviewDtoList(List<ReviewDto> reviewDtoList) {
        this.reviewDtoList = reviewDtoList;
    }

    public List<GoodsImgDto> getGoodsImgDtoList() {
        return goodsImgDtoList;
    }

    public void setGoodsImgDtoList(List<GoodsImgDto> goodsImgDtoList) {
        this.goodsImgDtoList = goodsImgDtoList;
    }

    public String getGoodsCategoryDetail() {
        return goodsCategoryDetail;
    }

    public int getGoodsSales() {
        return goodsSales;
    }

    public void setGoodsSales(int goodsSales) {
        this.goodsSales = goodsSales;
    }

    public void setGoodsCategoryDetail(String goodsCategoryDetail) {
        this.goodsCategoryDetail = goodsCategoryDetail;
    }

    public Integer getGoodsNo() {
        return goodsNo;
    }

    public void setGoodsNo(Integer goodsNo) {
        this.goodsNo = goodsNo;
    }

    public String getGoodsCategory() {
        return goodsCategory;
    }

    public void setGoodsCategory(String goodsCategory) {
        this.goodsCategory = goodsCategory;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public String getGoodsImgPath() {
        return goodsImgPath;
    }

    public void setGoodsImgPath(String goodsImgPath) {
        this.goodsImgPath = goodsImgPath;
    }

    public int getGoodsPrice() {
        return goodsPrice;
    }

    public void setGoodsPrice(int goodsPrice) {
        this.goodsPrice = goodsPrice;
    }

    public int getGoodsStock() {
        return goodsStock;
    }

    public void setGoodsStock(int goodsStock) {
        this.goodsStock = goodsStock;
    }

    public Double getGoodsReviewScore() {
        return goodsReviewScore;
    }

    public void setGoodsReviewScore(Double goodsReviewScore) {
        this.goodsReviewScore = goodsReviewScore;
    }

    public String getGoodsDescription() {
        return goodsDescription;
    }

    public void setGoodsDescription(String goodsDescription) {
        this.goodsDescription = goodsDescription;
    }

    @Override
    public String toString() {
        return "GoodsDto{" +
                "reviewDtoList=" + reviewDtoList +
                ", goodsImgDtoList=" + goodsImgDtoList +
                ", goodsNo=" + goodsNo +
                ", goodsDescription='" + goodsDescription + '\'' +
                ", goodsCategory='" + goodsCategory + '\'' +
                ", goodsCategoryDetail='" + goodsCategoryDetail + '\'' +
                ", goodsName='" + goodsName + '\'' +
                ", goodsImgPath='" + goodsImgPath + '\'' +
                ", goodsPrice=" + goodsPrice +
                ", goodsStock=" + goodsStock +
                ", goodsReviewScore=" + goodsReviewScore +
                ", goodsSales=" + goodsSales +
                '}';
    }
}
