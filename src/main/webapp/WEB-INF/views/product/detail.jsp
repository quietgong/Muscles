<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Muscles</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
    <script src="https://code.jquery.com/jquery-1.11.3.js"/>
</head>
<body>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
<form id="orderForm" method="post" action="<c:url value='/product/order'/>">
    <div class="product-detail-container">
        <div class="product-detail-item">
            <img src="http://via.placeholder.com/250?text=mypage"/>
            <div class="product-detail-item-detail">
                <span id="category" style="font-size:25px; font-weight:bold;">${productDto.productCategory}</span>
                <span id="name" style="font-size:25px; font-weight:bold;">${productDto.productName}</span>
                <div>
                    <span class="star">★★★★★<span>★★★★★</span></span>
                </div>
                <span style="font-size: small">리뷰 : 2,145개</span>
                <hr/>
                <span style="font-size:25px; font-weight:bold;">${productDto.productStock}</span>

                <a href="#" onclick='count("minus"); return false;'><span
                        style="font-size: 25px; font-weight: bold">-</span></a>
                <span id="qty" style="font-size: 25px; font-weight: bold">1</span>
                <a href="#" onclick='count("plus"); return false;'><span
                        style="font-size: 25px; font-weight: bold">+</span></a>
                <span id="price" style="float: right">124000</span>
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
    <div class="product-detail-item">
        <img src="http://via.placeholder.com/800?text=mypage"/>
    </div>
</div>
<hr/>
<!-- 상품 리뷰 -->
<h1>상품 리뷰</h1>
<!-- 작성한 리뷰 -->
<div class="product-detail-review-container">
    <img src="http://via.placeholder.com/100X100/000000/ffffff"/>
    <div class="product-detail-review-item"><h3>상품명</h3></div>
    <div class="product-detail-review-item">
        <span
        >Lorem ipsum dolor sit amet consectetur, adipisicing elit. Libero
          voluptates aliquam quo possimus ab consectetur expedita minus illo.
          Aut, quo? Rerum numquam nobis esse necessitatibus vitae tempora
          asperiores, libero porro.</span
        >
    </div>
    <div class="product-detail-review-item">
        <div>
            <span class="star">★★★★★<span>★★★★★</span></span>
        </div>
        <span style="font-size:25px; font-weight:bold;">주문일자 : 2022-03-20</span>
    </div>
    <div class="product-detail-review-item">
        <span
        ><a href="login.html">수정</a> |
          <a href="register.html">삭제</a></span
        ><br/>
    </div>
</div>
<hr/>
<!-- 작성한 리뷰 끝 -->

<!-- 상품 문의 -->
<h1>상품 문의</h1>
<input id="modalBtn" type="button" value="문의하기"/>
<div><input type="button" value="질문"/><br/></div>
<div class="product-detail-faq-container">
    <div class="product-detail-faq-item" style="width: 50%;">
        <span
        >Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatem
          at animi tempora possimus, libero distinctio atque, sunt error ratione
          sint vitae illum esse! Repudiandae corrupti perferendis est sit! Ad,
          nihil.</span
        >
    </div>
    <div class="product-detail-faq-item">
        <span style="font-size: 15px;">2023-02-10</span>
        <span style="font-size: 15px;">15:30:42</span>
    </div>
</div>
<hr>
<div><input type="button" value="답변"/><br/></div>
<div class="product-detail-faq-container">
    <div class="product-detail-faq-item" style="width: 50%;">
        <span
        >Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatem
          at animi tempora possimus, libero distinctio atque, sunt error ratione
          sint vitae illum esse! Repudiandae corrupti perferendis est sit! Ad,
          nihil.</span
        >
    </div>
    <div class="product-detail-faq-item">
        <span style="font-size: 15px;">2023-02-10</span>
        <span style="font-size: 15px;">15:30:42</span>
    </div>
</div>
<!-- 모달 -->
<dialog>
    <h3 style="background-color: rgb(227, 217, 204)">상품 문의</h3>
    <div class="product-detail-modal-container">
        <div class="product-detail-modal-item">
            <h3>문의내용</h3>
        </div>
        <div class="product-detail-modal-item">
            <textarea rows="4" cols="20"></textarea>
        </div>
    </div>
    <div class="product-detail-modal-container">
        <div class="product-detail-modal-item">
            <span style="font-size: 15px;">개인정보가 포함되지 않도록 유의해주세요.</span>
        </div>
    </div>
    <form method="dialog">
        <button type="submit">확인</button>
        <button type="button">취소</button>
    </form>
</dialog>
<script>
    $("#directOrder").on("click", function () {
        let data = {}
        data.productNo = ${productDto.productNo};
        data.productName = $("#name").html()
        data.productCategory = $("#category").html()
        data.productQty = $("#qty").html()
        data.productPrice = $("#price").html()

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


    // 별점
    document.querySelector(`.star span`).style.width = `20%`;
    // 모달창
    const button = document.querySelector("#modalBtn");
    const dialog = document.querySelector("dialog");
    button.addEventListener("click", () => {
        dialog.showModal();
    });
    dialog.addEventListener("close", () => {
        alert("cancel");
    });
</script>

<!-- footer -->
<%@ include file="../footer.jsp" %>
</body>
</html>