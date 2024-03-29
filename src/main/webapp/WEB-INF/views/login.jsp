<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<c:set var="message" value="${param.msg eq null ? 'none' : 'block'}"/>
<%@ include file="nav.jsp" %>
<input type="hidden" name="toURL" value="${param.toURL}">
<section class=" text-center text-lg-start">
    <div class="card mb-3">
        <div class="row g-0 d-flex align-items-center justify-content-center">
            <div class="col-lg-4">
                <form action="<c:url value="/login/"/>" name="loginForm" method="post">
                    <div class="card-body py-5 px-md-5">
                        <div class="form-outline mb-4">
                            <h5 style="font-weight: bold; text-align: center; color: red">${param.msg}</h5>
                        </div>
                        <div class="form-outline mb-4">
                            <label class="form-label" for="userId">아이디</label>
                            <input id="userId" type="text" name="userId" value="${cookie.id.value}" class="form-control"
                                   placeholder="ID를 입력해주세요"/>
                        </div>
                        <div class="form-outline mb-4">
                            <label class="form-label" for="password">패스워드</label>
                            <input type="password" id="password" name="password" class="form-control" placeholder="비밀번호를 입력해주세요"/>
                        </div>
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="form-check">
                                    <input class="form-check-input" name="rememberId" type="checkbox" value="on"
                                           id="rememberId" ${empty cookie.id.value?"":"checked"} />
                                    <label class="form-check-label" for="rememberId"> 아이디 기억 </label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <a style="float: right" href="<c:url value='/pwdfind'/>">비밀번호 찾기</a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <button type="submit" class="btn btn-primary btn-block mb-4">로그인</button>
                                <a href="<c:url value='/register'/>">
                                    <button type="button" class="btn btn-primary btn-block mb-4">회원가입</button>
                                </a>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="toURL" value="${param.toURL}">
                </form>
            </div>
        </div>
    </div>
</section>
<!-- footer -->
<%@ include file="footer.jsp" %>