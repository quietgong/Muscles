package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.ChatDao;
import com.kinaboot.muscles.domain.ChatDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ChatServiceImpl implements ChatService{
    @Autowired
    ChatDao chatDao;
    @Override
    public int saveChat(ChatDto chatDto) {
        return chatDao.insertChat(chatDto);
    }

    @Override
    public List<ChatDto> getChat(String chatName) {
        return chatDao.selectChat(chatName);
    }
}
