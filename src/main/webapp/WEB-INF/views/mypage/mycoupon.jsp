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
            <section class="py-5">
                <div class="container">
                    <div class="row text-left p-2 pb-3">
                        <h4>쿠폰 등록</h4>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <select id="selectEvent" class="form-select">
                                <option value="" selected disabled>이벤트를 선택하세요</option>
                                <option value="recommend">추천인 입력 이벤트</option>
                                <option value="">준비중...</option>
                            </select>
                        </div>
                        <div id="inputRecommend" class="col-md-8">
                            <div class="input-group">
                                <input class="form-control" id="recommendId" type="text"
                                       placeholder="추천인 아이디(코드)를 입력하세요" />
                                <button id="registerCoupon" class="btn btn-outline-primary" type="button"
                                        onclick="registerRecommend()">등록</button>
                            </div>
                            <p id="checkmsg"></p>
                        </div>
                    </div>
                    <hr class="mt-5">
                    <div class="row mt-5 text-left p-2 pb-3">
                        <h4>쿠폰 리스트</h4>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <table style="text-align: center;" class="table table-hover">
                                <tr id="couponList">
                                    <th>이벤트</th>
                                    <th>쿠폰 코드</th>
                                    <th>할인가 </th>
                                    <th>상태</th>
                                </tr>
                                <!-- 동적 추가-->
                            </table>
                        </div>
                    </div>
                    <hr class="mt-5">
                    <div class="row mt-5 text-left p-2 pb-3">
                        <h4>포인트 내역 (보유 포인트 : )</h4>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <table style="text-align: center;" class="table table-hover">
                                <tr id="pointList">
                                    <th>구분</th>
                                    <th>포인트</th>
                                </tr>
                                <!-- 동적 추가-->
                            </table>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>

<script>
    let userId = '${userId}'
    loadCoupon();
    loadPoint();

    function loadCoupon() {
        $.ajax({
            type: "GET",
            url: '/muscles/mypage/coupon/' + userId,
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
            tmp += '<td>[추천인] ' + item.couponCode + '</td>'
            tmp += '<td>' + item.discount + '%</td>'
            if(isNaN(item.status))
                tmp += '<td>' + item.status + '</td>'
            else
                tmp += '<td>사용완료</td>'
            tmp += '</tr>'
        })
        return tmp
    }
    function loadPoint() {
        $.ajax({
            type: "GET",
            url: '/muscles/mypage/point/' + userId,
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

            if(isNaN(item.pointName)) // 적립 구분이 '이벤트' 일 때
                tmp += '<td>' + item.pointName + '</td>'
            else if(item.point<0)
                tmp += '<td>포인트 사용 [주문번호:' + item.pointName + ']</td>'
            else
                tmp += '<td>결제 적립 [주문번호:' + item.pointName + ']</td>'

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
