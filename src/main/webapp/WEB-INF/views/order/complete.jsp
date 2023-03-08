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
<!-- 결제정보 -->
<h3>주문이 완료되었습니다. 이용해 주셔서 감사합니다.</h3>
<h4>
    주문 내역은 [마이 페이지 > 주문내역/배송조회]에서 다시 확인할 수 있습니다.
</h4>
<div class="order-container">
</div>
<hr />
<p style="font-weight: bold">| 주문번호 : ${orderItemDtoList.get(0).orderNo}</p>

<div class="order-container">
    <img style="visibility: hidden;" src="http://via.placeholder.com/100X100/000000/ffffff" />
    <div class="order-item-head"><h2>상품정보</h2></div>
    <div class="order-item-head"><h2>수량</h2></div>
    <div class="order-item-head"><h2>상품금액</h2></div>
</div>
<hr />
<c:forEach var="orderItemDto" items="${orderItemDtoList}">
<!-- 주문 상품 정보 -->
<div class="order-container">
    <img src="http://via.placeholder.com/100X100/000000/ffffff" />
    <div class="order-item"><h3>${orderItemDto.productName}</h3></div>
    <div class="order-item"><h3>${orderItemDto.productQty}</h3></div>
    <div class="order-item"><h3>${orderItemDto.productPrice * orderItemDto.productQty}</h3></div>
</div>
<hr />
<!-- 주문자 정보 -->
</c:forEach>
<p style="font-weight: bold">| 주문자 정보</p>
<table id="myTable">
    <tr>
        <td>이름</td>
        <td>${userDto.id}</td>
    </tr>
    <tr>
        <td>연락처</td>
        <td>${userDto.phone}</td>
    </tr>
</table>
<!-- 배송 정보 -->
<p style="font-weight: bold">| 배송 정보</p>
<table id="myTable">
    <tr>
        <td>수령인</td>
        <td>주소</td>
        <td>휴대폰</td>
        <td>요청사항</td>
    </tr>
    <tr>
        <td>${deliveryDto.receiver}</td>
        <td>${deliveryDto.address}</td>
        <td>${deliveryDto.phone}</td>
        <td>${deliveryDto.message}</td>
    </tr>
</table>
<!-- 결제 정보 -->
<p style="font-weight: bold">| 결제</p>
<table id="myTable">
    <tr>
        <td>결제 방법</td>
        <td>결제 금액</td>
    </tr>
    <tr>
        <td>${paymentDto.type}</td>
        <td>${paymentDto.price}</td>
    </tr>
</table>
<div class="order-container">
    <div class="order-item">
        <a href="<c:url value='/order/detail'/>">
            <input type="button" value="주문내역 확인" />
        </a>
        <a href="<c:url value='/'/>">
            <input type="button" value="홈으로 이동" />
        </a>
    </div>
</div>

<!-- footer -->
<%@ include file="../footer.jsp" %>
</body>
</html>