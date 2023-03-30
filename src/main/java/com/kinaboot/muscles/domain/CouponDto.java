package com.kinaboot.muscles.domain;

public class CouponDto {
    int couponNo;
    String couponName;
    String couponCode;
    String userId;
    int discount;
    String status;

    public CouponDto() {
    }

    public CouponDto(String couponName, String couponCode, String userId, int discount, String status) {
        this.couponName = couponName;
        this.couponCode = couponCode;
        this.userId = userId;
        this.discount = discount;
        this.status = status;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "CouponDto{" +
                "couponNo=" + couponNo +
                ", couponName='" + couponName + '\'' +
                ", couponCode='" + couponCode + '\'' +
                ", userId='" + userId + '\'' +
                ", discount=" + discount +
                ", status='" + status + '\'' +
                '}';
    }
}
