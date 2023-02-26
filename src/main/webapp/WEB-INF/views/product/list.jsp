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
<div>
    <p>런닝머신</p>
    <p>총 {}개의 상품이 있습니다.</p>
</div>
<div class="product-list-container" style="justify-content: flex-end;">
    <p>
        <a href="login.html">낮은가격 순</a> |
        <a href="register.html">높은가격 순</a> |
        <a href="register.html">좋아요 순</a> |
        <a href="register.html">리뷰점수 높은 순</a>
    </p>
</div>
<!-- 반복부 -->
<div class="product-list-container">
    <div class="product-list-item">
        <a href="<c:url value='/product/detail'/>">
            <img src="http://via.placeholder.com/250?text=mypage">
        </a>
        <span style="font-weight: bold;">상품명</span>
        <div>
            <span class="star">★★★★★<span>★★★★★</span></span>
        </div>
        <span style="font-weight: bold;">상품가격</span>
        <span style="font-weight: bold;">리뷰개수</span>
    </div>
    <div class="product-list-item">
        <img src="http://via.placeholder.com/250?text=mypage">
        <span style="font-weight: bold;">상품명</span>
        <span style="font-weight: bold;">상품가격</span>
        <span style="font-weight: bold;">리뷰개수</span>
    </div>
    <div class="product-list-item">
        <img src="http://via.placeholder.com/250?text=mypage">
        <span style="font-weight: bold;">상품명</span>
        <span style="font-weight: bold;">상품가격</span>
        <span style="font-weight: bold;">리뷰개수</span>
    </div>
    <div class="product-list-item">
        <img src="http://via.placeholder.com/250?text=mypage">
        <span style="font-weight: bold;">상품명</span>
        <span style="font-weight: bold;">상품가격</span>
        <span style="font-weight: bold;">리뷰개수</span>
    </div>
</div>
<hr>
<!-- 반복부 -->
<!-- 반복부 -->
<div class="product-list-container">
    <div class="product-list-item">
        <a href="<c:url value='/product/detail'/>">
            <img src="http://via.placeholder.com/250?text=mypage">
        </a>
        <span style="font-weight: bold;">상품명</span>
        <span style="font-weight: bold;">상품가격</span>
        <span style="font-weight: bold;">리뷰개수</span>
    </div>
    <div class="product-list-item">
        <img src="http://via.placeholder.com/250?text=mypage">
        <span style="font-weight: bold;">상품명</span>
        <span style="font-weight: bold;">상품가격</span>
        <span style="font-weight: bold;">리뷰개수</span>
    </div>
    <div class="product-list-item">
        <img src="http://via.placeholder.com/250?text=mypage">
        <span style="font-weight: bold;">상품명</span>
        <span style="font-weight: bold;">상품가격</span>
        <span style="font-weight: bold;">리뷰개수</span>
    </div>
    <div class="product-list-item">
        <img src="http://via.placeholder.com/250?text=mypage">
        <span style="font-weight: bold;">상품명</span>
        <span style="font-weight: bold;">상품가격</span>
        <span style="font-weight: bold;">리뷰개수</span>
    </div>
</div>
<hr>
<!-- 반복부 -->

<!-- footer -->
<%@ include file="../footer.jsp" %>
<script>
    // 별점
    document.querySelector(`.star span`).style.width = `20%`;
</script>
</body>
</html>