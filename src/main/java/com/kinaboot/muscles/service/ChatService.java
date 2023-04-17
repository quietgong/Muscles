package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.ChatDto;

import java.util.Date;
import java.util.List;

public interface ChatService {
    int saveChat(ChatDto chatDto);

    List<ChatDto> findChat(String chatName);

    Date findChatLastMsgDate(String chatName);

    int findChatNewMsgDate(String chatName);
}
