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
<a class="mypage-links" href="<c:url value='/order/list'/>"><p>> 주문 내역</p></a>
<a class="mypage-links" href="<c:url value='/mypage/mycoupon'/>"><p>> 쿠폰/포인트</p></a>
<hr class="col-8 mt-2">
<p style="font-weight: bold">게시물</p>
<a class="mypage-links" href="<c:url value='/mypage/mypost'/>"><p>> 내가 쓴 글</p></a>
<a class="mypage-links" href="<c:url value='/mypage/myreview'/>"><p>> 내가 쓴 리뷰</p></a>
<hr class="col-8 mt-2">
<p style="font-weight: bold">회원정보</p>
<a class="mypage-links" href="<c:url value='/mypage/modinfo'/>"><p>> 개인정보 수정</p></a>
<a class="mypage-links" href="<c:url value='/mypage/modpw'/>"><p>> 비밀번호 변경</p></a>
<a class="mypage-links" href="<c:url value='/mypage/leave'/>"><p>> 회원탈퇴</p></a>
