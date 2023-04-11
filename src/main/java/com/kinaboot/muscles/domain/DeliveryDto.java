package com.kinaboot.muscles.domain;

public class DeliveryDto {
    private int deliveryNo;
    private int orderNo;
    private String receiver;
    private String phone;
    private String address1;
    private String address2;
    private String message;

    public int getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
    }


    public DeliveryDto() {
    }
    public DeliveryDto(String receiver, String phone, String address1,String address2, String message) {
        this.receiver = receiver;
        this.phone = phone;
        this.address1 = address1;
        this.address2 = address2;
        this.message = message;
    }


    public int getDeliveryNo() {
        return deliveryNo;
    }

    public void setDeliveryNo(int deliveryNo) {
        this.deliveryNo = deliveryNo;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress1() {
        return address1;
    }

    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    public String getAddress2() {
        return address2;
    }

    public void setAddress2(String address2) {
        this.address2 = address2;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @Override
    public String toString() {
        return "DeliveryDto{" +
                "deliveryNo=" + deliveryNo +
                ", orderNo=" + orderNo +
                ", receiver='" + receiver + '\'' +
                ", phone='" + phone + '\'' +
                ", address1='" + address1 + '\'' +
                ", address2='" + address2 + '\'' +
                ", message='" + message + '\'' +
                '}';
    }
}
