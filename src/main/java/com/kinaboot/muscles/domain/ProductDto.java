package com.kinaboot.muscles.domain;

public class ProductDto {
    private String productNo;

    public String getProductNo() {
        return productNo;
    }

    public void setProductNo(String productNo) {
        this.productNo = productNo;
    }

    private String categoryName;
    private String productName;
    private int price;
    private int stock;

    public ProductDto() {
    }

    public ProductDto(String categoryName, String productName, int price, int stock) {
        this.categoryName = categoryName;
        this.productName = productName;
        this.price = price;
        this.stock = stock;
    }

    @Override
    public String toString() {
        return "ProductDto{" +
                "categoryName='" + categoryName + '\'' +
                ", productName='" + productName + '\'' +
                ", price=" + price +
                ", stock=" + stock +
                '}';
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }
}
