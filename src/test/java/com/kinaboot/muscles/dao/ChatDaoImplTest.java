package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.domain.ChatDto;
import com.kinaboot.muscles.service.ChatService;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.List;

public class ChatDaoImplTest extends TestConfigure {
    @Autowired
    private SqlSession session;

    private static String namespace = "com.kinaboot.muscles.dao.chatMapper.";

    @Autowired
    ChatService chatService;

    @Test
    public void chatSaveTest() {
        ChatDto chatDto = new ChatDto("test9", "test9", "sdf");
        chatService.saveChat(chatDto);
    }
    @Test
    public void chatLoadTest() {
        List<ChatDto> chatDtoList = chatService.findChat("test9");
        System.out.println("chatDtoList = " + chatDtoList);
    }
    @Test
    public void selectLastMsgDate() {
        String chatName = "test9";
        session.selectOne(namespace + "selectLastMsgDate", chatName);
    }

    @Test
    public void selectNewMsgCnt() {
        String chatName = "test9";
        session.selectOne(namespace + "selectNewMsgCnt", chatName);
    }
}
