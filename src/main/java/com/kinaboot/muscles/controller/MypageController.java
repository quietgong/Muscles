package com.kinaboot.muscles.controller;

import com.kinaboot.muscles.dao.UserDao;
import org.springframework.stereotype.Controller;

@Controller
public class MypageController {
    private final UserDao userDao;
    MypageController(UserDao userDao){
        this.userDao=userDao;
    }

    //    @GetMapping("/mypage")
//    public String mypage(Model m, HttpSession session, HttpServletRequest request){
//        // 1. 세션이 없다면 로그인 페이지로 이동
//        UserDto userDto;
//        String id = (String) session.getAttribute("id");
//        if(id==null)
//            return "redirect:/login?toURL="+request.getRequestURL();
//        userDto = userDao.selectUser(id);
//
//        m.addAttribute(userDto);
//        return "dashboard/mypageForm";
//    }

//
//    @PostMapping("/register/idcheck")
//    @ResponseBody
//    public int idDupCheck(@RequestBody String jsonStr) throws ParseException {
//        JSONParser jsonParser = new JSONParser();
//        JSONObject jsonObj = (JSONObject) jsonParser.parse(jsonStr);
//        String id = (String) jsonObj.get("id");
//        return userDao.searchIdCnt(id);
//    }
}
