package com.kinaboot.muscles;

import com.kinaboot.muscles.domain.CartDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Controller
public class TestController {
    @PostMapping("/test/checkbox")
    public String test1(List<CartDto> cartDtos){
        System.out.println("cartDtos = " + cartDtos);
        return "order/complete";
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
