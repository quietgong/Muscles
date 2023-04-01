<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<style>
    #emailVerifyNumber {
        background-color: #e0d9d9;
    }

    input[type=text], input[type=date] {
        width: 40%;
        padding: 12px 20px;
        margin: 8px 0;
        display: inline-block;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    input[type=submit] {
        width: 40%;
        background-color: #3f3ce3;
        color: white;
        padding: 14px 20px;
        margin: 8px 0;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .container {
        margin: auto;
        border-radius: 3px;
    }

    div {
        border-radius: 5px;
    }

    .checkMsg {
        display: none;
        color: #dc3545;
    }
</style>
<!-- nav -->
<%@ include file="nav.jsp" %>
<!-- 본문 -->
<div class="container">
    <div>
        <form id="registerForm" method="post">
            <label>아이디</label><br>
            <input type="text" id="inputId" name="userId" placeholder="5자 이상 20자 이하">
            <span id="id_check" class="checkMsg">아이디를 입력해주세요</span>
            <span id="id_length_check" class="checkMsg">ID는 4자 이상 20자 이하로 입력해주세요</span>
            <span id="dup_id_check" class="checkMsg">이미 사용중인 아이디입니다.</span>
            <br>

            <label>비밀번호</label><br>
            <input type="text" id="pw1" name="password" placeholder="영문+숫자 조합의 5자 이상 20자 이하"><br>
            <span id="pw_check" class="checkMsg">비밀번호를 입력해주세요</span>
            <span id="pw_length_check" class="checkMsg">비밀번호는 5자 이상으로 입력해주세요</span>
            <br>

            <label>비밀번호 확인</label><br>
            <input type="text" id="pw2"><br>
            <span id="pw2_check_ok" class="checkMsg" style="color: #04aa6d">비밀번호가 일치합니다</span>
            <span id="pw2_check_fail" class="checkMsg">비밀번호가 일치하지 않습니다</span>
            <br>

            <label>휴대폰 번호</label><br>
            <input type="text" id="phone" name="phone" placeholder="-를 제외하고 입력해주세요"><br>
            <span id="phone_check" class="checkMsg">연락처를 입력해주세요</span>
            <br>

            <label>이메일</label><br>
            <input type="text" id="email" name="email"><br>
            <span id="email_check" class="checkMsg">이메일을 입력해주세요</span>
            <br>

            <!-- 인증번호를 입력하는 input -->
            <input id="emailVerifyNumber" type="text" readonly name="verify">
            <button type="button">인증번호 전송</button>
            <br>
            <input type="hidden" name="">

            <label>주소</label><br>
            <input type="button" onclick="execDaumPostcode()" value="주소 찾기"><br>
            <input type="text" readonly name="address1" id="address" placeholder="주소">
            <input type="text" name="address2" id="detailAddress" placeholder="상세주소"><br>
            <span id="address_check" class="checkMsg">주소를 입력해주세요</span>
            <br>

            <input id="register" type="button" value="회원 가입">
        </form>
    </div>
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    /* Daum 우편번호 API */
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                // 사용자가 도로명 주소를 선택했을 경우
                if (data.userSelectedType === 'R')
                    addr = data.roadAddress;
                else // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if (data.userSelectedType === 'R') {
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname))
                        extraAddr += data.bname;

                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingName !== '' && data.apartment === 'Y')
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);

                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraAddr !== '')
                        extraAddr = ' (' + extraAddr + ')';
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("address").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>
<script>
    /* 회원가입 정보 유효성 체크 */

    let idCheck = false // 아이디 입력 체크
    let dupIdCheck = false // 아이디 중복 체크
    let idLengthCheck = false // 아이디 길이 체크
    let pwCheck = false // 비밀번호 입력 체크
    let pwLengthCheck = false // 비밀번호 길이 체크
    let pw1pw2Check = false // 비밀번호, 비밀번호 확인 일치 체크
    let phoneCheck = false // 휴대폰번호 입력 체크
    let emailCheck = false // 이메일 입력 체크
    let addressCheck = false // 주소 입력 체크

    $(document).ready(function () {
        $("#register").on("click", function () {
            IdValidCheck()
            PwValidCheck()
            Pw1Pw2Check()
            EmailValidCheck()
            AddressValidCheck()
            PhoneValidCheck()
            /* 최종 유효성 검사 */
            if (idCheck && dupIdCheck && idLengthCheck && pwCheck && pwLengthCheck && pw1pw2Check && phoneCheck && emailCheck && addressCheck) {
                const form = $("#registerForm")
                form.attr("action", "<c:url value="/register"/>")
                form.submit()
            }
            return false;
        })
        /*
        * ID 유효성 체크
         */
        function IdValidCheck(){
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
                        if (res !== 0) {
                            $("#dup_id_check").css("display", "block")
                            dupIdCheck = false
                        } else {
                            $("#dup_id_check").css("display", "none")
                            dupIdCheck = true
                        }
                    },
                    error: function () {
                        console.log("통신 실패")
                    }
                })
            }
        }
        $("#inputId").on("keyup", function () {
            IdValidCheck()
        })
        /*
        * 비밀번호 유효성 체크
         */
        function PwValidCheck(){
            let pw1 = $("#pw1").val()
            // 입력 여부 체크
            if (pw1 == "") {
                $("#pw_check").css("display", "block")
                pwCheck = false
            } else {
                $("#pw_check").css("display", "none")
                pwCheck = true
            }
            // 비밀번호 길이 체크
            if (pw1 != "" && pw1.length < 5) {
                $("#pw_length_check").css("display", "block")
                pwLengthCheck = false
            } else {
                $("#pw_length_check").css("display", "none")
                pwLengthCheck = true
            }
        }
        $("#pw1").on("keyup", function () {
            PwValidCheck()
        });
        // 비밀번호1, 비밀번호2 일치 체크
        function Pw1Pw2Check(){
            let pw1 = $("#pw1").val()
            let pw2 = $("#pw2").val()
            if(pw2!="") {
                if (pw1 == pw2) {
                    $("#pw2_check_ok").css("display", "block")
                    $("#pw2_check_fail").css("display", "none")
                    pw1pw2Check = true
                } else {
                    $("#pw2_check_ok").css("display", "none")
                    $("#pw2_check_fail").css("display", "block")
                    pw1pw2Check = false
                }
            }
        }
        $("#pw2").on("keyup", function () {
            Pw1Pw2Check()
        });
        /*
        * 이메일 유효성 체크
         */
        function EmailValidCheck(){
            let email = $("#email").val()
            // 입력 여부 체크
            if (email == "") {
                $("#email_check").css("display", "block")
                emailCheck = false
            } else {
                $("#email_check").css("display", "none")
                emailCheck = true
            }
        }
        $("#email").on("keyup", function () {
            EmailValidCheck()
        })
        /*
        * 주소 유효성 체크
         */
        function AddressValidCheck(){
            let address = $("#address").val()
            // 입력 여부 체크
            if (address == "") {
                $("#address_check").css("display", "block")
                addressCheck = false
            } else {
                $("#address_check").css("display", "none")
                addressCheck = true
            }
        }
        $("#address").on("keyup", function () {
            AddressValidCheck()
        })
        /*
        * 연락처 유효성 체크
         */
        function PhoneValidCheck(){
            $("#phone").val($("#phone").val().replaceAll("-", ""))
            let phone = $("#phone").val()
            // 입력 여부 체크
            if (phone == "") {
                $("#phone_check").css("display", "block")
                phoneCheck = false
            } else {
                $("#phone_check").css("display", "none")
                phoneCheck = true
            }
        }
        $("#phone").on("keyup", function () {
            PhoneValidCheck()
        })
    })
</script>
<!-- footer -->
<%@ include file="footer.jsp" %>