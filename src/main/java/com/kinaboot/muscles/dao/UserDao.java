package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.UserDto;
import org.springframework.stereotype.Repository;

import java.util.Map;

public interface UserDao {

    UserDto selectUser(String id);

    int insertUser(UserDto userDto);
    int deleteAll();

    int count();

    int updateUser(String[] userInfo);

    int deleteUser(String userId);

    int insertLeave(Map map);
}
