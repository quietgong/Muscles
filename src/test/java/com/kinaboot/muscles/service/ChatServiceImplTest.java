package com.kinaboot.muscles.service;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.dao.ChatDao;
import com.kinaboot.muscles.domain.ChatDto;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import static org.junit.Assert.*;

public class ChatServiceImplTest extends TestConfigure {
    @Autowired
    ChatDao chatDao;

    private String chatName = "test";
    @Test
    public void saveChat() {
        deleteAllChat();

        ChatDto chatDto1 = new ChatDto("test","test","MSG");
        ChatDto chatDto2 = new ChatDto("test","system","상담종료");
        ChatDto chatDto3 = new ChatDto("test","test","MSG");
        ChatDto chatDto4 = new ChatDto("test","test","MSG");

        chatDao.insertChat(chatDto1);
        chatDao.insertChat(chatDto2);
        chatDao.insertChat(chatDto3);
        chatDao.insertChat(chatDto4);
    }

    @Test
    public void findChat() {
        List<ChatDto> chatDtoList = chatDao.selectChat(chatName);
        assertEquals(chatDtoList.size(), 4);
    }

    public void deleteAllChat(){
        chatDao.deleteAll();
    }
}