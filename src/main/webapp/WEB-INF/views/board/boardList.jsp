<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<%@ include file="../nav.jsp" %>
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
                            <a style="text-decoration: none"
                               href="<c:url value="/${ph.sc.type}/${postDto.postNo}${ph.sc.queryString}"/>">
                                <c:choose>
                                    <c:when test="${postDto.commentDtoList.size() > 0}">
                                        ${postDto.title} [${postDto.commentDtoList.size()}]
                                    </c:when>
                                    <c:otherwise>
                                        ${postDto.title}
                                    </c:otherwise>
                                </c:choose>
                            </a>
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
            <c:if test="${postCategory eq 'notice' && userId eq 'admin'}">
                <button type="submit" onclick='location.href="<c:url value='/${ph.sc.type}/'/>"'
                        class="btn btn-lg btn-primary">공지사항 등록
                </button>
            </c:if>
            <c:if test="${postCategory eq 'community'}">
                <button type="submit" onclick='location.href="<c:url value='/${ph.sc.type}/'/>"'
                        class="btn btn-lg btn-primary">글쓰기
                </button>
            </c:if>
        </div>
    </div>
    <div class="row mt-5 justify-content-center">
        <div class="col-md-12">
            <c:if test="${ph.totalCnt==null||ph.totalCnt==0}">
                <h1 style="text-align: center">게시물이 없습니다.</h1>
            </c:if>
            <c:if test="${ph.totalCnt!=null&&ph.totalCnt!=0}">
                <ul class="pagination pagination-lg justify-content-center">
                    <c:if test="${ph.showPrev}">
                        <li class="page-item">
                            <a class="page-link rounded-0 shadow-sm border-top-0 border-left-0 text-dark"
                               href="<c:url value='${ph.sc.type}${ph.sc.getQueryString(ph.beginPage-1)}'/>"><<</a>
                        </li>
                    </c:if>
                    <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                        <li>
                            <a id="${i}" class="page-link rounded-0 mr-3 shadow-sm border-top-0 border-left-0 text-dark"
                               href="<c:url value='${ph.sc.type}${ph.sc.getQueryString(i)}'/>">${i}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${ph.showNext}">
                        <li class="page-item">
                            <a class="page-link rounded-0 shadow-sm border-top-0 border-left-0 text-dark"
                               href="<c:url value='${ph.sc.type}${ph.sc.getQueryString(ph.endPage+1)}'/>">>></a>
                        </li>
                    </c:if>
                </ul>
            </c:if>
        </div>
    </div>
</div>
<!-- footer -->
<script>$("#${param.page}").addClass("active")</script>
<%@ include file="../footer.jsp" %>
