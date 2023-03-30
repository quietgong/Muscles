package com.kinaboot.muscles.domain;

public class PointDto {
    int pointNo;
    String pointName;
    String userId;
    int point;

    public PointDto() {
    }

    public PointDto(String pointName, String userId, int point) {
        this.pointName = pointName;
        this.userId = userId;
        this.point = point;
    }

    public int getPointNo() {
        return pointNo;
    }

    public void setPointNo(int pointNo) {
        this.pointNo = pointNo;
    }

    public String getPointName() {
        return pointName;
    }

    public void setPointName(String pointName) {
        this.pointName = pointName;
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

    @Override
    public String toString() {
        return "PointDto{" +
                "pointNo=" + pointNo +
                ", pointName='" + pointName + '\'' +
                ", userId='" + userId + '\'' +
                ", point=" + point +
                '}';
    }
}
