package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.PageHandler;
import com.kinaboot.muscles.domain.PostDto;
import com.kinaboot.muscles.domain.SearchCondition;
import com.kinaboot.muscles.service.PostSerivce;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/community")
public class CommunityController {
    @Autowired
    PostSerivce postSerivce;

    @GetMapping("/list")
    public String list(SearchCondition sc, HttpSession session, HttpServletRequest request, Model m) throws Exception {
        if (session.getAttribute("id") == null)
            return "redirect:/login?toURL=" + request.getRequestURL();
        sc.setType("community");

        int totalCnt = postSerivce.getCountBySearch(sc);
        PageHandler ph = new PageHandler(totalCnt, sc);
        List<PostDto> list = postSerivce.getListBySearch(sc);

        m.addAttribute("totalCnt",totalCnt);
        m.addAttribute("ph",ph);
        m.addAttribute("list",list);
        return "boardList";
    }

    @GetMapping("/write")
    public String writeForm() throws Exception {
        return "boardForm";
    }

    @PostMapping("/write")
    public String write(PostDto postDto, HttpSession session) throws Exception {
        String userId = (String) session.getAttribute("id");
        postDto.setUserId(userId);
        postSerivce.write(postDto,"community");
        return "redirect:/community/list";
    }

    @GetMapping("/read")
    public String read(Integer page, Integer postNo, Model m) throws Exception {
        System.out.println("postNo = " + postNo);
        PostDto postDto = postSerivce.read(postNo);
        System.out.println("postDto = " + postDto);
        m.addAttribute(postDto);
        m.addAttribute(page);
        return "board";
    }

    @PostMapping("/remove")
    public String remove(Integer postNo, HttpSession session) throws Exception {
        String userId = (String) session.getAttribute("id");
        System.out.println("postNo = " + postNo);
        System.out.println("userId = " + userId);
        postSerivce.remove(postNo, userId);

        return "redirect:/community/list";
    }
    @PostMapping("/modify")
    public String modify(PostDto postDto, HttpSession session) throws Exception {
        String userId = (String) session.getAttribute("id");
        postDto.setUserId(userId);
        System.out.println("postDto = " + postDto);
        postSerivce.modify(postDto);
        return "redirect:/community/read?postNo="+postDto.getPostNo();
    }
}
