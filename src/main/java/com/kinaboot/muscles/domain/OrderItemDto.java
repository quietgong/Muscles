package com.kinaboot.muscles.domain;

public class OrderItemDto {
    private int orderNo;
    private int goodsNo;
    private String goodsName;
    private String goodsCategory;
    private String goodsCategoryDetail;
    private String goodsImgPath;
    private int goodsQty;
    private int goodsPrice;
    private boolean hasReview;

    public OrderItemDto() {
    }

    public OrderItemDto(int orderNo, int goodsNo, String goodsName, int goodsQty, int goodsPrice) {
        this.orderNo = orderNo;
        this.goodsNo = goodsNo;
        this.goodsName = goodsName;
        this.goodsQty = goodsQty;
        this.goodsPrice = goodsPrice;
    }
    public String getGoodsCategoryDetail() {
        return goodsCategoryDetail;
    }

    public void setGoodsCategoryDetail(String goodsCategoryDetail) {
        this.goodsCategoryDetail = goodsCategoryDetail;
    }
    public int getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
    }

    public int getGoodsNo() {
        return goodsNo;
    }

    public void setGoodsNo(int goodsNo) {
        this.goodsNo = goodsNo;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public String getGoodsCategory() {
        return goodsCategory;
    }

    public void setGoodsCategory(String goodsCategory) {
        this.goodsCategory = goodsCategory;
    }

    public String getGoodsImgPath() {
        return goodsImgPath;
    }

    public void setGoodsImgPath(String goodsImgPath) {
        this.goodsImgPath = goodsImgPath;
    }

    public int getGoodsQty() {
        return goodsQty;
    }

    public void setGoodsQty(int goodsQty) {
        this.goodsQty = goodsQty;
    }

    public int getGoodsPrice() {
        return goodsPrice;
    }

    public void setGoodsPrice(int goodsPrice) {
        this.goodsPrice = goodsPrice;
    }

    public boolean isHasReview() {
        return hasReview;
    }

    public void setHasReview(boolean hasReview) {
        this.hasReview = hasReview;
    }

    @Override
    public String toString() {
        return "OrderItemDto{" +
                "orderNo=" + orderNo +
                ", goodsNo=" + goodsNo +
                ", goodsName='" + goodsName + '\'' +
                ", goodsCategory='" + goodsCategory + '\'' +
                ", goodsImgPath='" + goodsImgPath + '\'' +
                ", goodsQty=" + goodsQty +
                ", goodsPrice=" + goodsPrice +
                ", hasReview=" + hasReview +
                '}';
    }
}
