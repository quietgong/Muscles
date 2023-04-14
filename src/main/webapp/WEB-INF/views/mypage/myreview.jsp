<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                        <h4>리뷰 작성 목록</h4>
                    </div>
                    <input type="hidden" id="reviewList">
                    <!-- 리뷰 데이터 -->
                </div>
            </section>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">리뷰 작성</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- 모달 구성 요소 -->
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <h3 id="goodsName" class="goodsName">상품 이름</h3>
                        </div>
                    </div>
                    <div class="row">
                        <ul class="list-unstyled d-flex justify-content-center mb-1">
                            <div class="star-ratings" style="width: auto">
                                <input class="starRange" type="range" value="0" step="10" min="0" max="100" />
                                <div class="fill-ratings">
                                    <span style="font-size: 1.8rem;">★★★★★</span>
                                </div>
                                <div class="empty-ratings">
                                    <span style="font-size: 1.8rem;">★★★★★</span>
                                </div>
                            </div>
                        </ul>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                                <textarea id="reviewContent" class="form-control mt-1" placeholder="상품 후기를 작성해주세요."
                                          rows="5"
                                          cols="50"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 모달 구성 요소 -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button onclick="reviewRegister(this)" type="button" class="btn btn-primary">등록</button>
                <input id="reviewNo" value="" type="hidden">
            </div>
        </div>
    </div>
</div>
<!-- Modal -->

<script>
    // 리뷰 데이터 불러오기
    loadReviewData()

    function loadReviewData() {
        $.ajax({
            type: "GET",
            url: "/muscles/mypage/review/" + '${userId}',
            success: function (res) {
                $("#reviewList").after(toHtml(res))
                console.log("Get All Review Item!")
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    }

    let toHtml = function (items) {
        let tmp = "";
        items.forEach(function (item) {
            tmp += '<div class="row">'
            tmp += '<div data-reviewNo=' + item.reviewNo + ' class="col-md-12">'
            tmp += '<button style="float: right;" type="button" onclick="delReview(this)" class="btn btn-space btn-outline-primary">삭제</button>'
            tmp += '<button style="float: right;" type="button" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="modReview(this)" class="delBtn btn btn-space btn-outline-primary">수정</button>'
            tmp += '<h3>' + item.goodsName + '</h3>'
            tmp += '</div>'
            tmp += '<div class="col-md-12">'
            tmp += '<ul class="list-unstyled d-flex mb-1">'
            tmp += '<div class="star-ratings">'
            tmp += '<div class="fill-ratings" style="width:' + item.score + '%">'
            tmp += '<span style="font-size: 1.8rem;">★★★★★</span>'
            tmp += '</div>'
            tmp += '<div class="empty-ratings">'
            tmp += '<span style="font-size: 1.8rem;">★★★★★</span>'
            tmp += '</div>'
            tmp += item.createdDate
            tmp += '</div>'
            tmp += '</ul>'
            tmp += '</div>'
            tmp += '<div class="col-md-12 mt-4">'
            tmp += '<span>' + item.content + '</span>'
            tmp += '</div>'
            tmp += '<hr class="mb-4 mt-5">'
            tmp += '</div>'
        })
        return tmp;
    }

    // 모달 내용 적용
    function insertModalData(item) {
        $("#goodsName").html(item.goodsName) // 상품명 입력
        $("#reviewContent").val(item.content) // 상품후기 입력
        $(".starRange").val(item.score) // 상품점수 입력
        $(".fill-ratings").css("width", item.score + '%') // 상품점수에 따른 별점 입력
        $("#reviewNo").val(item.reviewNo)
    }

    // 리뷰 수정
    function modReview(e) {
        let reviewNo = $(e).parent().attr("data-reviewNo")
        $.ajax({
            type: "GET",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/review/" + reviewNo, // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function (res) {
                insertModalData(res)
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    }

    function reviewRegister() {
        let reviewNo = $("#reviewNo").val()
        let score = $(".starRange").val()
        let content = $('#reviewContent').val()
        console.log(score)
        $.ajax({
            type: "PATCH",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/review/", // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            data: JSON.stringify({
                reviewNo: reviewNo,
                score: score,
                content: content,
            }),
            success: function () {
                alert("수정이 완료되었습니다.")
                location.reload()
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    }

    // 리뷰 삭제
    function delReview(e) {
        if (!confirm("정말로 삭제하시겠습니까?")) return;
        let reviewNo = $(e).parent().attr("data-reviewNo")
        $.ajax({
            type: "DELETE",
            url: "/muscles/review/" + reviewNo,
            success: function () {
                location.reload()
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    }

    // 별점 드래그
    $(document).on('mouseup', '.starRange', function () {
        $(this).next().css("width", $(this).val() + '%')
    })
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>