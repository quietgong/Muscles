package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.UserDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class UserDaoImpl implements UserDao{
    @Autowired
    private SqlSession session;

    @Override
    public List<UserDto> selectAllUser() {
        return session.selectList(namespace + "selectAllUser");
    }

    private static String namespace ="com.kinaboot.muscles.dao.userMapper.";

    @Override
    public int updateUserPassword(String userId, String newPassword) {
        Map map = new HashMap();
        map.put("userId", userId);
        map.put("newPassword", newPassword);
        return session.update(namespace + "updateUserPassword", map);
    }

    @Override
    public int insertLeave(Map map) {
        for(Object key : map.keySet()) {
            String value = (String) map.get(key);
            System.out.println(key + " : " + value);
        }
        return session.insert(namespace + "insertLeave", map);
    }

    @Override
    public int insertQuit(String userId) {
        Map map = new HashMap();
        map.put("userId", userId);
        map.put("opinion", "운영자에 의한 탈퇴처리");
        return session.insert(namespace+"insertQuitByAdmin", map);
    }

    @Override
    public int updateUser(String[] userInfo) {
        Map map = new HashMap();
        map.put("userId", userInfo[0]);
        map.put("userEmail", userInfo[1]);
        map.put("userPhone", userInfo[2]);
        return session.update(namespace+"updateUser",map);
    }

    @Override
    public int deleteUser(String userId) {
        return session.delete(namespace + "deleteUser", userId);
    }

    @Override
    public int deleteAll(){
        return session.delete(namespace + "deleteAllUser");
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
