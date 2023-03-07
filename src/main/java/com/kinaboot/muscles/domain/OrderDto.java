package com.kinaboot.muscles.domain;

import java.util.Date;

public class OrderDto {
    private int orderNo;
    private int bundleNo;
    private String userId;
    private int productNo;
    private int productQty;
    private String productName;
    private int productPrice;

    @Override
    public String toString() {
        return "OrderDto{" +
                "orderNo=" + orderNo +
                ", bundleNo=" + bundleNo +
                ", userId='" + userId + '\'' +
                ", productNo=" + productNo +
                ", productQty=" + productQty +
                ", productName='" + productName + '\'' +
                ", productPrice=" + productPrice +
                ", status='" + status + '\'' +
                ", createdDate=" + createdDate +
                '}';
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

    private String status;
    private Date createdDate;

    public OrderDto() {
    }

    public OrderDto(String userId, int productNo, int productQty) {
        this.userId = userId;
        this.productNo = productNo;
        this.productQty = productQty;
    }

    public int getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
    }

    public int getBundleNo() {
        return bundleNo;
    }

    public void setBundleNo(int bundleNo) {
        this.bundleNo = bundleNo;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getProductNo() {
        return productNo;
    }

    public void setProductNo(int productNo) {
        this.productNo = productNo;
    }

    public int getProductQty() {
        return productQty;
    }

    public void setProductQty(int productQty) {
        this.productQty = productQty;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

}
