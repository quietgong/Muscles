<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<%@ include file="../nav.jsp" %>
<div class="container">
    <div class="row mt-5">
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
                    <!-- 리뷰 데이터 동적 추가 -->
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
                            <h3 id="goodsName" class="goodsName text-center">상품 이름</h3>
                        </div>
                    </div>
                    <div class="row">
                        <ul class="list-unstyled d-flex justify-content-center mb-1">
                            <div class="star-ratings" style="width: auto">
                                <input class="starRange" type="range" value="0" step="10" min="0" max="100"/>
                                <div class="fill-ratings">
                                    <span style="font-size: 1.8rem;">★★★★★</span>
                                </div>
                                <div class="empty-ratings">
                                    <span style="font-size: 1.8rem;">★★★★★</span>
                                </div>
                            </div>
                        </ul>
                    </div>
                    <div class="row mt-5">
                        <div class="col-md-12">
                            <label for="reviewImg" class="form-label text-center">리뷰 이미지를 업로드해주세요!</label>
                            <input type="file" multiple class="form-control" id="reviewImg" name='uploadFile'>
                            <div id="reviewPreview"></div>
                        </div>
                    </div>
                    <div class="row mt-5">
                        <div class="col-md-12">
                                <textarea id="reviewContent" class="form-control mt-1" placeholder="상품 후기를 작성해주세요."
                                          rows="5"
                                          cols="50"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 모달 구성 요소 -->
            <div id="modal-footer" class="modal-footer">
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
        commonAjax("/muscles/mypage/review/" + '${userId}', null, "GET", function (res) {
            $("#reviewList").after(toHtml(res))
        })
    }

    let toHtml = function (items) {
        let tmp = "";
        items.forEach(function (item) {
            tmp += '<div class="row">'
            tmp += '<div data-reviewNo=' + item.reviewNo + ' class="col-md-12">'
            tmp += '<button style="float: right;" type="button" onclick="delReview(this)" class="btn btn-space btn-outline-primary">삭제</button>'
            tmp += '<button style="float: right; margin-right: 10px" type="button" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="modReview(this)" class="delBtn btn btn-space btn-outline-primary">수정</button>'
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
        $("#modal-footer").attr("data-goodsNo", item.goodsNo)

        if (item.reviewImgDtoList.length !== 0) {
            let items = []
            item.reviewImgDtoList.forEach(function (r) {
                let tmp = {}
                tmp.uploadName = r.uploadPath.split("&").filter(item => item.includes("fileName"))[0].split("=")[1]
                items.push(tmp)
            })
            showPreview(items, 'detail')
        }
    }

    // 이미지 업로드
    $("input[type='file']").on("change", function () {
        let fileList = $(this)[0].files;
        let formData = new FormData();
        for (let i = 0; i < fileList.length; i++)
            formData.append("uploadFile", fileList[i]);
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/muscles/img/review/detail/" + $("#modal-footer").attr("data-goodsno"), // 컨트롤러에서 대기중인 URL 주소이다.
            processData: false,
            contentType: false,
            data: formData,
            dataType: 'json',
            success: function (items) {
                showPreview(items, "detail")
            }
        })
    });

    function showPreview(items, type) {
        let tmp = "";
        items.forEach(function (item) {
            let addr = "/muscles/img/display?category=review&type=" + type + "&fileName=" + item.uploadName
            tmp += '<div class="detail" data-type=' + type + ' data-url=' + item.uploadName + '>'
            tmp += '<button class="delPreview btn btn-danger mb-3 mt-3" type="button">X</button>'
            tmp += '<button style="float: right" class="down btn btn-warning mb-3 mt-3" type="button">↓</button>'
            tmp += '<button style="float: right; margin-right: 10px" class="up btn btn-warning mb-3 mt-3" type="button">↑</button>'
            tmp += '<img class="img-fluid newDetail" src="' + addr + '">'
            tmp += '</div>'
        });
        $("#reviewPreview").append(tmp)
        moveImgPosition()
    }

    function showUpDownBtn() {
        $("button:contains('↑')").show()
        $('.detail:first-child button:contains("↑")').hide();
        $("button:contains('↓')").show()
        $('.detail:last-child button:contains("↓")').hide();
    }

    function moveImgPosition() {
        showUpDownBtn()
        $('.detail button:contains("↑")').click(function () {
            let currentDiv = $(this).parent();
            let prevDiv = currentDiv.prev('.detail');
            if (prevDiv.length !== 0)
                currentDiv.insertBefore(prevDiv);
            showUpDownBtn()
        });
        $('.detail button:contains("↓")').click(function () {
            let currentDiv = $(this).parent();
            let nextDiv = currentDiv.next('.detail');
            if (nextDiv.length !== 0)
                currentDiv.insertAfter(nextDiv);
            showUpDownBtn()
        });
    }

    <!-- 업로드된 이미지 삭제 -->
    $(document).on("click", ".delPreview", function () {
        let fileName = $(this).parent().attr("data-url")
        let target = $(this).parent()
        deleteImg(target, "detail", fileName)
    });

    function deleteImg(target, type, fileName) {
        let targetDiv = target
        $.ajax({
            type: "DELETE",
            enctype: 'multipart/form-data',
            url: "/muscles/img/delete/review/detail?fileName=" + fileName,
            success: function (res) {
                console.log(res)
                // 파일 삭제가 성공적으로 이루어지면
                if (res === "DEL_OK") {
                    targetDiv.empty();
                }
            }
        })
    }

    // 리뷰 수정
    function modReview(e) {
        let reviewNo = $(e).parent().attr("data-reviewNo")
        commonAjax("/muscles/review/" + reviewNo, null, "GET", function (res) {
            insertModalData(res)
        })
    }

    function reviewRegister() {
        let reviewNo = $("#reviewNo").val()
        let score = $(".starRange").val()
        let content = $('#reviewContent').val()
        let reviewImgDtoList = []
        $('.newDetail').each(function () {
            let tmp = {}
            tmp.reviewNo = reviewNo
            tmp.goodsNo = $("#modal-footer").attr("data-goodsNo")
            tmp.uploadPath = $(this).attr("src")
            reviewImgDtoList.push(tmp)
        });

        let data = {reviewNo: reviewNo, score: score, content: content, reviewImgDtoList: reviewImgDtoList}
        commonAjax("/muscles/review/", data, "PATCH", function () {
            alert("수정이 완료되었습니다.")
            location.reload()
        })
    }

    // 리뷰 삭제
    function delReview(e) {
        if (!confirm("정말로 삭제하시겠습니까?")) return;
        let reviewNo = $(e).parent().attr("data-reviewNo")
        commonAjax("/muscles/review/" + reviewNo, null, "DELETE", function () {
                location.reload()
        })
    }

    // 별점 드래그
    $(document).on('mouseup', '.starRange', function () {
        $(this).next().css("width", $(this).val() + '%')
    })
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>