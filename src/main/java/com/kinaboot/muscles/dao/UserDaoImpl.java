package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.UserDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDaoImpl implements UserDao{
    @Autowired
    private SqlSession session;

    private static String namespace ="com.kinaboot.muscles.dao.userMapper.";

    @Override
    public int deleteAll(){
        return session.delete(namespace + "deleteAllUser");
    }
    @Override
    public int searchIdCnt(String id) {
        return session.selectOne(namespace+"searchIdCnt", id);
    }

    @Override
    public int count() {
        return session.selectOne(namespace + "count");
    }

    @Override
    public UserDto selectUser(String id) {
        return session.selectOne(namespace+"selectUser", id);
    }

    @Override
    public int insertUser(UserDto userDto) {
        return session.insert(namespace+"insertUser", userDto);
    }
}
