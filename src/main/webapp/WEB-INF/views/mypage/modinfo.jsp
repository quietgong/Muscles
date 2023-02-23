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
<body>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
<div class="mypage-container">
    <div class="item">
        <!-- 사이드바 시작 -->
        <%@include file="sidebar.jsp" %>
        <!-- 사이드바 끝 -->
    </div>
    <table id="myTable" style="margin: auto">
        <tr>
            <td>아이디</td>
            <td>(가입 아이디 표기)</td>
        </tr>
        <tr>
            <td>이름</td>
            <td>(가입 이름 표기)</td>
        </tr>
        <tr>
            <td>휴대폰 번호</td>
            <td><input placeholder="-를 제외하고 입력해주세요"/></td>
        </tr>
        <tr>
            <td>이메일</td>
            <td><input /></td>
        </tr>
    </table>
    <div class="item">
        <input type="submit" value="변경" />
        <input type="submit" value="취소" />
    </div>
</div>

<!-- footer -->
<%@ include file="../footer.jsp" %>
</body>
</html>