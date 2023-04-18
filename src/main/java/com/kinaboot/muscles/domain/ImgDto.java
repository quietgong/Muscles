package com.kinaboot.muscles.domain;

public class ImgDto {
    private Integer imgNo;
    private Integer no;
    private String uploadPath;
    private String uploadName;

    public ImgDto() {
    }

    public ImgDto(Integer no, String uploadPath, String uploadName) {
        this.no = no;
        this.uploadPath = uploadPath;
        this.uploadName = uploadName;
    }

    public Integer getImgNo() {
        return imgNo;
    }

    public void setImgNo(Integer imgNo) {
        this.imgNo = imgNo;
    }

    public Integer getNo() {
        return no;
    }

    public void setNo(Integer no) {
        this.no = no;
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

    @Override
    public String toString() {
        return "ImgDto{" +
                "imgNo=" + imgNo +
                ", no=" + no +
                ", uploadPath='" + uploadPath + '\'' +
                ", uploadName='" + uploadName + '\'' +
                '}';
    }
}
