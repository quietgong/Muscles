<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ include file="../nav.jsp" %>
<div class="container">
    <div class="row mt-5">
        <div class="col-md-2">
            <%@include file="sidebar.jsp" %>
        </div>
        <div class="col-md-10">
            <div class="container-fluid bg-light py-5">
                <div class="col-md-8 m-auto text-center">
                    <h3>
                        ${userId} 고객님!
                    </h3>
                    <h5 style="font-weight: bold">* 회원 탈퇴 시 꼭 확인해 주세요!</h5>
                    <p>
                        ※ 탈퇴 이후 등록한 게시물, 보유 포인트 등 이용기록이 모두 삭제 됩니다.
                    </p>
                    <h5 style="font-weight: bold">* 탈퇴 사유를 선택해 주세요!</h5>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" name="type" type="checkbox" id="a" value="1">
                        <label class="form-check-label" for="a">이용률 감소</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" name="type" type="checkbox" id="b" value="1">
                        <label class="form-check-label" for="b">상품 불만족</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" name="type" type="checkbox" id="c" value="1">
                        <label class="form-check-label" for="c">단순 탈퇴</label>
                    </div>
                    <textarea class="form-control mt-1" id="message" placeholder="쇼핑몰 이용에 개선 사항 있다면 의견을 남겨 주세요!"
                              rows="8"></textarea>
                    <p class="mt-3">지금까지 저희 머슬스를 이용해 주셔서 감사합니다.</p>
                    <p>부족한 점이 있었다면 너그러운 양해 바라며,</p>
                    <p>더욱 고객님의 의견을 적극 반영하여
                        이용에 불편이 없도록 개선하겠습니다
                    </p>
                    <button onclick="submitExit()" type="button" class="btn btn-outline-primary">회원탈퇴</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function submitExit() {
        let arrType = $("input[name='type']")
        let type = [0, 0, 0]
        for (let i = 0; i < arrType.length; i++)
            if (arrType[i].checked === true)
                type[i] += 1;

        let exitDto = {}
        exitDto.userId = '${userId}'
        exitDto.removeType = 'user'
        exitDto.opinion = $("#message").val()
        exitDto.type1 = type[0]
        exitDto.type2 = type[1]
        exitDto.type3 = type[2]
        commonAjax("/muscles/mypage/exit/", exitDto, "POST", function (res) {
            if (res === "DEL_OK") {
                alert('탈퇴가 정상적으로 처리되었습니다.');
                location.href = '/muscles'
            }
        })
    }
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>
