<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<style>
  #Wrapper {
    display: flex;
  }
  #side_bar_title {
    background-color: rgb(178, 184, 182);
    border: none;
    text-align: center;
    font-size: 25px;
  }
  #side_bar_content {
    border: black 2px solid;
    text-align: left;
    font-size: 15px;
  }
  #order{
    border: 1px dotted;
    border-radius: 5px;
  }
</style>
<body>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
<div id="Wrapper">
  <!-- 사이드바 -->
  <%@include file="../mypage/sidebar.jsp" %>

  <div style="width: 50%; margin-left: 10px; margin: auto;">
    <!-- 주문 검색조건 -->
    <div style="text-align: center;">
      <label for="pw1">상품명</label>
      <input type="text" id="lname" name="lastname" />
      <label for="pw1">기간</label>
      <input type="date" id="lname" name="lastname" />
      <label for="pw1">~</label>
      <input type="date" id="lname" name="lastname" />
      <input type="button" value="검색" />
    </div>
    <div>
      <div id="order">
        <div>
          <span style="float: right; font-weight: bold">주문번호 : 129102</span>
          <span style="font-weight: bold">주문일자 : 2022-02-10</span>
        </div>
        <div>
          <img style="float: left;" src="http://via.placeholder.com/150X100/000000/ffffff" />
          <span style="font-weight: bold;">[카테고리 > 소분류]</span>
          <span>상품명</span>
          <a href="<c:url value='/order/detail'/>">
            <input style="margin: 20px 10px; float: right;" type="button" value="상세 내역" />
          </a>
          <input style="margin: 20px -5px; float: right;" type="button" value="주문 취소" />
          <table style="width: 30%; justify-self:flex-end;" id="myTable">
            <tr>
              <th>결제 상태</th>
              <th>주문 금액</th>
            </tr>
            <tr>
              <td>배송 전</td>
              <td>15,000원</td>
            </tr>
          </table>
        </div>
      </div>
      <div id="order">
        <div>
          <span style="float: right; font-weight: bold">주문번호 : 129102</span>
          <span style="font-weight: bold">주문일자 : 2022-02-10</span>
        </div>
        <div>
          <img style="float: left;" src="http://via.placeholder.com/150X100/000000/ffffff" />
          <span style="font-weight: bold;">[카테고리 > 소분류]</span>
          <span>상품명</span>
          <input style="margin: 20px 10px; float: right;" type="button" value="상세 내역" />
          <input style="margin: 20px -5px; float: right;" type="button" value="주문 취소" />
          <table style="width: 30%; justify-self:flex-end;" id="myTable">
            <tr>
              <th>결제 상태</th>
              <th>주문 금액</th>
            </tr>
            <tr>
              <td>배송 전</td>
              <td>15,000원</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
  </div>

<!-- footer -->
<%@ include file="../footer.jsp" %>
</body>
</html>