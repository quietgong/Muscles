package com.kinaboot.muscles.domain;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;
import java.util.List;

public class OrderDto {
    private List<OrderItemDto> orderItemDtoList;
    private DeliveryDto deliveryDto;
    private PaymentDto paymentDto;
    private int orderNo;
    private String userId;
    private String status;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date createdDate;

    public OrderDto() {
    }

    public OrderDto(List<OrderItemDto> orderItemDtoList, DeliveryDto deliveryDto, PaymentDto paymentDto, String userId, String status) {
        this.orderItemDtoList = orderItemDtoList;
        this.deliveryDto = deliveryDto;
        this.paymentDto = paymentDto;
        this.userId = userId;
        this.status = status;
    }

    public List<OrderItemDto> getOrderItemDtoList() {
        return orderItemDtoList;
    }

    public void setOrderItemDtoList(List<OrderItemDto> orderItemDtoList) {
        this.orderItemDtoList = orderItemDtoList;
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

    public int getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
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
                "orderItemDtoList=" + orderItemDtoList +
                ", deliveryDto=" + deliveryDto +
                ", paymentDto=" + paymentDto +
                ", orderNo=" + orderNo +
                ", userId='" + userId + '\'' +
                ", status='" + status + '\'' +
                ", createdDate=" + createdDate +
                '}';
    }
}
