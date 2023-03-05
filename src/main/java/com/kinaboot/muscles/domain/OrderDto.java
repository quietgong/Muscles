package com.kinaboot.muscles.domain;

import java.util.Date;

public class OrderDto {
    private DeliveryDto deliveryDto;
    private PaymentDto paymentDto;
    private int orderNo;
    private int bundleNo;
    private String userId;
    private int productNo;
    private int productQty;
    private String status;
    private Date createdDate;

    public OrderDto() {
    }

    public DeliveryDto getDeliveryDto() {
        return deliveryDto;
    }

    public void setDeliveryDto(DeliveryDto deliveryDto) {
        this.deliveryDto = deliveryDto;
    }

    public PaymentDto getPaymentDto() {
        return paymentDto;
    }

    public void setPaymentDto(PaymentDto paymentDto) {
        this.paymentDto = paymentDto;
    }

    public OrderDto(String userId, int productNo, int productQty, String status) {
        this.userId = userId;
        this.productNo = productNo;
        this.productQty = productQty;
        this.status = status;
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

    @Override
    public String toString() {
        return "OrderDto{" +
                "orderNo=" + orderNo +
                ", bundleNo=" + bundleNo +
                ", userId='" + userId + '\'' +
                ", productNo=" + productNo +
                ", productQty=" + productQty +
                ", status='" + status + '\'' +
                ", createdDate=" + createdDate +
                '}';
    }
}
