<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ include file="nav.jsp" %>
<!-- 캐러셀 시작 -->
<div id="template-mo-zay-hero-carousel" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <div class="container">
                <div class="row p-5">
                    <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                        <img class="img-fluid" src="img/slide1.jpg" alt="">
                    </div>
                    <div class="col-lg-6 mb-0 d-flex align-items-center">
                        <div class="text-align-left align-self-center">
                            <h1 class="h1 text-success"><b>안녕하세요,</b> 머슬스입니다.</h1>
                            <h3 class="h2 mt-3">"저희 운동 기구 매장에서</h3>
                            <h3 class="h2">최고의 운동 기구를 쇼핑하세요"</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="carousel-item">
            <div class="container">
                <div class="row p-5">
                    <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                        <img class="img-fluid" src="img/slide2.jpg" alt="">
                    </div>
                    <div class="col-lg-6 mb-0 d-flex align-items-center">
                        <div class="text-align-left">
                            <h1 class="h1">AIM</h1>
                            <h3 class="h2">"다양한 운동 기구와 액세서리로</h3>
                            <h3 class="h2">피트니스 목표를 달성하세요."</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="carousel-item">
            <div class="container">
                <div class="row p-5">
                    <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                        <img class="img-fluid" src="img/slide3.jpg" alt="">
                    </div>
                    <div class="col-lg-6 mb-0 d-flex align-items-center">
                        <div class="text-align-left">
                            <h1 class="h1">LEVEL UP</h1>
                            <h3 class="h2">"고품격 운동기구로 운동을</h3>
                            <h3 class="h2">한 차원 높여보세요."</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <a class="carousel-control-prev text-decoration-none w-auto ps-3" href="#template-mo-zay-hero-carousel"
       role="button" data-bs-slide="prev">
        <i class="fas fa-chevron-left"></i>
    </a>
    <a class="carousel-control-next text-decoration-none w-auto pe-3" href="#template-mo-zay-hero-carousel"
       role="button" data-bs-slide="next">
        <i class="fas fa-chevron-right"></i>
    </a>
</div>
<!-- 캐러셀 끝 -->
<!-- 카테고리 페이지 시작 -->
<section class="container py-5">
    <div class="row text-center pt-3">
        <div class="col-lg-6 m-auto">
            <h1 class="h1">카테고리별 상품</h1>
            <p>
                유산소, 근력, 운동에 필요한 기타 용품들을 구매해보세요.
            </p>
        </div>
    </div>
    <div class="row">
        <div class="col-12 col-md-4 p-5 mt-3">
            <a href="<c:url value='/goods/list?category=유산소'/>">
                <img src="<c:url value='/img/cardio.jpg'/>" class="rounded-circle img-fluid border" alt="">
            </a>
            <h5 class="text-center mt-3 mb-3">유산소</h5>
            <p class="text-center">
                <a href="<c:url value='/goods/list?category=유산소'/>" class="btn btn-success">상품보기</a>
            </p>
        </div>
        <div class="col-12 col-md-4 p-5 mt-3">
            <a href="<c:url value='/goods/list?category=근력'/>">
                <img src="<c:url value='/img/strength.jpg'/>" class="rounded-circle img-fluid border" alt="">
            </a>
            <h2 class="h5 text-center mt-3 mb-3">근력</h2>
            <p class="text-center">
                <a href="<c:url value='/goods/list?category=근력'/>" class="btn btn-success">상품보기</a>
            </p>
        </div>
        <div class="col-12 col-md-4 p-5 mt-3">
            <a href="<c:url value='/goods/list?category=기타'/>">
                <img src="<c:url value='/img/etc.jpg'/>" class="rounded-circle img-fluid border" alt="">
            </a>
            <h2 class="h5 text-center mt-3 mb-3">기타</h2>
            <p class="text-center">
                <a href="<c:url value='/goods/list?category=기타'/>" class="btn btn-success">상품보기</a>
            </p>
        </div>
    </div>
</section>
<!-- 카테고리 페이지 끝 -->

<!-- 베스트 상품 -->
<section class="bg-light">
    <div class="container py-5">
        <div class="row text-center py-3">
            <div class="col-lg-6 m-auto">
                <h1 class="h1">베스트 상품</h1>
                <p>
                    고객님들께서 많이 찾아주시는 상품들입니다.
                </p>
            </div>
        </div>
        <div class="row" id="bestGoodsList">
            <!-- 동적 추가 -->
        </div>
    </div>
</section>
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
<script>
    /* 베스트 상품 */
    loadBestGoods()

    function loadBestGoods() {
        $.ajax({
            type: "GET",
            url: '/muscles/goods/best',
            success: function (res) {
                $("#bestGoodsList").append(toHtml(res))
            },
            error: function () {
                console.log('error');
            }
        });
    }

    let toHtml = function (items) {
        let tmp = "";
        items.forEach(function (item) {
            tmp += '<div class="col-md-4">'
            tmp += '<div class="card mb-4 product-wap rounded-0">'
            tmp += '<div class="card rounded-0" style="height: 250px">'
            if (item.goodsImgPath == null)
                tmp += '<img style="height: 250px;" class="card-img rounded-0 img-fluid" src="/muscles/img/logo.jpg">'
            else
                tmp += '<img style="height: 250px;" class="card-img rounded-0 img-fluid" src="' + item.goodsImgPath + '">'
            tmp += "<a href=\"<c:url value='/goods/detail?goodsNo='/>" + item.goodsNo + "\">";
            tmp += '<div class="card-img-overlay rounded-0 product-overlay d-flex align-items-center justify-content-center">'
            tmp += '</div>'
            tmp += '</a>'
            tmp += '</div>'
            tmp += '<div class="card-body">'
            tmp += '<div class="row justify-content-center">'
            tmp += '<div class="col-md-12">'
            tmp += '<span class="text-muted">' + item.goodsCategory + ' > ' + item.goodsCategoryDetail + '</span>'
            tmp += '</div>'
            tmp += '<div class="col-md-12 text-center mt-2">'
            tmp += "<a class=\"h3 fw-bold text-decoration-none\" href=\"<c:url value='/goods/detail?goodsNo='/>" + item.goodsNo + "\">";
            tmp += '<h3>' + item.goodsName + '</h3>'
            tmp += '</a>'
            tmp += '</div>'
            tmp += '<div class="star-ratings" style="width:144px;">'
            tmp += '<div class="fill-ratings" style="width: ' + item.goodsReviewScore + '%;">'
            tmp += '<span style="font-size: 1.8rem;">★★★★★</span>'
            tmp += '</div>'
            tmp += '<div class="empty-ratings">'
            tmp += '<span style="font-size: 1.8rem;">★★★★★</span>'
            tmp += '</div>'
            tmp += '</div>'
            tmp += '<p class="text-center mb-0"> ₩ ' + item.goodsPrice.toLocaleString() + ' </p>'
            tmp += '<p class="text-center text-secondary mb-0">(Review : ' + item.reviewDtoList.length.toLocaleString() + ')</p>'
            tmp += '</div>'
            tmp += '</div>'
            tmp += '</div>'
            tmp += '</div>'
        })
        return tmp
    }
</script>
<%@ include file="footer.jsp" %>