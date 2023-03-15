package com.kinaboot.muscles.domain;

import java.util.Arrays;
import java.util.List;

public class ProductDto {
    private List<ReviewDto> reviewDtoList;
    private List<ProductImgDto> productImgDtoList;
    private Integer productNo;
    private String productCategory;
    private String productName;
    private String productImgPath;
    private int productPrice;
    private int productStock;
    private Double productReviewScore;

    public ProductDto() {
    }

    public ProductDto(String productCategory, String productName, int productPrice, int productStock, Double productReviewScore) {
        this.productCategory = productCategory;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productStock = productStock;
        this.productReviewScore = productReviewScore;
    }

    public ProductDto(String productCategory, String productName, int productPrice, int productStock) {
        this.productCategory = productCategory;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productStock = productStock;
    }

    public List<ReviewDto> getReviewDtoList() {
        return reviewDtoList;
    }

    public void setReviewDtoList(List<ReviewDto> reviewDtoList) {
        this.reviewDtoList = reviewDtoList;
    }

    public List<ProductImgDto> getProductImgDtoList() {
        return productImgDtoList;
    }

    public void setProductImgDtoList(List<ProductImgDto> productImgDtoList) {
        this.productImgDtoList = productImgDtoList;
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

    public String getProductImgPath() {
        return productImgPath;
    }

    public void setProductImgPath(String productImgPath) {
        this.productImgPath = productImgPath;
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

    public Double getProductReviewScore() {
        return productReviewScore;
    }

    public void setProductReviewScore(Double productReviewScore) {
        this.productReviewScore = productReviewScore;
    }

    @Override
    public String toString() {
        return "ProductDto{" +
                "reviewDtoList=" + reviewDtoList +
                ", productImgDtoList=" + productImgDtoList +
                ", productNo=" + productNo +
                ", productCategory='" + productCategory + '\'' +
                ", productName='" + productName + '\'' +
                ", productImgPath='" + productImgPath + '\'' +
                ", productPrice=" + productPrice +
                ", productStock=" + productStock +
                ", productReviewScore=" + productReviewScore +
                '}';
    }
}
