<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>
<div class="container">
    <div class="row mt-5">
        <!-- 사이드바 -->
        <div class="col-md-2">
            <%@include file="sidebar.jsp" %>
        </div>
        <!-- 컨텐츠 -->
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
                    <form action="<c:url value='/mypage/exit/'/>" method="post">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" name="type" type="checkbox" id="inlineCheckbox1" value="1">
                            <label class="form-check-label" for="inlineCheckbox1">이용률 감소</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" name="type" type="checkbox" id="inlineCheckbox2" value="2">
                            <label class="form-check-label" for="inlineCheckbox2">상품 불만족</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" name="type" type="checkbox" id="inlineCheckbox3" value="3">
                            <label class="form-check-label" for="inlineCheckbox3">단순 탈퇴</label>
                        </div>
                        <textarea class="form-control mt-1" id="message" name="opinion"
                                  placeholder="쇼핑몰 이용에 개선 사항 있다면 의견을 남겨 주세요!" rows="8"></textarea>
                    <p>지금까지 저희 머슬스를 이용해 주셔서 감사합니다.</p>
                    <p>부족한 점이 있었다면 너그러운 양해 바라며,</p>
                    <p>더욱 고객님의 의견을 적극 반영하여
                        이용에 불편이 없도록 개선하겠습니다
                    </p>
                    <button onclick="alert('탈퇴가 정상적으로 처리되었습니다.'); location.href='/';" type="submit" class="btn btn-outline-primary">회원탈퇴</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- footer -->
<%@ include file="../footer.jsp" %>
