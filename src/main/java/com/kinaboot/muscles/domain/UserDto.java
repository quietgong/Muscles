package com.kinaboot.muscles.domain;

import java.util.Date;

public class UserDto {
    private String id;
    private String password;
    private String email;
    private String phone;
    private String address;
    private int point;
    private Date birth;
    private Date created_date;
    private Date expired_date;

    public UserDto() {
    }

    public UserDto(String id, String password, Date birth, String address) {
        this.id = id;
        this.password = password;
        this.address=address;
    }

    public UserDto(String id, String password, String email, String phone, String address, int point) {
        this.id = id;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.point = point;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public Date getCreated_date() {
        return created_date;
    }

    public void setCreated_date(Date created_date) {
        this.created_date = created_date;
    }

    public Date getExpired_date() {
        return expired_date;
    }

    public void setExpired_date(Date expired_date) {
        this.expired_date = expired_date;
    }

    @Override
    public String toString() {
        return "UserDto{" +
                "id='" + id + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", point=" + point +
                ", birth=" + birth +
                ", created_date=" + created_date +
                ", expired_date=" + expired_date +
                '}';
    }
}
