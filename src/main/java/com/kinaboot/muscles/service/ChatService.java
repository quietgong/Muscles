package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.ChatDto;

import java.util.List;

public interface ChatService {
    int saveChat(ChatDto chatDto);

    List<ChatDto> getChat(String chatName);
}
