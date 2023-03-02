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
<div class="search-container" style="text-align: center;">
    <form action="" class="search-form" method="get">
        <input type="text" name="keyword" class="search-input" type="text" value="" placeholder="제목을 입력해주세요">
        <input type="submit" class="search-button" value="검색">
    </form>
    <table id="myTable" style="margin: auto;">
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>조회수</th>
            <th>작성일자</th>
        </tr>
        <c:forEach var="postDto" items="${list}">
            <tr>
                <td class="no">${postDto.postNo}</td>
                <td class="title">
                    <a href="<c:url value="/community/read?page=1&postNo=${postDto.postNo}"/>">${postDto.title}</a>
                </td>
                <td class="writer">${postDto.userId}</td>
                <td class="viewCnt">${postDto.viewCnt}</td>
                <td colspan="regdate">${postDto.createdDate}</td>
            </tr>
        </c:forEach>
    </table>
    <ul>
        <li><a href="#"><</a></li>
        <li><a href="#">1</a></li>
        <li><a href="#">2</a></li>
        <li><a href="#">3</a></li>
        <li><a href="#">4</a></li>
        <li><a href="#">5</a></li>
        <li><a href="#">6</a></li>
        <li><a href="#">7</a></li>
        <li><a href="#">8</a></li>
        <li><a href="#">9</a></li>
        <li><a href="#">10</a></li>
        <li><a href="#">></a></li>
    </ul>
</div>

<!-- footer -->
<%@ include file="../footer.jsp" %>
</body>
</html>