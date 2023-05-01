<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<%@ include file="../nav.jsp" %>
<div class="container mt-5 mb-5">
    <div class="row d-flex justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="text-left logo p-2 px-5">
                    <img class="img-fluid" src="<c:url value='/img/logo.jpg'/>" width="80">
                </div>
                <div class="invoice p-5">
                    <h5>주문이 완료되었습니다!</h5> <span class="font-weight-bold d-block mt-4">
                            안녕하세요, ${userId} 님</span>
                    <span>주문 내역은 <strong><a href="<c:url value='/mypage/order'/>">[마이 페이지 > 주문내역/배송조회]</a></strong> 에서 다시 확인할 수 있습니다.</span>
                    <div class="payment border-top mt-3 mb-3 border-bottom table-responsive">
                        <table class="table table-borderless" style="text-align: center">
                            <tbody>
                            <tr>
                                <td>
                                    <div class="py-2"><span class="d-block text-muted">주문일자</span>
                                        <span class="mt-2"><fmt:formatDate value="${orderDto.createdDate}"
                                                                           pattern="yyyy-MM-dd"
                                                                           type="date"/></span></div>
                                </td>
                                <td>
                                    <div class="py-2"><span class="d-block text-muted">주문번호</span>
                                        <span class="mt-2">${orderDto.orderNo}</span></div>
                                </td>
                                <td>
                                    <div class="py-2"><span class="d-block text-muted">결제수단</span>
                                        <span class="mt-2">
                                            ${orderDto.paymentDto.type}
                                        </span>
                                    </div>
                                </td>
                                <td>
                                    <div class="py-2"><span class="d-block text-muted">배송지</span>
                                        <span class="mt-2">${orderDto.deliveryDto.address1} ${orderDto.deliveryDto.address2}</span>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="product border-bottom table-responsive">
                        <table class="table table-borderless">
                            <tbody>
                            <!-- 상품 목록 -->
                            <c:forEach var="orderItemDto" items="${orderDto.orderItemDtoList}">
                                <tr>
                                    <td width="30%">
                                        <c:choose>
                                            <c:when test="${orderItemDto.goodsImgPath eq ''}">
                                                <img class="img-fluid" src="<c:url value='/img/logo.jpg'/>">
                                            </c:when>
                                            <c:otherwise>
                                                <img class="img-fluid" src="${orderItemDto.goodsImgPath}">
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td width="40%">
                                        <span class="font-weight-bold">
                                                ${orderItemDto.goodsName} (수량 : ${orderItemDto.goodsQty})
                                        </span>
                                    </td>
                                    <td width="20%">
                                        <div class="text-right">
                                            <span class="font-weight-bold">
                                                ₩<fmt:formatNumber value="${orderItemDto.goodsPrice}" pattern="#,###"/>
                                            </span>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <!-- 상품 목록 -->
                            </tbody>
                        </table>
                    </div>
                    <div class="row d-flex justify-content-center">
                        <div class="col-md-5">
                            <table class="table table-borderless">
                                <tbody class="totals">
                                <tr>
                                    <td>
                                        <div class="text-left"><span class="text-muted">주문 금액</span></div>
                                    </td>
                                    <td>
                                        <div class="text-right">
                                            <span>
                                                ₩<fmt:formatNumber
                                                    value="${orderDto.paymentDto.price + orderDto.discount}"
                                                    pattern="#,###"/>
                                            </span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="text-left"><span class="text-muted">할인 적용</span></div>
                                    </td>
                                    <td>
                                        <div class="text-right">
                                            <span class="text-success">
                                                ₩<fmt:formatNumber value="${orderDto.discount}" pattern="#,###"/>
                                            </span>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="border-top border-bottom">
                                    <td>
                                        <div class="text-left"><span class="font-weight-bold">결제 금액</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="text-right">
                                            <span class="font-weight-bold">
                                                ₩<fmt:formatNumber value="${orderDto.paymentDto.price}"
                                                                   pattern="#,###"/>
                                            </span>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-center footer p-3 gap-2">
                    <a href="<c:url value='/order/${orderDto.orderNo}'/>">
                        <button class="btn btn-primary" type="button">주문내역 확인</button>
                    </a>
                    <a href="<c:url value='/'/>">
                        <button class="btn btn-primary" type="button">홈으로 이동</button>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    <%--try {--%>
    <%--    JSON.parse('${orderDto}');--%>
    <%--} catch (e) {--%>
    <%--    location.href = "/muscles";--%>
    <%--}--%>
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>
