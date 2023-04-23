<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<%@ include file="../nav.jsp" %>
<div class="container">
    <div class="row mt-5">
        <div class="col-md-2">
            <%@include file="sidebar.jsp" %>
        </div>
        <!-- 컨텐츠 -->
        <div class="col-md-10">
            <table id="postList" class="table table-hover" style="text-align: center">
                <tr>
                    <th>제목</th>
                    <th>조회수</th>
                    <th>작성일자</th>
                </tr>
                <!-- 동적추가 -->
            </table>
        </div>
    </div>
</div>
<script>
    loadPostList()

    function loadPostList() {
        commonAjax("/muscles/mypage/post/" + '${userId}', null, "GET", function (res) {
            $("#postList").append(toHtml(res))
        })
    }

    let toHtml = function (items) {
        let tmp = "";
        items.forEach(function (item) {
            tmp += '<tr>'
            tmp += '<td class="title">'
            tmp += "<a href=\"<c:url value='/community/'/>" + item.postNo + "\">";
            tmp += item.title + ' [' + item.commentDtoList.length + ']'
            tmp += '</a>'
            tmp += '</td>'
            tmp += '<td class="viewCnt">' + item.viewCnt + '</td>'
            tmp += '<td colspan="regdate">' + item.createdDate + '</td>'
            tmp += '</tr>'
        })
        return tmp;
    }
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>
