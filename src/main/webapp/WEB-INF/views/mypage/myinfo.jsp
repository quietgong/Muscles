<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ include file="../nav.jsp" %>
<div class="container">
    <div class="row mt-5">
        <div class="col-md-2">
            <%@include file="sidebar.jsp" %>
        </div>
        <div class="col-md-8">
            <form id="modifyForm" method="post">
                <div class="d-flex justify-content-center">
                    <div class="row">
                        <div class="mb-3">
                            <label class="form-label" for="userId">아이디</label>
                            <input id="userId" name="userId" value="" readonly class="form-control mt-1" type="text"/>
                        </div>
                        <div class="mb-3">
                            <div class="form-check form-switch">
                                <label class="form-check-label" for="pwCheck">비밀번호 변경</label>
                                <input class="form-check-input" type="checkbox" id="pwCheck">
                            </div>
                        </div>
                        <div class="mb-3 passwordInput" style="display: none">
                            <label>새로운 비밀번호</label>
                            <input type="text" class="form-control mt-1" id="pw1"
                                   placeholder="※ 영문, 숫자를 조합하여 5~20자 이내로 입력해주세요"><br>
                            <p class="checkMsg" id="pw_check">비밀번호를 입력해주세요</p>
                            <p class="checkMsg" id="pw_length_check">비밀번호는 5자 이상으로 입력해주세요</p>
                        </div>
                        <div class="mb-3 passwordInput" style="display: none">
                            <label>새로운 비밀번호 확인</label>
                            <input type="text" class="form-control mt-1" id="pw2"><br>
                            <p class="checkMsg" id="pw2_check_ok" style="color: #04aa6d">비밀번호가 일치합니다</p>
                            <p class="checkMsg" id="pw2_check_fail">비밀번호가 일치하지 않습니다</p>
                        </div>
                        <div class="mb-3">
                            <label>휴대폰 번호</label>
                            <input type="text" class="form-control mt-1" id="phone" name="phone"
                                   placeholder="- 를 제외하고 입력해주세요"><br>
                            <p class="checkMsg" id="phone_check">연락처를 입력해주세요</p>
                        </div>
                        <div class="mb-3">
                            <label>이메일</label>
                            <input type="text" placeholder="이메일을 입력해주세요" class="form-control mt-1" id="email"
                                   name="email">
                            <p class="checkMsg" id="email_check">이메일을 입력해주세요</p>
                            <p class="checkMsg" id="email_form_check">올바른 이메일 형식을 입력해주세요</p>
                        </div>
                        <div class="row align-items-center">
                            <div class="form-group col-md-6 mb-3">
                                <input id="emailVerifyNumber" class="form-control mt-1" type="text" readonly
                                       name="verify">
                            </div>
                            <div class="form-group col-md-6 mb-3">
                                <button id="sendVerifyNumber" class="btn btn-primary" type="button">인증번호 전송</button>
                            </div>
                        </div>
                        <div class="mb-3">
                            <p class="checkMsg" id="email_verify_check_ok" style="color: #04aa6d">인증번호가 일치합니다</p>
                            <p class="checkMsg" id="email_verify_check_fail">인증번호가 불일치합니다</p>
                        </div>
                        <div class="mb-3">
                            <button class="btn btn-primary" type="button" onclick="execDaumPostcode()">
                                주소 찾기
                            </button>
                            <p class="checkMsg" id="address_check">주소를 입력해주세요</p>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-6 mb-3">
                                <input type="text" class="form-control mt-1" name="address1" id="address" readonly
                                       placeholder="주소">
                            </div>
                            <div class="form-group col-md-6 mb-3">
                                <input type="text" class="form-control mt-1" name="address2" id="detailAddress"
                                       placeholder="상세주소"><br>
                            </div>
                        </div>
                        <div class="row justify-content-center">
                            <div class="form-group col-md-6 mb-3">
                                <button type="button" class="btn btn-lg btn-primary form-control mt-3"
                                        onclick="submitModify()">변경
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<c:url value='/js/DaumPostCode.js'/>"></script>
<script src="<c:url value='/js/validation.js'/>"></script>
<script>
    $("#pwCheck").change(function () {
        $("#pwCheck").is(":checked") ? $(".passwordInput").show() : $(".passwordInput").hide()
    })
    getUserDetails()
    let originEmail;

    function getUserDetails() {
        commonAjax("/muscles/mypage/user/" + '${userId}', null, "GET", function (user) {
            $("#userId").val(user.userId);
            $("#email").val(user.email)
            $("#phone").val(user.phone)
            $("#address").val(user.address1)
            $("#detailAddress").val(user.address2)
            originEmail = user.email
        })
    }

    function submitModify() {
        if (!$("#pwCheck").is(":checked")) {
            pwCheck = true
            pwLengthCheck = true
            pw1pw2Check = true
        } else {
            PwValidCheck()
            Pw1Pw2Check()
        }
        if ($("#email").val() === originEmail) {
            emailCheck = true
            emailFormCheck = true
            emailVerifyCheck = true
        } else {
            EmailValidCheck()
            EmailVerifyCheck()
            EmailFormCheck($("#email").val())
        }
        /* 최종 유효성 검사 */
        if (pwCheck && pwLengthCheck && pw1pw2Check && phoneCheck && emailCheck && emailFormCheck && emailVerifyCheck && addressCheck) {
            let userDto = {};
            userDto.userId = $("#userId").val();
            userDto.password = $("#pw1").val();
            userDto.phone = $("#phone").val();
            userDto.email = $("#email").val();
            userDto.address1 = $("#address").val();
            userDto.address2 = $("#detailAddress").val();
            commonAjax("/muscles/mypage/modify/", userDto, "GET", function (res) {
                res === "MOD_OK" ? location.href = "/muscles" : alert("에러가 발생하였습니다.")
            })
        }
        return false;
    }
</script>
<%@ include file="../footer.jsp" %>
