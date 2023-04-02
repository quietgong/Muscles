<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
<form id="orderForm" method="post" action="<c:url value='/order'/>">
    <div class="product-detail-container">
        <div class="product-detail-item">
            <c:choose>
                <c:when test="${productDto.productImgPath eq null}">
                    <img style="width: 250px; height: 250px;" src="<c:url value='/img/logo.jpg'/>">
                </c:when>
                <c:otherwise>
                    <img style="width: 250px; height: 250px;" src="${productDto.productImgPath}">
                </c:otherwise>
            </c:choose>
            <div class="product-detail-item-detail">
                <span id="category" style="font-size:25px; font-weight:bold;">${productDto.productCategory}</span>
                <span id="name" style="font-size:25px; font-weight:bold;">${productDto.productName}</span>
                <div>
                    <span class="star">★★★★★<span style="width: ${productScore}%;">★★★★★</span></span>
                </div>
                <span style="font-size: small">리뷰 : ${reviewDtoList.size()}개</span>
                <hr/>
                <c:if test="${productDto.productStock<10}">
                    <span style="font-size:15px; color: red">${productDto.productStock}개 남음</span>
                </c:if>

                <a href="#" onclick='count("minus"); return false;'><span
                        style="font-size: 25px; font-weight: bold">-</span></a>
                <span id="qty" style="font-size: 25px; font-weight: bold">1</span>
                <a href="#" onclick='count("plus"); return false;'><span
                        style="font-size: 25px; font-weight: bold">+</span></a>
                <span id="price" style="float: right">${productDto.productPrice}</span>
            </div>
            <div class="product-detail-item-detail" style="margin: auto">
                <input onclick="addCart()" type="button" value="장바구니 담기"/>
                <a href="<c:url value='/order/page'/>">
                    <input id="directOrder" type="submit" value="바로구매"/>
                </a>
            </div>
        </div>
    </div>
</form>
<!-- 상품 상세 -->
<h1>제품 상세</h1>
<div class="product-detail-container">
    <div style="display: flex; flex-direction: column">
    <c:forEach var="productImgDto" items="${productImgDtoList}">
    <div class="product-detail-item">
        <img style="height: 200px; width: 300px;" src="${productImgDto.uploadPath}"/>
    </div>
    </c:forEach>
    </div>
</div>
<hr/>
<!-- 상품 리뷰 -->
<h1>상품 리뷰</h1>
<!-- 작성한 리뷰 -->
<div class="product-detail-review-container">
    <div>
    <c:forEach var="reviewDto" items="${reviewDtoList}">
        <div>
        <img style="width: 100px; height: 100px" src="${productDto.productImgPath}"/>
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
    </c:forEach>
    </div>
</div>
<hr/>
<!-- 작성한 리뷰 끝 -->

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
    $("#directOrder").on("click", function () {
        let data = []
        let tmp={}
        tmp.productNo = ${productDto.productNo};
        tmp.productName = $("#name").html()
        tmp.productCategory = $("#category").html()
        tmp.productQty = $("#qty").html()
        tmp.productPrice = $("#price").html()
        tmp.productImgPath = '${productDto.productImgPath}'
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
        data.productNo = ${productDto.productNo};
        data.productName = $("#name").html()
        data.productCategory = $("#category").html()
        data.productQty = $("#qty").html()
        data.productPrice = $("#price").html()
        console.log(JSON.stringify(data))
        $.ajax({
            type: "POST",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/cart/add", // 컨트롤러에서 대기중인 URL 주소이다.
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

    // 수량변경
    function count(type) {
        const price = parseInt($("#price").html())
        const qty = parseInt($("#qty").html())
        let number = qty
        let amount = price / number

        if (type == "minus") {
            if (number > 1)
                number = parseInt(number) - 1
        } else {
            number = parseInt(number) + 1
        }
        $("#qty").html(number)
        amount = parseInt(amount) * number
        $("#price").html(amount)
    }
</script>
<script>
    let loginUser = '${pageContext.request.session.getAttribute('id')}'

    $("#closeBtn").on("click", function (){
        $("#myModal").css("display", "none")
    })

    // 문의하기, 답변등록 버튼 클릭
    function registerContent(type, faqNo) {
        // 모달창 출력
        $("#myModal").css("display", "block")
        console.log(faqNo)
        $("#registerBtn").on("click", function () {
            let jsonData = {};
            jsonData.userId = loginUser
            jsonData.productNo =${productDto.productNo};
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
            url: "/muscles/product/faq/" + ${productDto.productNo},
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function (res) {
                console.log(res)
                $("#faqList").html(toHtml(res))
                console.log("GET FAQ DATA")
            },
            error: function () {
                console.log("통신 실패")
            }
        })
        let toHtml = function (items) {
            let tmp = "";
            items.forEach(function (item) {
                tmp += '<hr>'
                tmp += '<div>'
                tmp += '<input type="button" value="질문"/>'
                if (item.answer == null && loginUser == 'admin')
                    tmp += '<input onclick="registerContent(\'answer\'' +','+item.faqNo + ')" type="button" value="답변 등록하기"/><br/></div>'
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
