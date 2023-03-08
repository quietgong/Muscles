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
</head>
<style>
    .order-list-container{
        display: flex;
        flex-direction: column;
        margin: auto;
    }
    .order-list-item{
        display: flex;
        flex-direction: column;
        margin: auto;
    }
    .order-list-item-detail{
        display: flex;
        flex-direction: column;
        margin: auto;
    }
</style>
<body>
<!-- nav -->
<%@ include file="../nav.jsp" %>
<!-- 사이드바 -->
<%@include file="../mypage/sidebar.jsp" %>
<!-- 본문 -->
<div class="order-list-container">
    <div class="order-list-item" style="flex-direction: row">
        <!-- 검색 조건 -->
        <div>
            <label for="pw1">상품명</label>
            <input type="text" id="lname" name="lastname"/>
        </div>
        <div>
        <label>기간</label>
        <input type="date" id="lname" name="lastname"/>
        </div>
        <div>
        <label>~</label>
        <input type="date" id="lname" name="lastname"/>
        <input type="button" value="검색"/>
        </div>
    </div>
    <!-- 주문 조회 -->
    <c:forEach var="orderDto" items="${orderDtoList}">
    <div style="border: 2px solid darkorange; border-radius: 2px;" class="order-list-item">
        <div class="order-list-item-detail">
            <div>
                <!-- 좌측:주문일자, 우측:주문번호 -->
                <span>${orderDto.createdDate} 주문</span>
                <span>주문번호 : ${orderDto.orderNo}</span>
            </div>
            <div>
                <!-- 버튼 2개 -->
                <input type="button" value="상세 내역"/>
                <c:set var="accept" value="${orderDto.status=='pending' ? '주문 취소' : '리뷰 작성'}"/>
                <input type="button" value="${accept}"/>
            </div>
            <!-- 주문 내 주문상품 조회 -->
            <c:forEach var="orderItemDto" items="${orderDto.orderItemDtoList}">
            <div>
                <img style="float: left;" src="http://via.placeholder.com/150X100/000000/ffffff"/>
                <p>[${orderItemDto.productCategory}]</p>
                <p>${orderItemDto.productName}</p>
                <span>${orderItemDto.productPrice}원</span>
                <span> ${orderItemDto.productQty}개</span>
            </div>
            <!-- 주문 내 주문상품 조회 -->
            </c:forEach>
            </div>
        <div>
            <h2>주문상태 : ${orderDto.status}</h2>
        </div>
        </div>
        </c:forEach>
        <!-- 주문 조회 -->
    </div>
</div>
<!-- 본문 -->
<!-- 모달 -->
<dialog>
    <h3 style="background-color: rgb(227, 217, 204)">리뷰 작성</h3>
    <div class="modal-container">
        <div class="modal-item">
            <h3 id="modal-item-name"></h3>
        </div>
        <div class="modal-item">
            <h3>상품명 123</h3>
        </div>
    </div>
    <hr/>
    <div class="modal-container">
        <div class="modal-item">
            <h3>별점</h3>
        </div>
        <div class="modal-item">
            <div>
                <span class="modal-star">★★★★★
                    <span>★★★★★</span>
                <input
                        type="range"
                        oninput="drawStar(this)"
                        value="1"
                        step="0.5"
                        min="0"
                        max="5"
                />
                </span>
            </div>
        </div>
    </div>
    <hr/>
    <div class="modal-container">
        <div class="modal-item">
            <h3>후기</h3>
        </div>
        <div class="modal-item">
            <textarea rows="4" cols="20"></textarea>
        </div>
    </div>
    <form method="dialog">
        <button type="submit">등록</button>
        <button type="button">닫기</button>
    </form>
</dialog>
<!-- footer -->
<%@ include file="../footer.jsp" %>
<script>
    const drawStar = (target) => {
        document.querySelector(`.star span`).style.width = "${"${target.value*20}%"}";
    };
    // 별점
    const button = document.querySelector(".modalBtn")
    const dialog = document.querySelector("dialog");
    button.addEventListener("click", () => {
        dialog.showModal();
        $("#modal-item-name").html("TEST")
    });
    dialog.addEventListener("close", () => {
        alert("cancel");
    });
</script>
</body>
</html>