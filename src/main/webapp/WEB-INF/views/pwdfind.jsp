<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ include file="nav.jsp" %>
<style>
    #emailVerifyNumber {
        background-color: #ffeded;
    }

    .checkMsg {
        display: none;
        color: #dc3545;
    }
</style>
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
<script>
    let emailCheck = false // 이메일 입력 체크
    let emailFormCheck = false // 이메일 형식 체크
    let emailExistCheck = false // 이메일 데이터 유무 체크
    let emailVerifyCheck = false // 이메일 인증 체크
    /*
    * 이메일 유효성 체크
     */
    $("#email").on("keyup", function () {
        EmailValidCheck()
        if (EmailFormCheck($("#email").val())) {
            emailFormCheck = true
            $("#email_form_check").hide()
        } else {
            emailFormCheck = false
            $("#email_form_check").show()
        }
        if (emailCheck && emailFormCheck)
            EmailExistCheck($("#email").val())
        else
            $("#email_exist_check").hide()
    })

    function EmailValidCheck() {
        let email = $("#email").val()
        if (email === "") {
            $("#email_check").show()
            emailCheck = false
        } else {
            $("#email_check").hide()
            emailCheck = true
        }
    }

    function EmailExistCheck(email) {
        $.ajax({
            type: "GET",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/emailExistCheck?email=" + email,      // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function (res) {
                console.log(res)
                if (res !== 'invalid') {
                    $("#userId").val(res)
                    $("#email_exist_check").hide()
                    emailExistCheck = true
                } else {
                    $("#userId").val("")
                    $("#email_exist_check").show()
                    emailExistCheck = false
                }

            },
            error: function () {
                console.log("통신 실패")
            }
        })
    }

    function EmailFormCheck(email) {
        let form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
        return form.test(email)
    }

    // 이메일 인증 체크
    function EmailVerifyCheck() {
        if ($("#emailVerifyNumber").val() === verifyCode) {
            emailVerifyCheck = true
            $("#email_verify_check_ok").show()
            $("#email_verify_check_fail").hide()
        } else {
            emailVerifyCheck = false
            $("#email_verify_check_ok").hide()
            $("#email_verify_check_fail").show()
        }
    }

    $("#emailVerifyNumber").on("keyup", function () {
        EmailVerifyCheck()
    })

    /* 이메일 인증번호 발송 */
    let verifyCode;
    $("#sendVerifyNumber").on("click", function () {
        let email = $("#email").val()
        if (emailCheck && emailFormCheck && emailExistCheck) {
            $.ajax({
                type: "GET",            // HTTP method type(GET, POST) 형식이다.
                url: "/muscles/register/mailCheck?email=" + email,
                headers: {              // Http header
                    "Content-Type": "application/json",
                },
                success: function (verifyNumber) {
                    console.log("인증코드 : " + verifyNumber)
                    verifyCode = verifyNumber
                    $("#emailVerifyNumber").attr("readonly", false)
                    $("#emailVerifyNumber").css("background-color", "#fff")
                    $("#emailVerifyNumber").focus()
                    alert("인증번호가 전송되었습니다. 메일을 확인해주시기 바랍니다.")
                },
                error: function () {
                    console.log("통신 실패")
                }
            })
        } else
            alert("잘못된 이메일 또는 존재하지 않는 이메일입니다.")
    })
</script>
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