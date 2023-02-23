<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
  <meta charset="UTF-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Home</title>
  <link rel="stylesheet" href="css/style.css"/>
</head>
<body>
<!-- nav -->
<%@ include file="nav.jsp" %>

<!-- 본문 -->
<hr />
<div class="cart-container">
  <div class="cart-item-head">
    <label
    ><input type="checkbox" name="rememberId" value="on" />
      <span>전체선택</span></label
    >
  </div>
  <div class="cart-item-head"><h2>상품정보</h2></div>
  <div class="cart-item-head"><h2>수량</h2></div>
  <div class="cart-item-head"><h2>상품금액</h2></div>
</div>
<hr />
<!-- 반복부 -->
<div class="cart-container">
  <div class="cart-item" style="flex-basis: 150px">
    <input type="checkbox" name="rememberId" value="on" />
  </div>
  <img src="http://via.placeholder.com/100X100/000000/ffffff" />
  <div class="cart-item"><h3>상품명</h3></div>
  <div class="cart-item"><h3>수량</h3></div>
  <div class="cart-item"><h3>15,000원</h3></div>
</div>
<hr />
<!-- 반복부 끝 -->
<!-- 반복부 -->
<div class="cart-container">
  <div class="cart-item" style="flex-basis: 150px">
    <input type="checkbox" name="rememberId" value="on" />
  </div>
  <img src="http://via.placeholder.com/100X100/000000/ffffff" />
  <div class="cart-item"><h3>상품명</h3></div>
  <div class="cart-item"><h3>수량</h3></div>
  <div class="cart-item"><h3>15,000원</h3></div>
</div>
<hr />
<!-- 반복부 끝 -->

<div class="cart-container">
  <input type="button" value="선택삭제" />
  <select id="country" name="country">
    <option value="" selected>할인쿠폰 선택</option>
    <option value="">추천인 입력 이벤트</option>
    <option value="">준비중...</option>
  </select>
</div>

<div class="cart-container">
  <div class="cart-item">
    <p style="font-weight: bold;">총 주문 금액은 13,500원입니다.</p>
    <input type="button" value="주문하기" />
    <input type="button" value="홈 이동" />
  </div>
</div>

<!-- footer -->
<%@ include file="footer.jsp" %>
</body>
</html>