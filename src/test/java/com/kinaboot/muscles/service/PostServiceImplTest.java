package com.kinaboot.muscles.service;

import com.kinaboot.muscles.TestConfigure;
import com.kinaboot.muscles.dao.CommentDao;
import com.kinaboot.muscles.dao.PostDao;
import com.kinaboot.muscles.domain.CommentDto;
import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.domain.PostImgDto;
import com.kinaboot.muscles.handler.SearchCondition;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.parameters.P;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.Assert.assertEquals;

public class PostServiceImplTest extends TestConfigure {
    @Autowired
    PostDao postDao;

    @Autowired
    CommentDao commentDao;

    @Before
    public void setUp() throws Exception {
        postDao.deletePostImgs(1);
        postDao.deleteAll();
        PostDto postDto = new PostDto(1, "community", "title", "content", "test", 0, null, null, null, null);
        List<PostImgDto> postImgDtoList = new ArrayList<>();
        postImgDtoList.add(new PostImgDto(1, 1, "upload1", null, "community"));
        postImgDtoList.add(new PostImgDto(1, 1, "upload2", null, "community"));
        postDto.setPostImgDtoList(postImgDtoList);
        postDao.insert(postDto);
        for(PostImgDto postImgDto : postImgDtoList)
            postDao.insertPostImg(postImgDto);
    }

    @Test
    public void 글찾기() throws Exception {
        int postNo = 1;
        postDao.increaseViewCnt(postNo); // postNo의 조회수를 증가시킨다.
        PostDto postDto = postDao.select(postNo); // postNo에 해당하는 데이터 읽기
        assertEquals(Optional.ofNullable(postDto.getViewCnt()), Optional.ofNullable(1));
        postDto.setPostImgDtoList(postDao.selectPostImg(postDto.getPostNo()));
        assertEquals(postDto.getTitle(), "title");
        assertEquals(postDto.getContent(), "content");
        assertEquals(postDto.getPostImgDtoList().size(), 2);
    }

    @Test
    public void 글수정() throws Exception {
        int postNo = 1;
        PostDto postDto = postDao.select(postNo);
        postDao.deletePostImgs(postNo);

        List<PostImgDto> postImgDtoList = new ArrayList<>();
        postImgDtoList.add(new PostImgDto(1, 1, "upload100", null, "community"));
        for (PostImgDto postImgDto : postImgDtoList)
            postDao.insertPostImg(postImgDto);

        postDto.setTitle("modified_title");
        postDto.setContent("modified_content");
        postDao.update(postDto);
        PostDto modifiedPostDto = postDao.select(postNo);
        assertEquals(modifiedPostDto.getTitle(),"modified_title");
        assertEquals(modifiedPostDto.getContent(),"modified_content");
        assertEquals(postDao.selectPostImg(1).get(0).getUploadPath(),"upload100");
    }


    @Test
    public void 글삭제() throws Exception {
        int postNo = 1;
        postDao.deletePostImgs(postNo);
        commentDao.deletePost(postNo);
        postDao.delete(postNo);
    }
}