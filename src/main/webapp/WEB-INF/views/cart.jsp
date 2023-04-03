<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="nav.jsp" %>
<!-- 본문 -->
<hr/>
<div class="cart-container">
    <div class="cart-item-head">
        <label><input style="zoom: 2.0" id="allCheck" type="checkbox" checked onclick="allCheck(event);"/>
            <span>전체선택</span>
        </label>
    </div>
    <div class="cart-item-head"><h2>수량</h2></div>
    <div class="cart-item-head"><h2>상품정보</h2></div>
    <div class="cart-item-head"><h2>상품금액</h2></div>
</div>
<hr/>
<!-- 상품 정보 표시 시작 -->
<form id="cartForm" action="<c:url value='/order'/>" method="post">
    <div id="cartItemList">
        <!-- 동적 추가 -->
    </div>
    <!-- 상품 정보 표시 시작 -->
    <div class="cart-container">
        <input id="delete" onclick="deleteItem()" type="button" value="선택삭제"/>
    </div>

    <div class="cart-container">
        <div class="cart-item">
            <span class="totalPriceText" style="font-weight: bold;">총 주문 금액은 </span>
            <span class="totalPriceText" style="font-weight: bold; font-size: 1.2rem;" id="totalPrice"></span>
            <span class="totalPriceText">원입니다.</span><br>
            <input style="font-size: 1.5rem;" id="order" type="submit" value="주문하기"/>
            <a href="<c:url value="/"/>"><input style="font-size: 1.5rem;" type="button" value="홈 이동"/></a>
        </div>
    </div>
</form>
<script>
    loadCartItem()
    function notEmptyCart(){
        $("#delete").css("display", "block");
        $("#order").css("display", "block");
        $(".totalPriceText").css("display", "block");
    }
    function emptyCart(){
        $("#delete").css("display", "none");
        $("#order").css("display", "none");
        $(".totalPriceText").css("display", "none");
    }
    function loadCartItem() {
        $.ajax({
            type: "GET",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/cart/", // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function (res) {
                // 장바구니에 담긴 상품이 없을 때
                $("#cartItemList").html(toHtml(res))
                displayTotalPrice();
                if (res.length == 0) {
                    emptyCart()
                }
                else {
                    notEmptyCart()
                }
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    }

    $("#cartItemList").on("click", ".qtyChange", function () { // 수량 변경
        let nowQty;
        if ($(this).val() == '-') { // 감소
            nowQty = $(this).next()
            let number = parseInt(nowQty.html())
            if (number > 1)
                nowQty.text(number - 1)
        } else { // 증가
            nowQty = $(this).prev()
            let number = parseInt(nowQty.html()) + 1
            nowQty.text(number)
        }
        let targetDiv = $(this).parent().next()
        let qtyPrice = targetDiv.attr("data-productPrice") * nowQty.html()
        targetDiv.next().children().html(qtyPrice)
        displayTotalPrice()
        return false
    });

    // 체크박스에 변경이 있을때마다 주문금액 변경
    $(document).on("click", "input[type=checkbox]", function () {
        displayTotalPrice()
    })

    $("#order").on("click", function () {
        const form = $('#cartForm');
        let checkedItems = $('input[type=checkbox].check_all_list:checked');
        let data = []
        $(checkedItems).each(function (index) {
            let tmp = {}
            tmp.productNo = $(this).next().val()
            tmp.productName = $(this).next().next().val()
            tmp.productCategory = $(this).next().next().next().val()
            tmp.productQty = $(".qty").eq(index).html()
            tmp.productPrice = $(".price").eq(index).html()
            tmp.productImgPath = $(this).prev().val()
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

    let toHtml = function (items) {
        let tmp = "";
        items.forEach(function (item) {
            tmp += '<div class="cart-container">'
            tmp += '<div class="cart-item">'
            tmp += '<input type="hidden" value="' + item.productImgPath + '"/>'
            tmp += '<input style="zoom:2.0;" type="checkbox" checked class="check_all_list" />'
            tmp += '<input type="hidden" value="' + item.productNo + '"/>'
            tmp += '<input type="hidden" value="' + item.productName + '"/>'
            tmp += '<input type="hidden" value="' + item.productCategory + '"/>'
            tmp += '<input type="hidden" value="' + item.productPrice + '"/>'
            tmp += '</div>'
            tmp += '<div class="cart-item">'
            tmp += '<input style="font-size: 1.5rem" type="button" class="qtyChange" value="-"/>'
            tmp += '<span style="font-size: 1.5rem; font-weight: bold; padding-left: 20px; padding-right: 20px" class="qty">' + item.productQty + '</span>'
            tmp += '<input style="font-size: 1.5rem" type="button" class="qtyChange" value="+"/>'
            tmp += '</div>'
            tmp += '<div class="cart-item" data-productNo=' + item.productNo +
                ' data-productName=' + item.productName + ' data-productCategory=' + item.productCategory +
                ' data-productPrice=' + item.productPrice + '>'
            if (item.productImgPath == null)
                item.productImgPath = "/muscles/img/logo.jpg"
            tmp += '<img style="width: 300px; height: 200px" src=\"' + item.productImgPath + '\"/>'
            tmp += '<h3>' + item.productName + '</h3>'
            tmp += '</div>'
            tmp += '<div class="cart-item"><h3 class="price">' + item.productPrice * item.productQty + '</h3></div>'
            tmp += '</div>'
            tmp += '<hr>'
        })
        return tmp;
    }

    function displayTotalPrice() {
        // 총 주문금액 구하기
        let totalPrice = 0;
        let checkedItems = $('input[type=checkbox].check_all_list:checked');
        $(checkedItems).each(function () {
            totalPrice += parseInt($(this).parent().next().next().next().children().html())
        });
        $("#totalPrice").html(totalPrice)
    }

    function deleteItem() {
        const deleteItemList = [];
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
            if (v.checked === false)
                checkCount++;
        });
        if (checkCount > 0)
            document.getElementById("allCheck").checked = false;
        else if (checkCount === 0)
            document.getElementById("allCheck").checked = true;
    }
</script>
<!-- footer -->
<%@ include file="footer.jsp" %>