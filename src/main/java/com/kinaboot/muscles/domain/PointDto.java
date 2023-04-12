package com.kinaboot.muscles.domain;

public class PointDto {
    int pointNo;
    int orderNo;
    String userId;
    int point;

    public PointDto() {
    }

    public PointDto(String userId, int orderNo, int point) {
        this.userId = userId;
        this.orderNo = orderNo;
        this.point = point;
    }

    public int getPointNo() {
        return pointNo;
    }

    public void setPointNo(int pointNo) {
        this.pointNo = pointNo;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public int getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
    }

    @Override
    public String toString() {
        return "PointDto{" +
                "pointNo=" + pointNo +
                ", orderNo=" + orderNo +
                ", userId='" + userId + '\'' +
                ", point=" + point +
                '}';
    }
}
