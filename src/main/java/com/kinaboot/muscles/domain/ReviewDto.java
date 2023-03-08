package com.kinaboot.muscles.domain;

import java.util.Date;

public class ReviewDto {
    private Integer reviewNo;
    private Integer score;
    private String content;
    private String userId;
    private Integer productNo;
    private String productName;
    private Date createdDate;
    private Date modDate;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Integer getProductNo() {
        return productNo;
    }

    public void setProductNo(Integer productNo) {
        this.productNo = productNo;
    }


    public ReviewDto() {
    }
    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public ReviewDto(Integer score, String content, String productName) {
        this.score=score;
        this.content = content;
        this.productName = productName;
    }

    public Integer getReviewNo() {
        return reviewNo;
    }

    public void setReviewNo(Integer reviewNo) {
        this.reviewNo = reviewNo;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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
                ", score=" + score +
                ", content='" + content + '\'' +
                ", userId='" + userId + '\'' +
                ", productNo=" + productNo +
                ", productName='" + productName + '\'' +
                ", createdDate=" + createdDate +
                ", modDate=" + modDate +
                '}';
    }
}
