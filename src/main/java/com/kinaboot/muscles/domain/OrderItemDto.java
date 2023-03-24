package com.kinaboot.muscles.domain;

public class OrderItemDto {
    private int orderNo;
    private int productNo;
    private String productName;
    private String productCategory;
    private String productImgPath;
    private int productQty;
    private int productPrice;
    private boolean hasReview;

    public String getProductCategory() {
        return productCategory;
    }

    public void setProductCategory(String productCategory) {
        this.productCategory = productCategory;
    }

    public boolean isHasReview() {
        return hasReview;
    }

    public void setHasReview(boolean hasReview) {
        this.hasReview = hasReview;
    }

    public OrderItemDto() {
    }

    public String getProductImgPath() {
        return productImgPath;
    }

    public void setProductImgPath(String productImgPath) {
        this.productImgPath = productImgPath;
    }

    public int getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
    }

    public int getProductNo() {
        return productNo;
    }

    public void setProductNo(int productNo) {
        this.productNo = productNo;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getProductQty() {
        return productQty;
    }

    public void setProductQty(int productQty) {
        this.productQty = productQty;
    }

    public int getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(int productPrice) {
        this.productPrice = productPrice;
    }

    public OrderItemDto(int orderNo, int productNo, String productName, int productQty, int productPrice) {
        this.orderNo = orderNo;
        this.productNo = productNo;
        this.productName = productName;
        this.productQty = productQty;
        this.productPrice = productPrice;
    }

    @Override
    public String toString() {
        return "OrderItemDto{" +
                "orderNo=" + orderNo +
                ", productNo=" + productNo +
                ", productName='" + productName + '\'' +
                ", productCategory='" + productCategory + '\'' +
                ", productQty=" + productQty +
                ", productPrice=" + productPrice +
                '}';
    }
}
