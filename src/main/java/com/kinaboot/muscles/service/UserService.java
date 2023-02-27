package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.domain.UserDto;

import java.util.List;

public interface UserService {
    List<UserDto> getList(Integer offset, Integer pageSize) throws Exception;

    UserDto read(Integer u) throws Exception;

    int create(UserDto userDto) throws Exception;

    int modify(UserDto userDto) throws Exception;

    int remove(String id) throws Exception;
}
