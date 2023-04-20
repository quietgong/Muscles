package com.kinaboot.muscles.aop;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
@Aspect
@Slf4j
public class LoggingAdvice {
    @Around("execution(* com.kinaboot.muscles.service.*.*(..)) && !(within(com.kinaboot.muscles.handler.WebSocketConfig) || within(com.kinaboot.muscles.handler.SocketHandler))")
    public Object aopMethod(ProceedingJoinPoint pjp) throws Throwable {
        String fullClassName = pjp.getTarget().getClass().getName();
        String className = fullClassName.substring(fullClassName.lastIndexOf(".") + 1);
        String methodName = pjp.getSignature().getName();

        long startAt = System.currentTimeMillis();
        log.info("=======================================");
        log.info("요청");
        log.info("[class] : " + className + " [method] : " + methodName);

        Object obj = pjp.proceed();

        long endAt = System.currentTimeMillis();
        log.info("응답 시간  : " + "[" + (endAt - startAt) + "ms]");
        log.info("=======================================");
        return obj;
    }
}
