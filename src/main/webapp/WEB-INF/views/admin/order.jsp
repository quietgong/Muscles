<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../nav.jsp" %>
<style>
    tr {
        vertical-align: middle;
    }

    td {
        vertical-align: middle;
    }
</style>
<div class="container">
    <div class="row mt-5">
        <div class="col-md-2">
            <%@include file="sidebar.jsp" %>
        </div>
        <div class="col-md-10">
            <div class="row">
                <div class="col-md-8">
                    <h1 class="app-page-title mb-0">주문 관리</h1>
                </div>
                <div class="col-md-4">
                    <form id="conditionForm">
                        <!-- 기간 조건 -->
                        <div class="input-group flex-nowrap">
                            <span class="input-group-text" id="addon-wrapping">기간</span>
                            <select name="period" class="form-select">
                                <option selected value="all">전체</option>
                                <option value="week">이번주</option>
                                <option value="month">이번달</option>
                                <option value="3months">지난 3개월</option>
                            </select>
                            <button type="submit" onclick="submit()" class="btn btn-primary">검색</button>
                        </div>
                        <!-- 상태 조건 -->
                        <div class="input-group flex-nowrap mt-3">
                            <span class="input-group-text" id="">상태</span>
                            <select name="status" class="form-select">
                                <option selected value="all">전체</option>
                                <option value="pending">대기 주문</option>
                                <option value="complete">완료 주문</option>
                                <option value="cancel">취소 주문</option>
                            </select>
                            <button type="submit" onclick="submit()" class="btn btn-primary">검색</button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-md-12">
                    <div class="tab-content" id="orders-table-tab-content">
                        <div class="tab-pane fade show active" id="orders-all" role="tabpanel"
                             aria-labelledby="orders-all-tab">
                            <div class="app-card app-card-orders-table shadow-sm mb-5">
                                <div class="app-card-body">
                                    <div class="table-responsive">
                                        <table class="table app-table-hover mb-0 text-center">
                                            <thead>
                                            <tr>
                                                <th class="cell">주문번호</th>
                                                <th class="cell">주문상품</th>
                                                <th class="cell">구매자</th>
                                                <th class="cell">주문일자</th>
                                                <th class="cell">상태</th>
                                                <th class="cell">주문가격</th>
                                                <th class="cell"></th>
                                                <th class="cell"></th>
                                                <th class="cell"></th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="orderDto" items="${orderDtoList}">
                                                <tr>
                                                    <td class="cell">${orderDto.orderNo}</td>
                                                    <td class="cell">
                                                        <span class="truncate">
                                                            <c:choose>
                                                                <c:when test="${orderDto.orderItemDtoList.size()>1}">
                                                                    ${orderDto.orderItemDtoList[0].goodsName} 외 ${orderDto.orderItemDtoList.size()-1}개
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${orderDto.orderItemDtoList[0].goodsName}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </td>
                                                    <td class="cell">${orderDto.userId}</td>
                                                    <td class="cell">
                                                        <span class="note">
                                                            <fmt:formatDate value="${orderDto.createdDate}"
                                                                            pattern="yyyy-MM-dd" type="date"/>
                                                        </span>
                                                    </td>
                                                    <td class="cell">
                                                        <c:choose>
                                                            <c:when test="${orderDto.status == '주문대기'}">
                                                                <span class="badge bg-warning">
                                                                        ${orderDto.status}
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${orderDto.status == '주문완료'}">
                                                                <span class="badge bg-success">
                                                                        ${orderDto.status}
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-danger">
                                                                        ${orderDto.status}
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="cell">${orderDto.paymentDto.price}</td>
                                                    <td class="cell">
                                                        <a style="text-decoration: none"
                                                           class="btn-sm app-btn-secondary"
                                                           href="<c:url value='/order/${orderDto.orderNo}'/>">상세보기</a>
                                                    </td>
                                                    <c:if test="${orderDto.status == '주문대기'}">
                                                        <td class="cell">
                                                            <button type="button"
                                                                    class="orderAccept btn btn-outline-primary">승인
                                                            </button>
                                                        </td>
                                                    </c:if>
                                                    <c:if test="${orderDto.status == '주문대기'}">
                                                        <td class="cell">
                                                            <button type="button" data-bs-toggle="modal"
                                                                    data-bs-target="#orderCancelModal"
                                                                    onclick="$('#orderCancelNum').val(${orderDto.orderNo})"
                                                                    class="orderCancel btn btn-outline-danger">주문취소
                                                            </button>
                                                        </td>
                                                    </c:if>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div><!--//table-responsive-->
                                </div><!--//app-card-body-->
                            </div><!--//app-card-->
                        </div><!--//tab-pane-->
                    </div>
                </div>
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
                                <input class="form-check-input" type="radio" name="orderCancelOption" value="재고 부족"
                                       checked>
                                <label class="form-check-label">재고 부족</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="orderCancelOption" value="배송 불가">
                                <label class="form-check-label">배송 불가</label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="orderCancelOption" value="잘못된 주문">
                                <label class="form-check-label">잘못된 주문</label>
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
<script>
    /* 주문 승인 처리 */
    $(".orderAccept").on("click", function () {
        let orderNo = $(this).parent().parent().children().html()
        $.ajax({
            type: "POST",
            url: "/muscles/admin/order/" + orderNo,
            headers: { // Http header
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
    })
</script>
<script>
    /* 주문 취소 처리 */

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
        if ($("input[name='orderCancelOption']:checked").val() === 'etc')
            cancelReason = $("#orderCancelContent").val()
        else
            cancelReason = $("input[name='orderCancelOption']:checked").val()
        $.ajax({
            type: "DELETE",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/order/" + orderNo,
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            data: cancelReason,
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
    /* 조건 처리 */
    // 검색 결과에 따라 각 체크박스 선택
    $('select[name="period"] option[value="${param.period}"]').prop('selected', true);
    $('select[name="status"] option[value="${param.status}"]').prop('selected', true);
    
    function submit() {
        const form = $("#conditionForm")
        let period = $('select[name="period"] option:selected').val()
        let status = $('select[name="status"] option:selected').val()

        form.append($('<input>').attr({
            type: 'hidden', name: period, value: period
        }))
        form.append($('<input>').attr({
            type: 'hidden', name: status, value: status
        }))

        form.submit()
    }

</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>