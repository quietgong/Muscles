package com.kinaboot.muscles.domain;

public class ReviewImgDto {
    private Integer reviewImgNo;
    private Integer reviewNo;
    private Integer goodsNo;
    private String uploadPath;
    private String uploadName;

    public Integer getReviewImgNo() {
        return reviewImgNo;
    }

    public void setReviewImgNo(Integer reviewImgNo) {
        this.reviewImgNo = reviewImgNo;
    }

    public Integer getReviewNo() {
        return reviewNo;
    }

    public void setReviewNo(Integer reviewNo) {
        this.reviewNo = reviewNo;
    }

    public String getUploadPath() {
        return uploadPath;
    }

    public void setUploadPath(String uploadPath) {
        this.uploadPath = uploadPath;
    }

    public String getUploadName() {
        return uploadName;
    }

    public void setUploadName(String uploadName) {
        this.uploadName = uploadName;
    }

    public Integer getGoodsNo() {
        return goodsNo;
    }

    public void setGoodsNo(Integer goodsNo) {
        this.goodsNo = goodsNo;
    }

    @Override
    public String toString() {
        return "ReviewImgDto{" +
                "reviewImgNo=" + reviewImgNo +
                ", reviewNo=" + reviewNo +
                ", goodsNo=" + goodsNo +
                ", uploadPath='" + uploadPath + '\'' +
                ", uploadName='" + uploadName + '\'' +
                '}';
    }
}
