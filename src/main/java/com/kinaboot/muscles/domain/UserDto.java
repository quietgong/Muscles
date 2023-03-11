package com.kinaboot.muscles.domain;

import java.util.Date;

public class UserDto {
    private Integer userNo;
    private String userId;
    private String password;
    private String email;
    private String phone;
    private String address;
    private int point;
    private Date birth;
    private Date createdDate;
    private Date expiredDate;

    public UserDto() {
    }

    public UserDto(String userId, String password, String address) {
        this.userId = userId;
        this.password = password;
        this.address=address;
    }

    public UserDto(String userId, String password, String email, String phone, String address, int point) {
        this.userId = userId;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.point = point;
    }

    public UserDto(String userId, String password) {
        this.userId=userId;
        this.password=password;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public Date getBirth() {
        return birth;
    }

    public void setBirth(Date birth) {
        this.birth = birth;
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
                ", address='" + address + '\'' +
                ", point=" + point +
                ", birth=" + birth +
                ", createdDate=" + createdDate +
                ", expiredDate=" + expiredDate +
                '}';
    }
}
