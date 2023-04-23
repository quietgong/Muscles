<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<%@ include file="../nav.jsp" %>
<form id="conditionForm">
</form>
<div class="container py-5">
    <div class="row">
        <div class="col-lg-3">
            <h1 class="h2 pb-4" style="font-weight: bold">Categories</h1>
            <ul class="list-unstyled templatemo-accordion">
                <li class="pb-3">
                    <a class="collapsed d-flex justify-content-between h3 text-decoration-none"
                       href="">
                        유산소
                        <i class="fa fa-fw fa-chevron-circle-down mt-1"></i>
                    </a>
                    <ul id="cardioList" class="collapse show list-unstyled pl-3">
                    </ul>
                </li>
                <li class="pb-3">
                    <a class="collapsed d-flex justify-content-between h3 text-decoration-none"
                       href="">근력
                        <i class="pull-right fa fa-fw fa-chevron-circle-down mt-1"></i>
                    </a>
                    <ul id="collapseTwo" class="collapse list-unstyled pl-3">
                    </ul>
                </li>
                <li class="pb-3">
                    <a class="collapsed d-flex justify-content-between h3 text-decoration-none"
                       href="">기타 용품
                        <i class="pull-right fa fa-fw fa-chevron-circle-down mt-1"></i>
                    </a>
                    <ul id="collapseThree" class="collapse list-unstyled pl-3">
                    </ul>
                </li>
            </ul>
            <div class="form-control mt-5">
                <span class="h4 pb-3 mt-2" style="font-weight: bold">가격 범위</span>
                <button class="btn btn-primary" style="float: right;" type="button" onclick="priceSearch()">검색</button>
                <div class="input-group gap-3">
                    <input id="minPrice" style="text-align: center;" placeholder="최소 가격" value="${param.minPrice}"
                           class="form-control" type="number"/>
                    <label class="form-label mt-2">~</label>
                    <input id="maxPrice" style="text-align: center;" placeholder="최대 가격" value="${param.maxPrice}"
                           class="form-control" type="number"/>
                </div>
            </div>
        </div>
        <div class="col-lg-9">
            <div class="row">
                <div class="col-md-6">
                    <ul class="list-inline shop-top-menu pb-3 pt-1">
                        <c:if test="${param.keyword ne '' && param.keyword ne null}">
                            <li class="list-inline-item">
                                <p class="h3 text-dark text-decoration-none mr-3">
                                    키워드<strong> ${param.keyword}</strong> 검색 결과
                                </p>
                            </li>
                        </c:if>
                        <li class="list-inline-item mt-3">
                            <p class="h3 text-dark text-decoration-none">총 <fmt:formatNumber value="${ph.totalCnt }"
                                                                                             pattern="#,###"/> 개의 상품이
                                존재합니다.</p>
                        </li>
                    </ul>
                </div>
                <div class="col-md-6 pb-4">
                    <div class="d-flex justify-content-end gap-2">
                        <button type="button" class="btn btn-primary" onclick="optionSearch(this)" value="lowPrice">낮은가격
                            순
                        </button>
                        <button type="button" class="btn btn-primary" onclick="optionSearch(this)" value="highPrice">
                            높은가격 순
                        </button>
                        <button type="button" class="btn btn-primary" onclick="optionSearch(this)" value="review">리뷰 점수
                            순
                        </button>
                    </div>
                </div>
            </div>
            <div class="row">
                <c:forEach var="goodsDto" items="${list}">
                    <!-- 상품 카드 -->
                    <div class="col-md-4">
                        <div class="card mb-4 product-wap rounded-0">
                            <div class="card rounded-0">
                                <c:choose>
                                    <c:when test="${goodsDto.goodsImgPath eq null}">
                                        <img class="card-img rounded-0 img-fluid"
                                             src="<c:url value='/img/cardio.jpg'/>">
                                    </c:when>
                                    <c:otherwise>
                                        <img class="card-img rounded-0 img-fluid" src="${goodsDto.goodsImgPath}">
                                    </c:otherwise>
                                </c:choose>
                                <div class="card-img-overlay rounded-0 product-overlay d-flex align-items-center justify-content-center">
                                    <ul class="list-unstyled">
                                        <li><a class="btn btn-success text-white mt-2"
                                               href="<c:url value='/goods/detail?goodsNo=${goodsDto.goodsNo}'/>"><i
                                                class="far fa-eye"></i></a></li>
                                        <li><a class="btn btn-success text-white mt-2"
                                               onclick="addCart(${goodsDto.goodsNo},'${goodsDto.goodsName}','${goodsDto.goodsCategory}',${goodsDto.goodsPrice})"><i
                                                class="fas fa-cart-plus"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="card-body">
                                <a href="<c:url value='/goods/detail?goodsNo=${goodsDto.goodsNo}'/>"
                                   class="h3 text-decoration-none">${goodsDto.goodsCategory}
                                    > ${goodsDto.goodsCategoryDetail}</a>
                                <ul class="w-100 list-unstyled d-flex justify-content-between mb-0">
                                    <li>${goodsDto.goodsName}</li>
                                    <li>리뷰개수 : <fmt:formatNumber value="${goodsDto.reviewDtoList.size()}"
                                                                 pattern="#,###"/></li>
                                </ul>
                                <ul class="list-unstyled d-flex justify-content-center mb-1">
                                    <div class="star-ratings">
                                        <div class="fill-ratings" style="width: ${goodsDto.goodsReviewScore}%;">
                                            <span style="font-size: 1.8rem;">★★★★★</span>
                                        </div>
                                        <div class="empty-ratings">
                                            <span style="font-size: 1.8rem;">★★★★★</span>
                                        </div>
                                    </div>
                                </ul>
                                <p class="text-center mb-0"><fmt:formatNumber value="${goodsDto.goodsPrice}"
                                                                              pattern="#,###"/></p>
                            </div>
                        </div>
                    </div>
                    <!-- 상품 카드 -->
                </c:forEach>
                <!-- 페이징 -->
                <c:if test="${ph.totalCnt!=null&&ph.totalCnt!=0}">
                    <div class="row">
                        <ul class="pagination pagination-lg justify-content-center">
                            <c:if test="${ph.showPrev}">
                                <li class="page-item">
                                    <a class="page-link rounded-0 shadow-sm border-top-0 border-left-0 text-dark"
                                       href="<c:url value='/goods/list${ph.sc.getQueryString(ph.beginPage-1)}'/>"><<</a>
                                </li>
                            </c:if>
                            <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                                <li>
                                    <a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark"
                                       href="<c:url value='/goods/list${ph.sc.getQueryString(i)}'/>">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${ph.showNext}">
                                <li class="page-item">
                                    <a class="page-link rounded-0 shadow-sm border-top-0 border-left-0 text-dark"
                                       href="<c:url value='/goods/list${ph.sc.getQueryString(ph.endPage+1)}'/>">>></a>
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
    // 장바구니 추가
    function addCart(goodsNo, goodsName, goodsCategory, goodsPrice) {
        let data = {}
        data.userId = '${userId}'
        data.goodsNo = goodsNo
        data.goodsName = goodsName
        data.goodsCategory = goodsCategory
        data.goodsQty = 1
        data.goodsPrice = goodsPrice
        commonAjax("/muscles/cart/", data, "POST", function (res) {
            res === "ADD_OK" ? alert("장바구니에 추가하였습니다.") : alert("장바구니에 이미 존재합니다.")
            getCartItemsNum()
        })
    }

    $(document).ready(function () {
        let star_rating_width = $('.fill-ratings span').width();
        $('.star-ratings').width(star_rating_width);
    })
    // 카테고리 불러오기
    loadGoodsCategories()

    function loadGoodsCategories() {
        commonAjax("/muscles/goods/category", null, "GET", function (res) {
                addCategoryList(res)
        })
    }
    function addCategoryList(items) {
        items.forEach(function (item) {
            let link = "<li><a style='cursor: pointer' class=\"text-decoration-none\" onclick=\"subCategorySearch(this)\">" + item.subCategory + "</a></li>";
            if (item.category === '유산소')
                $("#cardioList").append(link)
            else if (item.category === '근력')
                $("#collapseTwo").append(link)
            else
                $("#collapseThree").append(link)
        })
    }
</script>
<script>
    // 조건 검색
    let conditions = {
        page: '${ph.sc.page}',
        category: '${ph.sc.category}',
        option: '${ph.sc.option}',
        subCategory: '${ph.sc.subCategory}',
        keyword: '${ph.sc.keyword}',
        minPrice: '${ph.sc.minPrice}',
        maxPrice: '${ph.sc.maxPrice}',
    }

    function priceSearch() {
        conditions.minPrice = $("#minPrice").val()
        conditions.maxPrice = $("#maxPrice").val()
        appendForm(conditions)
    }

    function keywordSearch(e) {
        conditions.keyword = $(e).prev().val()
        appendForm(conditions)
    }

    function optionSearch(e) {
        conditions.option = $(e).val()
        appendForm(conditions)
    }

    function subCategorySearch(e) {
        conditions.subCategory = $(e).html()
        appendForm(conditions)
    }

    function appendForm(conditions) {
        const form = $("#conditionForm")
        Object.keys(conditions).forEach(function (key) {
            form.append($('<input>').attr({
                type: 'hidden', name: key, value: conditions[key]
            }))
        })
        form.submit()
    }
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>