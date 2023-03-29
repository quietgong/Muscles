package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.ChatDto;
import com.kinaboot.muscles.service.ChatService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class ChatDaoImplTest {
    @Autowired
    ChatService chatService;

    @Test
    public void chatSaveTest() {
        ChatDto chatDto = new ChatDto("test9", "test9", "sdf");
        chatService.saveChat(chatDto);
    }
    @Test
    public void chatLoadTest() {
        List<ChatDto> chatDtoList = chatService.getChat("test9");
        System.out.println("chatDtoList = " + chatDtoList);
    }
}
