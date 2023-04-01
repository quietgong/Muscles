package com.kinaboot.muscles.domain;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class FaqDto {
    private Integer faqNo;
    private String userId;
    private Integer productNo;
    private String question;
    private String answer;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date createdDate;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date replyDate;

    public Integer getFaqNo() {
        return faqNo;
    }

    public void setFaqNo(Integer faqNo) {
        this.faqNo = faqNo;
    }

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

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getReplyDate() {
        return replyDate;
    }

    public void setReplyDate(Date replyDate) {
        this.replyDate = replyDate;
    }

    @Override
    public String toString() {
        return "FaqDto{" +
                "faqNo=" + faqNo +
                ", userId='" + userId + '\'' +
                ", productNo=" + productNo +
                ", question='" + question + '\'' +
                ", answer='" + answer + '\'' +
                ", createdDate=" + createdDate +
                ", replyDate=" + replyDate +
                '}';
    }
}
