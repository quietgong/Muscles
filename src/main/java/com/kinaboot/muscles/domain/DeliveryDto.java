package com.kinaboot.muscles.domain;

public class DeliveryDto {
    private int deliveryNo;
    private int orderNo;
    private String receiver;
    private String phone;
    private String address;
    private String message;

    @Override
    public String toString() {
        return "DeliveryDto{" +
                "orderNo=" + orderNo +
                ", deliveryNo=" + deliveryNo +
                ", receiver='" + receiver + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", message='" + message + '\'' +
                '}';
    }

    public int getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
    }


    public DeliveryDto(String receiver, String phone, String address, String message) {
        this.receiver = receiver;
        this.phone = phone;
        this.address = address;
        this.message = message;
    }

    public DeliveryDto() {
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
