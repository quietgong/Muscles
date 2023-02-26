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
          <a href="<c:url value='/order/detail'/>">
            <input style="margin: 20px 10px; float: right;" type="button" value="상세 내역" />
          </a>
          <input class="modalBtn" style="margin: 20px -5px; float: right;" type="button" value="리뷰 작성" />
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
</div>
<!-- 모달 -->
<dialog>
  <h3 style="background-color: rgb(227, 217, 204)">리뷰 작성</h3>
  <div class="modal-container">
    <div class="modal-item">
      <h3>상품명</h3>
    </div>
    <div class="modal-item">
      <h3>상품명 123</h3>
    </div>
  </div>
  <hr/>
  <div class="modal-container">
    <div class="modal-item">
      <h3>별점</h3>
    </div>
    <div class="modal-item">
      <div>
                <span class="modal-star">★★★★★
                    <span>★★★★★</span>
                <input
                        type="range"
                        oninput="drawStar(this)"
                        value="1"
                        step="0.5"
                        min="0"
                        max="5"
                />
                </span>
      </div>
    </div>
  </div>
  <hr/>
  <div class="modal-container">
    <div class="modal-item">
      <h3>후기</h3>
    </div>
    <div class="modal-item">
      <textarea rows="4" cols="20"></textarea>
    </div>
  </div>
  <form method="dialog">
    <button type="submit">등록</button>
    <button type="button">닫기</button>
  </form>
</dialog>
<!-- footer -->
<%@ include file="../footer.jsp" %>
<script>
  const drawStar = (target) => {
    document.querySelector(`.star span`).style.width = "${"${target.value*20}%"}";
  };
  // 별점
  const button = document.querySelector(".modalBtn");
  const dialog = document.querySelector("dialog");
  button.addEventListener("click", () => {
    dialog.showModal();
  });
  dialog.addEventListener("close", () => {
    alert("cancel");
  });
</script>
</body>
</html>