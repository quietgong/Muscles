<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<%@ include file="../nav.jsp" %>
<div class="container">
    <div class="row mt-5 justify-content-center">
        <div class="col-md-8 mt-5">
            <span style="font-size: 1.6rem; font-weight: bold;" class="card-title">주문번호 : ${orderDto.orderNo}</span>
            <div class="card">
                <div class="card-body">
                    <div class="col-md-12">
                        <span>주문자 ID : ${orderDto.userId}</span>
                        <span style="float: right;" class="card-title"
                              href="<c:url value='/order/${orderDto.orderNo}'/>">
                            <fmt:formatDate value="${orderDto.createdDate}" pattern="yyyy-MM-dd" type="date"/> 주문</span>
                    </div>
                    <!-- 주문상품 반복 -->
                    <c:forEach var="orderItemDto" items="${orderDto.orderItemDtoList}">
                        <div class="card mt-3">
                            <div class="card-body">
                                <div class="row mt-2 gx-4">
                                    <div class="col-md-2">
                                        <!-- 상품 이미지 -->
                                        <c:choose>
                                            <c:when test="${orderItemDto.goodsImgPath eq ''}">
                                                <img class="card-img rounded-0 img-fluid" src="<c:url value='/img/logo.jpg'/>" id="goods-detail">
                                            </c:when>
                                            <c:otherwise>
                                                <img class="card-img rounded-0 img-fluid" src="${orderItemDto.goodsImgPath}" id="goods-detail">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="col-md-8">
                                        <!-- 상품 이름 -->
                                        <p class="card-text">${orderItemDto.goodsName}</p>
                                        <!-- 상품 단가 -->
                                        <span class="card-text"><fmt:formatNumber value="${orderItemDto.goodsPrice}" pattern="#,###"/>원</span>
                                        <span class="card-text"> · </span>
                                        <!-- 주문 개수 -->
                                        <span class="card-text">${orderItemDto.goodsQty} 개</span><br>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <!-- 주문상품 반복 -->
                    <div class="col-md-12 mt-5">
                        <i class="fas fa-truck fa-2x fa-fw me-3"></i>
                        <span style="font-weight: bold" class="card-title"> 배송 정보</span>
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th scope="col">수령인</th>
                                <th scope="col">주소</th>
                                <th scope="col">휴대폰</th>
                                <th scope="col">요청사항</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td style="word-break: break-all">${orderDto.deliveryDto.receiver}</td>
                                <td style="word-break: break-all">${orderDto.deliveryDto.address1} ${orderDto.deliveryDto.address2}</td>
                                <td style="word-break: break-all">${orderDto.deliveryDto.phone}</td>
                                <td style="word-break: break-all">${orderDto.deliveryDto.message}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-md-12 mt-5">
                        <i class="fas fa-credit-card fa-2x fa-fw me-3"></i>
                        <span style="font-weight: bold" class="card-title"> 결제 정보</span>
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th scope="col">결제 수단</th>
                                <th scope="col">결제 금액</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td style="word-break: break-all">${orderDto.paymentDto.type}</td>
                                <td style="word-break: break-all"><fmt:formatNumber value="${orderDto.paymentDto.price}" pattern="#,###"/></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-md-12 mt-5" style="text-align: center;">
                        <button class="btn btn-outline-primary" onclick="window.history.back();"
                                type="button">뒤로가기</button>
                        <button class="btn btn-outline-primary" onclick="location.href = '<c:url value='/'/>'" type="button">홈으로
                            이동</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- footer -->
<%@ include file="../footer.jsp" %>
