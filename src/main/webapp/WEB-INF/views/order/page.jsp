<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>
<style>
    #submit {
        width: 20%;
        height: 60px;
        font-size: 1.5rem;
        font-weight: bold;
        margin-top: 50px;
    }
</style>
<!-- 본문 -->
<hr/>
<form id="orderForm">
    <div class="order-container">
        <img style="visibility: hidden" src="http://via.placeholder.com/300X200/000000/ffffff"/>
        <div class="order-item-head"><h2>상품정보</h2></div>
        <div class="order-item-head"><h2>수량</h2></div>
        <div class="order-item-head"><h2>상품금액</h2></div>
    </div>
    <hr/>
    <!-- 반복부 -->
    <c:forEach var="orderItemDto" items="${list}">
        <div class="order-container">
            <img style="width: 300px; height: 200px;" src="${orderItemDto.productImgPath}"/>
            <input type="hidden" class="order-item" value="${orderItemDto.productNo}">
            <input type="hidden" value="${orderItemDto.productName}">
            <input type="hidden" value="${orderItemDto.productQty}">
            <input type="hidden" value="${orderItemDto.productPrice}">
            <input type="hidden" value="${orderItemDto.productCategory}">

            <div class="order-item"><h3>${orderItemDto.productName}</h3></div>
            <div class="order-item"><h3>${orderItemDto.productQty}</h3></div>
            <div class="order-item"><h3 class="order-item-price">${orderItemDto.productPrice}</h3></div>
        </div>
        <hr/>
    </c:forEach>
    <!-- 반복부 끝 -->

    <!-- 배송지정보 -->
    <div class="order-container">
        <h3>배송지 정보</h3>
        <span style="justify-content: flex-end">기존 정보로 설정
        <input id="checkbox" style="justify-content: flex-end" type="checkbox" checked/>
    </span>
    </div>
    <hr/>
    <label for="receiver">수령인</label><br/>
    <input id="receiver" class="delivery" name="receiver" type="text" value="${userDto.userId}"/>
    <br/>
    <label for="phone">연락처</label><br/>
    <input id="phone" class="delivery" name="phone" type="text" value="${userDto.phone}" placeholder="-를 제외하고 입력해주세요"/>
    <br/>
    <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"/>
    <br/>
    <input type="text" id="postcode" placeholder="우편번호"/>
    <input id="address" class="address" type="text" name="address" placeholder="주소"/><br/>
    <input class="delivery" type="text" id="detailAddress" placeholder="상세주소"/>
    <br/>
    <label for="message">배송 메세지</label><br/>
    <input id="message" name="message" type="text" placeholder="배송 메시지 입력"/>
    <br/>

    <!-- 결제정보 -->
    <div class="order-container">
        <h3>결제 정보</h3>
    </div>
    <hr/>
    <div>
        <table id="myTable" style="margin: auto">
            <tr>
                <td>총 상품가격</td>
                <td id="payPrice"></td>
            </tr>
            <tr>
                <td>할인 쿠폰 선택</td>
                <td>
                    <select>
                        <option value="" selected>할인쿠폰 선택</option>
                        <option value="">추천인 입력 이벤트</option>
                        <option value="">준비중...</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>포인트 사용</td>
                <td><input type="text"><br>
                    <span>보유 포인트 : ${userDto.point}</span>
                    <button type="button">모두 사용</button>
                </td>
            </tr>
            <tr>
                <td>최종 결제금액</td>
                <td>
                    <input style="text-align: center" name="price" type="text" class="order-payment" readonly>
                </td>
            </tr>
            <tr>
                <td>결제 수단</td>
                <td>
                    <input name="type" type="radio" checked class="order-payment" value="네이버페이"/>네이버페이
                    <input name="type" type="radio" class="order-payment" value="카카오페이"/>카카오페이
                </td>
            </tr>
        </table>
    </div>
    <div class="order-item">
        <input id="submit" type="submit" value="결제하기"/>
    </div>
</form>
<script>
    // 결제 처리
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
        form.attr("action", "<c:url value='/order/complete'/>");
        form.attr("method", "post");
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
        '${userDto.userId}', '${userDto.phone}', '${userDto.address}'
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