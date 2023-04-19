package com.kinaboot.muscles.domain;

public class PostImgDto {
    private Integer postImgNo;
    private Integer postNo;
    private String uploadPath;
    private String uploadName;
    private String type;

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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "PostImgDto{" +
                "postImgNo=" + postImgNo +
                ", postNo=" + postNo +
                ", uploadPath='" + uploadPath + '\'' +
                ", uploadName='" + uploadName + '\'' +
                ", type='" + type + '\'' +
                '}';
    }
}
