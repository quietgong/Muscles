<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<style>
    .modal-container {
        align-items: center;
        justify-content: flex-start;
        display: flex;
    }

    .modal-item:nth-child(odd) {
        flex-grow: 1;
    }

    .modal-item:nth-child(even) {
        flex-grow: 2;
    }
</style>
<!-- nav -->
<%@ include file="../nav.jsp" %>
<div class="container">
    <div class="row">
        <!-- 사이드바 -->
        <div class="col-md-2">
            <%@include file="sidebar.jsp" %>
        </div>
        <!-- 컨텐츠 -->
        <div class="col-md-10">
            <h1>리뷰 관리</h1>
            <div id="reviewList">
                <!-- AJAX 동적 추가 -->
            </div>
        </div>
    </div>
</div>
<!-- 모달 -->
<div id="myModal" class="modal">
    <div class="modal-content">
        <h3 style="text-align: center; font-style: italic;">리뷰 작성</h3>
        <div id="modalList">
            <!-- 동적 추가 -->
        </div>
        <div style="text-align: center;">
            <button id="registerBtn">등록</button>
            <button id="closeBtn">닫기</button>
        </div>
    </div>
</div>
<!-- 모달 -->

<script>
    //수정 기능
    // 1. 수정 버튼 클릭
    $(document).on("click", ".modBtn", function () {
        // 2-1. 기존 작성내용의 모달창 출력
        let productName = $(this).parent().parent().prev().prev().prev().val();
        let score = $(this).parent().parent().prev().prev().val();
        let content = $(this).parent().parent().prev().val();
        let orderNo = $(this).next().next().val();
        let productNo = $(this).next().next().next().val();

        $("#modalList").html(append())

        // f : 리뷰 작성을 선택한 상품의 정보에 따라 모달 내용을 동적으로 추가
        function append() {
            let tmp = "";
            tmp += '<div class="modal-container">'
            tmp += '<div><h3 class="productName">' + productName + '</h3></div>'
            tmp += '<h3 style="display: none" class="orderNo">' + orderNo + '</h3>'
            tmp += '<h3 style="display: none" class="productNo">' + productNo + '</h3>'
            tmp += '<div><span class="modal-star">★★★★★<span style=\"width:' + score + '%\">★★★★★</span>'
            tmp += '<input class="starRange" type="range" value="0" step="10" min="0" max="100"/>'
            tmp += '</span></div></div>'
            tmp += '<div class="modal-container">'
            tmp += '<div><textarea class="reviewContent" placeholder="상품 후기를 작성해주세요." rows="5" cols="50">' + content
            tmp += '</textarea></div>'
            tmp += '</div>'
            tmp += '<hr>'
            return tmp;
        }

        // 2-2. 모달창 출력
        $("#myModal").css("display", "block")
        // 3. AJAX 수정내용 DB 반영
        $("#registerBtn").on("click", function () {
            let jsonData = {};
            jsonData.userId = $("#userId").html()
            jsonData.orderNo = $('.orderNo').html()
            jsonData.productNo = $('.productNo').html()
            jsonData.score = $('.starRange').val()
            jsonData.content = $('.reviewContent').val()

            $.ajax({
                type: "PATCH",            // HTTP method type(GET, POST) 형식이다.
                url: "/muscles/review", // 컨트롤러에서 대기중인 URL 주소이다.
                headers: {              // Http header
                    "Content-Type": "application/json",
                },
                data: JSON.stringify(jsonData),
                success: function () {
                    alert("수정이 완료되었습니다.")
                    loadReviewData()
                },
                error: function () {
                    console.log("통신 실패")
                }
            })
            $("#myModal").css("display", "none")
        })
    })

    // 모달 닫기
    $("#closeBtn").on("click", function () {
        $("#myModal").css("display", "none")
    })

    //삭제 기능
    $(document).on("click", ".delBtn", function () {
        let orderNo = $(this).next().val();
        let productNo = $(this).next().next().val();
        $.ajax({
            type: "DELETE",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/mypage/myreview/delete?orderNo=" + orderNo + "&productNo=" + productNo, // 컨트롤러에서 대기중인 URL 주소이다.
            success: function () {
                console.log("Delete Review Item!")
                alert("삭제되었습니다.")
                loadReviewData()
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    })

    function loadReviewData() {
        $.ajax({
            type: "GET",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/mypage/myreview/get", // 컨트롤러에서 대기중인 URL 주소이다.
            success: function (res) {
                $("#reviewList").html(toHtml(res))
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
            tmp += '<div class="mypage-container">'
            tmp += '<img src="http://via.placeholder.com/100X100/000000/ffffff"/>'
            tmp += '<div class="item"><h3>' + item.productName + '</h3></div>'
            tmp += '<div class="item"><span>' + item.content + '</span></div>'
            tmp += '<div class="item">'
            tmp += '<div>'
            tmp += '<span class="star">★★★★★'
            tmp += '<span style=\"width:' + item.score + '%">★★★★★</span>'
            tmp += '</span>'
            tmp += '</div>'
            tmp += '<span>작성일자 : ' + item.createdDate + '</span>'
            tmp += '</div>'
            tmp += '<input type="hidden" value=\"' + item.productName + '">'
            tmp += '<input type="hidden" value=\"' + item.score + '">'
            tmp += '<input type="hidden" value=\"' + item.content + '">'
            tmp += '<div class="item"><span><button type="button" class="modBtn">수정</button><button type="button" class="delBtn">삭제</button>'
            tmp += '<input type="hidden" value=\"' + item.orderNo + '">'
            tmp += '<input type="hidden" value=\"' + item.productNo + '">'
            tmp += '</span></div>'
            tmp += '</div>'
            tmp += '<hr/>'
        })
        return tmp;
    }
    loadReviewData()

    // 별점 드래그
    $(document).on('mouseup', '.starRange', function () {
        $(this).prev().css("width", $(this).val() + '%')
    })
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>