<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    .mypage-links{
        text-decoration: none;
        cursor: pointer;
        color: #0a53be;
    }
</style>
<h5 style="font-weight: bold">MYPAGE</h5>
<hr class="col-8 mt-2">
<p style="font-weight: bold">쇼핑이용 정보</p>
<a class="mypage-links" href="<c:url value='/mypage/order'/>"><p>> 주문 내역</p></a>
<a class="mypage-links" href="<c:url value='/mypage/coupon'/>"><p>> 쿠폰/포인트</p></a>
<hr class="col-8 mt-2">
<p style="font-weight: bold">게시물</p>
<a class="mypage-links" href="<c:url value='/mypage/post'/>"><p>> 내가 쓴 글</p></a>
<a class="mypage-links" href="<c:url value='/mypage/review'/>"><p>> 내가 쓴 리뷰</p></a>
<hr class="col-8 mt-2">
<p style="font-weight: bold">회원정보</p>
<a class="mypage-links" href="<c:url value='/mypage/modify'/>"><p>> 개인정보 수정</p></a>
<a class="mypage-links" href="<c:url value='/mypage/exit'/>"><p>> 회원탈퇴</p></a>
