<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="item"  style="flex-shrink: 0; width: 130px; float: left;">
  <div id="side_bar_title">
    <span style="font-weight: bold">MY</span>
  </div>
  <div id="side_bar_content">
    <p style="font-weight: bold">쇼핑이용 정보</p>
    <a href="<c:url value='/order/list'/>"><p>> 주문 내역</p></a>
    <a href="<c:url value='/cart'/>"><p>> 장바구니</p></a>
    <a href="<c:url value='/mypage/mycoupon'/>"><p>> 쿠폰 등록</p></a>
    <br />
    <a href="<c:url value='/chatting'/>"><p>> 1:1 채팅 문의</p></a>
    <br />
    <p style="font-weight: bold">게시물</p>
    <a href="<c:url value='/mypage/mypost'/>"><p>> 내가 쓴 글</p></a>
    <a href="<c:url value='/mypage/myreview'/>"><p>> 내가 쓴 리뷰</p></a>
    <br />
    <p style="font-weight: bold">개인정보 수정</p>
    <a href="<c:url value='/mypage/modinfo'/>"><p>> 개인정보 수정</p></a>
    <a href="<c:url value='/mypage/modpw'/>"><p>> 비밀번호 변경</p></a>
    <br />
    <a href="<c:url value='/mypage/leave'/>"><p>> 회원탈퇴</p></a>
  </div>
</div>