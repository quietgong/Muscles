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
<%@ include file="nav.jsp" %>

<!-- 본문 -->
<div class="search-container" style="text-align: center;">
    <form action="" class="search-form" method="get">
        <select name="option">
            <option value="W" ${ph.sc.option=='W' || ph.sc.option=='' ? "selected" : ""}>제목+작성자</option>
            <option value="T" ${ph.sc.option=='T' ? "selected" : ""}>제목</option>
            <option value="A" ${ph.sc.option=='A' ? "selected" : ""}>작성자</option>
        </select>
        <input type="text" name="keyword" class="search-input" type="text" value="${ph.sc.keyword}" placeholder="내용을 입력해주세요">
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
                    <a href="<c:url value="/community/read${ph.sc.queryString}&postNo=${postDto.postNo}"/>">${postDto.title}</a>
                </td>
                <td class="writer">${postDto.userId}</td>
                <td class="viewCnt">${postDto.viewCnt}</td>
                <td colspan="regdate">${postDto.createdDate}</td>
            </tr>
        </c:forEach>
    </table>
    <a href="<c:url value='/community/write'/>">
        <input type="button" class="search-button" value="글쓰기">
    </a>
    <br>
    <c:if test="${totalCnt==null||totalCnt==0}">
        <h1>게시물이 없습니다.</h1>
    </c:if>
    <c:if test="${totalCnt!=null&&totalCnt!=0}">
    <ul class="paging">
        <c:if test="${ph.showPrev}">
        <li><a href="<c:url value='/community/list${ph.sc.getQueryString(ph.beginPage-1)}'/>">&lt</a></li>
        </c:if>
        <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
        <li><a href="<c:url value='/community/list${ph.sc.getQueryString(i)}'/>">${i}</a></li>
        </c:forEach>
        <c:if test="${ph.showNext}">
            <li><a href="<c:url value='/community/list${ph.sc.getQueryString(ph.endPage+1)}'/>">&gt</a></li>
        </c:if>
    </ul>
    </c:if>
</div>

<!-- footer -->
<%@ include file="footer.jsp" %>
</body>
</html>