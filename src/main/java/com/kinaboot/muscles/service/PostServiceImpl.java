package com.kinaboot.muscles.service;

import com.kinaboot.muscles.dao.CommentDao;
import com.kinaboot.muscles.dao.PostDao;
import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.domain.PostImgDto;
import com.kinaboot.muscles.domain.ReviewDto;
import com.kinaboot.muscles.domain.ReviewImgDto;
import com.kinaboot.muscles.handler.SearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.parameters.P;
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
        postDto.setPostImgDtoList(postDao.selectPostImg(postDto.getPostNo()));
        postDao.increaseViewCnt(postNo); // postNo의 조회수를 증가시킨다.
        return postDto;
    }

    @Override
    public int addPost(PostDto postDto) throws Exception {
        List<PostImgDto> postImgDtoList = postDto.getPostImgDtoList();
        int postNo = postDao.selectPostNo();
        for(PostImgDto postImgDto : postImgDtoList) {
            postImgDto.setType(postDto.getType());
            postImgDto.setPostNo(postNo);
            postDao.insertPostImg(postImgDto);
        }
        postDao.insert(postDto);
        return postNo;
    }

    @Override
    public Integer countPost(SearchCondition sc) throws Exception {
        return postDao.searchResultCnt(sc);
    }

    @Override
    public int modifyPost(PostDto postDto) throws Exception {
        savePostImgs(postDto);
        return postDao.update(postDto);
    }
    private void savePostImgs(PostDto postDto) {
        postDao.deletePostImgs(postDto.getPostNo());
        List<PostImgDto> postImgDtoList = postDto.getPostImgDtoList();
        for(PostImgDto postImgDto : postImgDtoList){
            postDao.insertPostImg(postImgDto);
        }
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
        postDao.deletePostImgs(postNo);
        commentDao.deletePost(postNo);
        return postDao.delete(postNo);
    }
    @Override
    public int removePost(String userId) throws Exception {
        return postDao.delete(userId);
    }

    @Override
    public int removePostImg(String imgPath) {
        return postDao.deletePostImg(imgPath);
    }
}
