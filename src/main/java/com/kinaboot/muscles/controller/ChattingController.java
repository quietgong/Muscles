package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.domain.ChatDto;
import com.kinaboot.muscles.service.ChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Controller
public class ChattingController {
    @Autowired
    ChatService chatService;
    List<ChatDto> chatDtoList = new ArrayList<>();

    // 채팅 내용 DB 저장
    @PostMapping("/chat/post")
    @ResponseBody
    public ResponseEntity<String> chatPost(ChatDto chatDto) {
        System.out.println("chatDto = " + chatDto);
        chatService.saveChat(chatDto);
        return new ResponseEntity<>("OK", HttpStatus.OK);
    }

    // 유저가 채팅상담 페이지에 접속했을 때
    @GetMapping("/chatting")
    public String chatting(HttpSession session, Model m) {
        // 사용자 ID 이름으로 된 채팅방을 생성한다.
        String chatName = (String) session.getAttribute("id");
        boolean hasAlreadyChatRoom = false;
        if (chatName != null && !chatName.trim().equals("") && !chatName.equals("null")) {
            if (chatDtoList.size() > 0) {
                for (ChatDto chatDto : chatDtoList) {
                    if (chatDto.getChatName().equals(chatName)) {
                        hasAlreadyChatRoom = true;
                        break;
                    }
                }
            }
        }
        if (!hasAlreadyChatRoom) {
            ChatDto chatDto = new ChatDto();
            chatDto.setChatName(chatName);
            chatDtoList.add(chatDto);
        }
        m.addAttribute("chatDtoList", chatService.getChat(chatName);
        System.out.println("chatService.getChat(chatName) = " + chatService.getChat(chatName));
        return "chatting";
    }

    // 방 정보 가져오기
    @GetMapping("/getRoom")
    public @ResponseBody List<ChatDto> getRoom() {
        return chatDtoList;
    }

    // 관리자가 유저 채팅목록에 접속할 때
    @GetMapping("/moveChating")
    public String chating(String chatName, Model m) {
        System.out.println("chatName = " + chatName);
        List<ChatDto> new_list = chatDtoList.stream().
                filter(o -> Objects.equals(o.getChatName(), chatName))
                .collect(Collectors.toList());
        if (new_list != null && new_list.size() > 0) {
            m.addAttribute("chatName", chatName);
            m.addAttribute("chatDto", chatService.getChat(chatName));
            return "chatting";
        } else
            return "chatRoom";
    }
}
