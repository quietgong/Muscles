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
    <link rel="stylesheet" href="<c:url value='/css/modal.css'/>"/>
    <style>
        .order-list-container {
            display: flex;
            flex-direction: column;
            margin: auto;
        }

        .order-list-item {
            display: flex;
            flex-direction: column;
            margin: auto;
        }

        .order-list-item-detail {
            display: flex;
            flex-direction: column;
            margin: auto;
        }
    </style>
    <script src="https://code.jquery.com/jquery-1.11.3.js"/>

</head>
<body>
<!-- nav -->
<%@ include file="../nav.jsp" %>
<!-- 사이드바 -->
<%@include file="../mypage/sidebar.jsp" %>
<!-- 본문 -->
<div class="order-list-container">
    <div class="order-list-item" style="flex-direction: row">
        <!-- 검색 조건 -->
        <div>
            <label for="pw1">상품명</label>
            <input type="text" id="lname" name="lastname"/>
        </div>
        <div>
            <label>기간</label>
            <input type="date" id="lname" name="lastname"/>
        </div>
        <div>
            <label>~</label>
            <input type="date" id="lname" name="lastname"/>
            <input type="button" value="검색"/>
        </div>
    </div>
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
                    <!-- 버튼 2개 -->
                    <input style="float:right;" type="button" value="상세 내역"/>
                    <c:set var="accept" value="${orderDto.status=='대기중' ? 'button' : 'hidden'}"/>
                    <input style="float: right" type="${accept}" value="주문 취소">
                </div>
                <!-- 주문 내 주문상품 조회 -->
                <c:forEach var="orderItemDto" items="${orderDto.orderItemDtoList}">
                    <div>
                        <c:set var="hasReview"
                               value="${orderDto.status == '배송완료' && orderItemDto.hasReview == false ? 'button' : 'hidden'}"/>
                        <input type="${hasReview}"
                               onclick="createReview(${orderDto.orderNo}, ${orderItemDto.productNo})"
                               value="리뷰 작성"/>
                    </div>
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
<!-- 본문 -->

<!-- 모달 -->
<div id="myModal" class="modal">
    <div class="modal-content">
        <h3 style="text-align: center; font-style: italic;">리뷰 작성</h3>
        <div id="modalList">
            <!-- 동적 추가 -->
        </div>
        <div style="text-align: center;">
            <button id="registerBtn">등록</button>
            <button id="closeBtn">닫기</button>
        </div>
    </div>
</div>
<!-- 모달 -->
<!-- footer -->
<%@ include file="../footer.jsp" %>

<script>
    // 모달 내용 등록
    $("#registerBtn").on("click", function () {
        let jsonData = {};
        jsonData.userId = $("#userId").html()
        jsonData.orderNo = $('.orderNo').html()
        jsonData.productNo = $('.productNo').html()
        jsonData.productName = $('.productName').html()
        jsonData.score = $('.starRange').val()
        jsonData.content = $('.reviewContent').val()

        $.ajax({
            type: "POST",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/review", // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            data: JSON.stringify(jsonData),
            success: function () {
                alert("등록이 완료되었습니다.")
                // 리뷰 등록 버튼 숨기기
                location.replace("")
            },
            error: function () {
                console.log("통신 실패")
            }
        })
        $("#myModal").css("display", "none")
    })

    // 모달 닫기
    $("#closeBtn").on("click", function () {
        $("#myModal").css("display", "none")
    })

    // 주문 정보를 서버에서 받아온 다음 모달 내용을 추가한다.
    function createReview(orderNo, productNo) {
        console.log(orderNo, productNo);
        $.ajax({
            type: "GET",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/order?orderNo=" + orderNo + "&productNo=" + productNo, // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function (item) {
                console.log(item)
                $("#modalList").html(toHtml(item))
                console.log("Get Item")
            },
            error: function () {
                console.log("통신 실패")
            }
        })
        // 모달창 띄우기
        $("#myModal").css("display", "block")
    }

    // 리뷰 작성을 선택한 상품의 정보에 따라 모달 내용을 동적으로 추가
    let toHtml = function (item) {
        let tmp = "";
        tmp += '<div class="modal-container">'
        tmp += '<div><h3 class="productName">' + item.productName + '</h3></div>'
        tmp += '<h3 style="display: none" class="orderNo">' + item.orderNo + '</h3>'
        tmp += '<h3 style="display: none" class="productNo">' + item.productNo + '</h3>'
        tmp += '<div><span class="modal-star">★★★★★<span>★★★★★</span>'
        tmp += '<input class="starRange" type="range" value="0" step="10" min="0" max="100"/>'
        tmp += '</span></div></div>'
        tmp += '<div class="modal-container">'
        tmp += '<div><textarea class="reviewContent" placeholder="상품 후기를 작성해주세요." rows="5" cols="50"/></div>'
        tmp += '</div>'
        tmp += '<hr>'
        return tmp;
    }
</script>
<script>
    $(document).on('mousemove', '.starRange', function () {
        $(this).prev().css("width", $(this).val() + '%')
    })
</script>
</body>
</html>