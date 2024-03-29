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
                            </select>
                        </div>
                        <div style="display: none" id="inputRecommend" class="col-md-8">
                            <div class="input-group">
                                <input class="form-control" id="recommendId" type="text"
                                       placeholder="추천인 아이디(코드)를 입력하세요"/>
                                <button id="registerCoupon" class="btn btn-outline-primary" type="button"
                                        onclick="registerRecommend()">등록
                                </button>
                            </div>
                            <p id="checkmsg"></p>
                        </div>
                    </div>
                    <hr class="mt-5">
                    <div class="row mt-5 text-left p-2 pb-3">
                        <h4>쿠폰 리스트</h4>
                    </div>
                    <div class="row">
                        <div class="col-md-10">
                            <table style="text-align: center;" class="table table-hover">
                                <tr id="couponList">
                                    <th>이벤트</th>
                                    <th>쿠폰 코드</th>
                                    <th>할인가(₩)</th>
                                    <th>상태</th>
                                </tr>
                                <!-- 동적 추가-->
                            </table>
                        </div>
                    </div>
                    <hr class="mt-5">
                    <div class="row mt-5 text-left p-2 pb-3">
                        <h4>포인트 내역</h4>
                    </div>
                    <div class="row">
                        <div class="col-md-10">
                            <table style="text-align: center;" class="table table-hover">
                                <tr id="pointList">
                                    <th>구분</th>
                                    <th>포인트 (합계 : <span id="totalPoint"></span>)</th>
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
    /* 포인트 */
    loadPoint()

    function loadPoint() {
        commonAjax("/muscles/mypage/point/" + userId, null, "GET", function (res) {
            $("#pointList").after(toHtmlPoint(res));
        })
    }

    let toHtmlPoint = function (items) {
        console.log(items)
        let totalPoint = 0;
        let tmp = "";
        items.forEach(function (item) {
            totalPoint += item.point
            tmp += "<tr class='point-item'>";
            if (item.point < 0)
                tmp += '<td><strong>포인트 사용</strong> [주문번호:' + item.orderNo + ']</td>'
            else if (item.orderNo === 0)
                tmp += '<td><strong>추천인 이벤트</strong></td>'
            else
                tmp += '<td><strong>결제 적립</strong> [주문번호:' + item.orderNo + ']</td>'
            tmp += '<td>' + item.point.toLocaleString() + '</td>'
            tmp += '</tr>'
        })
        $("#totalPoint").html(totalPoint.toLocaleString())
        return tmp
    }
</script>
<script>
    /* 쿠폰 */
    loadCoupon();

    function loadCoupon() {
        commonAjax("/muscles/mypage/coupon/" + userId, null, "GET", function (res) {
            $("#couponList").after(toHtml(res));
            checkCouponList(res)
        });
    }

    let toHtml = function (items) {
        let tmp = "";
        items.forEach(function (item) {
            tmp += "<tr class='coupon-item'>";
            tmp += '<td>' + item.couponName + '</td>'
            tmp += '<td>[추천인] ' + item.couponCode + '</td>'
            tmp += '<td>' + item.discount.toLocaleString() + '</td>'
            tmp += item.orderNo === 0 ? '<td>사용가능</td>' : '<td>사용완료</td>'
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

    function registerRecommend() {
        let recommendId = $("#recommendId").val()
        if (recommendId === '' || recommendId === userId) {
            alert("유효하지 않은 아이디입니다. 다시 입력해주세요.")
            return false;
        }
        commonAjax('/muscles/mypage/coupon/' + userId + '/' + recommendId, null, "POST", function (res) {
            if (res === "ADD_OK") {
                $(".coupon-item").remove()
                loadCoupon(recommendId)
                alert("쿠폰이 등록되었습니다.")
            } else
                alert("유효하지 않은 아이디입니다. 다시 입력해주세요.")
        });
    }

    $("#selectEvent").on("change", function () {
        let selectedOption = this.value;
        // 쿠폰 등록을 이미 했는지 안했는지 확인
        selectedOption === 'recommend' ? $("#inputRecommend").show() : $("#inputRecommend").hide()
    })
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>
