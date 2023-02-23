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
<div id="Wrapper">
    <h3 style="text-align: left">주문 정보</h3>
    <hr />
    <h3 style="text-align: left">받는사람 정보</h3>
    <hr />
    <h3 style="text-align: left">결제 정보</h3>
    <hr />
    <a href="<c:url value='/order/list'/>">
        <input type="button" value="주문목록" />
    </a>
    <a href="<c:url value='/'/>">
        <input type="button" value="홈 이동" />
    </a>
</div>

<!-- footer -->
<%@ include file="../footer.jsp" %>
</body>
</html>