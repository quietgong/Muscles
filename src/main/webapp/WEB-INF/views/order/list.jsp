<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>
<div class="container">
    <div class="row mt-5">
        <!-- 사이드바 -->
        <div class="col-md-2">
            <%@include file="../mypage/sidebar.jsp" %>
        </div>
        <!-- 컨텐츠 -->
        <div class="col-md-10">
            <!-- 검색 조건 -->
            <div>
                <label for="pw1">상품명</label>
                <input type="text" id="lname" name="lastname"/>
            </div>
            <div>
                <label>기간</label>
                <input type="date" name="startDate"/>
            </div>
            <div>
                <label>~</label>
                <input type="date" name="endDate"/>
                <input type="button" value="검색"/>
            </div>
        </div>
        <!-- 주문 조회 -->
        <c:forEach var="orderDto" items="${orderDtoList}">
            <div>
                <div>
                    <div>
                        <!-- 좌측:주문일자, 우측:주문번호 -->
                        <span>
                        <fmt:formatDate value="${orderDto.createdDate}" pattern="yyyy-MM-dd" type="date"/> 주문</span>
                        <span>주문번호 : ${orderDto.orderNo}</span>
                    </div>
                    <div>
                        <button onclick='location.href="<c:url value='/order/${orderDto.orderNo}'/>"' type="button"
                                class="btn btn-primary">상세 내역
                        </button>
                        <input type="submit" style="float:right;" value="상세 내역"/>
                        <c:set var="accept" value="${orderDto.status=='대기중' ? 'button' : 'hidden'}"/>
                        <input class="orderCancel" style="float: right" type="${accept}" value="주문 취소">
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
</div>
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
    // 주문 취소
    $(document).on("click", ".orderCancel", function () {
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
</script>
<script>
    $(document).on('mousemove', '.starRange', function () {
        $(this).prev().css("width", $(this).val() + '%')
    })

</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>