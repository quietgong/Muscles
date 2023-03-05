package com.kinaboot.muscles.domain;
/*
* PAYMENT_NO int PK
BUNDLE_NO int
PRICE int
TYPE varchar(100)
* */
public class PaymentDto {
    private int paymentNo;
    private int bundleNo;
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

    public int getBundleNo() {
        return bundleNo;
    }

    public void setBundleNo(int bundleNo) {
        this.bundleNo = bundleNo;
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

    @Override
    public String toString() {
        return "PaymentDto{" +
                "paymentNo=" + paymentNo +
                ", bundleNo=" + bundleNo +
                ", price=" + price +
                ", type='" + type + '\'' +
                '}';
    }
}
