package com.kinaboot.muscles.interceptor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginChkInterceptor implements HandlerInterceptor {
    private static final Logger logger = LoggerFactory.getLogger(LoginChkInterceptor.class);
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        logger.info("Login 인터셉터 작동");

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("id");

        if(userId==null){
            response.sendRedirect("/muscles/login?toURL=" + request.getRequestURL());
            return false;
        }
        return true;
    }
}
