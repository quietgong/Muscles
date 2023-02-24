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
<body>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
<hr/>
<div class="order-container">
    <img
            style="visibility: hidden"
            src="http://via.placeholder.com/100X100/000000/ffffff"
    />
    <div class="order-item-head"><h2>상품정보</h2></div>
    <div class="order-item-head"><h2>수량</h2></div>
    <div class="order-item-head"><h2>상품금액</h2></div>
</div>
<hr/>
<!-- 반복부 -->
<div class="order-container">
    <img src="http://via.placeholder.com/100X100/000000/ffffff"/>
    <div class="order-item"><h3>상품명</h3></div>
    <div class="order-item"><h3>2</h3></div>
    <div class="order-item"><h3>30,000원</h3></div>
</div>
<hr/>
<!-- 반복부 끝 -->
<!-- 반복부 -->
<div class="order-container">
    <img src="http://via.placeholder.com/100X100/000000/ffffff"/>
    <div class="order-item"><h3>상품명</h3></div>
    <div class="order-item"><h3>2</h3></div>
    <div class="order-item"><h3>30,000원</h3></div>
</div>
<hr/>
<!-- 반복부 끝 -->
<div class="order-container" style="justify-content: flex-end; margin-right: 10%">
    <h3>합계 : 60,000원</h3>
</div>
<!-- 배송지정보 -->
<div class="order-container">
    <h3>배송지 정보</h3>
    <span style="justify-content: flex-end">기존 정보로 설정
        <input id="checkbox" style="justify-content: flex-end" type="checkbox" checked/>
      </span>
</div>
<hr/>
<label for="receiver">수령인</label><br/>
<input type="text" class="address" value="test"
        placeholder="영문+숫자 조합의 5자 이상 20자 이하"
/>
<br/>
<label for="pw2">연락처</label><br/>
<input
        type="text" class="address"
        placeholder="-를 제외하고 입력해주세요"
/>
<br/>
<label for="pw2">주소</label>
<input
        type="button"
        onclick="sample6_execDaumPostcode()"
        value="우편번호 찾기"
/>
<br/>
<input type="text" class="address" id="sample6_postcode" placeholder="우편번호"/>
<input type="text" class="address" id="sample6_address" placeholder="주소"/><br/>
<input type="text" class="address" id="sample6_detailAddress" placeholder="상세주소"/>
<br/>
<label for="pw2">배송 메세지</label><br/>
<input
        type="text" class="address"
        placeholder="배송 메시지 입력"
/>
<br/>

<!-- 결제정보 -->
<div class="order-container">
    <h3>결제 정보</h3>
</div>
<hr/>
<table id="myTable" style="margin: auto">
    <tr>
        <td>총 상품가격</td>
        <td>21,500원</td>
    </tr>
    <tr>
        <td>포인트 사용</td>
        <td><input/>
            <button type="button">모두 사용</button>
        </td>
    </tr>
    <tr>
        <td>배송비</td>
        <td>0원(택배발송)</td>
    </tr>
    <tr>
        <td>총 결제금액</td>
        <td>21,500원</td>
    </tr>
    <tr>
        <td>일반 결제</td>
        <td><input type="radio" value="무통장 입금"/>무통장 입금</td>
    </tr>
</table>

<div class="order-item">
    <a href="<c:url value='/order/complete'/>">
        <input type="button" value="결제하기"/>
    </a>
</div>

<!-- footer -->
<%@ include file="../footer.jsp" %>
<script>
    const checkbox = document.getElementById('checkbox');
    const inputs = document.getElementsByClassName('address');

    let savedAddressInfo = ['asdf','010-1234-5678','test','test','test','test'];

    if (checkbox.checked) { // 체크되어있을 떄
        for (let i = 0; i < inputs.length; i++) {
            inputs[i].value = savedAddressInfo[i];
        }
    }

    checkbox.addEventListener('change', () => {
        if (checkbox.checked) { // 체크되어있을 떄
            for (let i = 0; i < inputs.length; i++) {
                inputs[i].value = savedAddressInfo[i];
            }
        } else {
            for (let i = 0; i < inputs.length; i++) {
                inputs[i].value = '';
            }
        }
    })

</script>
</body>
</html>