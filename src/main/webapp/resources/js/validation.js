/* 회원가입 정보 유효성 체크 */
let idCheck = false // 아이디 입력 체크
let dupIdCheck = false // 아이디 중복 체크
let idLengthCheck = false // 아이디 길이 체크
let pwCheck = false // 비밀번호 입력 체크
let pwLengthCheck = false // 비밀번호 길이 체크
let pw1pw2Check = false // 비밀번호, 비밀번호 확인 일치 체크
let phoneCheck = false // 휴대폰번호 입력 체크
let emailCheck = false // 이메일 입력 체크
let emailFormCheck = false // 이메일 형식 체크
let emailVerifyCheck = false // 이메일 인증 체크
let addressCheck = false // 주소 입력 체크

function submitRegister() {
    IdValidCheck()
    PwValidCheck()
    Pw1Pw2Check()
    EmailValidCheck()
    EmailVerifyCheck()
    EmailFormCheck($("#email").val())
    AddressValidCheck()
    PhoneValidCheck()
    /* 최종 유효성 검사 */
    if (idCheck && dupIdCheck && idLengthCheck && pwCheck && pwLengthCheck && pw1pw2Check && phoneCheck && emailCheck && emailFormCheck && emailVerifyCheck && addressCheck) {
        const form = $("#registerForm")
        form.attr("action", "<c:url value=" / register / "/>")
        form.submit()
        alert("회원가입이 완료되었습니다.")
    }
    return false;
}

/*
* ID 유효성 체크
 */
function IdValidCheck() {
    let id = $("input[name=userId]").val()
    // 입력 여부 체크
    if (id == "") {
        $("#id_check").css("display", "block")
        idCheck = false
    } else {
        $("#id_check").css("display", "none")
        idCheck = true
    }
    // 아이디 길이 체크
    if (id != "" && id.length < 4 || id.length > 20) {
        $("#id_length_check").css("display", "block")
        idLengthCheck = false
    } else {
        $("#id_length_check").css("display", "none")
        idLengthCheck = true
    }
    // 아이디 중복체크 //
    if (idCheck && idLengthCheck) {
        $.ajax({
            type: "GET",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/register/idDupCheck/" + id,      // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
                "X-HTTP-Method-Override": "POST"
            },
            success: function (res) {
                console.log(res)
                if (res !== 0) { // 중복일 때
                    $("#dup_id_check_ok").css("display", "none")
                    $("#dup_id_check").css("display", "block")
                    dupIdCheck = false
                } else {
                    $("#dup_id_check_ok").css("display", "block")
                    $("#dup_id_check").css("display", "none")
                    dupIdCheck = true
                }
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    } else {
        $("#dup_id_check_ok").css("display", "none")
        $("#dup_id_check").css("display", "none")
        dupIdCheck = false
    }
}

$("#inputId").on("keyup", function () {
    IdValidCheck()
})

/*
* 비밀번호 유효성 체크
 */
function PwValidCheck() {
    let pw1 = $("#pw1").val()
    // 입력 여부 체크
    if (pw1 === "") {
        pwCheck = false
        $("#pw_check").show()
    } else {
        pwCheck = true
        $("#pw_check").hide()
    }
    // 비밀번호 길이 체크
    if (pw1 !== "" && pw1.length < 5) {
        pwLengthCheck = false
        $("#pw_length_check").show()
    } else {
        pwLengthCheck = true
        $("#pw_length_check").hide()
    }
}

$("#pw1").on("keyup", function () {
    PwValidCheck()
});

// 비밀번호1, 비밀번호2 일치 체크
function Pw1Pw2Check() {
    let pw1 = $("#pw1").val()
    let pw2 = $("#pw2").val()
    if (pw2 !== "") {
        if (pw1 === pw2) {
            pw1pw2Check = true
            $("#pw2_check_ok").show()
            $("#pw2_check_fail").hide()
        } else {
            pw1pw2Check = false
            $("#pw2_check_ok").hide()
            $("#pw2_check_fail").show()
        }
    }
}

$("#pw2").on("keyup", function () {
    Pw1Pw2Check()
});

/*
* 이메일 유효성 체크
 */
function EmailValidCheck() {
    let email = $("#email").val()
    // 입력 여부 체크
    if (email === "") {
        $("#email_check").show()
        emailCheck = false
    } else {
        $("#email_check").hide()
        emailCheck = true
    }
}

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

// 이메일 형식 체크

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
        commonAjax("/muscles/register/mailCheck?email=" + email, null, "GET", function (verifyNumber) {
            console.log("인증코드 : " + verifyNumber)
            verifyCode = verifyNumber
            $("#emailVerifyNumber").attr("readonly", false)
            $("#emailVerifyNumber").css("background-color", "#fff")
            $("#emailVerifyNumber").focus()
            alert("인증번호가 전송되었습니다. 메일을 확인해주시기 바랍니다.")

        })
    } else
        alert("잘못된 이메일 또는 존재하지 않는 이메일입니다.")
})

/*
    * 이메일 존재 체크
     */
function EmailExistCheck(email) {
    commonAjax("/muscles/emailExistCheck?email=" + email, null, "GET", function (res) {
        if (res !== 'invalid') {
            $("#userId").val(res)
            $("#email_exist_check").hide()
            emailExistCheck = true
        } else {
            $("#userId").val("")
            $("#email_exist_check").show()
            emailExistCheck = false
        }
    })
}

/*
* 주소 유효성 체크
 */
function AddressValidCheck() {
    let address = $("#address").val()
    // 입력 여부 체크
    if (address === "") {
        addressCheck = false
        $("#address_check").show()
    } else {
        addressCheck = true
        $("#address_check").hide()
    }
}

$("#address").on("keyup", function () {
    AddressValidCheck()
})

/*
* 연락처 유효성 체크
 */
function PhoneValidCheck() {
    $("#phone").val($("#phone").val().replaceAll("-", ""))
    let phone = $("#phone").val()
    // 입력 여부 체크
    if (phone === "") {
        phoneCheck = false
        $("#phone_check").show()
    } else {
        phoneCheck = true
        $("#phone_check").hide()
    }
}