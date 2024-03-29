<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ include file="nav.jsp" %>
<div class="container">
    <div class="row mt-5">
        <section class="h-100" style="background-color: #eee;">
            <div class="container h-100 py-5">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-10">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h3 class="fw-normal mb-0 text-black">Shopping Cart</h3>
                        </div>
                        <div id="cartItemList" class="card rounded-3 mb-4"><!-- AJAX 동적 추가 --></div>
                        <!-- 요약 정보 시작 -->
                        <div class="card mb-5">
                            <div class="card-body p-5">
                                <div class="float-end">
                                    <p class="mb-0 me-5 d-flex align-items-center">
                                        <span class="text-muted me-2">총 주문금액 : ₩</span>
                                        <span id="totalPrice" class="lead fw-normal"></span>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <!-- 요약 정보 끝 -->
                        <div class="d-flex justify-content-end">
                            <button type="button"
                                    onclick="location.href='<c:url value='/goods/list'/>'"
                                    class="btn btn-light btn-lg me-2">계속 쇼핑하기
                            </button>
                            <button style="display: none" id="order" type="button" class="btn btn-primary btn-lg">주문하기
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
<script>
    loadCartItem()

    function loadCartItem() {
        commonAjax("/muscles/cart/" + '${userId}', null, "GET", function (res) {
            $("#cartItemList").html(toHtml(res))
            if (res.length !== 0) {
                calculateTotalPrice()
                $("#order").show();
            }
        })
    }

    let toHtml = function (items) {
        let tmp = "";
        items.forEach(function (item) {
            tmp += '<div content="item" class="card-body p-4" data-goodsNo=' + item.goodsNo +
                ' data-goodsName=' + item.goodsName + ' data-goodsCategory=' + item.goodsCategory +
                ' data-goodsCategoryDetail=' + item.goodsCategoryDetail +
                ' data-goodsPrice=' + item.goodsPrice + ' data-goodsImgPath=' + item.goodsImgPath + '>'
            tmp += '<div class="row d-flex justify-content-between align-items-center">'
            tmp += '<div class="col-md-2 col-lg-2 col-xl-2">'
            if (item.goodsImgPath == null)
                item.goodsImgPath = "/muscles/img/logo.jpg"
            tmp += '<img src=\"' + item.goodsImgPath + '\" class="img-fluid rounded-3">'
            tmp += '</div>'
            tmp += '<div class="col-md-3 col-lg-3 col-xl-3">'
            tmp += '<p class="lead fw-normal mb-2">' + item.goodsCategory + ' > ' + item.goodsCategoryDetail + '</p>'
            tmp += '<p>' + item.goodsName + '</p>'
            tmp += '</div>'
            tmp += '<div class="col-md-3 col-lg-3 col-xl-2 d-flex" data-goodsPrice=' + item.goodsPrice + '>'
            tmp += '<button type="button" class="btn btn-link px-2" onclick="this.parentNode.querySelector(\'input[type=number]\').stepDown(); qtyChange(this)">'
            tmp += '<i class="fas fa-minus"></i>'
            tmp += '</button>'
            tmp += '<input style="text-align: center" min="1" max="10" name="quantity" readonly value=' + item.goodsQty + ' type="number" class="form-control" />'
            tmp += '<button type="button" class="btn btn-link px-2" onclick="this.parentNode.querySelector(\'input[type=number]\').stepUp(); qtyChange(this)">'
            tmp += '<i class="fas fa-plus"></i>'
            tmp += '</button>'
            tmp += '</div>'
            tmp += '<div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">'
            tmp += '<h5 class="mb-0 nowPrice text-end">' + (item.goodsPrice * item.goodsQty).toLocaleString() + ' ₩</h5>'
            tmp += '</div>'
            tmp += '<div class="col-md-1 col-lg-1 col-xl-1 text-end">'
            tmp += '<a style="cursor: pointer" onclick="deleteItem(' + item.goodsNo + ')" class="text-danger"><i class="fas fa-trash fa-lg"></i></a>'
            tmp += '</div>'
            tmp += '</div>'
            tmp += '</div>'
        })
        return tmp;
    }

    function qtyChange(elem) {
        let goodsPrice = parseInt($(elem).parent().attr("data-goodsPrice"))
        let nowQty = parseInt($(elem).siblings('input').val())
        $(elem).parent().next().children().html((goodsPrice * nowQty).toLocaleString() + " ₩")
        calculateTotalPrice()
    }

    function calculateTotalPrice() { // 총 주문금액 구하기
        let totalPrice = 0;
        $(".nowPrice").each(function () {
            totalPrice += parseInt($(this).html().replaceAll(",", "").replaceAll(" ₩", ""))
        })
        $("#totalPrice").html(totalPrice.toLocaleString())
    }

    $("#order").on("click", function () {
        let data = []
        $("div[content='item']").each(function (index) {
            let tmp = {}
            tmp.goodsNo = $(this).attr("data-goodsNo")
            tmp.goodsName = $(this).attr("data-goodsname")
            tmp.goodsCategory = $(this).attr("data-goodscategory")
            tmp.goodsCategoryDetail = $(this).attr("data-goodscategorydetail")
            tmp.goodsQty = $("input[name='quantity']").eq(index).val()
            tmp.goodsPrice = parseInt($(this).attr("data-goodsprice")) * parseInt(tmp.goodsQty)
            tmp.goodsImgPath = $(this).attr("data-goodsimgpath")
            data.push(tmp)
        });
        let form = document.createElement("form");
        form.setAttribute("method", "post")
        form.setAttribute("action", "/muscles/order/checkout")

        let hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", "orderData");
        hiddenField.setAttribute("value", JSON.stringify(data));
        form.appendChild(hiddenField)
        document.body.appendChild(form)
        form.submit()
    });

    // 장바구니 상품 삭제
    function deleteItem(goodsNo) {
        commonAjax("/muscles/cart/" + goodsNo, null, "DELETE", function (res) {
            if (res === "DEL_OK")
                alert("장바구니에서 삭제하였습니다.")
            loadCartItem()
            getCartItemsNum()
        })
    }
</script>
<%@ include file="footer.jsp" %>