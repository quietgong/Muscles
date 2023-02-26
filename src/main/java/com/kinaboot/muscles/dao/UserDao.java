package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.UserDto;

public interface UserDao {

    int searchIdCnt(String id);
    UserDto selectUser(String id);

    int insertUser(UserDto userDto);
    int deleteAll();

    int count();
}
