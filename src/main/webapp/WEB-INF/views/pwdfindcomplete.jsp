<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ include file="nav.jsp" %>
<div class="container" style="margin-top: 200px;height: 600px">
    <div class="row justify-content-center align-content-center">
        <div class="col-md-8">
            <div class="card text-center">
                <h5 class="card-header">비밀번호 찾기</h5>
                <div class="card-body">
                    <h5 class="card-title">이메일(${email})로 임시 비밀번호를 발송했습니다.</h5>
                    <p class="card-text">보안을 위해 임시 비밀번호를 사용한 로그인 이후,</p>
                    <p class="card-text">반드시 <strong>비밀번호를 변경</strong>하여 주시기 바랍니다.</p>
                </div>
                <div class="card-body">
                    <div class="card-text">
                        <a href="<c:url value='/'/>" class="btn btn-primary btn-lg">홈</a>
                        <a href="<c:url value='/login'/>" class="btn btn-primary btn-lg">로그인</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- footer -->
<%@ include file="footer.jsp" %>