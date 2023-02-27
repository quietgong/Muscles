package com.kinaboot.muscles.dao;

import com.kinaboot.muscles.domain.UserDto;
import org.springframework.stereotype.Repository;

public interface UserDao {

    UserDto selectUser(String id);

    int insertUser(UserDto userDto);
    int deleteAll();

    int count();
}
