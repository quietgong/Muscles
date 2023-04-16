package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.ChatDto;
import com.kinaboot.muscles.service.ChatService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Controller
public class ChattingController {
    private static final Logger logger = LoggerFactory.getLogger(ChattingController.class);

    @Autowired
    ChatService chatService;

    List<ChatDto> chatDtoList = new ArrayList<>();

    @PostMapping("/chat/post")
    @ResponseBody
    public ResponseEntity<String> chatAdd(ChatDto chatDto) {
        chatService.saveChat(chatDto);
        return new ResponseEntity<>("OK", HttpStatus.OK);
    }

    @GetMapping("/chatting")
    public String chatList(HttpSession session, Model m) {
        String chatName = (String) session.getAttribute("id");
        logger.info("[id] : " + chatName + "채팅상담 접속");
        boolean hasAlreadyChatRoom = false;
        if (chatDtoList.size() != 0 && chatName != null && !chatName.trim().equals("") && !chatName.equals("null")) {
            for (ChatDto chatDto : chatDtoList) {
                if (chatDto.getChatName().equals(chatName)) {
                    hasAlreadyChatRoom = true;
                    break;
                }
            }
        }
        if (!hasAlreadyChatRoom) {
            ChatDto chatDto = new ChatDto();
            chatDto.setChatName(chatName);
            chatDtoList.add(chatDto);
        }
        m.addAttribute("chatDtoList", chatService.findChat(chatName));
        return "chatting/chatting";
    }
    @GetMapping("/chatRoom")
    public String chatList(String chatName, Model m) {
        logger.info("관리자 채팅문의 진입");
        List<ChatDto> new_list = chatDtoList.stream().
                filter(o -> Objects.equals(o.getChatName(), chatName))
                .collect(Collectors.toList());

        if (new_list != null && new_list.size() > 0) {
            m.addAttribute("chatName", chatName);
            m.addAttribute("chatDtoList", chatService.findChat(chatName));
            return "chatting/chatting";
        } else
            return "chatting/chatRoom";
    }
    @GetMapping("/getRoom")
    public @ResponseBody List<ChatDto> roomList() {
        logger.info("채팅방 리스트");
        return chatDtoList;
    }

    @ResponseBody
    @DeleteMapping("/removeRoom/{chatName}")
    public ResponseEntity<List<ChatDto>> roomRemove(@PathVariable String chatName) {
        logger.info("채팅방 이름 : " + chatName + " 삭제");
        for (int i = 0; i < chatDtoList.size(); i++) {
            if (chatDtoList.get(i).getChatName().equals(chatName)) {
                chatDtoList.remove(i);
                break;
            }
        }
        return new ResponseEntity<>(chatDtoList, HttpStatus.OK);
    }
}
