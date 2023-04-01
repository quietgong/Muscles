package com.kinaboot.muscles.domain;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class CommentDto {
    private Integer commentNo;
    private Integer postNo;
    private String userId;
    private String content;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date createdDate;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date modDate;

    public Integer getCommentNo() {
        return commentNo;
    }

    public CommentDto() {
    }

    public CommentDto(Integer postNo, String userId, String content) {
        this.postNo = postNo;
        this.userId = userId;
        this.content = content;
    }

    @Override
    public String toString() {
        return "CommentDto{" +
                "commentNo=" + commentNo +
                ", postNo=" + postNo +
                ", userId='" + userId + '\'' +
                ", content='" + content + '\'' +
                ", createdDate=" + createdDate +
                ", modDate=" + modDate +
                '}';
    }

    public void setCommentNo(Integer commentNo) {
        this.commentNo = commentNo;
    }

    public Integer getPostNo() {
        return postNo;
    }

    public void setPostNo(Integer postNo) {
        this.postNo = postNo;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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
}
