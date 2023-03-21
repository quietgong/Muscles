<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../nav.jsp" %>
<style>
    .order-list-item {
        width: 50%;
        border: 3px solid #333333;
        border-radius: 3px;
        margin: auto auto 30px;
    }

    .order-list-item-detail {
        padding: 20px;
    }

    .innerOrderList {
        margin-bottom: 10px;
        padding: 5px;
        border: 1px solid #333333;
        border-radius: 3px;
        display: flex;
        flex-direction: row;
    }
</style>
<!-- 검색조건 -->
<div class="admin-condition">
    <div>
        <form action="<c:url value='/admin/order'/>">
            <label for="startDate">주문 일자</label>
            <input type="date" id="startDate" name="startDate" value="${param.startDate}"/>
            <span> ~ </span>
            <input type="date" id="endDate" name="endDate" value="${param.endDate}"/>
            <input type="submit" value="검색"/>
        </form>
    </div>
</div>
<!-- 컨테이너 -->
<div class="admin-container">
    <!-- 주문 조회 -->
    <c:forEach var="orderDto" items="${orderDtoList}">
        <div class="order-list-item">
            <div class="order-list-item-detail">
                <div>
                    <span style="font-weight: bold; font-style: italic">주문번호 : ${orderDto.orderNo} (${orderDto.status})</span>
                    <span style="float: right">주문일자 : ${orderDto.createdDate}</span>
                    <form action="<c:url value='/order/detail'/>">
                        <input type="hidden" name="orderNo" value="${orderDto.orderNo}">
                        <input type="submit" style="float:right;" value="상세 내역"/>
                    </form>
                </div>
                <div>
                    <h3>주문자 : ${orderDto.userId}</h3>
                </div>
                <div>
                    <c:set var="accept" value="${orderDto.status=='대기중' ? 'button' : 'hidden'}"/>
                    <input class="orderCancel" style="float: right" type="${accept}" value="주문 취소">
                    <input class="orderAccept" style="float: right" type="${accept}" value="주문 승인">
                    <input type="hidden" value="${orderDto.orderNo}">
                </div>
                <!-- 주문 내 주문상품 조회 -->
                <c:forEach var="orderItemDto" items="${orderDto.orderItemDtoList}">
                    <div class="innerOrderList">
                        <div>
                            <img src="http://via.placeholder.com/150X100/000000/ffffff"/>
                        </div>
                        <div>
                            <span>카테고리 : ${orderItemDto.productCategory}</span><br>
                            <span>상품명 : ${orderItemDto.productName}</span><br>
                            <span>단가 : ${orderItemDto.productPrice}원</span><br>
                            <span>주문개수 : ${orderItemDto.productQty}개</span>
                        </div>
                    </div>
                    <!-- 주문 내 주문상품 조회 -->
                </c:forEach>
            </div>
        </div>
    </c:forEach>
    <!-- 주문 조회 -->
</div>
<!-- 내용 -->
<!-- 컨테이너 -->
<ul class="paging">
    <li class="paging"><a href="#"><</a></li>
    <li class="paging"><a href="#">1</a></li>
    <li class="paging"><a href="#">2</a></li>
    <li class="paging"><a href="#">3</a></li>
    <li class="paging"><a href="#">4</a></li>
    <li class="paging"><a href="#">5</a></li>
    <li class="paging"><a href="#">6</a></li>
    <li class="paging"><a href="#">7</a></li>
    <li class="paging"><a href="#">8</a></li>
    <li class="paging"><a href="#">9</a></li>
    <li class="paging"><a href="#">10</a></li>
    <li class="paging"><a href="#">></a></li>
</ul>

<script>
    // 주문 취소
    $(".orderCancel").on("click", function () {
        let orderNo = $(this).prev().prev().val()
        $.ajax({
            type: "DELETE",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/order/" + orderNo,
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function () {
                alert("주문이 취소되었습니다.")
                location.replace("")
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    })
    // 주문 승인
    $(".orderAccept").on("click", function () {
        if ($(this).val() !== '') {
            let orderNo = $(this).next().val();
            console.log(orderNo)
            $.ajax({
                type: "POST",            // HTTP method type(GET, POST) 형식이다.
                url: "/muscles/admin/order/accept/" + orderNo, // 컨트롤러에서 대기중인 URL 주소이다.
                headers: {              // Http header
                    "Content-Type": "application/json",
                },
                success: function (res) {
                    if (res === 'ACCEPT_OK')
                        alert("주문을 승인하였습니다.")
                    location.replace("")
                },
                error: function () {
                    console.log("통신 실패")
                }
            })
        }
    })
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>
