package com.kinaboot.muscles.domain;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class ChatDto {
    String chatName;
    String talker;
    String msg;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    Date createdDate;

    int newMsgCnt;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    Date lastMsgDate;

    public ChatDto() {
    }

    public ChatDto(String chatName, String talker, String msg) {
        this.chatName = chatName;
        this.talker = talker;
        this.msg = msg;
    }

    public String getChatName() {
        return chatName;
    }

    public void setChatName(String chatName) {
        this.chatName = chatName;
    }

    public String getTalker() {
        return talker;
    }

    public void setTalker(String talker) {
        this.talker = talker;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public int getNewMsgCnt() {
        return newMsgCnt;
    }

    public void setNewMsgCnt(int newMsgCnt) {
        this.newMsgCnt = newMsgCnt;
    }

    public Date getLastMsgDate() {
        return lastMsgDate;
    }

    public void setLastMsgDate(Date lastMsgDate) {
        this.lastMsgDate = lastMsgDate;
    }

    @Override
    public String toString() {
        return "ChatDto{" +
                "chatName='" + chatName + '\'' +
                ", talker='" + talker + '\'' +
                ", msg='" + msg + '\'' +
                ", createdDate=" + createdDate +
                ", newMsgCnt=" + newMsgCnt +
                ", lastMsgDate=" + lastMsgDate +
                '}';
    }
}
