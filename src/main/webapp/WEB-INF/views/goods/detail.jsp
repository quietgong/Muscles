<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<%@ include file="../nav.jsp" %>
<!-- 상품 정보 시작 -->
<section class="bg-light">
    <div class="container pb-5">
        <div class="row">
            <div class="col-lg-5 mt-5">
                <div class="card mb-3">
                    <c:choose>
                        <c:when test="${goodsDto.goodsImgPath eq null}">
                            <img class="card-img img-fluid" src="<c:url value='/img/logo.jpg'/>"
                                 alt="Card image cap" id="goods-detail">
                        </c:when>
                        <c:otherwise>
                            <img class="card-img img-fluid" src="${goodsDto.goodsImgPath}" alt="Card image cap"
                                 id="goods-detail">
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <!-- col end -->
            <div class="col-lg-7 mt-5">
                <div class="card">
                    <div class="card-body">
                        <h1 class="h2">[${goodsDto.goodsCategory}
                            > ${goodsDto.goodsCategoryDetail}] <strong>${goodsDto.goodsName}</strong></h1>
                        <p id="price" class="h3 py-2"><fmt:formatNumber value="${goodsDto.goodsPrice}"
                                                                        pattern="#,###"/></p>
                        <ul class="list-inline pb-3">
                            <li class="list-inline-item text-right">
                                <div class="star-ratings">
                                    <div class="fill-ratings" style="width: ${goodsDto.goodsReviewScore}%;">
                                        <span style="font-size: 1.8rem;">★★★★★</span>
                                    </div>
                                    <div class="empty-ratings">
                                        <span style="font-size: 1.8rem;">★★★★★</span>
                                    </div>
                                </div>
                            </li>
                        </ul>
                        <p class="py-2">
                                <span class="list-inline-item text-dark">
                                평점 : ${goodsDto.goodsReviewScore/20} | 리뷰 (${goodsDto.reviewDtoList.size()})
                                </span>
                        </p>
                        <p>${goodsDto.goodsDescription}</p>
                        <input type="hidden" name="goods-title" value="Activewear">
                        <div class="row">
                            <div class="col-auto">
                                <ul class="list-inline pb-3">
                                    <li class="list-inline-item text-right">
                                        수량
                                        <input type="hidden" name="goods-quanity" id="goods-quanity" value="1">
                                    </li>
                                    <li class="list-inline-item">
                                        <c:if test="${goodsDto.goodsStock<10}">
                                            <span style="color: red">${goodsDto.goodsStock}개 남음</span>
                                        </c:if>
                                    </li>
                                    <li class="list-inline-item"><span class="btn btn-success"
                                                                       id="btn-minus">-</span></li>
                                    <li class="list-inline-item"><span class="badge bg-secondary"
                                                                       id="var-value">1</span></li>
                                    <li class="list-inline-item"><span class="btn btn-success"
                                                                       id="btn-plus">+</span></li>
                                </ul>
                            </div>
                        </div>
                        <form id="orderForm" method="post" action="<c:url value='/order/checkout'/>">
                            <div class="row pb-3">
                                <div class="col d-grid">
                                    <button id="directOrder" type="submit" class="btn btn-success btn-lg"
                                            name="submit" value="buy">구매
                                    </button>
                                </div>
                                <div class="col d-grid">
                                    <button onclick="addCart()" type="button" class="btn btn-success btn-lg">장바구니 추가
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- 상품 정보 끝 -->
<!-- 상품 상세 시작 -->
<section class="py-5">
    <div class="container">
        <div class="row text-left p-2 pb-3">
            <h4>상품 설명</h4>
        </div>
        <div class="row justify-content-center">
        <c:forEach var="goodsImgDto" items="${goodsDto.goodsImgDtoList}">
                <div class="col-md-8 mt-5">
                    <img class="img-fluid" src="${goodsImgDto.uploadPath}"/>
                </div>
        </c:forEach>
        </div>
    </div>
</section>
<!-- 상품 상세 끝 -->
<!-- 작성 리뷰 시작 -->
<section class="py-5">
    <div class="container">
        <div class="row text-left p-2 pb-3">
            <h4>리뷰 목록</h4>
        </div>
        <c:forEach var="reviewDto" items="${goodsDto.reviewDtoList}">
        <div class="row">
            <div class="col">
                <h3>${reviewDto.goodsName}</h3>
                <ul class="list-unstyled d-flex mb-1">
                    <div class="star-ratings">
                        <div class="fill-ratings" style="width: ${reviewDto.score}%;">
                            <span style="font-size: 1.8rem;">★★★★★</span>
                        </div>
                        <div class="empty-ratings">
                            <span style="font-size: 1.8rem;">★★★★★</span>
                            <fmt:formatDate value="${reviewDto.createdDate}" pattern="yyyy-MM-dd" type="date"/>
                        </div>
                    </div>
                </ul>
            </div>
            <div class="col-md-12">
                <p>${reviewDto.userId}</p>
            </div>
            <div class="col-md-12">
                <span>${reviewDto.content}</span>
            </div>
            <div class="row flex-nowrap" style="overflow-x: auto">
                <c:forEach var="reviewImgDto" items="${reviewDto.reviewImgDtoList}">
                    <div class="col-md-2 mt-3">
                        <img style="cursor: pointer" src='${reviewImgDto.uploadPath}'
                             onclick="showImgDetail('${reviewImgDto.uploadPath}')" class="img-fluid"
                             data-bs-toggle="modal" data-bs-target="#imgModal">
                    </div>
                </c:forEach>
            </div>
            <hr class="mb-4 mt-5">
            </c:forEach>
        </div>
</section>
<!-- 작성 리뷰 끝 -->
<!-- 상품 문의 시작 -->
<section class="py-5">
    <div class="container form-control">
        <div class="row text-left p-2 pb-3">
            <div class="col-md-12">
                <h4 style="display: inline;">상품 문의</h4>
                <c:if test="${userId ne null && userId != 'admin'}">
                    <button style="float: right;" class="btn btn-outline-primary" type="button" data-bs-toggle="modal"
                            data-bs-target="#exampleModal" onclick="registerQuestion()">문의하기
                    </button>
                </c:if>
            </div>
        </div>
        <div class="row p-2 pb-3">
            <div class="col-md-12">
                <ul>
                    <li>상품문의 및 후기게시판을 통해 취소나 환불, 반품 등은 처리되지 않습니다.</li>
                    <li>가격, 판매자, 교환/환불 및 배송 등 해당 상품 자체와 관련 없는 문의는 1:1 채팅 문의를 이용해주세요.</li>
                    <li>"해당 상품 자체"와 관계없는 글, 양도, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 이동, 노출제한, 삭제 등의 조치가 취해질 수 있습니다.</li>
                    <li>공개 게시판이므로 전화번호, 메일 주소 등 고객님의 소중한 개인정보는 절대 남기지 말아주세요.</li>
                </ul>
            </div>
        </div>
        <hr style="border: 2px solid black;">
        <!-- 상품문의 문답 -->
        <div id="faqList" class="row mt-4 justify-content-center">
            <!-- AJAX 동적 추가 -->
        </div>
        <!-- 상품문의 문답 -->
    </div>
</section>
<!-- 상품 문의 끝 -->
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">상품문의 등록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div>
                    <textarea id="content" class="form-control mt-1" rows="6" cols="40"
                              placeholder="개인정보가 포함되지 않도록 유의해주세요."></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button id="registerBtn" type="button" class="btn btn-primary" data-bs-dismiss="modal">등록</button>
                <input type="hidden" id="type">
                <input type="hidden" id="faqNo">
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<!-- 이미지 확대 출력 모달 -->
<div class="modal fade" id="imgModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <img id="modalImg" src="" class="img-fluid">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script>
    let goodsNo = ${goodsDto.goodsNo};
    let goodsName = '${goodsDto.goodsName}';
    let goodsPrice = '${goodsDto.goodsPrice}';
    let goodsCategory = '${goodsDto.goodsCategory}';
    let goodsCategoryDetail = '${goodsDto.goodsCategoryDetail}';
    let goodsStock = ${goodsDto.goodsStock};
    let goodsImgPath = '${goodsDto.goodsImgPath}';

    $("#directOrder").on("click", function () {
        let orderData = []
        let data = {}
        data.goodsNo = goodsNo
        data.goodsName = goodsName
        data.goodsCategory = goodsCategory
        data.goodsCategoryDetail = goodsCategoryDetail
        data.goodsQty = $("#var-value").html()
        data.goodsPrice = goodsPrice * parseInt($("#var-value").html())
        data.goodsImgPath = goodsImgPath
        orderData.push(data)
        const form = $("#orderForm")
        form.append($('<input>').attr({
            type: 'hidden',
            name: 'orderData',
            value: JSON.stringify(orderData)
        }))
        form.submit()
    })

    function addCart() {
        let data = {}
        data.userId = '${userId}'
        data.goodsNo = goodsNo
        data.goodsName = goodsName
        data.goodsCategory = goodsCategory
        data.goodsQty = $("#var-value").html()
        data.goodsPrice = goodsPrice * parseInt($("#var-value").html())
        commonAjax("/muscles/cart/", data, "POST", function (res) {
            res === "ADD_OK" ? alert("장바구니에 추가하였습니다.") : alert("장바구니에 이미 존재합니다.")
            getCartItemsNum()
        })
    }

    loadFaqData()
    function loadFaqData() { // FAQ 데이터 불러오기
        commonAjax("/muscles/goods/faq/"+goodsNo, null, "GET", function (res) {
            console.log(res)
            let target = $("#faqList")
            target.empty()
            target.append(toHtml(res))
        })
        let toHtml = function (items) {
            let tmp = "";
            items.forEach(function (item) {
                /* 질문 */
                tmp += '<div class="col-md-10 mt-2">'
                tmp += '<button class="btn btn-secondary disabled" type="button">문의</button>'
                tmp += '<span class="px-3" style="font-size: 1.2rem">' + item.question + '</span>'
                tmp += '<span class="px-3" style="float:right;font-style: italic; text-align: right;">' + item.createdDate + '</span>'
                // 관리자만 답변 작성 가능
                if ('${userId}' === 'admin' && item.answer == null)
                    tmp += '<button onclick="registerAnswer(' + item.faqNo + ')" class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#exampleModal" style="float: right">답변 등록</button>'
                tmp += '</div>'

                /* 답변 */
                if (item.answer !== null) {
                    tmp += '<div class="col-md-10 mt-2" style="background-color: aliceblue">'
                    tmp += '<button class="btn btn-outline-primary disabled" type="button">답변</button>'
                    tmp += '<span class="px-3" style="font-size: 1.2rem">' + item.answer + '</span>'
                    tmp += '<span class="px-3" style="float:right;font-style: italic; text-align: right;">' + item.createdDate + '</span>'
                    tmp += '</div>'
                }
            })
            return tmp;
        }
    }

    function registerQuestion() {
        $("#type").val('question')
    }

    function registerAnswer(faqNo) {
        $("#type").val('answer')
        $("#faqNo").val(faqNo)
    }

    $("#registerBtn").on("click", function () {
        if ($("#content").val() === '') {
            alert("문의 내용을 입력해주세요")
            return false
        }
        let type = $("#type").val()
        let data = {userId: '${userId}', goodsNo: goodsNo};
        if (type === 'question')
            data.question = $("#content").val()
        else {
            data.answer = $("#content").val()
            data.faqNo = $("#faqNo").val()
        }
        commonAjax("/muscles/goods/faq/", data, "POST", function () {
            alert("등록되었습니다.")
            loadFaqData()
            $("#content").val("")
        })
    })
</script>
<%@ include file="../footer.jsp" %>