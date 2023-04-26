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
                            <input id="userId" name="userId" value="${userId}" readonly class="form-control mt-1"
                                   type="text"/>
                        </div>

                        <div class="mb-3">
                            <div class="form-check form-switch">
                                <label class="form-check-label" for="pwChange">비밀번호 변경</label>
                                <input class="form-check-input" type="checkbox" id="pwChange">
                            </div>
                        </div>
                        <div class="inputForm mb-3 pwInput">
                            <label>새로운 비밀번호</label>
                            <input type="password" class="form-control mt-1" id="pw1"
                                   placeholder="※ 영문, 숫자를 조합하여 5~20자 이내로 입력해주세요"><br>
                            <p class="checkMsg" id="pw_check">비밀번호를 입력해주세요</p>
                            <p class="checkMsg" id="pw_length_check">비밀번호는 5자 이상으로 입력해주세요</p>
                        </div>
                        <div class="inputForm mb-3 pwInput">
                            <label>새로운 비밀번호 확인</label>
                            <input type="password" class="form-control mt-1" id="pw2"><br>
                            <p class="checkMsg" id="pw2_check_ok" style="color: #04aa6d">비밀번호가 일치합니다</p>
                            <p class="checkMsg" id="pw2_check_fail">비밀번호가 일치하지 않습니다</p>
                        </div>

                        <div class="mb-3">
                            <div class="form-check form-switch">
                                <label class="form-check-label" for="phoneChange">휴대폰 번호 변경</label>
                                <input class="form-check-input" type="checkbox" id="phoneChange">
                            </div>
                        </div>
                        <div class="inputForm mb-3 phoneInput">
                            <label>휴대폰 번호</label>
                            <input type="text" class="form-control mt-1" id="phone" name="phone"
                                   placeholder="- 를 제외하고 입력해주세요"><br>
                            <p class="checkMsg" id="phone_check">연락처를 입력해주세요</p>
                        </div>

                        <div class="mb-3">
                            <div class="form-check form-switch">
                                <label class="form-check-label" for="emailChange">이메일 변경</label>
                                <input class="form-check-input" type="checkbox" id="emailChange">
                            </div>
                        </div>
                        <div class="inputForm mb-3 emailInput">
                            <label>이메일</label>
                            <input type="text" placeholder="이메일을 입력해주세요" class="form-control mt-1" id="email"
                                   name="email">
                            <p class="checkMsg" id="email_check">이메일을 입력해주세요</p>
                            <p class="checkMsg" id="email_form_check">올바른 이메일 형식을 입력해주세요</p>
                            <p class="checkMsg" id="email_exist_check">중복된 이메일입니다! 다른 이메일을 사용해주세요</p>
                        </div>
                        <div class="inputForm row align-items-center emailInput">
                            <div class="form-group col-md-6 mb-3">
                                <input id="emailVerifyNumber" class="form-control mt-1" type="text" readonly
                                       name="verify">
                            </div>
                            <div class="form-group col-md-6 mb-3">
                                <button id="sendVerifyNumber" class="btn btn-primary" type="button">인증번호 전송</button>
                            </div>
                        </div>
                        <div class="inputForm mb-3 emailInput">
                            <p class="checkMsg" id="email_verify_check_ok" style="color: #04aa6d">인증번호가 일치합니다</p>
                            <p class="checkMsg" id="email_verify_check_fail">인증번호가 불일치합니다</p>
                        </div>

                        <div class="mb-3">
                            <div class="form-check form-switch">
                                <label class="form-check-label" for="addressChange">주소 변경</label>
                                <input class="form-check-input" type="checkbox" id="addressChange">
                            </div>
                        </div>
                        <div class="inputForm mb-3 addressInput">
                            <button class="btn btn-primary" type="button" onclick="execDaumPostcode()">
                                주소 찾기
                            </button>
                            <p class="checkMsg" id="address_check">주소를 입력해주세요</p>
                        </div>
                        <div class="inputForm row addressInput">
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
                                <button id="modify" type="button" class="btn btn-lg btn-primary form-control mt-3"
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
<script src="<c:url value='/js/custom/validation.js'/>"></script>
<script>
    $(".inputForm").hide()

    let pwChecked = false;
    let phoneChecked = false;
    let emailChecked = false;
    let addressChecked = false;

    $("input[type='checkbox']").change(function () {
        pwChecked = $("#pwChange").is(":checked");
        phoneChecked = $("#phoneChange").is(":checked");
        emailChecked = $("#emailChange").is(":checked");
        addressChecked = $("#addressChange").is(":checked");
        $("input[type='checkbox']").each(function () {
            let inputClass = "." + $(this).attr("id").replace("Change", "Input");
            $(inputClass).toggle($(this).is(":checked"));
        });
    });

    function submitModify() {
        if (!pwChecked) {
            pwCheck = true
            pwLengthCheck = true
            pw1pw2Check = true
        }

        if (!phoneChecked)
            phoneCheck = true

        if (!emailChecked) {
            emailCheck = true
            emailFormCheck = true
            emailVerifyCheck = true
            emailExistCheck = true
        }

        if (!addressChecked)
            addressCheck = true

        /* 최종 유효성 검사 */
        if (pwCheck && pwLengthCheck && pw1pw2Check && phoneCheck && emailCheck && emailFormCheck && emailVerifyCheck && emailExistCheck && addressCheck) {
            let userDto = {
                userId: $("#userId").val(),
                password: $("#pw1").val(),
                phone: $("#phone").val(),
                email: $("#email").val(),
                address1: $("#address").val(),
                address2: $("#detailAddress").val()
            };
            for (let key in userDto) {
                if (userDto[key] === '')
                    delete userDto[key]
            }
            if (Object.keys(userDto).length === 0) {
                alert("변경된 항목이 없습니다.")
                return;
            }
            commonAjax("/muscles/mypage/user", userDto, "PATCH", function (res) {
                if(res==="MOD_OK"){
                    alert("회원 정보가 수정되었습니다. 다시 로그인해주시기 바랍니다.");
                    location.href = "/muscles";
                }
                alert("에러가 발생하였습니다.")
            })
        } else
            alert("입력 내용을 다시 확인해주세요.")
    }
</script>
<%@ include file="../footer.jsp" %>
