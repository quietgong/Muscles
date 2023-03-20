<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<style>
    img{
        width: 400px;
        height: 300px;
    }
</style>
<%@ include file="nav.jsp" %>
<!-- 카테고리별 상품 시작 -->
<h3>카테고리별 상품</h3>
<hr/>
<div class="index-container">
    <div class="index-item">
        <a href="<c:url value='/product/list?category=cardio'/>">
            <img src="<c:url value='/img/cardio.jpg'/>">
        </a>
    </div>
    <div class="index-item">
        <a href="<c:url value='/product/list?category=strength'/>">
            <img src="<c:url value='/img/strength.jpg'/>">
        </a>
    </div>
    <div class="index-item">
        <a href="<c:url value='/product/list?category=etc'/>">
            <img src="<c:url value='/img/etc.jpg'/>">
        </a>
    </div>
</div>
<div class="index-container">
    <div class="index-item">
        <span>유산소</span>
    </div>
    <div class="index-item">
        <span>근력</span>
    </div>
    <div class="index-item">
        <span>기타용품</span>
    </div>
</div>
<!-- 카테고리별 상품 끝 -->

<!-- 베스트 상품 시작 -->
<h3>베스트 상품</h3>
<hr/>
<div class="index-container">
    <!-- 반복부 -->
    <div class="index-item">
        <div class="index-item-detail">
            <div>
                <img src="http://via.placeholder.com/300X200/000000/ffffff"/>
            </div>
        </div>
        <div class="index-item-detail">
            <div class="index-item-description">
                <span style="float: left;">상품명</span>
                <span style="float: right;">상품 가격</span>
            </div>
        </div>
        <div class="index-item-detail">
            <div>
            <span class="star">★★★★★<span>★★★★★</span></span>
            </div>
        </div>
        <div class="index-item-detail">
            <span>리뷰 개수 : {}개</span>
        </div>
    </div>
    <!-- 반복부 -->
    <div class="index-item">
        <div class="index-item-detail">
            <div>
                <img src="http://via.placeholder.com/300X200/000000/ffffff"/>
            </div>
        </div>
        <div class="index-item-detail">
            <div class="index-item-description">
                <span style="float: left;">상품명</span>
                <span style="float: right;">상품 가격</span>
            </div>
        </div>
        <div class="index-item-detail">
            <span>★★★★★</span>
        </div>
        <div class="index-item-detail">
            <span>리뷰 개수 : {}개</span>
        </div>
    </div>
    <div class="index-item">
        <div class="index-item-detail">
            <div>
                <img src="http://via.placeholder.com/300X200/000000/ffffff"/>
            </div>
        </div>
        <div class="index-item-detail">
            <div class="index-item-description">
                <span style="float: left;">상품명</span>
                <span style="float: right;">상품 가격</span>
            </div>
        </div>
        <div class="index-item-detail">
            <span>★★★★★</span>
        </div>
        <div class="index-item-detail">
            <span>리뷰 개수 : {}개</span>
        </div>
    </div>
</div>
<!-- 베스트 상품 끝 -->
<%@ include file="footer.jsp" %>