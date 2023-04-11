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
            <form action="<c:url value='/mypage/modify/'/>" method="post" onsubmit="alert('회원정보가 변경되었습니다. 다시 로그인해주세요.')">
                <div class="d-flex justify-content-center">
                    <div class="row">
                        <div class="mb-3">
                            <label class="form-label" for="userId">아이디</label>
                            <input id="userId" name="userId" value="" readonly class="form-control mt-1"
                                   type="text"/>
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="email">이메일</label>
                            <input class="form-control mt-1" type="text" id="email" name="email" value=""
                                   placeholder="이메일을 입력해주세요"/>
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="phone">연락처</label>
                            <input class="form-control mt-1" value="" type="text" id="phone"
                                   name="phone" placeholder="- 를 제외하고 입력해주세요"/>
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="nowPassword">현재 비밀번호 입력</label>
                            <input class="form-control mt-1" type="password" id="nowPassword" name="nowPassword"/>
                            <c:if test="${param.msg != null}">
                            <div class="alert alert-danger" role="alert">
                                ${param.msg}
                            </div>
                            </c:if>
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="newPassword">새로운 비밀번호 입력</label>
                            <input class="form-control mt-1" type="password" id="newPassword" name="newPassword"
                                   placeholder="※ 영문, 숫자,를 조합하여 5~20자 이내로 입력"/>
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="newPassword2">새로운 비밀번호 확인</label>
                            <input class="form-control mt-1" type="password" id="newPassword2" name="newPassword2"/>
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
<script>
    getUserDetails()
    function getUserDetails(){
        $.ajax({
            type: "GET",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/mypage/user/" + '${userId}', // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function (user) {
                $("#userId").val(user.userId);
                $("#email").val(user.email)
                $("#phone").val(user.phone)
            },
            error: function () {
                alert("ajax 통신 실패")
            },
        })
    }
</script>
<%@ include file="../footer.jsp" %>
