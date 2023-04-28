/*
* 유효성 검사 관련 변수
 */
let idCheck = false // 아이디 입력 체크
let idLengthCheck = false // 아이디 길이 체크
let dupIdCheck = false // 아이디 중복 체크
let pwCheck = false // 비밀번호 입력 체크
let pwLengthCheck = false // 비밀번호 길이 체크
let pwFormCheck = false // 비밀번호 형식 체크
let pw1pw2Check = false // 비밀번호 확인 일치 체크
let phoneCheck = false // 휴대폰번호 입력 체크
let emailCheck = false // 이메일 입력 체크
let emailFormCheck = false // 이메일 형식 체크
let emailVerifyCheck = false // 이메일 인증 체크
let emailExistCheck = false // 이메일 존재 체크
let addressCheck = false // 주소 입력 체크

/*
* ID 유효성 체크
 */
function IdValidCheck() {
    let id = $("input[name=userId]").val()
    // 입력 여부 체크
    if (id === "") {
        $("#id_check").show()
        idCheck = false
    } else {
        $("#id_check").hide()
        idCheck = true
    }
    // 아이디 길이 체크
    if (id !== "" && id.length < 4 || id.length > 20) {
        $("#id_length_check").show()
        idLengthCheck = false
    } else {
        $("#id_length_check").hide()
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
                    $("#dup_id_check_ok").hide()
                    $("#dup_id_check").show()
                    dupIdCheck = false
                } else {
                    $("#dup_id_check_ok").show()
                    $("#dup_id_check").hide()
                    dupIdCheck = true
                }
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    } else {
        $("#dup_id_check_ok").hide()
        $("#dup_id_check").hide()
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
    if (pwCheck && (pw1.length < 5 || pw1.length > 20)) {
        pwLengthCheck = false
        $("#pw_length_check").show()
    } else {
        pwLengthCheck = true
        $("#pw_length_check").hide()
    }
    if (pwCheck && pwLengthCheck) {
        if (PwRegCheck(pw1)) {
            pwFormCheck = false
            $("#pw_form_check").show()
        } else {
            pwFormCheck = true
            $("#pw_form_check").hide()
        }
    }
}

function PwRegCheck(pw) {
    return /^[a-zA-Z0-9]{5,20}$/.test(pw);
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

// 이메일 입력 체크
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

// 이메일 형식 체크
function EmailFormCheck(email) {
    let form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
    if (form.test(email)) {
        emailFormCheck = true
        $("#email_form_check").hide()
    } else {
        emailFormCheck = false
        $("#email_form_check").show()
    }
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

// 이메일 중복 체크
function EmailExistCheck(email) {
    commonAjax("/muscles/emailExistCheck?email=" + email, null, "GET", function (res) {
        if (res !== 'invalid') {
            $("#email_exist_check").show()
            $("#email_not_exist_check").hide()
            emailExistCheck = false
        } else {
            $("#email_exist_check").hide()
            $("#email_not_exist_check").show()
            emailExistCheck = true
        }
    })
}

$("#email").on("keyup", function () {
    let email = $("#email").val()
    EmailValidCheck()
    if (emailCheck) {
        EmailFormCheck(email)
        if (emailFormCheck) {
            EmailExistCheck(email)
        } else {
            $("#email_exist_check").hide()
            $("#email_not_exist_check").hide()
        }
    } else {
        $("#email_exist_check").hide()
        $("#email_not_exist_check").hide()
        $("#email_form_check").hide()
    }
})

/* 이메일 인증번호 발송 */
let verifyCode;
$("#sendVerifyNumber").on("click", function () {
    let email = $("#email").val()
    $("#sendVerifyNumber").hide()
    if (emailCheck && emailFormCheck && emailExistCheck) {
        commonAjax("/muscles/mailCheck?email=" + email + "&type=register", null, "GET", function (verifyNumber) {
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
$("#emailVerifyNumber").on("keyup", function () {
    EmailVerifyCheck()
})


/*
* 주소 유효성 체크
 */

function AddressValidCheck() {
    let address = $("#address").val()
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
    $("#phone").val($("#phone").val().replace(/[^0-9]/g, ''))
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

$("#phone").on("keyup", function () {
    PhoneValidCheck()
})