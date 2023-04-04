<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<div class="container py-5">
    <div class="row">
        <div class="col-lg-3">
            <h1 class="h2 pb-4">Categories</h1>
            <ul class="list-unstyled templatemo-accordion">
                <li class="pb-3">
                    <a class="collapsed d-flex justify-content-between h3 text-decoration-none" href="#">
                        유산소
                        <i class="fa fa-fw fa-chevron-circle-down mt-1"></i>
                    </a>
                    <ul class="collapse show list-unstyled pl-3">
                        <li><a class="text-decoration-none" href="#">러닝머신</a></li>
                        <li><a class="text-decoration-none" href="#">줄넘기</a></li>
                    </ul>
                </li>
                <li class="pb-3">
                    <a class="collapsed d-flex justify-content-between h3 text-decoration-none" href="#">
                        근력
                        <i class="pull-right fa fa-fw fa-chevron-circle-down mt-1"></i>
                    </a>
                    <ul id="collapseTwo" class="collapse list-unstyled pl-3">
                        <li><a class="text-decoration-none" href="#">Sport</a></li>
                        <li><a class="text-decoration-none" href="#">Luxury</a></li>
                    </ul>
                </li>
                <li class="pb-3">
                    <a class="collapsed d-flex justify-content-between h3 text-decoration-none" href="#">
                        기타 용품
                        <i class="pull-right fa fa-fw fa-chevron-circle-down mt-1"></i>
                    </a>
                    <ul id="collapseThree" class="collapse list-unstyled pl-3">
                        <li><a class="text-decoration-none" href="#">Bag</a></li>
                        <li><a class="text-decoration-none" href="#">Sweather</a></li>
                        <li><a class="text-decoration-none" href="#">Sunglass</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        <div class="col-lg-9">
            <div class="row">
                <div class="col-md-6">
                    <ul class="list-inline shop-top-menu pb-3 pt-1">
                        <li class="list-inline-item">
                            <p class="h3 text-dark text-decoration-none mr-3">
                                ${param.keyword}
                            </p>
                        </li>
                        <li class="list-inline-item">
                            <p class="h3 text-dark text-decoration-none">총 ${totalCnt} 개의 상품이 존재합니다.</p>
                        </li>
                    </ul>
                </div>
                <div class="col-md-6 pb-4">
                    <div class="d-flex justify-content-end gap-2">
                        <form action="" id="conditionSearch">
                            <button type="button" class="btn btn-primary" name="condition">낮은가격 순</button>
                            <button type="button" class="btn btn-primary" name="condition">높은가격 순</button>
                            <button type="button" class="btn btn-primary" name="condition">리뷰 점수 순</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="row">
                <c:forEach var="productDto" items="${list}">
                    <!-- 상품 카드 -->
                    <div class="col-md-4">
                        <div class="card mb-4 product-wap rounded-0">
                            <div class="card rounded-0">
                                <c:choose>
                                    <c:when test="${productDto.productImgPath eq null}">
                                        <img class="card-img rounded-0 img-fluid"
                                             src="<c:url value='/img/cardio.jpg'/>">
                                    </c:when>
                                    <c:otherwise>
                                        <img class="card-img rounded-0 img-fluid" src="${productDto.productImgPath}">
                                    </c:otherwise>
                                </c:choose>
                                <div class="card-img-overlay rounded-0 product-overlay d-flex align-items-center justify-content-center">
                                    <ul class="list-unstyled">
                                        <li><a class="btn btn-success text-white mt-2"
                                               href="<c:url value='/product/detail?productNo=${productDto.productNo}'/>"><i
                                                class="far fa-eye"></i></a></li>
                                        <li><a class="btn btn-success text-white mt-2" href="shop-single.html"><i
                                                class="fas fa-cart-plus"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="card-body">
                                <a href="shop-single.html" class="h3 text-decoration-none">상품 카테고리</a>
                                <ul class="w-100 list-unstyled d-flex justify-content-between mb-0">
                                    <li>${productDto.productName}</li>
                                    <li>리뷰개수 : ${productDto.reviewDtoList.size()}</li>
                                </ul>
                                <ul class="list-unstyled d-flex justify-content-center mb-1">
                                    <div class="star-ratings">
                                        <div class="fill-ratings" style="width: ${productDto.productReviewScore}%;">
                                            <span style="font-size: 1.8rem;">★★★★★</span>
                                        </div>
                                        <div class="empty-ratings">
                                            <span style="font-size: 1.8rem;">★★★★★</span>
                                        </div>
                                    </div>
                                </ul>
                                <p class="text-center mb-0">${productDto.productPrice}</p>
                            </div>
                        </div>
                    </div>
                    <!-- 상품 카드 -->
                </c:forEach>
                <!-- 페이징 -->
                <c:if test="${totalCnt!=null&&totalCnt!=0}">
                    <div class="row">
                        <ul class="pagination pagination-lg justify-content-center">
                            <c:if test="${ph.showPrev}">
                                <li class="page-item">
                                    <a class="page-link rounded-0 shadow-sm border-top-0 border-left-0 text-dark"
                                       href="<c:url value='/product/list${ph.sc.getQueryString(ph.beginPage-1)}'/>"><<</a>
                                </li>
                            </c:if>
                            <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                                <li>
                                    <a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark"
                                       href="<c:url value='/product/list${ph.sc.getQueryString(i)}'/>">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${ph.showNext}">
                                <li class="page-item">
                                    <a class="page-link rounded-0 shadow-sm border-top-0 border-left-0 text-dark"
                                       href="<c:url value='/product/list${ph.sc.getQueryString(ph.endPage+1)}'/>">>></a>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        var star_rating_width = $('.fill-ratings span').width();
        $('.star-ratings').width(star_rating_width);
    })
</script>
<script>
    $("button[name='condition']").click(function () {
        let option = "";
        if ($(this).html() == "낮은가격 순")
            option = 'lowPrice'
        else if ($(this).html() == "높은가격 순")
            option = 'highPrice'
        else
            option = 'review'

        const form = $("#conditionSearch")
        form.append($('<input>').attr({
            type: 'hidden',
            name: 'page',
            value: ${ph.sc.page}
        }))
        form.append($('<input>').attr({
            type: 'hidden',
            name: 'category',
            value: '${ph.sc.category}'
        }))
        form.append($('<input>').attr({
            type: 'hidden',
            name: 'option',
            value: option
        }))
        form.append($('<input>').attr({
            type: 'hidden',
            name: 'keyword',
            value: '${ph.sc.keyword}'
        }))
        form.submit()
    })
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>