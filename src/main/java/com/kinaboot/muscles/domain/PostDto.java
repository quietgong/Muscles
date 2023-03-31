package com.kinaboot.muscles.domain;

import java.util.Date;

public class PostDto {
    private Integer postNo;
    private String type;
    private String title;
    private String content;
    private String userId;
    private Date createdDate;
    private Date modDate;

    private Integer viewCnt;


    public PostDto() {

    }

    public PostDto(String type, String title, String content, String userId) {
        this.type = type;
        this.title = title;
        this.content = content;
        this.userId = userId;
    }

    public Integer getPostNo() {
        return postNo;
    }

    public void setPostNo(Integer postNo) {
        this.postNo = postNo;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Integer getViewCnt() {
        return viewCnt;
    }

    public void setViewCnt(Integer viewCnt) {
        this.viewCnt = viewCnt;
    }

    @Override
    public String toString() {
        return "PostDto{" +
                "postNo=" + postNo +
                ", type='" + type + '\'' +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", userId='" + userId + '\'' +
                ", createdDate=" + createdDate +
                ", modDate=" + modDate +
                ", viewCnt=" + viewCnt +
                '}';
    }
}
