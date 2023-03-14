package com.kinaboot.muscles.domain;

public class ProductImgDto {
    private Integer imgNo;
    private Integer productNo;
    private String uploadPath;
    private String uploadName;
    private String uuid;

    public ProductImgDto() {
    }

    public ProductImgDto(Integer productNo, String uploadPath, String uploadName, String uuid) {
        this.productNo = productNo;
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

    public Integer getProductNo() {
        return productNo;
    }

    public void setProductNo(Integer productNo) {
        this.productNo = productNo;
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
        return "ProductImgDto{" +
                "imgNo=" + imgNo +
                ", productNo=" + productNo +
                ", uploadPath='" + uploadPath + '\'' +
                ", uploadName='" + uploadName + '\'' +
                ", uuid='" + uuid + '\'' +
                '}';
    }
}
