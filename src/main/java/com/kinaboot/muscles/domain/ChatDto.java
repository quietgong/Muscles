package com.kinaboot.muscles.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class ChatDto {
    String chatName;
    String talker;
    String msg;
    int newMsgCnt;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    Date createdDate;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    Date lastMsgDate;

    public ChatDto(String chatName, String talker, String msg) {
        this.chatName = chatName;
        this.talker = talker;
        this.msg = msg;
    }

    public ChatDto(String chatName, String talker, String msg, Date createdDate) {
        this.chatName = chatName;
        this.talker = talker;
        this.msg = msg;
        this.createdDate = createdDate;
    }
}
