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
    .container {
        justify-content: center;

        align-items: center;
        flex-direction: column;
    }
    .item {
        flex-basis: 100%;
    }
</style>
<body>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
<body>
<div class="container">
    <div class="item">
            <span>제목
                <input type="text" placeholder="제목을 입력해주세요">
            </span>
    </div>
    <div class="item">
        <textarea rows="7" cols="80" placeholder="내용을 입력해주세요"></textarea>
    </div>
    <div class="item">
        <input type="submit" value="완료">
        <input type="submit" value="저장">
        <input type="submit" value="취소">
    </div>
</div>

<!-- footer -->
<%@ include file="../footer.jsp" %>
</body>
</html>