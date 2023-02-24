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
<!-- 사이드바 시작 -->
<%@include file="sidebar.jsp" %>
<!-- 사이드바 끝 -->
<div id="Wrapper" style="margin: auto; width: 70%;">
    <h3 style="text-align: left">쿠폰 등록</h3>
    <hr />
    <label for="selectEvent">이벤트 선택</label>
    <select id="selectEvent" onchange="changeEventSelect()">
        <option value="" selected disabled>이벤트를 선택하세요</option>
        <option value="">추천인 입력 이벤트</option>
        <option value="">준비중...</option>
    </select>
    <br>
    <div id="inputRecommend" style="display: none">
    <input type="text" placeholder="추천인 아이디를 입력하세요" />
    <br>
    <input type="button" value="등록" />
    </div>

    <h3 style="text-align: left">사용가능 쿠폰</h3>
    <hr />
    <table id="myTable">
        <tr>
            <th>쿠폰명</th>
            <th>할인액(율)</th>
        </tr>
        <tr>
            <td>추천인 입력 이벤트</td>
            <td>10%</td>
        </tr>
    </table>
    <h3 style="text-align: left">사용완료 쿠폰</h3>
    <hr />

</div>
<script>
    function changeEventSelect(){
        document.getElementById("inputRecommend").style.display='block';

    }
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>
</body>
</html>