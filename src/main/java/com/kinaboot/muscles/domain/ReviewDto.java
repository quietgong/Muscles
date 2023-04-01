package com.kinaboot.muscles.domain;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class ReviewDto {
    private int reviewNo;
    private int orderNo;
    private int score;
    private String content;
    private String userId;
    private int productNo;
    private String productName;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date createdDate;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date expiredDate;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date modDate;

    public ReviewDto() {
    }

    public ReviewDto(int productNo, int score, String content, String productName) {
        this.productNo = productNo;
        this.score = score;
        this.content = content;
        this.productName = productName;
    }

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }

    public int getReviewNo() {
        return reviewNo;
    }

    public void setReviewNo(int reviewNo) {
        this.reviewNo = reviewNo;
    }

    public int getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getProductNo() {
        return productNo;
    }

    public void setProductNo(int productNo) {
        this.productNo = productNo;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getModDate() {
        return modDate;
    }

    public void setModDate(Date modDate) {
        this.modDate = modDate;
    }

    @Override
    public String toString() {
        return "ReviewDto{" +
                "reviewNo=" + reviewNo +
                ", orderNo=" + orderNo +
                ", score=" + score +
                ", content='" + content + '\'' +
                ", userId='" + userId + '\'' +
                ", productNo=" + productNo +
                ", productName='" + productName + '\'' +
                ", createdDate=" + createdDate +
                ", expiredDate=" + expiredDate +
                ", modDate=" + modDate +
                '}';
    }
}
