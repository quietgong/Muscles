package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.PageHandler;
import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.domain.SearchCondition;
import com.kinaboot.muscles.service.PostSerivce;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping({"/community", "/notice"})
public class PostController {
    @Autowired
    PostSerivce postSerivce;

    private String parsingURL(HttpServletRequest request) {
        return request.getRequestURI().split("/")[2];
    }

    // 글 목록
    @GetMapping("")
    public String list(SearchCondition sc, HttpSession session, HttpServletRequest request, Model m) throws Exception {
        String postCategory = parsingURL(request);
        if (session.getAttribute("id") == null)
            return "redirect:/login?toURL=" + request.getRequestURL();
        sc.setType(postCategory);

        int totalCnt = postSerivce.getCountBySearch(sc);
        m.addAttribute("postCategory", postCategory);
        m.addAttribute("totalCnt", totalCnt);
        m.addAttribute("ph", new PageHandler(totalCnt, sc));
        m.addAttribute("list", postSerivce.getListBySearch(sc));
        return "boardList";
    }

    // 글쓰기 페이지
    @PostMapping("/add")
    public String postForm(HttpServletRequest request, Model m) {
        m.addAttribute("postCategory", parsingURL(request));
        return "boardForm";
    }

    // 글쓰기
    @PostMapping("")
    public String post(PostDto postDto, String postCategory, HttpSession session) throws Exception {
        postDto.setUserId((String) session.getAttribute("id"));
        postSerivce.write(postDto, postCategory);
        return "redirect:/" + postCategory;
    }

    // 글읽기
    @GetMapping("/{postNo}")
    public String read(@PathVariable Integer postNo, Integer page, HttpServletRequest request, Model m) throws Exception {
        m.addAttribute("postDto", postSerivce.read(postNo));
        m.addAttribute(page);
        m.addAttribute("postCategory", parsingURL(request));
        return "board";
    }

    // 글 삭제
    @DeleteMapping("/{postNo}")
    @ResponseBody
    public ResponseEntity<String> remove(@PathVariable Integer postNo) throws Exception {
        postSerivce.remove(postNo);
        return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
    }

    // 글 수정
    @PatchMapping("/{postNo}")
    @ResponseBody
    public ResponseEntity<String> modify(@RequestBody PostDto postDto) throws Exception {
        postSerivce.modify(postDto);
        return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
    }
}
