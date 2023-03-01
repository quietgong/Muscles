<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Muscles</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
</head>
<body>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
<div class="product-detail-container">
    <div class="product-detail-item">
        <img src="http://via.placeholder.com/250?text=mypage" />
        <div class="product-detail-item-detail">
            <span style="font-size:25px; font-weight:bold;">${productDto.productName}</span>
            <div>
                <span class="star">★★★★★<span>★★★★★</span></span>
            </div>
            <span style="font-size: small">리뷰 : 2,145개</span>
            <hr />
            <span style="font-size:25px; font-weight:bold;">${productDto.stock}</span>

            <a href="#" onclick='count("minus")'><span style="font-size: 25px; font-weight: bold">-</span></a>
            <span id="qty" style="font-size: 25px; font-weight: bold">1</span>
            <a href="#" onclick='count("plus")'><span style="font-size: 25px; font-weight: bold">+</span></a>
            <span id="price" style="float: right">124,000원</span>

        </div>
        <div class="product-detail-item-detail" style="margin: auto">
            <input type="button" value="장바구니 담기" />
            <a href="<c:url value='/order/page'/>">
                <input type="button" value="바로구매" />
            </a>
        </div>
    </div>
</div>
<hr />
<!-- 상품 상세 -->
<h1>제품 상세</h1>
<div class="product-detail-container">
    <div class="product-detail-item">
        <img src="http://via.placeholder.com/800?text=mypage" />
    </div>
</div>
<hr />
<!-- 상품 리뷰 -->
<h1>상품 리뷰</h1>
<!-- 작성한 리뷰 -->
<div class="product-detail-review-container">
    <img src="http://via.placeholder.com/100X100/000000/ffffff" />
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
        ><br />
    </div>
</div>
<hr />
<!-- 작성한 리뷰 끝 -->

<!-- 상품 문의 -->
<h1>상품 문의</h1>
<input id="modalBtn" type="button" value="문의하기" />
<div><input type="button" value="질문" /><br /></div>
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
<div><input type="button" value="답변" /><br /></div>
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
    // 별점
    document.querySelector(`.star span`).style.width = `20%`;
    // 수량변경
    function count(type){
        const price = document.getElementById("price")
        const qty = document.getElementById("qty")
        let number = qty.innerHTML
        let amount = priceToInt(price)/parseInt(number)
        if(type=="minus"){
            if(number>1)
                number = parseInt(number)-1
        }
        else{
            number = parseInt(number)+1
        }
        qty.innerHTML=number

        amount = parseInt(amount)*number
        amount = amount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원"; //10,000
        price.innerHTML=amount
    }
    function priceToInt(price){
        price = price.innerHTML.replace(/[^0-9]/g,"")
        return price
    }
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