package com.kinaboot.muscles.domain;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;
import java.util.List;

public class ReviewDto {
    private int reviewNo;
    private int orderNo;
    private int score;
    private String content;
    private String userId;
    private int goodsNo;
    private String goodsName;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date createdDate;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date expiredDate;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date modDate;
    private List<ReviewImgDto> reviewImgDtoList;

    public ReviewDto() {
    }

    public ReviewDto(int goodsNo, int score, String content, String goodsName) {
        this.goodsNo = goodsNo;
        this.score = score;
        this.content = content;
        this.goodsName = goodsName;
    }


    public List<ReviewImgDto> getReviewImgDtoList() {
        return reviewImgDtoList;
    }

    public void setReviewImgDtoList(List<ReviewImgDto> reviewImgDtoList) {
        this.reviewImgDtoList = reviewImgDtoList;
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

    public int getGoodsNo() {
        return goodsNo;
    }

    public void setGoodsNo(int goodsNo) {
        this.goodsNo = goodsNo;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
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
                ", goodsNo=" + goodsNo +
                ", goodsName='" + goodsName + '\'' +
                ", createdDate=" + createdDate +
                ", expiredDate=" + expiredDate +
                ", modDate=" + modDate +
                ", reviewImgDtoList=" + reviewImgDtoList +
                '}';
    }
}
