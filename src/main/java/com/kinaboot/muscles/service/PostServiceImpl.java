package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.PostDao;
import com.kinaboot.muscles.domain.PageHandler;
import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.domain.SearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PostServiceImpl implements PostSerivce{
    @Autowired
    PostDao postDao;

    @Override
    public int getCount(String type) throws Exception {
        return postDao.count(type);
    }

    @Override
    public List<PostDto> getList(String type) throws Exception {
        return postDao.selectAll(type);
    }

    @Override
    public PostDto read(Integer postNo) throws Exception {
        PostDto postDto = postDao.select(postNo); // postNo에 해당하는 데이터를 읽고
        postDao.increaseViewCnt(postNo); // postNo의 조회수를 증가시킨다.
        return postDto;
    }

    @Override
    public int write(PostDto postDto, String type) throws Exception {
        return postDao.insert(postDto, type);
    }

    @Override
    public int getCountBySearch(SearchCondition sc) throws Exception {
        return postDao.searchResultCnt(sc);
    }

    @Override
    public int modify(PostDto postDto) throws Exception {
        return postDao.update(postDto);
    }

    @Override
    public List<PostDto> getListBySearch(SearchCondition sc) throws Exception {
        return postDao.searchResult(sc);
    }

    @Override
    public int remove(Integer postNo, String userId) throws Exception {
        return postDao.delete(postNo, userId);
    }

    @Override
    public List<PostDto> getListByPage(PageHandler ph) throws Exception {
        return postDao.selectPage(ph);
    }
}
