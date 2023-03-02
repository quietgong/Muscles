<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Home</title>
    <link rel="stylesheet" href="css/style.css"/>
    <script src="https://code.jquery.com/jquery-1.11.3.js"/>

</head>
<body>
<!-- nav -->
<%@ include file="nav.jsp" %>

<!-- 본문 -->
<hr/>
<div class="cart-container">
    <div class="cart-item-head">
        <label>
            <input id="allCheck" type="checkbox" onclick="allCheck(event)"/>
            <span>전체선택</span></label
        >
    </div>
    <div class="cart-item-head"><h2>상품정보</h2></div>
    <div class="cart-item-head"><h2>수량</h2></div>
    <div class="cart-item-head"><h2>상품금액</h2></div>
</div>
<hr/>
<!-- 반복부 -->
<div id="cartItemList"></div>
<!-- 반복부 끝 -->
<div class="cart-container">
    <input id="delete" onclick="deleteItem()" type="button" value="선택삭제"/>
    <select id="country" name="country">
        <option value="" selected>할인쿠폰 선택</option>
        <option value="">추천인 입력 이벤트</option>
        <option value="">준비중...</option>
    </select>
</div>

<div class="cart-container">
    <div class="cart-item">
        <p style="font-weight: bold;">총 주문 금액은 13,500원입니다.</p>
        <input type="button" value="주문하기"/>
        <input type="button" value="홈 이동"/>
    </div>
</div>

<!-- footer -->
<%@ include file="footer.jsp" %>
<script>
    loadCartItem()
    function loadCartItem(){
        $.ajax({
            type: "GET",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/cart/get", // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function (res) {
                $("#cartItemList").html(toHtml(res))
                console.log(res)
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    }
    let toHtml = function (items) {
        let tmp = "";
        items.forEach(function (item) {
            tmp += '<div class="cart-container">'
            tmp += '<div class="cart-item" style="flex-basis: 150px">'
            tmp += '<input type="checkbox" class="check_all_list" onclick="checkAllList(event)"/>'
            tmp += '<input id="productNo" type="hidden" value="' + item.productNo + '">'
            tmp += '</div>'
            tmp += '<img src="http://via.placeholder.com/100X100/000000/ffffff"/>'
            tmp += '<div class="cart-item"><h3>' + item.productName + '</h3></div>'
            tmp += '<div class="cart-item"><h3>' + item.productQty + '</h3></div>'
            tmp += '<div class="cart-item"><h3 class="price">' + item.productPrice + '</h3></div>'
            tmp += '</div>'
            tmp += '<hr/>'
        })
        return tmp;
    }
    function deleteItem() {
        var deleteItemList = []
        let checkedItems = $('input[type=checkbox].check_all_list:checked');
        $(checkedItems).each(function () {
            deleteItemList.push($(this).next().val())
        });
        console.log(deleteItemList)
        $.ajax({
            type: "POST",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/cart/remove", // 컨트롤러에서 대기중인 URL 주소이다.
            data: {
                deleteItemList: deleteItemList,
            },
            success: function (res) {
                if (res == "DEL_OK")
                    alert("장바구니에서 삭제하였습니다.")
                loadCartItem()
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    }

    function allCheck(e) {
        // 전체 체크 버튼 클릭시 전체 체크 및 해제
        if (e.target.checked) {
            document.querySelectorAll(".check_all_list").forEach(function (v, i) {
                v.checked = true;
            });
        } else {
            document.querySelectorAll(".check_all_list").forEach(function (v, i) {
                v.checked = false;
            });
        }
    }

    function checkAllList(e) {
        // 체크 버튼 클릭시 전체 체크 버튼 체크 및 해제
        let checkCount = 0;
        document.querySelectorAll(".check_all_list").forEach(function (v, i) {
            if (v.checked === false) {
                checkCount++;
            }
        });
        if (checkCount > 0) {
            document.getElementById("allCheck").checked = false;
        } else if (checkCount === 0) {
            document.getElementById("allCheck").checked = true;
        }
    }
</script>
</body>
</html>