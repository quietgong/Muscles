package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.CommentDao;
import com.kinaboot.muscles.dao.PostDao;
import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.handler.SearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PostServiceImpl implements PostSerivce{
    @Autowired
    PostDao postDao;

    @Autowired
    CommentDao commentDao;

    @Override
    public PostDto findPost(Integer postNo) throws Exception {
        PostDto postDto = postDao.select(postNo); // postNo에 해당하는 데이터 읽기
        postDao.increaseViewCnt(postNo); // postNo의 조회수를 증가시킨다.
        return postDto;
    }

    @Override
    public int addPost(PostDto postDto, String type) throws Exception {
        return postDao.insert(postDto, type);
    }

    @Override
    public Integer countPost(SearchCondition sc) throws Exception {
        return postDao.searchResultCnt(sc);
    }

    @Override
    public int modifyPost(PostDto postDto) throws Exception {
        return postDao.update(postDto);
    }

    @Override
    public List<PostDto> findPosts(SearchCondition sc) throws Exception {
        List<PostDto> postDtoList = postDao.searchResult(sc);
        // 해당 게시물에 대한 댓글 리스트
        for(PostDto postDto : postDtoList)
            postDto.setCommentDtoList(commentDao.selectAll(postDto.getPostNo()));
        return postDtoList;
    }
    @Override
    public List<PostDto> findPosts(String userId, SearchCondition sc) {
        return postDao.searchResult(userId, sc);
    }

    @Override
    public List<PostDto> findPosts(String userId) throws Exception {
        List<PostDto> postDtoList = postDao.selectAllByUser(userId);
        // 해당 게시물에 대한 댓글 리스트
        for(PostDto postDto : postDtoList)
            postDto.setCommentDtoList(commentDao.selectAll(postDto.getPostNo()));
        return postDtoList;
    }

    @Override
    public int removePost(Integer postNo) throws Exception {
        commentDao.deletePost(postNo);
        return postDao.delete(postNo);
    }
    @Override
    public int removePost(String userId) throws Exception {
        return postDao.delete(userId);
    }

}
