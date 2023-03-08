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
    <script src="https://code.jquery.com/jquery-1.11.3.js"/>
</head>
<body>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
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
                        <!-- 좌측:주문일자, 우측:주문번호 -->
                        <span>${orderDto.createdDate} 주문</span>
                        <span>주문번호 : ${orderDto.orderNo}</span>
                    </div>
                    <div>
                        <h3>주문자 : ${orderDto.userId}</h3>
                    </div>
                    <div>
                        <!-- 버튼 2개 -->
                        <input type="button" value="상세 내역"/>
                        <c:set var="acceptBtn" value="${orderDto.status == '대기중' ? 'button' : 'hidden'}"/>
                        <input type="${acceptBtn}" class="acceptBtn" value="주문 승인"/>
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

<!-- footer -->
<%@ include file="../footer.jsp" %>
<script>
    $(".acceptBtn").on("click", function (){
        if($(this).val()!==''){
            let orderNo = $(this).next().val();
            let now = $(this)
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
                    now.hide()
                },
                error: function () {
                    console.log("통신 실패")
                }
            })
        }

    })
</script>
</body>
</html>