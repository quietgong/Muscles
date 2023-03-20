<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
<div class="mypage-container">
    <div class="item">
        <!-- 사이드바 시작 -->
        <%@include file="sidebar.jsp" %>
        <!-- 사이드바 끝 -->
    </div>
    <div class="item">
    <table id="myTable" style="margin: auto">
        <tr>
            <td>아이디</td>
            <td>${user.userId}</td>
        </tr>
        <tr>
            <form method="post">
            <td>이메일</td>
            <td><input name="newEmail" value="${user.email}"/></td>
        </tr>
        <tr>
            <td>휴대폰 번호</td>
            <td><input name="newPhone" value="${user.phone}" placeholder="-를 제외하고 입력해주세요"/></td>
        </tr>
    </table>
    </div>
    <div class="item">
        <input type="submit" value="변경" />
        <input type="submit" value="취소" />
        </form>
    </div>
</div>

<!-- footer -->
<%@ include file="../footer.jsp" %>
