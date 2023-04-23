<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ include file="nav.jsp" %>
<div class="container" style="margin-top: 100px">
    <div class="row justify-content-center align-content-center">
        <div class="col-md-8">
            <div class="card">
                <h5 class="card-header">비밀번호 찾기</h5>
                <div class="card-body py-5 px-md-5">
                    <div class="mb-3">
                        <h5 class="card-title">이메일(로그인 이메일)을 입력한 후 이메일 인증을 해주세요</h5>
                        <form id="resetForm" method="post" action="<c:url value='/passwordReset'/>">
                            <input type="hidden" id="userId" name="userId">
                            <input type="text" placeholder="이메일을 입력해주세요" class="form-control mt-4 mb-3" id="email"
                                   name="email">
                        </form>
                        <p class="checkMsg" id="email_check">이메일을 입력해주세요</p>
                        <p class="checkMsg" id="email_form_check">올바른 이메일 형식을 입력해주세요<br></p>
                        <p class="checkMsg" id="email_exist_check">존재하지 않는 이메일입니다<br></p>
                    </div>
                    <div class="mb-3">
                        <div class="form-group col-md-12 mt-3">
                            <div class="row align-items-center">
                                <div class="col-md-9">
                                    <input id="emailVerifyNumber" class="form-control mt-1"
                                           placeholder="인증번호를 입력해주세요" type="text" readonly>
                                </div>
                                <div class="col-md-3">
                                    <button id="sendVerifyNumber" class="form-control btn btn-success"
                                            type="button">인증번호 전송
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row align-items-center">
                        <div class="form-group col-md-6 mb-3">
                            <div class="mb-3">
                                <span class="checkMsg" id="email_verify_check_ok"
                                      style="color: #04aa6d">인증번호가 일치합니다</span>
                                <span class="checkMsg" id="email_verify_check_fail">인증번호가 불일치합니다</span>
                            </div>
                        </div>
                        <div class="text-center mt-5">
                            <button onclick="submit()" class="w-50 btn btn-primary btn-lg" type="submit">임시비밀번호
                                발송
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="<c:url value='/js/validation.js'/>"></script>
<script>
    function submit() {
        EmailValidCheck()
        EmailVerifyCheck()
        EmailExistCheck($("#email").val())
        EmailFormCheck($("#email").val())
        /* 최종 유효성 검사 */
        if (emailCheck && emailFormCheck && emailVerifyCheck && emailExistCheck) {
            const form = $("#resetForm")
            form.submit()
        }
        return false;
    }
</script>
<!-- footer -->
<%@ include file="footer.jsp" %>