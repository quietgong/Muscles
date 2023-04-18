package com.kinaboot.muscles.domain;

public class PostImgDto {
    private Integer postImgNo;
    private Integer postNo;
    private String uploadPath;
    private String uploadName;

    public Integer getPostImgNo() {
        return postImgNo;
    }

    public void setPostImgNo(Integer postImgNo) {
        this.postImgNo = postImgNo;
    }

    public Integer getPostNo() {
        return postNo;
    }

    public void setPostNo(Integer postNo) {
        this.postNo = postNo;
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
        return "postImgDto{" +
                "postImgNo=" + postImgNo +
                ", postNo=" + postNo +
                ", uploadPath='" + uploadPath + '\'' +
                ", uploadName='" + uploadName + '\'' +
                '}';
    }
}
