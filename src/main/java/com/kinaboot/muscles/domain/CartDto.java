package com.kinaboot.muscles.domain;

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

    public int getCartNo() {
        return cartNo;
    }

    public void setCartNo(int cartNo) {
        this.cartNo = cartNo;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
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

    public String getGoodsCategoryDetail() {
        return goodsCategoryDetail;
    }

    public void setGoodsCategoryDetail(String goodsCategoryDetail) {
        this.goodsCategoryDetail = goodsCategoryDetail;
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

    public int getGoodsNo() {
        return goodsNo;
    }

    public void setGoodsNo(int goodsNo) {
        this.goodsNo = goodsNo;
    }

    public int getGoodsPrice() {
        return goodsPrice;
    }

    public void setGoodsPrice(int goodsPrice) {
        this.goodsPrice = goodsPrice;
    }

    public int getGoodsQty() {
        return goodsQty;
    }

    public void setGoodsQty(int goodsQty) {
        this.goodsQty = goodsQty;
    }

    @Override
    public String toString() {
        return "CartDto{" +
                "cartNo=" + cartNo +
                ", userId='" + userId + '\'' +
                ", goodsName='" + goodsName + '\'' +
                ", goodsCategory='" + goodsCategory + '\'' +
                ", goodsImgPath='" + goodsImgPath + '\'' +
                ", goodsNo=" + goodsNo +
                ", goodsPrice=" + goodsPrice +
                ", goodsQty=" + goodsQty +
                '}';
    }
}
