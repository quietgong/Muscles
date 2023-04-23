<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ include file="nav.jsp" %>
<form class="col-md-8 m-auto" id="registerForm" method="post">
    <div class="container py-5">
        <div class="row py-5">
            <div class="row">
                <div class="mb-3">
                    <label>아이디</label>
                    <input type="text" class="form-control mt-1" id="inputId" name="userId" placeholder="5자 이상 20자 이하">
                    <p class="checkMsg" id="id_check">아이디를 입력해주세요</p>
                    <p class="checkMsg" id="id_length_check">ID는 4자 이상 20자 이하로 입력해주세요</p>
                    <p class="checkMsg" id="dup_id_check">이미 사용중인 아이디입니다.</p>
                    <p class="checkMsg" style="color: #59ab6e" id="dup_id_check_ok">사용가능한 아이디입니다.</p>
                </div>
                <div class="mb-3">
                    <label>비밀번호</label>
                    <input type="text" class="form-control mt-1" id="pw1" name="password"
                           placeholder="※ 영문, 숫자를 조합하여 5~20자 이내로 입력해주세요"><br>
                    <p class="checkMsg" id="pw_check">비밀번호를 입력해주세요</p>
                    <p class="checkMsg" id="pw_length_check">비밀번호는 5자 이상으로 입력해주세요</p>
                </div>
                <div class="mb-3">
                    <label>비밀번호 확인</label>
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
                    <input type="text" placeholder="이메일을 입력해주세요" class="form-control mt-1" id="email" name="email">
                    <p class="checkMsg" id="email_check">이메일을 입력해주세요</p>
                    <p class="checkMsg" id="email_form_check">올바른 이메일 형식을 입력해주세요</p>
                </div>
                <div class="row align-items-center">
                    <div class="form-group col-md-6 mb-3">
                        <input id="emailVerifyNumber" class="form-control mt-1" type="text" readonly name="verify">
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
                        <input type="text" class="form-control mt-1" name="address1" id="address" placeholder="주소">
                    </div>
                    <div class="form-group col-md-6 mb-3">
                        <input type="text" class="form-control mt-1" name="address2" id="detailAddress"
                               placeholder="상세주소"><br>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="form-group col-md-6 mb-3">
                        <button onclick="submitRegister()" class="form-control mt-1 btn btn-primary" id="register"
                                type="button">회원 가입
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<c:url value='/js/DaumPostCode.js'/>"></script>
<script src="<c:url value='/js/validation.js'/>"></script>
<!-- footer -->
<%@ include file="footer.jsp" %>