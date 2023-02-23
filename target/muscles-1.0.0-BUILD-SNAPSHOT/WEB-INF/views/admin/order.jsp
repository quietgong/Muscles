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
    <div class="admin-item">
        <!-- 반복부 -->
        <div class="admin-item-detail">
            <div class="admin-detail-section">
                <div>
                    <!-- 주문번호, 주문일자 -->
                    <span>주문번호 : 123124</span><br>
                    <span>주문일자 : 2023.02.22</span>
                </div>
                <div>
                    <!-- 주문승인, 주문취소 버튼 -->
                    <input type="button" value="주문 승인">
                    <input type="button" value="주문 취소">
                </div>
            </div>
            <div class="admin-detail-section">
                <div>
                    <!-- 상품사진 -->
                    <img src="http://via.placeholder.com/200X100/000000/ffffff"/>
                </div>
                <div>
                    <!-- 결제상태 테이블 -->
                    <table id="myTable">
                        <tr>
                            <td>결제 상태</td>
                            <td>주문 금액</td>
                        </tr>
                        <tr>
                            <td>[배송 전]</td>
                            <td>21,500원</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <!-- 반복부 -->
        <!-- 반복부 -->
        <div class="admin-item-detail">
            <div class="admin-detail-section">
                <div>
                    <!-- 주문번호, 주문일자 -->
                    <span>주문번호 : 123124</span><br>
                    <span>주문일자 : 2023.02.22</span>
                </div>
                <div>
                    <!-- 주문승인, 주문취소 버튼 -->
                    <input type="button" value="주문 승인">
                    <input type="button" value="주문 취소">
                </div>
            </div>
            <div class="admin-detail-section">
                <div>
                    <!-- 상품사진 -->
                    <img src="http://via.placeholder.com/200X100/000000/ffffff"/>
                </div>
                <div>
                    <!-- 결제상태 테이블 -->
                    <table id="myTable">
                        <tr>
                            <td>결제 상태</td>
                            <td>주문 금액</td>
                        </tr>
                        <tr>
                            <td>[배송 전]</td>
                            <td>21,500원</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <!-- 반복부 -->
    </div>
    <!-- 내용 -->
</div>
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
</body>
</html>