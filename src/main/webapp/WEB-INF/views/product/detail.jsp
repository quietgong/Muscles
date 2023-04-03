<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 상품 정보 시작 -->
<form id="orderForm" method="post" action="<c:url value='/order'/>">
    <section class="bg-light">
        <div class="container pb-5">
            <div class="row">
                <div class="col-lg-5 mt-5">
                    <div class="card mb-3">
                        <c:choose>
                            <c:when test="${productDto.productImgPath eq null}">
                                <img class="card-img img-fluid" src="<c:url value='/img/logo.jpg'/>"
                                     alt="Card image cap" id="product-detail">
                            </c:when>
                            <c:otherwise>
                                <img class="card-img img-fluid" src="${productDto.productImgPath}" alt="Card image cap"
                                     id="product-detail">
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <!-- col end -->
                <div class="col-lg-7 mt-5">
                    <div class="card">
                        <div class="card-body">
                            <h1 class="h2">${productDto.productName}</h1>
                            <p id="price" class="h3 py-2">${productDto.productPrice}</p>
                            <ul class="list-inline pb-3">
                                <li class="list-inline-item text-right">
                                    <div class="star-ratings">
                                        <div class="fill-ratings" style="width: 50%;">
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
                                평점 : ${productDto.productReviewScore} | 리뷰 (${productDto.reviewDtoList.size()})
                                </span>
                            </p>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod temp incididunt
                                ut labore et dolore magna aliqua. Quis ipsum suspendisse. Donec condimentum elementum
                                convallis. Nunc sed orci a diam ultrices aliquet interdum quis nulla.</p>
                            <input type="hidden" name="product-title" value="Activewear">
                            <div class="row">
                                <div class="col-auto">
                                    <ul class="list-inline pb-3">
                                        <li class="list-inline-item text-right">
                                            수량
                                            <input type="hidden" name="product-quanity" id="product-quanity" value="1">
                                        </li>
                                        <li class="list-inline-item">
                                            <c:if test="${productDto.productStock<10}">
                                                <span>${productDto.productStock}개 남음</span>
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
                            <div class="row pb-3">
                                <div class="col d-grid">
                                    <a href="<c:url value='/order/page'/>">
                                        <button id="directOrder" type="submit" class="btn btn-success btn-lg"
                                                name="submit" value="buy">구매
                                        </button>
                                    </a>
                                </div>
                                <div class="col d-grid">
                                    <button onclick="addCart()" type="button" class="btn btn-success btn-lg"
                                            name="submit" value="addtocard">장바구니 추가
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</form>
<!-- 상품 정보 끝 -->

<!-- 상품 상세 시작 -->
<section class="py-5">
    <div class="container">
        <div class="row text-left p-2 pb-3">
            <h4>상품 설명</h4>
        </div>
        <c:forEach var="productImgDto" items="${productImgDtoList}">
            <div class="row">
                <img src="${productImgDto.uploadPath}"/>
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
                <div>
                    <img src="${productDto.productImgPath}"/>
                </div>
                <div class="product-detail-review-item"><h3>${reviewDto.productName}</h3></div>
                <div class="product-detail-review-item">
                    <span>${reviewDto.content}</span>
                </div>
                <div class="product-detail-review-item">
                    <div>
                        <span class="star">★★★★★<span style="width: ${reviewDto.score}%">★★★★★</span></span>
                    </div>
                    <span style="font-size:25px; font-weight:bold;">작성일자 :
                <fmt:formatDate value="${reviewDto.createdDate}" pattern="yyyy-MM-dd" type="date"/>
            </span>
                </div>
            </div>
        </c:forEach>
    </div>
</section>
<!-- 작성 리뷰 끝 -->

<h1>상품 문의</h1>
<!-- admin이 접속해있으면 type=hidden 그렇지 않으면 button -->
<c:set var="isAdmin" value="${pageContext.request.session.getAttribute('id')=='admin' ? 'hidden' : 'button'}"/>
<input type="${isAdmin}" onclick="registerContent('question')" value="문의하기"/>
<div id="faqList">
    <!-- AJAX 동적 추가 -->
</div>

<!-- 모달 -->
<div id="myModal" class="modal">
    <div class="modal-content">
        <h3 style="text-align: center; font-style: italic;">상품 문의</h3>
        <div id="modalList">
            <div>
                <textarea id="content" rows="6" cols="40"></textarea>
            </div>
            <div>
                <span style="font-size: 15px;">개인정보가 포함되지 않도록 유의해주세요.</span>
            </div>
        </div>
        <div style="text-align: center;">
            <button id="registerBtn">등록</button>
            <button id="closeBtn">닫기</button>
        </div>
    </div>
</div>
<!-- 모달 -->
<script>
    let productNo = ${productDto.productNo};
    let productName = '${productDto.productNo}';
    let productPrice = '${productDto.productPrice}';
    let productCategory = '${productDto.productNo}';
    let productStock = ${productDto.productStock};
    let productImgPath = '${productDto.productImgPath}';

    $("#directOrder").on("click", function () {
        let data = []
        let tmp = {}
        tmp.productNo = productNo
        tmp.productName = productName
        tmp.productCategory = productCategory
        tmp.productQty = $("#var-value").html()
        tmp.productPrice = productPrice * parseInt($("#var-value").html())
        tmp.productImgPath = productImgPath
        data.push(tmp);

        const form = $("#orderForm")
        form.append($('<input>').attr({
            type: 'hidden',
            name: 'jsonData',
            value: JSON.stringify(data)
        }))
        form.submit()
    })

    function addCart() {
        let data = {}
        data.productNo = productNo
        data.productName = productName
        data.productCategory = productCategory
        data.productQty = $("#var-value").html()
        data.productPrice = productPrice * parseInt($("#var-value").html())
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
            jsonData.productNo = productNo
            if (type == 'question')
                jsonData.question = $("#content").val()
            else {
                jsonData.answer = $("#content").val()
                jsonData.faqNo = faqNo
            }
            console.log(JSON.stringify(jsonData))
            $.ajax({
                type: "POST",            // HTTP method type(GET, POST) 형식이다.
                url: "/muscles/product/faq/", // 컨트롤러에서 대기중인 URL 주소이다.
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
            url: "/muscles/product/faq/" + productNo,
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
                tmp += '<div class="product-detail-faq-container">'
                tmp += '<div class="product-detail-faq-item">'
                tmp += '<span>' + item.question + '</span>'
                tmp += '</div>'
                tmp += '<div class="product-detail-faq-item">'
                tmp += '<p>' + '작성자 : ' + item.userId + '</p>'
                tmp += '<p>' + '작성일자 : ' + item.createdDate + '</p>'
                tmp += '</div></div></div>'
                if (item.answer == null)
                    tmp += '<div style="display:none;">'
                else
                    tmp += '<div>'
                tmp += '<input type="button" value="답변"/><br/>'
                tmp += '<div class="product-detail-faq-container">'
                tmp += '<div class="product-detail-faq-item">'
                tmp += '<span>' + item.answer + '</span>'
                tmp += '</div>'
                tmp += '<div class="product-detail-faq-item">'
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
