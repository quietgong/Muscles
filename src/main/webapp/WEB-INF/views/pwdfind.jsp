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
                        <h5 class="card-title"><strong>이메일</strong>(로그인 이메일)을 입력한 후 이메일 인증을 해주세요</h5>
                        <form id="resetForm" method="post" action="<c:url value='/passwordReset'/>">
                            <input type="hidden" id="userId" name="userId">
                            <input type="text" placeholder="이메일을 입력해주세요" class="form-control mt-4 mb-3" id="email"
                                   name="email">
                        </form>
                        <p class="checkMsg" id="email_check">이메일을 입력해주세요</p>
                        <p class="checkMsg" id="email_form_check">올바른 이메일 형식을 입력해주세요<br></p>
                        <p class="checkMsg" id="email_not_exist_check">존재하지 않는 이메일입니다<br></p>
                    </div>
                    <div class="mb-3">
                        <div class="form-group col-md-12 mt-3">
                            <div class="row align-items-center">
                                <div class="col-md-9">
                                    <input id="emailVerifyNumber" class="form-control mt-1"
                                           placeholder="인증번호를 입력해주세요" type="text" readonly>
                                </div>
                                <div class="col-md-3">
                                    <button id="sendVerifyCode" class="form-control btn btn-success"
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
                                발급
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="<c:url value='/js/custom/validation.js'/>"></script>
<script>
    $("#sendVerifyCode").on("click", function () {
        let email = $("#email").val()
        if (emailCheck && emailFormCheck && !emailExistCheck) {
            commonAjax("/muscles/mailCheck?email=" + email + "&type=passwordFind", null, "GET", function (verifyNumber) {
                verifyCode = verifyNumber
                $("#emailVerifyNumber").attr("readonly", false)
                $("#emailVerifyNumber").css("background-color", "#fff")
                $("#emailVerifyNumber").focus()
                $("#sendVerifyNumber").html("인증번호 확인")
                alert("인증번호가 전송되었습니다. 메일을 확인해주시기 바랍니다.")
            })
        } else
            alert("잘못된 이메일 또는 이미 존재하는 이메일입니다.")
    })

    function submit() {
        let email = $("#email").val()
        EmailValidCheck()
        EmailFormCheck(email)
        EmailExistCheck(email)
        EmailVerifyCheck()
        /* 최종 유효성 검사 */
        if (emailCheck && emailFormCheck && emailVerifyCheck && !emailExistCheck) {
            const form = $("#resetForm")
            form.submit()
        }
        else
            alert("입력하신 이메일을 다시 확인해주세요")
        return false;
    }
</script>
<!-- footer -->
<%@ include file="footer.jsp" %>