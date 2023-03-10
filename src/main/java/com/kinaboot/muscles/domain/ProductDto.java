package com.kinaboot.muscles.domain;

import java.util.List;

public class ProductDto {
    private List<ReviewDto> reviewDtoList;
    private Integer productNo;
    private String productCategory;
    private String productName;
    private int productPrice;
    private int productStock;
    private Double productReviewScore;

    public List<ReviewDto> getReviewDtoList() {
        return reviewDtoList;
    }

    public void setReviewDtoList(List<ReviewDto> reviewDtoList) {
        this.reviewDtoList = reviewDtoList;
    }

    public Double getProductReviewScore() {
        return productReviewScore;
    }

    public void setProductReviewScore(Double productReviewScore) {
        this.productReviewScore = productReviewScore;
    }

    public ProductDto() {
    }

    public ProductDto(String productCategory, String productName, int productPrice, int productStock) {
        this.productCategory = productCategory;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productStock = productStock;
    }

    public Integer getProductNo() {
        return productNo;
    }

    public void setProductNo(Integer productNo) {
        this.productNo = productNo;
    }

    public String getProductCategory() {
        return productCategory;
    }

    public void setProductCategory(String productCategory) {
        this.productCategory = productCategory;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(int productPrice) {
        this.productPrice = productPrice;
    }

    public int getProductStock() {
        return productStock;
    }

    public void setProductStock(int productStock) {
        this.productStock = productStock;
    }

    @Override
    public String toString() {
        return "ProductDto{" +
                "productNo='" + productNo + '\'' +
                ", productCategory='" + productCategory + '\'' +
                ", productName='" + productName + '\'' +
                ", productPrice=" + productPrice +
                ", productStock=" + productStock +
                '}';
    }
}
