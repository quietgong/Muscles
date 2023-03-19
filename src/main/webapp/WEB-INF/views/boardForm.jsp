<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
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
<!-- nav -->
<%@ include file="nav.jsp" %>
<!-- 본문 -->
<form action="<c:url value='/community/write'/>" name="wrtForm" method="post">
<div class="container">
    <div class="item">
            <span>제목
                <input name="title" type="text" placeholder="제목을 입력해주세요">
            </span>
    </div>
    <div class="item">
        <textarea name="content" rows="7" cols="80" placeholder="내용을 입력해주세요"></textarea>
    </div>
    <div class="item">
        <input type="submit" value="완료">
        <input type="submit" value="저장">
        <input type="submit" value="취소">
    </div>
</div>
</form>
<!-- footer -->
<%@ include file="footer.jsp" %>
