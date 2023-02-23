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
        margin: auto;
        width: 30%;
        align-items: center;
        justify-content: space-between;
        display: flex;
    }
    .item{
        display: flex;
        flex-direction: column;
    }
    .item-btn {
        align-self: flex-end;
        justify-content: flex-end;
    }
    .item-comment {
        flex-direction: row;
        justify-content: center;
        align-items: center;
    }
    hr{
        width: 50%;
    }
</style>
<body>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
<hr />
<div class="container">
    <p style="font-weight: bold;">{제목 표기} 관리자님께 문의 드립니다.</p>
    <p>{작성자 ID} | {작성날짜}</p>
</div>
<hr />
<div class="container">
    <p>
        Lorem ipsum dolor sit, amet consectetur adipisicing elit. Repellat
        dignissimos numquam nam maxime. Odio sed nesciunt ut necessitatibus,
        magnam earum voluptas quo voluptate, sunt impedit, mollitia iusto rerum
        ea eos?
    </p>
</div>
<hr />
<div class="container">
    <div class="item-btn">
        <span>작성된 댓글 (1개)</span>
        <input type="button" value="작성" />
        <input type="button" value="취소" />
    </div>
</div>
<hr />
<div class="container">
    <div class="item-comment">
        <textarea rows="4" cols="50"></textarea><br>
        <input type="submit" value="등록">
        <p>
            └ {작성자 ID 표기} | {작성일 표기}
            {내용표기}
            안녕하세요! 고객님 본인인증(또는 상점인증)이 완료된 고객님만 이용할 수 있는 서비스입니다. 확인 결과 고객님은 아직 본인인증 절차가 진행되지 않습니다. 본인인증 후 진행해 주세요!
        </p>
    </div>
</div>
<hr />
<div class="container">
    <div class="item-btn">
        <a href="<c:url value='/board/list'/>">
        <input type="button" value="목록" />
        </a>
        <input type="button" value="수정" />
        <input type="button" value="삭제" />
    </div>
</div>

<!-- footer -->
<%@ include file="../footer.jsp" %>
</body>
</html>