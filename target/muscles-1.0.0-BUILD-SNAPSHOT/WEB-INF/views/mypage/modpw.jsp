<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Muscles</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
</head>
<style>

    .item-head {
        text-align: center;
        flex: 1 1 20%;
    }
    .item {
        text-align: center;
        flex: 1 1 20%;
    }
</style>
<body>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
<!-- 사이드바 시작 -->
<%@include file="sidebar.jsp" %>
<!-- 사이드바 끝 -->
<div class="mypage-container">
    <div class="item">
        <label style="font-weight: bold;" for="pw1">현재의 비밀번호 입력 : </label>
        <input type="password" id="lname" name="lastname" />
    </div>
</div>
<hr />
<div class="mypage-container">
    <div class="item">
        <label style="font-weight: bold;" for="pw1">새로운 비밀번호 입력 : </label>
        <input type="password" id="lname" name="lastname" />
    </div>
</div>
<div class="mypage-container">
    <div class="item">
        <label style="font-weight: bold;" for="pw1">새로운 비밀번호 확인 : </label>
        <input type="password" id="lname" name="lastname" />
    </div>
</div>
<div class="mypage-container">
    <div class="item">
        <span>※ 영문, 숫자,를 조합하여 5~20자 이내로 입력</span>
        <br>
        <input type="submit" value="변경" />
        <input type="submit" value="취소" />
    </div>
</div>

<!-- footer -->
<%@ include file="../footer.jsp" %>
</body>
</html>