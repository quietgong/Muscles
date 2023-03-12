<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../nav.jsp" %>

<!-- 검색조건 -->
<div class="admin-condition">
    <div>
        <span for="pw1">주문 일자</span>
        <input type="date" id="lname" name="lastname"/>
        <span for="pw1"> ~ </span>
        <input type="date" id="lname" name="lastname"/>
        <input type="button" value="검색"/>
    </div>
</div>
<!-- 검색조건 끝 -->

<!-- 컨테이너 -->
<div class="admin-container">
    <!-- 사이드바 -->
    <%@include file="sidebar.jsp" %>
    <!-- 사이드바 -->
    <!-- 내용 -->
    <!-- 본문 -->
    <div class="order-list-container">
        <!-- 주문 조회 -->
        <c:forEach var="orderDto" items="${orderDtoList}">
            <div style="border: 2px solid darkorange; border-radius: 2px;" class="order-list-item">
                <div class="order-list-item-detail">
                    <div>
                        <span>${orderDto.createdDate} 주문</span>
                        <span>주문번호 : ${orderDto.orderNo}</span>
                    </div>
                    <div>
                        <h3>주문자 : ${orderDto.userId}</h3>
                    </div>
                    <div>
                        <form action="<c:url value='/order/detail'/>">
                            <input type="hidden" name="orderNo" value="${orderDto.orderNo}">
                            <input type="submit" style="float:right;" value="상세 내역"/>
                        </form>
                        <c:set var="accept" value="${orderDto.status=='대기중' ? 'button' : 'hidden'}"/>
                        <input class="orderCancel" style="float: right" type="${accept}" value="주문 취소">
                        <input class="orderAccept" style="float: right" type="${accept}" value="주문 승인">
                        <input type="hidden" value="${orderDto.orderNo}">
                    </div>
                    <!-- 주문 내 주문상품 조회 -->
                    <c:forEach var="orderItemDto" items="${orderDto.orderItemDtoList}">
                        <div>
                            <img style="float: left;" src="http://via.placeholder.com/150X100/000000/ffffff"/>
                            <p>[${orderItemDto.productCategory}]</p>
                            <p>${orderItemDto.productName}</p>
                            <span>${orderItemDto.productPrice}원</span>
                            <span> ${orderItemDto.productQty}개</span>
                        </div>
                        <!-- 주문 내 주문상품 조회 -->
                    </c:forEach>
                </div>
                <div>
                    <h2>주문상태 : ${orderDto.status}</h2>
                </div>
            </div>
        </c:forEach>
        <!-- 주문 조회 -->
    </div>
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
    $(".orderCancel").on("click", function (){
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
    $(".orderAccept").on("click", function (){
        if($(this).val()!==''){
            let orderNo = $(this).next().val();
            console.log(orderNo)
            $.ajax({
                type: "POST",            // HTTP method type(GET, POST) 형식이다.
                url: "/muscles/admin/order/accept/" + orderNo , // 컨트롤러에서 대기중인 URL 주소이다.
                headers: {              // Http header
                    "Content-Type": "application/json",
                },
                success: function (res) {
                    if(res==='ACCEPT_OK')
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
