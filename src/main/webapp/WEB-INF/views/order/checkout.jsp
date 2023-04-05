<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>
<form id="orderForm" action="<c:url value='/order/complete'/>" method="post">
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
                <ul class="list-group mb-3">
                    <c:forEach var="orderItemDto" items="${list}">
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0">${orderItemDto.productName}</h6>
                                <small class="text-muted">${orderItemDto.productCategory}</small>
                            </div>
                            <span class="text-muted">${orderItemDto.productPrice}</span>
                        </li>
                    </c:forEach>
                    <li class="list-group-item d-flex justify-content-between bg-light">
                        <div class="text-success">
                            <small>추천인 입력</small>
                            <h6 class="my-0">이벤트 적용</h6>
                        </div>
                        <span class="text-success">-$5</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between">
                        <span>Total (KRW)</span>
                        <strong id="payPrice">총 주문 금액</strong>
                    </li>
                </ul>
                <div class="input-group">
                    <select class="form-select" name="couponName" id="selectEvent"
                            style="font-size: 1.2rem; text-align: center">
                        <option value="" selected>쿠폰 선택</option>
                        <c:forEach var="couponDto" items="${couponDtoList}">
                            <c:if test="${couponDto.status == '사용가능'}">
                                <option value="${couponDto.couponName}"
                                        data-sub=${couponDto.discount}>${couponDto.couponName}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                    <div class="row">
                        <label class="form-check-label" for="pointUse">포인트 사용</label>
                        <input id="pointUse" type="number" name="point" value="0" min="0" max="${userDto.point}">
                        <span>보유 포인트 : ${userDto.point}</span>
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
                        <input type="text" class="form-control" id="receiver" placeholder=""
                               value="${userDto.userId}" required>
                        <div class="invalid-feedback">
                            수령인을 입력해주세요.
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="phone">연락처</label>
                        <input type="text" class="form-control" id="phone" name="phone"
                               placeholder="- 를 제외하고 입력해주세요" value="${userDto.phone}" required>
                        <div class="invalid-feedback">
                            Valid phone number is required.
                        </div>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="address">주소</label>
                    <button type="button" class="btn btn-primary mb-2" onclick="execDaumPostcode()">우편번호 찾기</button>
                    <div class="col-md-3">
                        <input type="text" id="postcode" class="form-control mb-4" readonly placeholder="우편번호"/>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <input id="address" class="address form-control" type="text" readonly name="address"
                                   placeholder="주소"/><br/>
                        </div>
                        <div class="col-md-6">
                            <input class="delivery form-control" type="text" id="detailAddress"
                                   placeholder="상세주소"/>
                        </div>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="message">배송 메세지 <span class="text-muted">(선택사항)</span></label>
                    <input type="text" class="form-control" id="message" name="message"
                           placeholder="(예 : 경비실에 맡겨 주세요.)">
                </div>
                <hr class="mb-4">
                <h4 class="mb-3">결제 수단</h4>
                <div class="d-block my-3">
                    <div class="custom-control custom-radio">
                        <input id="credit" name="paymentMethod" type="radio" class="custom-control-input"
                               checked
                               required>
                        <label class="custom-control-label" for="credit">네이버페이</label>
                    </div>
                    <div class="custom-control custom-radio">
                        <input id="debit" name="paymentMethod" type="radio" class="custom-control-input"
                               required>
                        <label class="custom-control-label" for="debit">카카오페이</label>
                    </div>
                    <div class="custom-control custom-radio">
                        <input id="paypal" name="paymentMethod" type="radio" class="custom-control-input"
                               required>
                        <label class="custom-control-label" for="paypal">신용카드</label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="cc-number">카드 번호</label>
                        <input type="text" class="form-control" id="cc-number" placeholder="">
                        <div class="invalid-feedback">
                            Credit card number is required
                        </div>
                    </div>
                </div>
                <div class="row">
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
                        <div class="invalid-feedback">
                            Security code required
                        </div>
                    </div>
                </div>
                <hr class="mb-8">
                <button id="submit" class="col-md-6 btn btn-primary btn-lg btn-block" type="submit">결제</button>
            </div>
        </div>
    </div>
</form>

<script>
    // 쿠폰 및 포인트 사용
    let discount = 0
    let point = 0
    let selectedCoupon;
    // 포인트 사용
    $("#pointUse").keyup(function () {
        calculateFinalPrice()
    })
    // 포인트 모두 사용 버튼 클릭
    $("#pointAll").on("click", function () {
        $("#pointUse").val("${userDto.point}")
        point = parseInt($("#pointUse").val())
        calculateFinalPrice()
    })
    // 셀렉트박스 선택
    $("#selectEvent").on("change", function () {
        selectedCoupon = this.value;
        discount = selectedCoupon === '추천인 이벤트' ? $(this).find("option:selected").data("sub") : 0
        calculateFinalPrice()
    })

    // 최종 결제 금액 계산
    function calculateFinalPrice() {
        let totalPrice = parseInt($("#payPrice").html())
        let pointUse = $("#pointUse").val() == '' ? 0 : parseInt($("#pointUse").val());
        $("#finalPrice").val(Math.floor(totalPrice * (1 - (discount / 100)) - pointUse))
    }
</script>
<script>
    // 결제 버튼 처리
    $("#submit").on("click", function () {
        const form = $('#orderForm');
        let orderJsonData = [];
        // 상품 정보
        let orderItemInfo = $("input[type='hidden'].order-item");
        $(orderItemInfo).each(function () {
            let data = {};
            data.productNo = $(this).val()
            data.productName = $(this).next().val()
            data.productQty = $(this).next().next().val()
            data.productPrice = $(this).next().next().next().val()
            data.productCategory = $(this).next().next().next().val()
            data.productImgPath = $(this).prev().attr("src")
            orderJsonData.push(data);
        });

        form.append($('<input>').attr({
            type: 'hidden',
            name: 'orderJsonData',
            value: JSON.stringify(orderJsonData)
        }))
        form.submit();
    });
</script>
<script>
    let sum = 0
    $(".order-item-price").each(function () {
        sum += Number($(this).html())
    })
    $("#payPrice").html(sum)
    $("input[name='price']").val(sum)

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
        if (checkbox.checked) { // 체크되어있을 떄
            for (let i = 0; i < inputs.length; i++)
                inputs[i].value = savedDeliveryInfo[i];
        } else {
            for (let i = 0; i < inputs.length; i++)
                inputs[i].value = '';
        }
    })
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    /* 우편번호 API */
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                // 사용자가 도로명 주소를 선택했을 경우
                if (data.userSelectedType === 'R')
                    addr = data.roadAddress;
                else // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if (data.userSelectedType === 'R') {
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname))
                        extraAddr += data.bname;

                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingName !== '' && data.apartment === 'Y')
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);

                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraAddr !== '')
                        extraAddr = ' (' + extraAddr + ')';
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>