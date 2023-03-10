<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Muscles</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
<!-- nav -->
<%@ include file="nav.jsp" %>

<!-- 본문 -->
<div class="login-container">
    <h2>Muscles</h2>
    <div id="msg">
        <i class="fa fa-exclamation-circle">${param.msg}</i>
    </div>
    <div class="login-btn">
        <form action="<c:url value="/login"/>" name="loginForm" method="post">
        <input type="text" name="userId" value="${cookie.id.value}" placeholder="아이디" /><br>
        <input type="text" name="password" value="1234" placeholder="비밀번호" /><br>
        <input type="submit" value="로그인">
        <a href="register.html"><input type="submit" value="회원가입"></a>
        <div>
            <input type="checkbox"name="rememberId" value="on" ${empty cookie.id.value?"":"checked"}>
            <span>아이디 기억</span>
        </div>
            <input type="hidden" name="toURL" value="${param.toURL}">
        </form>
        <br>
    </div>

<!-- footer -->
<%@ include file="footer.jsp" %>
</body>
</html>