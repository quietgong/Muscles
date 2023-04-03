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

    @Around("execution(* com.kinaboot.muscles.service.*.*(..)) && !(within(com.kinaboot.muscles.handler.WebSocketConfig) || within(com.kinaboot.muscles.handler.SocketHandler))")
    public Object aopMethod(ProceedingJoinPoint pjp) throws Throwable {
        String fullClassName = pjp.getTarget().getClass().getName();
        String className = fullClassName.substring(fullClassName.lastIndexOf(".") + 1);
        String methodName = pjp.getSignature().getName();

        long startAt = System.currentTimeMillis();
        logger.info("=======================================");
        logger.info("요청");
        logger.info("[class] : " + className + " [method] : " + methodName);

        Object obj = pjp.proceed();

        long endAt = System.currentTimeMillis();
        logger.info("응답 시간  : " + "[" + (endAt - startAt) + "ms]");
        logger.info("=======================================");
        return obj;
    }
}
