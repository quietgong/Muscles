<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>
<div class="container">
    <div class="row mt-5">
        <!-- 사이드바 -->
        <div class="col-md-2">
            <%@include file="sidebar.jsp" %>
        </div>
        <!-- 컨텐츠 -->
        <div class="col-md-10">
            <form method="post">
                <div class="d-flex justify-content-center">
                    <div class="row">
                        <div class="mb-3">
                            <label class="form-label" for="userId">아이디</label>
                            <input id="userId" value="${userDto.userId}" readonly class="form-control mt-1" type="text" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="email">이메일</label>
                            <input class="form-control mt-1" type="text" id="email" name="email" value="${userDto.email}"
                                   placeholder="이메일을 입력해주세요" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="phone">연락처</label>
                            <input class="form-control mt-1" value="${userDto.phone}" type="text" id="phone" name="phone" placeholder="- 를 제외하고 입력해주세요" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">현재 비밀번호 입력</label>
                            <input class="form-control mt-1" type="text" name="nowPassword" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="password2">새로운 비밀번호 입력</label>
                            <input class="form-control mt-1" type="text" id="password2" name="newPassword1"
                                   placeholder="※ 영문, 숫자,를 조합하여 5~20자 이내로 입력" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="newpassword">새로운 비밀번호 확인</label>
                            <input class="form-control mt-1" type="text" id="newpassword" name="newPassword2" />
                        </div>
                        <div class="col-md-6" style="margin: auto;">
                            <button class="btn btn-lg btn-primary form-control mt-3" type="submit">변경</button>
                        </div>
                        <div class="col-md-6" style="margin: auto;">
                            <button class="btn btn-lg btn-primary form-control mt-3" type="submit">변경</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<%@ include file="../footer.jsp" %>
