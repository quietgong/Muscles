package com.kinaboot.muscles;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kinaboot.muscles.domain.CartDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Controller
public class TestController {
    @PostMapping(value = "/test/checkbox")
    public String test1(String data) throws JsonProcessingException {
        System.out.println("data = " + data);
        List<CartDto> cartDtoList = JsonToJava(data);
        System.out.println(cartDtoList.toString());
        return "order/complete";
    }
    public List<CartDto> JsonToJava(String rowData) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.readValue(rowData, new TypeReference<List<CartDto>>() {});
    }
    @GetMapping("/test")
    public String test(Model m){
        List<CartDto> cartDtos = new ArrayList<>();
        cartDtos.add(new CartDto("1", 10000, 10));
        cartDtos.add(new CartDto("2", 20000, 5));
        m.addAttribute("list", cartDtos);
        return "test";
    }
}
