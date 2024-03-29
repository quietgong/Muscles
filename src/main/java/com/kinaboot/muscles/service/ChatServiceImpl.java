package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.ChatDao;
import com.kinaboot.muscles.domain.ChatDto;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ChatServiceImpl implements ChatService{
    private final ChatDao chatDao;
    public ChatServiceImpl(ChatDao chatDao) {
        this.chatDao = chatDao;
    }

    @Override
    public int saveChat(ChatDto chatDto) {
        return chatDao.insertChat(chatDto);
    }

    @Override
    public List<ChatDto> findChat(String chatName) {
        return chatDao.selectChat(chatName);
    }

    @Override
    public Date findChatLastMsgDate(String chatName) {
        return chatDao.selectLastMsgDate(chatName);
    }

    @Override
    public int findChatNewMsgDate(String chatName) {
        return chatDao.selectNewMsgCnt(chatName);
    }
}
