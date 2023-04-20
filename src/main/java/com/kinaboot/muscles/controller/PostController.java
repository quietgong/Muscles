package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.handler.PageHandler;
import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.handler.SearchCondition;
import com.kinaboot.muscles.service.PostSerivce;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Slf4j
@Controller
@RequestMapping({"/community", "/notice"})
public class PostController {

    @Autowired
    PostSerivce postSerivce;

    private String parsingURL(HttpServletRequest request) {
        return request.getRequestURI().split("/")[2];
    }

    @GetMapping("")
    public String postList(SearchCondition sc, HttpServletRequest request, Model m) throws Exception {
        log.info("글 목록 조회");
        String postCategory = parsingURL(request);
        sc.setType(postCategory);

        Integer totalCnt = postSerivce.countPost(sc);
        m.addAttribute("ph", new PageHandler(totalCnt, sc));
        m.addAttribute("list", postSerivce.findPosts(sc));
        return "board/boardList";
    }

    @GetMapping("/")
    public String postForm(HttpServletRequest request, Model m) {
        log.info("글작성 폼 진입 : 카테고리 : " + parsingURL(request));
        m.addAttribute("postCategory", parsingURL(request));
        return "board/boardForm";
    }

    @GetMapping("/{postNo}")
    public String postDetails(@PathVariable Integer postNo, Integer page, HttpServletRequest request, Model m) throws Exception {
        log.info("글읽기 진입");
        page = page == null ? 1 : page;
        m.addAttribute("postDto", postSerivce.findPost(postNo));
        m.addAttribute(page);
        m.addAttribute("postCategory", parsingURL(request));
        return "board/board";
    }

    @PostMapping("/")
    @ResponseBody
    public ResponseEntity<Integer> postAdd(@RequestBody PostDto postDto) throws Exception {
        log.info("글작성 완료");
        return new ResponseEntity<>(postSerivce.addPost(postDto), HttpStatus.OK);
    }

    @DeleteMapping("/{postNo}")
    @ResponseBody
    public ResponseEntity<String> postRemove(@PathVariable Integer postNo) throws Exception {
        postSerivce.removePost(postNo);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }

    @PatchMapping("/{postNo}")
    @ResponseBody
    public ResponseEntity<String> postModify(@RequestBody PostDto postDto) throws Exception {
        postSerivce.modifyPost(postDto);
        return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
    }
}
