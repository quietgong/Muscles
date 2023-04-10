<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="nav.jsp" %>
<div class="container">
    <form>
        <div class="row justify-content-center mt-5">
            <div class="col-md-2">
                <select class="form-select" name="option">
                    <option value="W" ${ph.sc.option=='W' || ph.sc.option=='' ? "selected" : ""}>제목+작성자</option>
                    <option value="T" ${ph.sc.option=='T' ? "selected" : ""}>제목</option>
                    <option value="A" ${ph.sc.option=='A' ? "selected" : ""}>작성자</option>
                </select>
            </div>
            <div class="col-md-6">
                <div class="input-group mb-3">
                    <input type="text" name="keyword" class="form-control" value="${ph.sc.keyword}"
                           placeholder="내용을 입력해주세요">
                    <button type="submit" class="btn btn-outline-primary">검색</button>
                </div>
            </div>
        </div>
    </form>
    <div class="row justify-content-center mt-5">
        <div class="col-md-10">
            <table class="table table-hover" style="text-align: center">
                <tr>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일자</th>
                </tr>
                <c:forEach var="postDto" items="${list}">
                    <tr>
                        <td class="title">
                            <a href="<c:url value="/${postCategory}/${postDto.postNo}${ph.sc.queryString}"/>">${postDto.title}</a>
                        </td>
                        <td class="writer">${postDto.userId}</td>
                        <td class="viewCnt">${postDto.viewCnt}</td>
                        <td colspan="regdate">
                            <fmt:formatDate value="${postDto.createdDate}" pattern="yyyy-MM-dd" type="date"/>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="row justify-content-center">
        <div class="col-10" style="text-align: right">
            <form method="post" action="<c:url value='/${postCategory}/add'/>">
                <button type="submit" class="btn btn-lg btn-primary">글쓰기</button>
            </form>
        </div>
    </div>
    <div class="row mt-5 justify-content-center">
        <div class="col-md-12">
            <c:if test="${totalCnt==null||totalCnt==0}">
                <h1>게시물이 없습니다.</h1>
            </c:if>
            <c:if test="${totalCnt!=null&&totalCnt!=0}">
                <ul class="pagination pagination-lg justify-content-center">
                    <c:if test="${ph.showPrev}">
                        <li class="page-item">
                            <a class="page-link rounded-0 shadow-sm border-top-0 border-left-0 text-dark"
                               href="<c:url value='${postCategory}${ph.sc.getQueryString(ph.beginPage-1)}'/>"><<</a>
                        </li>
                    </c:if>
                    <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                        <li>
                            <a class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark"
                               href="<c:url value='${postCategory}${ph.sc.getQueryString(i)}'/>">${i}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${ph.showNext}">
                        <li class="page-item">
                            <a class="page-link rounded-0 shadow-sm border-top-0 border-left-0 text-dark"
                               href="<c:url value='${postCategory}${ph.sc.getQueryString(ph.endPage+1)}'/>">>></a>
                        </li>
                    </c:if>
                </ul>
            </c:if>
        </div>
    </div>
</div>
<script>
    $("#${param.page}").attr("class", "paging-active")
</script>
<!-- footer -->
<%@ include file="footer.jsp" %>
