package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.PostDto;
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
@RequestMapping("/notice")
public class NoticeController {
    @Autowired
    PostSerivce postSerivce;

    @GetMapping("/list")
    public String list(HttpSession session, HttpServletRequest request, Model m) throws Exception {
        if (session.getAttribute("id") == null)
            return "redirect:/login?toURL=" + request.getRequestURL();

        List<PostDto> list = postSerivce.getList("notice");
        System.out.println("list = " + list);
        m.addAttribute("list", list);
        return "boardList";
    }

//    @PostMapping("/remove")
//    public String remove(Integer postNo, HttpSession session) throws Exception {
//        String userId = (String) session.getAttribute("id");
//        System.out.println("postNo = " + postNo);
//        System.out.println("userId = " + userId);
//        postSerivce.remove(postNo, userId);
//
//        return "redirect:/board/list";
//    }
//    @GetMapping("/read")
//    public String read(Integer postNo, Model m, Integer page, Integer pageSize) throws Exception {
//        PostDto postDto = postSerivce.read(postNo);
//        m.addAttribute(postDto);
//        m.addAttribute(page);
//        m.addAttribute(pageSize);
//
//        return "board";
//    }
//
//    @GetMapping("/write")
//    public String writeForm() throws Exception {
//        return "boardForm";
//    }
//
//    @PostMapping("/write")
//    public String write(PostDto postDto, HttpSession session) throws Exception {
//        String userId = (String) session.getAttribute("id");
//        postDto.setUserId(userId);
//
//        System.out.println("postDto = " + postDto);
//        postSerivce.write(postDto);
//        return "redirect:/board/list";
//    }
//    @PostMapping("/modify")
//    public String modify(PostDto postDto, HttpSession session) throws Exception {
//        String userId = (String) session.getAttribute("id");
//        postDto.setUserId(userId);
//        System.out.println("postDto = " + postDto);
//        postSerivce.modify(postDto);
//        return "redirect:/board/read?postNo="+postDto.getBno();
//    }

}
