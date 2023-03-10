package com.kinaboot.muscles.service;

import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.domain.UserDto;

import java.util.List;
import java.util.Map;

public interface UserService {
    List<UserDto> getList(Integer offset, Integer pageSize) throws Exception;

    UserDto read(String userId) throws Exception;

    int create(UserDto userDto) throws Exception;

    int modify(UserDto userDto) throws Exception;

    int removeUser(String userId) throws Exception;

    int modifyUserInfo(String[] userInfo);
    int modifyUserPassword(String userId, String newPassword);
    int leaveUser(Map map);
    List<UserDto> getAllUser();

    int createQuit(String userId);
}
