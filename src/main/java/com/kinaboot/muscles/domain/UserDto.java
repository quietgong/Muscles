package com.kinaboot.muscles.domain;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class UserDto {
    private Integer userNo;
    private String userId;
    private String password;
    private String email;
    private String phone;
    private String address1;
    private String address2;
    private int point;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date createdDate;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date expiredDate;

    public UserDto() {
    }

    public UserDto(String userId, String password, String address1) {
        this.userId = userId;
        this.password = password;
        this.address1 = address1;
    }

    public UserDto(String userId, String password, String email, String phone, String address1, String address2, int point) {
        this.userId = userId;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.address1 = address1;
        this.address2 = address2;
        this.point = point;
    }

    public UserDto(String userId, String password) {
        this.userId = userId;
        this.password = password;
    }

    public Integer getUserNo() {
        return userNo;
    }

    public void setUserNo(Integer userNo) {
        this.userNo = userNo;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }

    @Override
    public String toString() {
        return "UserDto{" +
                "userNo=" + userNo +
                ", userId='" + userId + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", address1='" + address1 + '\'' +
                ", address2='" + address2 + '\'' +
                ", point=" + point +
                ", createdDate=" + createdDate +
                ", expiredDate=" + expiredDate +
                '}';
    }
}
