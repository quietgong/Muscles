<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
<!-- 사이드바 시작 -->
<%@include file="sidebar.jsp" %>
<!-- 사이드바 끝 -->
<div id="Wrapper" style="margin: auto; width: 70%;">
    <h1 style="text-align: left">쿠폰 등록</h1>
    <hr/>
    <label for="selectEvent">이벤트 선택</label>
    <select id="selectEvent">
        <option value="" selected disabled>이벤트를 선택하세요</option>
        <option value="recommend">추천인 입력 이벤트</option>
        <option value="">준비중...</option>
    </select>
    <br>
    <div id="inputRecommend" style="display: none">
        <input id="recommendId" type="text" placeholder="추천인 아이디(코드)를 입력하세요"/>
        <input id="registerCoupon" type="button" onclick="registerRecommend()" value="등록"/>
        <p id="checkmsg"></p>
    </div>

    <h1 style="text-align: left">쿠폰 리스트</h1>
    <hr/>
    <table class="myTable">
        <tr id="couponList">
            <th>이벤트</th>
            <th>쿠폰 코드</th>
            <th>할인율</th>
            <th>상태</th>
        </tr>
        <!-- 동적 추가-->
    </table>

    <h1 style="text-align: left">포인트 내역</h1>
    <hr/>
    <h3>보유 포인트 : ${userDto.point}</h3>
    <table class="myTable">
        <tr id="pointList">
            <th>적립 구분</th>
            <th>적립 포인트</th>
        </tr>
        <!-- 동적 추가-->
    </table>
</div>
<script>
    let userId = '${userDto.userId}'
    loadCoupon();

    function loadCoupon() {
        $.ajax({
            type: "GET",
            url: '/muscles/mypage/mycoupon/' + userId,
            success: function (res) {
                $("#couponList").after(toHtml(res));
                checkCouponList(res)
            },
            error: function () {
                console.log('error');
            }
        });
    }

    let toHtml = function (items) {
        let tmp = "";
        items.forEach(function (item) {
            tmp += "<tr class='coupon-item'>";
            tmp += '<td>' + item.couponName + '</td>'
            tmp += '<td>' + item.couponCode + '</td>'
            tmp += '<td>' + item.discount + '</td>'
            tmp += '<td>' + item.status + '</td>'
            tmp += '</tr>'
        })
        return tmp
    }
    loadPoint();

    function loadPoint() {
        $.ajax({
            type: "GET",
            url: '/muscles/mypage/mypoint/' + userId,
            success: function (res) {
                $("#pointList").after(toHtmlPoint(res));
            },
            error: function () {
                console.log('error');
            }
        });
    }

    let toHtmlPoint = function (items) {
        let tmp = "";
        items.forEach(function (item) {
            tmp += "<tr class='point-item'>";
            tmp += '<td>' + item.pointName + '</td>'
            tmp += '<td>' + item.point + '</td>'
            tmp += '</tr>'
        })
        return tmp
    }

    function checkCouponList(items) {
        items.forEach(function (item) {
            if (item.couponName === '추천인 이벤트') {
                $("#recommendId").val("이미 참여한 이벤트입니다.")
                $("#recommendId").attr("readonly", true)
                $("#registerCoupon").attr("disabled", true)
            }
        })
    }

    function checkIsValidId() {
        let recommendId = $("#recommendId").val()
        let result = false
        if (recommendId !== '' && recommendId !== userId) {
            $.ajax({
                type: "GET",
                async: false,
                url: '/muscles/mypage/mycoupon/validIdCheck/' + recommendId,
                success: function (res) {
                    if (res === "invalid") { // 유효하지 않은 아이디일 때
                        result = false
                    } else {
                        result = true
                    }
                },
                error: function () {
                    console.log('error');
                }
            });
        }
        return result
    }

    function registerRecommend() {
        if (checkIsValidId()) {
            $.ajax({
                type: "POST",
                url: '/muscles/mypage/mycoupon/' + $("#recommendId").val(),
                success: function (res) {
                    console.log(res)
                    if (res === "invalid") { // 유효하지 않은 아이디일 때
                        alert("유효하지 않은 아이디입니다. 다시 입력해주세요.")
                    } else {
                        $(".coupon-item").remove()
                        loadCoupon()
                        alert("쿠폰이 등록되었습니다.")
                    }
                },
                error: function () {
                    console.log('error');
                }
            });
        } else {
            alert("유효하지 않은 아이디입니다. 다시 입력해주세요.")
        }
    }

    $("#selectEvent").on("change", function () {
        let selectedOption = this.value;
        if (selectedOption === 'recommend') {
            // 쿠폰 등록을 이미 했는지 안했는지 확인
            document.getElementById("inputRecommend").style.display = 'block';
        } else
            document.getElementById("inputRecommend").style.display = 'none';
    })
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>
