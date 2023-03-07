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
<body>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
<!-- 검색조건 -->
<div class="admin-condition">
    <div>
        <span for="pw1">유저 ID </span>
        <input type="text" id="lname" name="lastname" />
        <span for="pw1">가입 기간 </span>
        <input type="date" id="lname" name="lastname" />
        <span for="pw1"> ~ </span>
        <input type="date" id="lname" name="lastname" />
        <input type="button" value="검색" />
    </div>
</div>
<!-- 검색조건 끝 -->

<!-- 컨테이너 -->
<div class="container">
    <!-- 사이드바 -->
    <%@include file="sidebar.jsp" %>
    <!-- 사이드바 -->
    <!-- 내용 -->
    <div class="admin-item">
        <div class="admin-item-detail" style="border: none;">
            <table id="myTable">
                <tr>
                    <th>번호</th>
                    <th>작성 ID</th>
                    <th>가입일자</th>
                    <th>설정</th>
                </tr>
                <c:forEach var="userDto" items="${list}">
                <tr>
                    <td>${userDto.userNo}</td>
                    <td>${userDto.id}</td>
                    <td>${userDto.created_date}</td>
                    <td><input type="button" value="탈퇴처리"></td>
                </tr>
                </c:forEach>
            </table>
        </div>
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