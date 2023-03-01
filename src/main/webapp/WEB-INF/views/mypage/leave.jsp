<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    .item:nth-child(1) {
        flex-shrink: 0;
        width: 130px;
    }

    .item:nth-child(2) {
        padding-left: 100px;
        margin: auto;
        flex-grow: 1;
    }
</style>
<body>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
<div class="mypage-container">
    <!-- 사이드바 시작 -->
    <%@include file="sidebar.jsp" %>
    <!-- 사이드바 끝 -->
    <!-- 내용 -->
    <div class="item">
        <p style="font-weight: bold">| 회원 탈퇴 안내</p>
        <span>
          {고객명} 고객님! 지금까지 저희 머슬스를 이용해 주셔서감사합니다.
          부족한 점이 있었다면 너그러운 양해 바라며, 아래의 사항을 확인 하시고,
          개선해야 할점이 있다면 남겨 주세요! 더욱 고객님의 의견을 적극 반영하여
          이용에 불편이 없도록 개선하겠습니다</span
        >
        <p style="font-weight: bold">| 회원 탈퇴 시 꼭 확인해 주세요!</p>
        <span>
          1. 사용하고 계신 아이디({이용자ID})는 탈퇴할 경우 3개월 간 재사용이
          불가능 합니다. <br/>2. 탈퇴 이후 등록한 게시물, 보유 포인트 등
          이용기록이 모두 삭제 됩니다.
        </span>
        <p style="font-weight: bold">| 탈퇴 사유를 선택해 주세요!</p>
        <form method="post">
        <span>
          <input
                  type="checkbox"
                  style="float: left"
                  name="type"
                  value="1"
          />
          <span style="float: left">이용률 감소</span>
          <input
                  type="checkbox"
                  style="float: left"
                  name="type"
                  value="2"
          />
          <span style="float: left">상품 저품질</span>
          <input
                  type="checkbox"
                  style="float: left"
                  name="type"
                  value="3"
          />
          <span style="float: left">상품 가격불만</span>

        </span>
        <br/>
        <p style="font-weight: bold">
            | 쇼핑몰 이용에 개선 사항 있다면 의견을 남겨 주세요!
        </p>
        <textarea name="opinion" style="width: 500px; height: 100px"></textarea>
        <br/>
        <input type="submit" value="확인"/>
        </form>
        <input type="submit" value="취소"/>
    </div>
</div>

<!-- footer -->
<%@ include file="../footer.jsp" %>
</body>
</html>