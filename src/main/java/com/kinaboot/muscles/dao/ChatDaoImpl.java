package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.ChatDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ChatDaoImpl implements ChatDao{
    @Autowired
    private SqlSession session;
    private static String namespace = "com.kinaboot.muscles.dao.chatMapper.";

    @Override
    public int insertChat(ChatDto chatDto) {
        return session.insert(namespace + "insertChat", chatDto);
    }

    @Override
    public List<ChatDto> selectChat(String chatName) {
        return session.selectList(namespace + "selectChat", chatName);
    }
}