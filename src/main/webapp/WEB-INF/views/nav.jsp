<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://kit.fontawesome.com/b663b9db7c.js" crossorigin="anonymous"></script>
<div class="nav-container">
  <div class="nav-item" style="width: 150px; display: flex; justify-content: space-between">
    <a href="<c:url value='/order/list'/>">
      <div style="text-align: center">
        <i style="margin: auto" class="fa-sharp fa-solid fa-user"></i>
      </div>
      <span>마이페이지</span>
      <br/>
    </a>
    <a href="<c:url value='/cart'/>">
      <div style="text-align: center">
        <i
                style="margin: auto"
                class="fa-sharp fa-solid fa-cart-shopping"
        ></i>
      </div>
      <span>장바구니</span>
      <br/>
    </a>
  </div>
  <div class="nav-item">
    <a href="<c:url value='/'/>">
      <img src="http://via.placeholder.com/300X100/000000/ffffff"/>
    </a>
    <div class="nav-item" style="text-align: center">
      <input
              style="text-align: center"
              type="text"
              placeholder="상품 이름을 검색하세요"
      />
      <button type="submit">검색</button>
    </div>
  </div>
  <div class="nav-item" style="align-self: baseline">
    <div>
          <span
          ><a href="<c:url value='/login'/>">로그인</a> |
            <a href="<c:url value='/register'/>">회원가입</a></span
          >
      <br/>
      <span><a href="<c:url value='/logout'/>">로그아웃</a> | <a href="<c:url value='/chatting'/>">채팅상담</a></span>
    </div>
  </div>
</div>
<!-- Dropdown -->
<div class="nav-item">

  <ul class="nav">
    <li class="nav"><a href="<c:url value='/'/>">Home</a></li>
    <li class="dropdown">
      <a href="javascript:void(0)" class="dropbtn">Muscles</a>
      <div class="dropdown-content">
        <a href="<c:url value='/community'/>">커뮤니티</a>
        <a href="<c:url value='/notice'/>">공지사항/이벤트</a>
      </div>
    </li>
    <li class="dropdown">
      <a href="javascript:void(0)" class="dropbtn">카테고리</a>
      <div class="dropdown-content">
        <a href="<c:url value='/products/cardio'/>">유산소</a>
        <a href="<c:url value='/products/strength'/>">근력</a>
        <a href="<c:url value='/products/etc'/>">기타용품</a>
      </div>
    </li>
  </ul>

</div>