package com.kinaboot.muscles.domain;

public class CartDto {
    private int cartNo;
    private String userId;
    private String productName;
    private String productCategory;
    private int productNo;
    private int productPrice;
    private int productQty;

    public String getProductCategory() {
        return productCategory;
    }

    public void setProductCategory(String productCategory) {
        this.productCategory = productCategory;
    }

    public int getProductNo() {
        return productNo;
    }
    public void setProductNo(int productNo) {
        this.productNo = productNo;
    }


    public CartDto(int cartNo, String userId, String productName, int productPrice, int productQty) {
        this.cartNo = cartNo;
        this.userId = userId;
        this.productPrice = productPrice;
        this.productQty = productQty;
        this.productName = productName;
    }

    public CartDto(String productName, int productPrice, int productQty) {
        this.productName = productName;
        this.productPrice = productPrice;
        this.productQty = productQty;
    }

    public CartDto() {
    }

    @Override
    public String toString() {
        return "CartDto{" +
                "cartNo=" + cartNo +
                ", userId='" + userId + '\'' +
                ", productName='" + productName + '\'' +
                ", productNo=" + productNo +
                ", productPrice=" + productPrice +
                ", productQty=" + productQty +
                '}';
    }

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

    public int getProductQty() {
        return productQty;
    }

    public void setProductQty(int productQty) {
        this.productQty = productQty;
    }
}
