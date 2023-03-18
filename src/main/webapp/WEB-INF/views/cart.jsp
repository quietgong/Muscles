<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="nav.jsp" %>
<!-- 본문 -->
<hr/>
<div class="cart-container">
    <div class="cart-item-head">
        <label><input id="allCheck" type="checkbox" checked onclick="allCheck(event)"/>
            <span>전체선택</span>
        </label>
    </div>
    <div class="cart-item-head"><h2>수량</h2></div>
    <div class="cart-item-head"><h2>상품정보</h2></div>
    <div class="cart-item-head"><h2>상품금액</h2></div>
</div>
<hr/>
<!-- 상품 정보 표시 시작 -->
<form id="myForm" action="<c:url value='/cart/order'/>" method="post">
    <div id="cartItemList">
    </div>
    <!-- 상품 정보 표시 시작 -->
    <div class="cart-container">
        <input id="delete" onclick="deleteItem()" type="button" value="선택삭제"/>
        <select>
            <option value="" selected>할인쿠폰 선택</option>
            <option value="">추천인 입력 이벤트</option>
            <option value="">준비중...</option>
        </select>
    </div>

    <div class="cart-container">
        <div class="cart-item">
            <p style="font-weight: bold;">총 주문 금액은 13,500원입니다.</p>
            <input id="order" type="submit" value="주문하기"/>
            <a href="<c:url value="/"/>"><input type="button" value="홈 이동"/></a>
        </div>
    </div>
</form>
<script>
    $("#cartItemList").on("click", ".qtyChange", function () {
        if ($(this).html() == '-') {
            const nowQty = $(this).next()
            let number = parseInt(nowQty.html())
            if (number > 1) {
                nowQty.text(number - 1)
            }
        } else {
            const nowQty = $(this).prev()
            let number = parseInt(nowQty.html()) + 1
            nowQty.text(number)
        }
        return false
    });

    $("#order").on("click", function () {
        const form = $('#myForm');
        let checkedItems = $('input[type=checkbox].check_all_list:checked');
        let data = []

        $(checkedItems).each(function () {
            let tmp = {}
            tmp.productNo = $(this).next().val()
            tmp.productName = $(this).next().next().val()
            tmp.productCategory = $(this).next().next().next().val()
            tmp.productQty = $(this).parent().next().children("h1").text()
            tmp.productPrice = $(this).next().next().next().next().val()
            data.push(tmp)
        });
        console.log(JSON.stringify(data))
        form.append($('<input>').attr({
            type: 'hidden',
            name: 'jsonData',
            value: JSON.stringify(data)
        }))
        form.submit();
    });

    loadCartItem()
    function loadCartItem() {
        $.ajax({
            type: "GET",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/cart/get", // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function (res) {
                $("#cartItemList").html(toHtml(res))
                console.log("Get All Cart Item!")
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
            tmp += '<input type="checkbox" checked class="check_all_list" />'
            tmp += '<input type="hidden" value="' + item.productNo + '"/>'
            tmp += '<input type="hidden" value="' + item.productName + '"/>'
            tmp += '<input type="hidden" value="' + item.productCategory + '"/>'
            tmp += '<input type="hidden" value="' + item.productPrice + '"/>'

            tmp += '</div>'

            tmp += '<div class="cart-item">'
            tmp += '<a class="qtyChange" href="#">-</a>'
            tmp += '<h1>' + item.productQty + '</h1>'
            tmp += '<a class="qtyChange" href="#">+</a>'
            tmp += '</div>'

            tmp += '<div class="cart-item">'
            tmp += '<img src="http://via.placeholder.com/300X200/000000/ffffff"/>'
            tmp += '<h3>' + item.productName + '</h3>'
            tmp += '</div>'
            tmp += '<div class="cart-item"><h3 class="price">' + item.productPrice + '</h3></div>'
            tmp += '</div>'
            tmp += '<hr>'
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
<!-- footer -->
<%@ include file="footer.jsp" %>