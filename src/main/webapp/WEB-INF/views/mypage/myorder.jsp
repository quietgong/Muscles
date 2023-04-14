<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>
<style>
    tr{
        vertical-align: middle;
    }
    td{
        vertical-align: middle;
    }
</style>
<div class="container">
    <div class="row mt-3">
        <!-- 사이드바 -->
        <div class="col-md-2">
            <%@include file="sidebar.jsp" %>
        </div>
        <!-- 컨텐츠 -->
        <div class="col-md-10">
            <!-- 검색 조건 -->
            <div class="row mt-5 justify-content-center">
                <div class="col-md-6">
                    <div class="input-group gap-3">
                        <label class="form-label mt-2" for="startDate">주문일자</label>
                        <input id="startDate" class="form-control" type="date" name="startDate"/>
                        <label class="form-label mt-2">~</label>
                        <input class="form-control" type="date" name="endDate"/>
                        <button class="btn btn-primary" type="button">검색</button>
                    </div>
                </div>
            <!-- 검색 조건 -->
            <!-- 주문 내역 -->
            <div class="row mt-5 justify-content-center">
                <!-- 주문 반복 -->
                <c:forEach var="orderDto" items="${orderDtoList}">
                    <div class="col-md-8 mt-5">
                        <div class="card">
                            <div class="card-body">
                                <div class="col-md-12">
                                    <span style="font-size: 1.6rem; font-weight: bold;"
                                          class="card-title"><fmt:formatDate value="${orderDto.createdDate}"
                                                                             pattern="yyyy-MM-dd"
                                                                             type="date"/> 주문</span>
                                    <a style="float: right; text-decoration: none;" class="card-title"
                                       href="<c:url value='/order/${orderDto.orderNo}'/>">상세내역 확인</a>
                                </div>
                                <div class="col-md-12">
                                    <c:set var="accept" value="${orderDto.status=='주문대기' ? 'inline' : 'none'}"/>
                                    <button style="display: ${accept}" type="button" class="btn btn-outline-danger"
                                            onclick="orderCancel(this)">주문 취소
                                    </button>
                                    <input type="hidden" value="${orderDto.orderNo}">
                                </div>
                                <!-- 주문상품 반복 -->
                                <c:forEach var="orderItemDto" items="${orderDto.orderItemDtoList}">
                                    <div class="card mt-3">
                                        <div class="card-body">
                                            <div class="row mt-2">
                                                <h5 style="font-weight: bold; display: block;"
                                                    class="card-text">${orderDto.status}</h5>
                                            </div>
                                            <div class="row mt-2 gx-4">
                                                <div class="col-md-3">
                                                    <!-- 상품 이미지 -->
                                                    <img class="card-img rounded-0 img-fluid"
                                                         src="${orderItemDto.goodsImgPath}">
                                                </div>
                                                <div class="col-md-3 justify-content-center">
                                                    <!-- 상품 이름 -->
                                                    <p class="card-text">${orderItemDto.goodsName}</p>
                                                    <!-- 상품 단가 -->
                                                    <span class="card-text">${orderItemDto.goodsPrice}원</span>
                                                    <span class="card-text"> · </span>
                                                    <!-- 주문 개수 -->
                                                    <span class="card-text">${orderItemDto.goodsQty} 개</span><br>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="d-flex justify-content-center gap-2">
                                                        <button type="button"
                                                                onclick='location.href="<c:url value='/goods/detail?goodsNo=${orderItemDto.goodsNo}'/>"' class="btn btn-outline-primary">
                                                            상품 페이지 이동
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <c:set var="hasReview"
                                               value="${orderDto.status == '주문완료' && orderItemDto.hasReview == false ? 'inline' : 'none'}"/>
                                        <button style="display: ${hasReview}" type=button class="btn btn-primary"
                                                data-bs-toggle="modal" data-bs-target="#exampleModal"
                                                onclick="createReview(${orderDto.orderNo}, ${orderItemDto.goodsNo})">
                                            리뷰 작성
                                        </button>
                                    </div>
                                </c:forEach>
                                <!-- 주문상품 반복 -->
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <!-- 주문 반복 -->
            </div>
            <!-- 주문 내역 -->
        </div>
    </div>
</div>
<%@ include file="../footer.jsp" %>
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">리뷰 작성</h5>
                <button type="button" onclick="initModal()" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- 모달 구성 요소 -->
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <h3 id="goodsName" class="goodsName">상품 이름</h3>
                        </div>
                    </div>
                    <div class="row">
                        <ul class="list-unstyled d-flex justify-content-center mb-1">
                            <div class="star-ratings" style="width: auto">
                                <input id="starRange" class="starRange" type="range" value="100" step="10" min="0"
                                       max="100"/>
                                <div class="fill-ratings">
                                    <span style="font-size: 1.8rem;">★★★★★</span>
                                </div>
                                <div class="empty-ratings">
                                    <span style="font-size: 1.8rem;">★★★★★</span>
                                </div>
                            </div>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                                <textarea id="reviewContent" class="form-control mt-1" placeholder="상품 후기를 작성해주세요."
                                          rows="5"
                                          cols="50"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 모달 구성 요소 -->
            <div id="modal-footer" class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="initModal()" data-bs-dismiss="modal">Close
                </button>
                <button onclick="reviewRegister(this)" type="button" class="btn btn-primary">등록</button>
                <input id="reviewNo" value="" type="hidden">
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<script>
    // 주문 취소
    function orderCancel(e) {
        let orderNo = $(e).next().val()
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
    }
</script>
<script>
    // 모달창이 닫혔을 때 모달 내용 초기화
    function initModal() {
        $("#reviewContent").val("")
        $("#starRange").val("")
        $("#starRange").next().css("width", "100%")
    }

    // 해당 주문에 대한 정보를 모달창에 입력
    function createReview(orderNo, goodsNo) {
        $.ajax({
            type: "GET",
            url: "/muscles/order?orderNo=" + orderNo + "&goodsNo=" + goodsNo,
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function (res) {
                console.log(res)
                insertModalData(res)
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    }

    function insertModalData(item) {
        $("#goodsName").html(item.goodsName) // 상품 이름 입력
        $("#modal-footer").attr("data-orderNo", item.orderNo)
        $("#modal-footer").attr("data-goodsNo", item.goodsNo)
        $("#modal-footer").attr("data-goodsName", item.goodsName)
    }

    // 모달 내용 등록
    function reviewRegister(e) {
        let data = {};
        data.userId = '${userId}'
        data.orderNo = $(e).parent().attr("data-orderNo")
        data.goodsNo = $(e).parent().attr("data-goodsNo")
        data.goodsName = $(e).parent().attr("data-goodsName")
        data.score = $('#starRange').val()
        data.content = $('#reviewContent').val()
        $.ajax({
            type: "POST",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/review", // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            data: JSON.stringify(data),
            success: function () {
                alert("등록이 완료되었습니다.")
                // 리뷰 등록 버튼 숨기기
                location.replace("")
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    }
</script>
<script>
    // 별점 드래그
    $(document).on('mouseup', '.starRange', function () {
        $(this).next().css("width", $(this).val() + '%')
    })
</script>