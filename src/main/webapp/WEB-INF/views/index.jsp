<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<style>
    img {
        width: 400px;
        height: 300px;
    }

    .content {
        width: 600px;
        margin: auto;
        height: 400px;
    }

    .slide_div img {
        margin: auto;
    }

    .image_wrap img {
        max-width: 85%;
        height: auto;
        display: block;
        margin: auto;
    }
    .categoryImg{
        border-radius: 20px;
        transition: all 0.3s ease-in-out;
        z-index: 20;
        box-shadow: 10px 10px 53px 0px rgba(0,0,0,0.49);
    }
    .categoryDescription{
        font-size: 1.5rem;
        font-weight: bold;
        font-style: italic;
        letter-spacing: 3px;
    }
    .index-container{
        padding: 20px;
    }

</style>
<%@ include file="nav.jsp" %>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<div class="content">
    <div>
        <h1 style="font-family: 'MS UI Gothic'; font-style: italic; text-align: center">Exercise</h1>
    </div>
    <div class="slide_div_wrap">
        <div class="slide_div">
            <div>
                <img src="<c:url value='/img/slide1.jpg'/>">
            </div>
            <div>
                <img src="<c:url value='/img/slide2.jpg'/>">
            </div>
            <div>
                <img src="<c:url value='/img/slide3.jpg'/>">
            </div>
        </div>
    </div>
</div>
<!-- 카테고리별 상품 시작 -->
<div>
    <h3>카테고리별 상품</h3>
    <hr/>
    <div class="index-container">
        <div class="index-item">
            <span class="categoryDescription">유산소</span>
        </div>
        <div class="index-item">
            <span class="categoryDescription">근력</span>
        </div>
        <div class="index-item">
            <span class="categoryDescription">기타용품</span>
        </div>
    </div>
    <div class="index-container">
        <div class="index-item">
            <a href="<c:url value='/product/list?category=cardio'/>">
                <img class="categoryImg" src="<c:url value='/img/cardio.jpg'/>">
            </a>
        </div>
        <div class="index-item">
            <a href="<c:url value='/product/list?category=strength'/>">
                <img class="categoryImg" src="<c:url value='/img/strength.jpg'/>">
            </a>
        </div>
        <div class="index-item">
            <a href="<c:url value='/product/list?category=etc'/>">
                <img class="categoryImg" src="<c:url value='/img/etc.jpg'/>">
            </a>
        </div>
    </div>
</div>
<!-- 카테고리별 상품 끝 -->
<!-- 베스트 상품 시작 -->
<div>
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
</div>
<!-- 베스트 상품 끝 -->
<script>
    $(document).ready(function () {
        $('.slide_div').slick({
            dots: true,
            infinite: true,
            autoplay: true,
            speed: 500,
            fade: true,
            cssEase: 'linear'
        });
        $(".slick-prev").css("display", "none")
        $(".slick-next").css("display", "none")
        $(".slick-dots").css("top", "300px")
    })
</script>
<%@ include file="footer.jsp" %>