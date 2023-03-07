package com.kinaboot.muscles.domain;

public class PaymentDto {
    private int orderNo;
    private int paymentNo;

    @Override
    public String toString() {
        return "PaymentDto{" +
                "orderNo=" + orderNo +
                ", paymentNo=" + paymentNo +
                ", price=" + price +
                ", type='" + type + '\'' +
                '}';
    }

    public int getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
    }

    private int price;
    private String type;

    public PaymentDto() {
    }

    public PaymentDto(int price, String type) {
        this.price = price;
        this.type = type;
    }

    public int getPaymentNo() {
        return paymentNo;
    }

    public void setPaymentNo(int paymentNo) {
        this.paymentNo = paymentNo;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

}
