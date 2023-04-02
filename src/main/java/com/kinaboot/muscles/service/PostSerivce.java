package com.kinaboot.muscles.service;

import com.kinaboot.muscles.handler.PageHandler;
import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.handler.SearchCondition;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public interface PostSerivce {
    int getCount(String type) throws Exception;
    Integer getCountBySearch(SearchCondition sc) throws Exception;

    List<PostDto> getList(String type) throws Exception;

    PostDto read(Integer postNo) throws Exception;

    int write(PostDto postDto, String type) throws Exception;

    int modify(PostDto postDto) throws Exception;

    int remove(Integer postNo) throws Exception;

    List<PostDto> getListByPage(PageHandler ph) throws Exception;
    List<PostDto> getListBySearch(SearchCondition sc) throws Exception;
}
