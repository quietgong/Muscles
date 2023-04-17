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
<section class="text-center text-lg-start">
    <div class="card mb-3">
        <div class="row g-0 d-flex align-items-center justify-content-center">
            <div class="col-md-12">
                <div class="card-body py-5 px-md-5">
                    <div class="mb-3">
                        <label>이메일</label>
                        <form id="resetForm" method="post" action="<c:url value='/passwordReset'/>">
                        <input type="hidden" id="userId" name="userId">
                        <input type="text" placeholder="이메일을 입력해주세요" class="form-control mt-1" id="email"
                               name="email">
                        </form>
                        <p class="checkMsg" id="email_check">이메일을 입력해주세요</p>
                        <p class="checkMsg" id="email_form_check">올바른 이메일 형식을 입력해주세요</p>
                        <p class="checkMsg" id="email_exist_check">존재하지 않는 이메일입니다</p>
                    </div>
                    <div class="row align-items-center">
                        <div class="form-group col-md-6 mb-3">
                            <button id="sendVerifyNumber" class="btn btn-primary" type="button">인증번호 전송</button>
                            <input id="emailVerifyNumber" class="form-control mt-1" type="text" readonly>
                        </div>
                        <div class="form-group col-md-6 mb-3">
                            <div class="mb-3">
                                <p class="checkMsg" id="email_verify_check_ok" style="color: #04aa6d">인증번호가
                                    일치합니다</p>
                                <p class="checkMsg" id="email_verify_check_fail">인증번호가 불일치합니다</p>
                            </div>
                        </div>
                        <button onclick="submit()" class="btn btn-primary" type="submit">확인</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
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
        if (emailCheck) {
            if (EmailFormCheck($("#email").val())) {
                $("#email_form_check").hide()
                emailFormCheck = true
                if (emailFormCheck) {
                    if (EmailExistCheck($("#email").val())) {
                        $("#email_exist_check").hide()
                        emailExistCheck = true
                    } else {
                        $("#email_exist_check").hide()
                        emailExistCheck = true
                    }
                }
            } else {
                $("#email_form_check").show()
                emailFormCheck = false
            }
        }
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
                    return true
                } else {
                    $("#userId").val("")
                    return false
                }
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    }

    function EmailFormCheck(email) {
        var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
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
        EmailValidCheck()
        if (emailCheck) {
            let email = $("#email").val()
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
        }
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