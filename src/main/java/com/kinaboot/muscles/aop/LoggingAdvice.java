package com.kinaboot.muscles.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class LoggingAdvice {
    private static final Logger logger = LoggerFactory.getLogger(LoggingAdvice.class);
    @Around("execution(* com.kinaboot.muscles.*.*.*(..)) && !(within(com.kinaboot.muscles.handler.WebSocketConfig) || within(com.kinaboot.muscles.handler.SocketHandler))")
    public Object aopMethod(ProceedingJoinPoint pjp) throws Throwable {
        long startAt = System.currentTimeMillis();

        logger.info("----------> 요청 : " + pjp.getSignature().getName());

        Object obj = pjp.proceed();

        long endAt = System.currentTimeMillis();

        logger.info("----------> 응답 : " + pjp.getSignature().getName());

        logger.info("Execution time : " + "[" + (endAt-startAt) + "ms]");

        return obj;
    }
}
