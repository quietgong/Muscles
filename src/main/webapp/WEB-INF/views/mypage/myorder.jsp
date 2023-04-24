<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<%@ include file="../nav.jsp" %>
<div class="container">
    <div class="row mt-3">
        <div class="col-md-2">
            <%@include file="sidebar.jsp" %>
        </div>
        <!-- 컨텐츠 -->
        <div class="col-md-10">
            <!-- 검색 조건 -->
            <div class="row mt-5 justify-content-center">
                <div class="col-md-6">
                    <form>
                        <div class="input-group gap-3">
                            <label class="form-label mt-2" for="startDate">주문일자</label>
                            <input id="startDate" class="form-control" type="date" name="startDate"
                                   value="${param.startDate}"/>
                            <label class="form-label mt-2">~</label>
                            <input class="form-control" type="date" name="endDate" value="${param.endDate}"/>
                            <button class="btn btn-primary" type="submit">검색</button>
                        </div>
                    </form>
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
                                                data-bs-toggle="modal" data-bs-target="#orderCancelModal"
                                                onclick="$('#orderCancelNum').val(${orderDto.orderNo})">주문 취소
                                        </button>
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
                                                        <span class="card-text"><fmt:formatNumber
                                                                value="${orderItemDto.goodsPrice}"
                                                                pattern="#,###"/>원</span>
                                                        <span class="card-text"> · </span>
                                                        <!-- 주문 개수 -->
                                                        <span class="card-text">${orderItemDto.goodsQty} 개</span><br>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="d-flex justify-content-center gap-2">
                                                            <c:set var="hasReview"
                                                                   value="${orderDto.status == '주문완료' && orderItemDto.hasReview == false ? 'inline' : 'none'}"/>
                                                            <button style="display: ${hasReview}" type=button class="btn btn-primary"
                                                                    data-bs-toggle="modal" data-bs-target="#exampleModal"
                                                                    onclick="createReview(${orderDto.orderNo}, ${orderItemDto.goodsNo})">
                                                                리뷰 작성
                                                            </button>
                                                            <button type="button"
                                                                    onclick='location.href="<c:url
                                                                            value='/goods/detail?goodsNo=${orderItemDto.goodsNo}'/>"'
                                                                    class="btn btn-outline-primary">
                                                                상품 페이지 이동
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
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
</div>
<!-- 주문 취소 Modal -->
<div class="modal fade" id="orderCancelModal" tabindex="-1" aria-labelledby="orderCancelModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="orderCancelModalLabel">주문 취소 사유</h5>
                <button type="button" onclick="initOrderCancelModal()" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- 모달 구성 요소 -->
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <!-- 모달 구성 -->
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="orderCancelOption" value="단순 변심"
                                       checked>
                                <label class="form-check-label">단순 변심</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="orderCancelOption" value="배송 지연">
                                <label class="form-check-label">배송 지연</label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="orderCancelOption" value="주문 실수">
                                <label class="form-check-label">주문 실수</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="orderCancelOption" value="서비스 불만족">
                                <label class="form-check-label">서비스 불만족</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="orderCancelOption" value="etc">
                                <label class="form-check-label">기타 사유</label>
                            </div>
                        </div>
                    </div>
                    <div style="display: none" id="orderCancelDetail" class="row mt-5">
                        <div class="col-md-12">
                                <textarea id="orderCancelContent" class="form-control mt-1"
                                          placeholder="500자 이내로 주문취소 사유를 작성해주시기 바랍니다."
                                          rows="5"
                                          cols="50"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 모달 구성 요소 -->
            <div class="modal-footer">
                <button type="button" onclick="initOrderCancelModal()" class="btn btn-secondary"
                        data-bs-dismiss="modal">Close
                </button>
                <button onclick="orderCancel(this)" type="button" class="btn btn-primary">완료</button>
                <input type="hidden" id="orderCancelNum" value="">
            </div>
        </div>
    </div>
</div>
<!-- 주문 취소 Modal -->

<!-- 리뷰 작성 Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">리뷰 작성</h5>
                <button type="button" onclick="initReviewModal()" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- 모달 구성 요소 -->
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 text-center">
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
                    <div class="row mt-5">
                        <div class="col-md-12">
                            <label for="reviewImg" class="form-label text-center">리뷰 이미지를 업로드해주세요!</label>
                            <input onchange='uploadImg("/muscles/img/review/detail/"+$("#modal-footer").attr("data-goodsno"), this)' type="file" multiple class="form-control" id="reviewImg" name='uploadFile'>
                            <div id="reviewPreview"></div>
                        </div>
                    </div>
                    <div class="row mt-5">
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
                <button type="button" class="btn btn-secondary" onclick="initReviewModal()" data-bs-dismiss="modal">
                    Close
                </button>
                <button onclick="reviewRegister(this)" type="button" class="btn btn-primary">등록</button>
            </div>
        </div>
    </div>
</div>
<!-- 리뷰 작성 Modal -->

<script src="<c:url value='/js/custom/image.js'/>"></script>
<script>
    function showPreview(items, type) {
        let tmp = "";
        items.forEach(function (item) {
            let addr = "/muscles/img/display?category=review&type=" + type + "&fileName=" + item.uploadName
            tmp += '<div class="detail" data-type=' + type + ' data-url=' + item.uploadName + '>'
            tmp += '<button class="delPreview btn btn-danger mb-3 mt-3" type="button">X</button>'
            tmp += '<button style="float: right" class="down btn btn-warning mb-3 mt-3" type="button">↓</button>'
            tmp += '<button style="float: right; margin-right: 10px" class="up btn btn-warning mb-3 mt-3" type="button">↑</button>'
            tmp += '<img class="img-fluid newDetail" src="' + addr + '">'
            tmp += '</div>'
        });
        $("#reviewPreview").append(tmp)
        showUpDownBtn()
    }
</script>
<script>
    /* 주문 취소 모달창 처리 */
    // 기타 사유 선택시 textarea 출력, 그렇지 않으면 미출력
    $("input[name='orderCancelOption']").change(function () {
        if ($("input[name='orderCancelOption']:checked").val() === 'etc') {
            $("#orderCancelDetail").show()
        } else
            $("#orderCancelDetail").hide()
    });
    $("#etcReason:checked")

    // 주문 취소 모달창이 닫혔을 때 모달 내용 초기화
    function initOrderCancelModal() {
        $("#orderCancelDetail").val("")
    }

    // 주문 취소
    function orderCancel(e) {
        let orderNo = $(e).next().val()
        let cancelReason;
        let checkVal = $("input[name='orderCancelOption']:checked").val()
        cancelReason = checkVal === 'etc' ? $("#orderCancelContent").val() : checkVal
        commonAjax("/muscles/order/" + orderNo, cancelReason, "DELETE", function () {
            alert("주문이 취소되었습니다.")
            location.replace("")
        })
    }
</script>
<script>
    // 리뷰 작성 모달창이 닫혔을 때 모달 내용 초기화
    function initReviewModal() {
        $("#reviewContent").val("")
        $("#starRange").val("")
        $("#starRange").next().css("width", "100%")
        $("#reviewPreview").html("")
        $("#reviewImg").val("")
    }

    // 해당 주문에 대한 정보를 모달창에 입력
    function createReview(orderNo, goodsNo) {
        let url = "/muscles/order?orderNo=" + orderNo + "&goodsNo=" + goodsNo
        commonAjax(url, null, "GET", function (res) {
            insertReviewModalData(res)
        })
    }

    function insertReviewModalData(item) {
        $("#goodsName").html(item.goodsName)
        $("#modal-footer").attr("data-orderNo", item.orderNo)
        $("#modal-footer").attr("data-goodsNo", item.goodsNo)
        $("#modal-footer").attr("data-goodsName", item.goodsName)
    }

    // 리뷰 작성 모달 내용 등록
    function reviewRegister(e) {
        let data = {};
        data.userId = '${userId}'
        data.orderNo = $(e).parent().attr("data-orderNo")
        data.goodsNo = $(e).parent().attr("data-goodsNo")
        data.goodsName = $(e).parent().attr("data-goodsName")
        data.score = $('#starRange').val()
        data.content = $('#reviewContent').val()
        let reviewImgDtoList = []
        $('.newDetail').each(function () {
            let tmp = {}
            tmp.goodsNo = data.goodsNo
            tmp.uploadPath = $(this).attr("src")
            reviewImgDtoList.push(tmp)
        });
        data.reviewImgDtoList = reviewImgDtoList
        commonAjax("/muscles/review", data, "POST", function () {
            alert("등록이 완료되었습니다.")
            location.reload()
        })
    }
</script>
<%@ include file="../footer.jsp" %>