<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<c:set var="welcomeUser"
       value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${welcomeUser=='' ? '/login' : '/logout'}"/>
<c:set var="loginOut" value="${welcomeUser=='' ? '로그인' : '로그아웃'}"/>
<c:set var="chatting" value="${welcomeUser=='' ? '' : '채팅상담'}"/>
<c:set var="register" value="${pageContext.request.getSession(false)==null ? '회원가입' : ''}"/>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Muscles</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
    <link rel="stylesheet" href="<c:url value='/css/modal.css'/>"/>
    <script src="https://kit.fontawesome.com/b663b9db7c.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<body>
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
    <div class="nav-item" style="text-align: center">
        <a href="<c:url value='/'/>">
            <img src="http://via.placeholder.com/300X100/000000/ffffff"/>
        </a>
        <span>
            <form action="<c:url value='/product/list'/>">
            <input style="text-align: center; width: 60%;" name="keyword" type="text" placeholder="상품 이름을 검색하세요"/>
            <button type="submit">검색</button>
            </form>
        </span>
    </div>
    <div class="nav-item" style="align-self: baseline">
        <div>
          <span>
            <a href="<c:url value='${loginOutLink}'/>">${loginOut}</a> |
            <a href="<c:url value='/register'/>">${register}</a>
            <a href="<c:url value='/chatting'/>">${chatting}</a>
          </span>
        </div>
        <div><h2 id="userId">${welcomeUser}님! 좋은 하루 되세요</h2></div>
    </div>
</div>
<!-- Dropdown -->
<div class="nav-item">

    <ul class="nav">
        <li class="nav"><a href="<c:url value='/'/>">Home</a></li>
        <li class="dropdown">
            <a href="javascript:void(0)" class="dropbtn">Muscles</a>
            <div class="dropdown-content">
                <a href="<c:url value='/community/list'/>">커뮤니티</a>
                <a href="<c:url value='/notice/list'/>">공지사항/이벤트</a>
            </div>
        </li>
        <li class="dropdown">
            <a href="javascript:void(0)" class="dropbtn">카테고리</a>
            <div class="dropdown-content">
                <a href="<c:url value='/product/list?category=cardio'/>">유산소</a>
                <a href="<c:url value='/product/list?category=strength'/>">근력</a>
                <a href="<c:url value='/product/list?category=etc'/>">기타용품</a>
            </div>
        </li>
    </ul>
</div>
</body>
</html>