package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.ChatDto;

import java.util.List;

public interface ChatDao {
    int insertChat(ChatDto chatDto);

    List<ChatDto> selectChat(String chatName);
}
