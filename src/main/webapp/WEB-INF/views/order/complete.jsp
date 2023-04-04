<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>
<div class="container mt-5 mb-5">
    <div class="row d-flex justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="text-left logo p-2 px-5"><img src="<c:url value='/img/logo.jpg'/>" width="50"></div>
                <div class="invoice p-5">
                    <h5>주문이 완료되었습니다!</h5> <span class="font-weight-bold d-block mt-4">
                            안녕하세요, ${userDto.userId} 님</span>
                    <span>주문 내역은 <strong>[마이 페이지 > 주문내역/배송조회]</strong> 에서 다시 확인할 수 있습니다.</span>
                    <div class="payment border-top mt-3 mb-3 border-bottom table-responsive">
                        <table class="table table-borderless">
                            <tbody>
                            <tr>
                                <td>
                                    <div class="py-2"><span class="d-block text-muted">주문일자</span>
                                        <span>${orderDto.createdDate}</span></div>
                                </td>
                                <td>
                                    <div class="py-2"><span class="d-block text-muted">주문번호</span>
                                        <span>${orderDto.orderNo}</span></div>
                                </td>
                                <td>
                                    <div class="py-2"><span class="d-block text-muted">결제수단</span>
                                        <span>
                                            ${orderDto.paymentDto.type}
                                        </span>
                                    </div>
                                </td>
                                <td>
                                    <div class="py-2"><span class="d-block text-muted">배송지</span>
                                        <span>${orderDto.deliveryDto.address}</span></div>
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
                                    <td width="20%"><img src="${orderItemDto.productImgPath}" width="90"></td>
                                    <td width="60%"><span class="font-weight-bold">${orderItemDto.productName}</span>
                                        <div class="product-qty"><span class="d-block">수량:${orderItemDto.productQty}</span>
                                            <span>${orderItemDto.productCategory}</span></div>
                                    </td>
                                    <td width="20%">
                                        <div class="text-right"><span class="font-weight-bold">${orderItemDto.productPrice}</span></div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <!-- 상품 목록 -->
                            </tbody>
                        </table>
                    </div>
                    <div class="row d-flex justify-content-end">
                        <div class="col-md-5">
                            <table class="table table-borderless">
                                <tbody class="totals">
                                <tr>
                                    <td>
                                        <div class="text-left"><span class="text-muted">주문 금액</span></div>
                                    </td>
                                    <td>
                                        <div class="text-right"><span>${orderDto.paymentDto.price}</span></div>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <div class="text-left"><span class="text-muted">할인 적용</span></div>
                                    </td>
                                    <td>
                                        <div class="text-right"><span class="text-success">$168.50</span>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="border-top border-bottom">
                                    <td>
                                        <div class="text-left"><span class="font-weight-bold">결제 금액</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="text-right"><span
                                                class="font-weight-bold">${orderDto.paymentDto.price}</span>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-center footer p-3 gap-2">
                    <a href="<c:url value='/order/detail?orderNo=${orderDto.orderNo}'/>">
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
<!-- footer -->
<%@ include file="../footer.jsp" %>
