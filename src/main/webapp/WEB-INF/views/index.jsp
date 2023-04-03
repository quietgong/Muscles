<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<style>
    .cardImg {
        border-radius: 20px;
        transition: all 0.3s ease-in-out;
        z-index: 20;
        box-shadow: 10px 10px 53px 0px rgba(0, 0, 0, 0.49);
        width: 400px;
        height: 400px;
    }
</style>
<%@ include file="nav.jsp" %>
<!-- 캐러셀 -->
<!-- Start Banner Hero -->
<div id="template-mo-zay-hero-carousel" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <div class="container">
                <div class="row p-5">
                    <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                        <img class="img-fluid" src="<c:url value='/img/slide1.jpg'/>" alt="">
                    </div>
                    <div class="col-lg-6 mb-0 d-flex align-items-center">
                        <div class="text-align-left align-self-center">
                            <h1 class="h1 text-success"><b>Zay</b> eCommerce</h1>
                            <h3 class="h2">Tiny and Perfect eCommerce Template</h3>
                            <p>
                                Zay Shop is an eCommerce HTML5 CSS template with latest version of Bootstrap 5 (beta 1).
                                This template is 100% free provided by <a rel="sponsored" class="text-success"
                                                                          href="https://templatemo.com" target="_blank">TemplateMo</a>
                                website.
                                Image credits go to <a rel="sponsored" class="text-success"
                                                       href="https://stories.freepik.com/" target="_blank">Freepik
                                Stories</a>,
                                <a rel="sponsored" class="text-success" href="https://unsplash.com/" target="_blank">Unsplash</a>
                                and
                                <a rel="sponsored" class="text-success" href="https://icons8.com/" target="_blank">Icons
                                    8</a>.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="carousel-item">
            <div class="container">
                <div class="row p-5">
                    <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                        <img class="img-fluid" src="<c:url value='/img/slide2.jpg'/>" alt="">
                    </div>
                    <div class="col-lg-6 mb-0 d-flex align-items-center">
                        <div class="text-align-left">
                            <h1 class="h1">Proident occaecat</h1>
                            <h3 class="h2">Aliquip ex ea commodo consequat</h3>
                            <p>
                                You are permitted to use this Zay CSS template for your commercial websites.
                                You are <strong>not permitted</strong> to re-distribute the template ZIP file in any
                                kind of template collection websites.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="carousel-item">
            <div class="container">
                <div class="row p-5">
                    <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                        <img class="img-fluid" src="<c:url value='/img/slide3.jpg'/>" alt="">
                    </div>
                    <div class="col-lg-6 mb-0 d-flex align-items-center">
                        <div class="text-align-left">
                            <h1 class="h1">Repr in voluptate</h1>
                            <h3 class="h2">Ullamco laboris nisi ut </h3>
                            <p>
                                We bring you 100% free CSS templates for your websites.
                                If you wish to support TemplateMo, please make a small contribution via PayPal or tell
                                your friends about our website. Thank you.
                            </p>
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
<!-- End Banner Hero -->
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
            <a href="<c:url value='/product/list?category=cardio'/>"><img src="<c:url value='/img/cardio.jpg'/>"
                                                                          class="rounded-circle img-fluid border"></a>
            <h5 class="text-center mt-3 mb-3">유산소</h5>
            <p class="text-center"><a href="<c:url value='/product/list?category=cardio'/>" class="btn btn-success">상품
                보기</a></p>
        </div>
        <div class="col-12 col-md-4 p-5 mt-3">
            <a href="<c:url value='/product/list?category=strength'/>"><img src="<c:url value='/img/strength.jpg'/>"
                                                                            class="rounded-circle img-fluid border"></a>
            <h2 class="h5 text-center mt-3 mb-3">근력</h2>
            <p class="text-center"><a href="<c:url value='/product/list?category=strength'/>" class="btn btn-success">상품
                보기</a></p>
        </div>
        <div class="col-12 col-md-4 p-5 mt-3">
            <a href="<c:url value='/product/list?category=etc'/>"><img src="<c:url value='/img/etc.jpg'/>"
                                                                       class="rounded-circle img-fluid border"></a>
            <h2 class="h5 text-center mt-3 mb-3">기타 용품</h2>
            <p class="text-center"><a href="<c:url value='/product/list?category=etc'/>" class="btn btn-success">상품
                보기</a></p>
        </div>
    </div>
</section>
<!-- 카테고리 페이지 끝 -->>

<!-- 베스트 상품 -->>
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
        <div class="row">
            <div class="col-12 col-md-4 mb-4">
                <div class="card h-100">
                    <a href="#">
                        <img src="<c:url value='/img/cardio.jpg'/>" class="card-img-top">
                    </a>
                    <div class="card-body">
                        <ul class="list-unstyled d-flex justify-content-between">
                            <li>
                                <i class="text-warning fa fa-star"></i>
                                <i class="text-warning fa fa-star"></i>
                                <i class="text-warning fa fa-star"></i>
                                <i class="text-muted fa fa-star"></i>
                                <i class="text-muted fa fa-star"></i>
                            </li>
                            <li class="text-muted text-right">가격</li>
                        </ul>
                        <a href="shop-single.html" class="h2 text-decoration-none text-dark">상품 이름</a>
                        <p class="card-text">
                            상품 세부설명
                        </p>
                        <p class="text-muted">Reviews (리뷰개스)</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
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