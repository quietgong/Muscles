package com.kinaboot.muscles.service;

import com.kinaboot.muscles.handler.PageHandler;
import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.handler.SearchCondition;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface PostSerivce {
    List<PostDto> findPosts(SearchCondition sc) throws Exception;

    List<PostDto> findPosts(String userId) throws Exception;

    Integer countPost(SearchCondition sc) throws Exception;

    PostDto findPost(Integer postNo) throws Exception;

    int addPost(PostDto postDto) throws Exception;

    int modifyPost(PostDto postDto) throws Exception;

    int removePost(Integer postNo) throws Exception;

    int removePost(String userId) throws Exception;

}
