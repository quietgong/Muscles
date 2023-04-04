<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>
<div class="container">
    <div class="row mt-5">
        <!-- 사이드바 -->
        <div class="col-md-2">
            <%@include file="../mypage/sidebar.jsp" %>
        </div>
        <!-- 컨텐츠 -->
        <div class="col-md-10">
            <table class="table table-hover" style="text-align: center">
                <tr>
                    <th>제목</th>
                    <th>조회수</th>
                    <th>작성일자</th>
                </tr>
                <c:forEach var="postDto" items="${list}">
                    <tr>
                        <td class="title">
                            <a href="<c:url value="/community/${postDto.postNo}?page=1"/>">${postDto.title}</a>
                        </td>
                        <td class="viewCnt">${postDto.viewCnt}</td>
                        <td colspan="regdate">
                            <fmt:formatDate value="${postDto.createdDate}" pattern="yyyy-MM-dd" type="date"/>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
<!-- footer -->
<%@ include file="../footer.jsp" %>
