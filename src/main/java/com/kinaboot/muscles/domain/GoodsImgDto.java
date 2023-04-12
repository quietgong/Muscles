package com.kinaboot.muscles.domain;

public class GoodsImgDto {
    private Integer imgNo;
    private Integer goodsNo;
    private String uploadPath;
    private String uploadName;
    private String uuid;

    public GoodsImgDto() {
    }

    public GoodsImgDto(Integer goodsNo, String uploadPath, String uploadName, String uuid) {
        this.goodsNo = goodsNo;
        this.uploadPath = uploadPath;
        this.uploadName = uploadName;
        this.uuid = uuid;
    }

    public Integer getImgNo() {
        return imgNo;
    }

    public void setImgNo(Integer imgNo) {
        this.imgNo = imgNo;
    }

    public Integer getGoodsNo() {
        return goodsNo;
    }

    public void setGoodsNo(Integer goodsNo) {
        this.goodsNo = goodsNo;
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

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    @Override
    public String toString() {
        return "goodsImgDto{" +
                "imgNo=" + imgNo +
                ", goodsNo=" + goodsNo +
                ", uploadPath='" + uploadPath + '\'' +
                ", uploadName='" + uploadName + '\'' +
                ", uuid='" + uuid + '\'' +
                '}';
    }
}
