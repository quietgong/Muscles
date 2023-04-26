<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% response.setHeader("Cache-Control", "no-store"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<%@ include file="../nav.jsp" %>
<div class="container">
    <div class="py-5 text-center">
        <h2>주문 페이지</h2>
    </div>
    <div class="row">
        <div class="col-md-4 order-md-2 mb-4">
            <h4 class="d-flex justify-content-between align-items-center mb-3">
                <span class="text-muted">구매 목록</span>
                <span class="badge badge-secondary badge-pill"></span>
            </h4>
            <ul id="orderList" class="list-group mb-3">
                <!-- AJAX -->
                <li id="event" class="list-group-item d-flex justify-content-between bg-light">
                    <div class="text-success">
                        <small id="eventName"></small>
                    </div>
                    <span id="eventDiscount" class="text-success"></span>
                </li>
                <li class="list-group-item d-flex justify-content-between">
                    <span>Total (KRW)</span>
                    <strong id="payPrice">0</strong>
                </li>
            </ul>
            <div class="input-group">
                <select class="form-select" id="selectEvent" style="font-size: 1.2rem; text-align: center">
                    <option value="" selected>쿠폰 선택</option>
                    <c:forEach var="couponDto" items="${couponDtoList}">
                        <c:if test="${couponDto.orderNo eq 0}">
                            <option value="${couponDto.couponName}"
                                    data-no=${couponDto.couponNo} data-sub=${couponDto.discount}>
                                    ${couponDto.couponName}(<fmt:formatNumber value="${couponDto.discount}"
                                                                              pattern="#,###"/>원 할인)
                            </option>
                        </c:if>
                    </c:forEach>
                </select>
                <div class="row mt-5">
                    <label class="form-check-label" for="pointUse">포인트 사용</label>
                    <input id="pointUse" type="number" value="0" min="0" max="${userDto.point}">
                    <span id="userPoint">보유 포인트 : <fmt:formatNumber value="${userDto.point}"
                                                                    pattern="#,###"/></span>
                    <button id="pointAll" type="button" class="btn btn-primary">모두 사용</button>
                </div>
            </div>
        </div>
        <div class="col-md-8 order-md-1">
            <h4 class="mb-3">배송지 입력</h4>
            <div class="mb-3">
                <label class="form-check-label" for="checkbox">기존 정보로 입력</label>
                <input id="checkbox" class="form-check-input" type="checkbox" checked/>
            </div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="receiver">수령인</label>
                    <input type="text" class="delivery form-control" id="receiver" placeholder="수령인을 입력해주세요."
                           value="${userDto.userId}" required>
                    <div class="invalid-feedback">
                        수령인을 입력해주세요.
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="phone">연락처</label>
                    <input type="text" class="delivery form-control" id="phone"
                           placeholder="- 를 제외하고 입력해주세요" value="${userDto.phone}" required>
                    <div class="invalid-feedback">
                        Valid phone number is required.
                    </div>
                </div>
            </div>
            <div class="mb-3">
                <label for="address1">주소</label>
                <button type="button" class="btn btn-primary mb-2" onclick="execDaumPostcode()">우편번호 찾기</button>
                <div class="row">
                    <div class="col-md-6">
                        <input id="address1" class="delivery address form-control" type="text" readonly
                               placeholder="주소"/><br/>
                    </div>
                    <div class="col-md-6">
                        <input id="address2" class="delivery form-control" type="text" id="detailAddress"
                               placeholder="상세주소"/>
                    </div>
                </div>
            </div>
            <div class="mb-3">
                <label for="message">배송 메세지 <span class="text-muted">(선택사항)</span></label>
                <input type="text" class="form-control" id="message" placeholder="(예 : 경비실에 맡겨 주세요.)">
            </div>
            <hr class="mb-4">
            <h4 class="mb-3">결제 수단</h4>
            <div class="d-block my-3">
                <div class="custom-control custom-radio">
                    <input id="credit" name="paymentMethod" type="radio" class="custom-control-input"
                           checked required value="네이버페이">
                    <label class="custom-control-label" for="credit">네이버페이</label>
                </div>
                <div class="custom-control custom-radio">
                    <input id="debit" name="paymentMethod" type="radio" class="custom-control-input"
                           required value="카카오페이">
                    <label class="custom-control-label" for="debit">카카오페이</label>
                </div>
                <div class="custom-control custom-radio">
                    <input id="paypal" name="paymentMethod" type="radio" class="custom-control-input"
                           required value="신용카드">
                    <label class="custom-control-label" for="paypal">신용카드</label>
                </div>
            </div>

            <div class="row card-info" style="display: none">
                <div class="col-md-6 mb-3">
                    <label for="cc-number">카드 번호</label>
                    <input type="text" class="form-control" id="cc-number" placeholder="">
                    <div class="invalid-feedback">
                        Credit card number is required
                    </div>
                </div>
            </div>
            <div class="row card-info" style="display: none">
                <div class="col-md-3 mb-3">
                    <label for="cc-expiration">만료일자</label>
                    <input type="text" class="form-control" id="cc-expiration" placeholder="">
                    <div class="invalid-feedback">
                        Expiration date required
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <label for="cc-cvv">CVV</label>
                    <input type="text" class="form-control" id="cc-cvv" placeholder="">
                </div>
            </div>

            <hr class="mb-8">
            <form id="orderForm" action="<c:url value='/order/pay'/>" method="post">
                <button id="submit" class="col-md-6 btn btn-primary btn-lg btn-block" type="submit">결제</button>
            </form>
        </div>
    </div>
</div>
<script>
    loadItemList()

    function loadItemList() {
        let items = JSON.parse('${orderList}');
        ;
        $("#orderList").prepend(appendItemList(items))

        function appendItemList(items) {
            let tmp = "";
            items.forEach(function (item) {
                tmp += '<li class="list-group-item d-flex justify-content-between lh-condensed">'
                tmp += '<div>'
                tmp += '<h6 class="my-0">' + item.goodsName + '<span> · ' + item.goodsQty + '개 </span>' + '</h6>'
                tmp += '<small class="text-muted">' + item.goodsCategory + ' > ' + item.goodsCategoryDetail + '</small>'
                tmp += '</div>'
                tmp += '<span class="order-item-price text-muted">' + item.goodsPrice.toLocaleString() + ' ₩</span>'
                tmp += '</li>'
            })
            return tmp;
        }
    }
</script>
<script>
    let point = 0
    let couponNo = 0;
    let couponName = "";
    let couponDiscount = 0;
    // 최종 주문 가격 계산
    calculateFinalPrice()

    // 포인트 사용
    $("#pointUse").keyup(function () {
        point = $("#pointUse").val() === '' ? 0 : parseInt($("#pointUse").val())
        calculateFinalPrice()
    })
    // 포인트 모두 사용
    $("#pointAll").on("click", function () {
        $("#pointUse").val("${userDto.point}")
        point = parseInt($("#pointUse").val())
        calculateFinalPrice()
    })
    // 셀렉트박스 선택
    $("#selectEvent").on("change", function () {
        if (this.value !== '') {
            couponNo = $(this).find("option:selected").data("no")
            couponName = $(this).find("option:selected").val()
            couponDiscount = $(this).find("option:selected").data("sub")
            $("#eventName").html(couponName)
            $("#eventDiscount").html("-" + couponDiscount + "₩")
        } else {
            couponNo = 0
            couponName = ""
            couponDiscount = 0
            $("#eventName").html("")
            $("#eventDiscount").html("")
        }
        calculateFinalPrice()
    })

    // 최종 결제 금액 계산
    function calculateFinalPrice() {
        let orderPrice = 0
        let totalDiscount = couponDiscount + point
        // 현재 주문 가격 표시
        $(".order-item-price").each(function () {
            orderPrice += Number($(this).html().replaceAll(",", "").replaceAll(" ₩", ""))
        })
        $("#payPrice").html((orderPrice - totalDiscount).toLocaleString())
    }
</script>
<script>
    // 결제 버튼
    $("#submit").on("click", function () {
        const form = $('#orderForm');
        let orderData = {}; // 주문 정보
        let orderItemDtoList = JSON.parse('${orderList}') // 주문 상품 정보
        let payment = {}; // 결제 정보
        payment.type = $("input[name='paymentMethod']:checked").val()
        payment.price = $("#payPrice").html().replaceAll(",", "")
        let delivery = {}; // 배송 정보
        delivery.receiver = $("#receiver").val()
        delivery.phone = $("#phone").val()
        delivery.address1 = $("#address1").val()
        delivery.address2 = $("#address2").val()
        delivery.message = $("#message").val()
        orderData.userId = '${userId}'
        orderData.discount = couponDiscount + point
        orderData.paymentDto = payment
        orderData.deliveryDto = delivery
        orderData.orderItemDtoList = orderItemDtoList

        form.append($('<input>').attr({
            type: 'hidden',
            name: 'orderData',
            value: JSON.stringify(orderData)
        }))
        form.append($('<input>').attr({
            type: 'hidden',
            name: 'couponNo',
            value: couponNo
        }))
        form.append($('<input>').attr({
            type: 'hidden',
            name: 'point',
            value: point
        }))
        console.log(orderData)
        console.log(couponNo)
        console.log(point)
        form.submit();
    });
</script>
<script>
    // 배송지 기본 정보로 설정 체크 여부
    const checkbox = document.getElementById('checkbox');
    const inputs = document.getElementsByClassName('delivery');

    let savedDeliveryInfo = [
        '${userDto.userId}', '${userDto.phone}', '${userDto.address1}', "${userDto.address2}"
    ];
    // Checked
    if (checkbox.checked)
        for (let i = 0; i < inputs.length; i++)
            inputs[i].value = savedDeliveryInfo[i];

    checkbox.addEventListener('change', () => {
        if (checkbox.checked)
            for (let i = 0; i < inputs.length; i++)
                inputs[i].value = savedDeliveryInfo[i];
        else
            for (let i = 0; i < inputs.length; i++)
                inputs[i].value = '';
    })
</script>
<script>
    $("input[name='paymentMethod']").on("click", function () {
        let payType = $("input[name='paymentMethod']:checked").val();
        payType === '신용카드' ? $(".card-info").show() : $(".card-info").hide()
    })
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<c:url value='/js/DaumPostCode.js'/>"></script>
<!-- footer -->
<%@ include file="../footer.jsp" %>