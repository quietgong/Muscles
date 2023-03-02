<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Muscles</title>
    <link rel="stylesheet" href="css/style.css"/>
    <script src="https://code.jquery.com/jquery-1.11.3.js"/>
</head>
<style>
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

    div {
        border-radius: 5px;
        background-color: #f2f2f2;
        padding: 20px;
    }

    .required {
        font-weight: bold;
        color: red;
    }
</style>
<body>
<!-- nav -->
<%@ include file="nav.jsp" %>

<!-- 본문 -->
<div>
    <form action="<c:url value="/register"/>" name="registerForm" method="post">
        <p><span class="required">*</span> 표시는 필수입력 항목입니다.</p>

        <label>아이디 <span class="required">*</span></label><br>
        <input type="text" id="inputId" name="id" placeholder="5자 이상 20자 이하">
        <div><font id="id_check"></font></div>
        <br>

        <label>비밀번호 <span class="required">*</span></label><br>
        <input type="text" name="password" placeholder="영문+숫자 조합의 5자 이상 20자 이하"><br>

        <label>비밀번호 확인 <span class="required">*</span></label><br>
        <input type="text" id="password_check"><br>

        <label>휴대폰 번호 <span class="required">*</span></label><br>
        <input type="text" name="phone" placeholder="-를 제외하고 입력해주세요"><br>

        <label>주소 <span class="required">*</span></label>
        <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
        <input type="text" id="postcode" placeholder="우편번호">
        <input type="text" name="address" id="address" placeholder="주소"><br>
        <input type="text" name="address" id="detailAddress" placeholder="상세주소"><br>

        <label>이메일</label><br>
        <input type="text" name="email"><br>

        <label>추천인 ID</label><br>
        <input type="text" placeholder="10% 할인쿠폰을 드립니다"><br>

        <input type="submit" value="회원 가입">
    </form>
</div>

<!-- footer -->
<%@ include file="footer.jsp" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    /* 유효성 체크 */
    // 1. 비밀번호
    // let regPass = /^(?=.*[a-zA-Z])(?=.*[0-9]).{5,20}$/;
    // if (!regPass.test(password)) alert("영문, 숫자 조합으로 5-20자리 입력해주세요.")

    /* 아이디 중복체크 (비동기) */
    $("#inputId").keyup(function () {
        let inputId = $("input[name=id]").val();
        $.ajax({
            type: "GET",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/register/idDupCheck?inputId="+inputId,      // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
                "X-HTTP-Method-Override": "POST"
            },
            dataType: 'text',
            data: inputId,
            success: function (res) {
                if (res == 0)
                    $("#id_check").html("사용 가능한 아이디입니다.").attr('color', '#2fb380')
                else
                    $("#id_check").html("이미 사용중인 아이디입니다.").attr('color', '#dc3545')
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    })

    /* 우편번호 API */
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
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>
</body>
</html>