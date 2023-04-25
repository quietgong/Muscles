package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.ChatDto;
import com.kinaboot.muscles.service.ChatService;
import lombok.extern.slf4j.Slf4j;
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

@Slf4j
@Controller
public class ChattingController {

    @Autowired
    ChatService chatService;

    List<ChatDto> chatDtoList = new ArrayList<>();

    @PostMapping("/chat/post")
    @ResponseBody
    public ResponseEntity<String> chatAdd(@RequestBody ChatDto chatDto) {
        System.out.println("chatDto = " + chatDto);
        if (chatService.saveChat(chatDto) != 0)
            return new ResponseEntity<>("ADD_OK", HttpStatus.OK);
        else
            return new ResponseEntity<>("ADD_FAIL", HttpStatus.OK);
    }

    @GetMapping("/chatting")
    public String chatList(HttpSession session, Model m) {
        String chatName = (String) session.getAttribute("id");
        log.info("[id] : " + chatName + " 채팅상담 접속");
        boolean hasAlreadyChatRoom = false;
        if (chatDtoList.size() != 0 && chatName != null && !chatName.trim().equals("") && !chatName.equals("null")) {
            for (ChatDto chatDto : chatDtoList) {
                if (chatDto.getChatName().equals(chatName)) {
                    hasAlreadyChatRoom = true;
                    break;
                }
            }
        }
        if (!hasAlreadyChatRoom)
            chatDtoList.add(new ChatDto(chatName, chatName, chatName, 0, null, null));
        m.addAttribute("chatDtoList", chatService.findChat(chatName));
        return "chatting/chatting";
    }

    @GetMapping("/chatRoom")
    public String chatList(String chatName, Model m) {
        log.info("관리자 채팅문의 진입");
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
    @ResponseBody
    public List<ChatDto> roomList() {
        log.info("채팅방 리스트");
        for (ChatDto chatDto : chatDtoList) {
            chatDto.setLastMsgDate(chatService.findChatLastMsgDate(chatDto.getChatName()));
            chatDto.setNewMsgCnt(chatService.findChatNewMsgDate(chatDto.getChatName()));
        }
        return chatDtoList;
    }

    @DeleteMapping("/removeRoom/{chatName}")
    @ResponseBody
    public ResponseEntity<String> roomRemove(@PathVariable String chatName) {
        log.info("채팅방 이름, 채팅 유저 : " + chatName + " 삭제");
        for (int i = 0; i < chatDtoList.size(); i++) {
            if (chatDtoList.get(i).getChatName().equals(chatName)) {
                chatDtoList.remove(i);
                return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
            }
        }
        return new ResponseEntity<>("DEL_FAIL", HttpStatus.OK);
    }
}
