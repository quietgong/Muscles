package com.kinaboot.muscles.domain;

public class CouponDto {
    int couponNo;
    String couponName;
    String couponCode;
    String userId;
    int discount;
    int orderNo;

    public CouponDto() {
    }

    public CouponDto(String couponName, String couponCode, String userId, int discount, String status) {
        this.couponName = couponName;
        this.couponCode = couponCode;
        this.userId = userId;
        this.discount = discount;
        this.orderNo = orderNo;
    }

    public int getCouponNo() {
        return couponNo;
    }

    public void setCouponNo(int couponNo) {
        this.couponNo = couponNo;
    }

    public String getCouponName() {
        return couponName;
    }

    public void setCouponName(String couponName) {
        this.couponName = couponName;
    }

    public String getCouponCode() {
        return couponCode;
    }

    public void setCouponCode(String couponCode) {
        this.couponCode = couponCode;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public int getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
    }

    @Override
    public String toString() {
        return "CouponDto{" +
                "couponNo=" + couponNo +
                ", couponName='" + couponName + '\'' +
                ", couponCode='" + couponCode + '\'' +
                ", userId='" + userId + '\'' +
                ", discount=" + discount +
                ", orderNo='" + orderNo + '\'' +
                '}';
    }
}
