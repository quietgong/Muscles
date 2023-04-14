<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<!-- nav -->
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
                        <h1 class="h2">${goodsDto.goodsName}</h1>
                        <p id="price" class="h3 py-2">${goodsDto.goodsPrice}</p>
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
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod temp incididunt
                            ut labore et dolore magna aliqua. Quis ipsum suspendisse. Donec condimentum elementum
                            convallis. Nunc sed orci a diam ultrices aliquet interdum quis nulla.</p>
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
                                            <span>${goodsDto.goodsStock}개 남음</span>
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
        <c:forEach var="goodsImgDto" items="${goodsImgDtoList}">
            <div class="row justify-content-center">
                <div class="col-md-8 mt-5">
                    <img class="img-fluid" src="${goodsImgDto.uploadPath}"/>
                </div>
            </div>
        </c:forEach>
    </div>
</section>
<!-- 상품 상세 끝 -->

<!-- 작성 리뷰 시작 -->
<section class="py-5">
    <div class="container">
        <div class="row text-left p-2 pb-3">
            <h4>리뷰 목록</h4>
        </div>
        <c:forEach var="reviewDto" items="${reviewDtoList}">
        <div class="row">
            <div class="col">
                <p>${reviewDto.userId}</p>
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
                <h3>${reviewDto.goodsName}</h3>
            </div>
            <div class="col-md-12">
                <span>${reviewDto.content}</span>
            </div>
            <hr class="mb-4 mt-5">
            </c:forEach>
        </div>
        <div class="row">
        </div>
</section>
<!-- 작성 리뷰 끝 -->

<!-- 상품 문의 시작 -->
<section class="py-5">
    <div class="container form-control">
        <div class="row text-left p-2 pb-3">
            <div class="col-md-12">
                <h4 style="display: inline;">상품 문의</h4>
                <button style="float: right;" class="btn btn-outline-primary" type="button" data-bs-toggle="modal"
                        data-bs-target="#exampleModal"
                        onclick="registerContent('question')">문의하기
                </button>
            </div>
        </div>
        <div class="row p-2 pb-3">
            <div class="col-md-12">
                <ul>
                    <li>상품문의 및 후기게시판을 통해 취소나 환불, 반품 등은 처리되지 않습니다.</li>
                    <li>가격, 판매자, 교환/환불 및 배송 등 해당 상품 자체와 관련 없는 문의는 고객센터 내 1:1 문의하기를 이용해주세요.</li>
                    <li>"해당 상품 자체"와 관계없는 글, 양도, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 이동, 노출제한, 삭제 등의 조치가 취해질 수 있습니다.</li>
                    <li>공개 게시판이므로 전화번호, 메일 주소 등 고객님의 소중한 개인정보는 절대 남기지 말아주세요.</li>
                </ul>
            </div>
        </div>
        <hr style="border: 2px solid black;">
        <!-- 상품문의 문답 -->
        <div class="row mt-4">
            <!-- 질문 -->
            <div class="col-md-12">
                <button class="btn btn-secondary disabled" type="button">질문</button>
                <!-- 관리자만 답변 작성 가능 -->
                <c:if test="${isAdmin == 'true'}">
                    <button class="btn btn-primary" type="button">답변 작성</button>
                </c:if>
                <p style="float: right;">작성 날짜</p>
            </div>
            <div class="col-md-12 mt-4">
                <span>질문입니다.</span>
            </div>
        </div>
        <div class="row mt-4">
            <!-- 답변 -->
            <div class="col-md-12 mt-4">
                <span>  </span>
                <button class="btn btn-outline-primary disabled" type="button">답변</button>
                <p style="float: right;">작성 날짜</p>
            </div>
            <div class="col-md-12 mt-4">
                <span>  </span>
                <span>답변입니다</span>
            </div>
        </div>

        <div id="faqList" class="col-md-12">
            <!-- AJAX 동적 추가 -->
        </div>
    </div>
    <!-- 상품문의 문답 -->
</section>
<!-- 상품 문의 끝 -->

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">상품문의 등록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div>
                    <textarea id="content" class="form-control mt-1" rows="6" cols="40"
                              placeholder="개인정보가 포함되지 않도록 유의해주세요."></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button id="registerBtn" type="button" class="btn btn-primary">등록</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->

<script>
    let goodsNo = ${goodsDto.goodsNo};
    let goodsName = '${goodsDto.goodsName}';
    let goodsPrice = '${goodsDto.goodsPrice}';
    let goodsCategory = '${goodsDto.goodsCategory}';
    let goodsStock = ${goodsDto.goodsStock};
    let goodsImgPath = '${goodsDto.goodsImgPath}';

    $("#directOrder").on("click", function () {
        let orderData = []
        let data = {}
        data.goodsNo = goodsNo
        data.goodsName = goodsName
        data.goodsCategory = goodsCategory
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
        data.goodsNo = goodsNo
        data.goodsName = goodsName
        data.goodsCategory = goodsCategory
        data.goodsQty = $("#var-value").html()
        data.goodsPrice = goodsPrice * parseInt($("#var-value").html())
        console.log(JSON.stringify(data))
        $.ajax({
            type: "POST",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/cart/",
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            data: JSON.stringify(data),
            success: function (res) {
                if (res == "ADD_OK")
                    alert("장바구니에 추가하였습니다.")
                else
                    alert("장바구니에 이미 존재합니다.")
                getCartItemsNum()
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    }
</script>
<script>
    // FAQ
    let loginUser = '${userId}'
    $("#closeBtn").on("click", function () {
        $("#myModal").css("display", "none")
    })

    function registerContent(type, faqNo) {
        // 모달창 출력
        $("#myModal").css("display", "block")
        $("#registerBtn").on("click", function () {
            let jsonData = {};
            jsonData.userId = loginUser
            jsonData.goodsNo = goodsNo
            if (type == 'question')
                jsonData.question = $("#content").val()
            else {
                jsonData.answer = $("#content").val()
                jsonData.faqNo = faqNo
            }
            console.log(JSON.stringify(jsonData))
            $.ajax({
                type: "POST",            // HTTP method type(GET, POST) 형식이다.
                url: "/muscles/goods/faq/", // 컨트롤러에서 대기중인 URL 주소이다.
                headers: {              // Http header
                    "Content-Type": "application/json",
                },
                data: JSON.stringify(jsonData),
                success: function () {
                    alert("내용이 등록되었습니다.")
                    $("#myModal").css("display", "none")
                    // 2. 문의내용을 작성 -> 등록 -> faq 데이터가 생성되고 데이터를 다시 불러온다.
                    loadFaqData()
                },
                error: function () {
                    console.log("통신 실패")
                }
            })
        })
    }

    loadFaqData()

    function loadFaqData() {
        $.ajax({
            type: "GET",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/goods/faq/" + goodsNo,
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function (res) {
                $("#faqList").html(toHtml(res))
            },
            error: function () {
                alert("AJAX 통신 실패")
            }
        })
        let toHtml = function (items) {
            let tmp = "";
            items.forEach(function (item) {
                tmp += '<hr>'
                tmp += '<div>'
                tmp += '<input type="button" value="질문"/>'
                if (item.answer == null && loginUser == 'admin')
                    tmp += '<input onclick="registerContent(\'answer\'' + ',' + item.faqNo + ')" type="button" value="답변 등록하기"/><br/></div>'
                tmp += '<div class="goods-detail-faq-container">'
                tmp += '<div class="goods-detail-faq-item">'
                tmp += '<span>' + item.question + '</span>'
                tmp += '</div>'
                tmp += '<div class="goods-detail-faq-item">'
                tmp += '<p>' + '작성자 : ' + item.userId + '</p>'
                tmp += '<p>' + '작성일자 : ' + item.createdDate + '</p>'
                tmp += '</div></div></div>'
                if (item.answer == null)
                    tmp += '<div style="display:none;">'
                else
                    tmp += '<div>'
                tmp += '<input type="button" value="답변"/><br/>'
                tmp += '<div class="goods-detail-faq-container">'
                tmp += '<div class="goods-detail-faq-item">'
                tmp += '<span>' + item.answer + '</span>'
                tmp += '</div>'
                tmp += '<div class="goods-detail-faq-item">'
                tmp += '<p>' + '작성자 : 관리자</p>'
                tmp += '<p>' + '작성일자 : ' + item.replyDate + '</p>'
                tmp += '</div></div></div>'
            })
            return tmp;
        }
    }
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>
