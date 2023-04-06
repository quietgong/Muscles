<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>
<div class="container">
    <div class="row mt-5">
        <div class="col-md-2">
            <%@include file="sidebar.jsp" %>
        </div>
        <div class="col-md-10">
            <div class="row">
                <div class="col-md-8">
                    <h1 class="app-page-title mb-0">상품 관리</h1>
                </div>
                <div class="col-md-4">
                    <!-- 조건 -->
                    <form>
                        <div class="input-group flex-nowrap">
                            <span class="input-group-text" id="addon-wrapping">상품명</span>
                            <input class="form-control">
                            <button type="submit" class="btn btn-primary">검색</button>
                        </div>
                    </form>
                    <!-- 조건 -->
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-md-12">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th scope="col">이름</th>
                            <th scope="col">카테고리</th>
                            <th scope="col">가격</th>
                            <th scope="col">재고</th>
                            <th scope="col">평점</th>
                            <th scope="col">판매량</th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                        </tr>
                        </thead>
                        <tbody id="productList">

                        </tbody>
                    </table>
                </div>
            </div>
        </div><!--//container-fluid-->
    </div><!--//app-content-->
</div>
<!-- 본문 -->
<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">상품정보 변경</h5>
                <button type="button" onclick="initModal()" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6">
                            <input id="productNo" type="hidden" value="">
                            <label class="form-label">상품명</label>
                            <input id="productName" type="text" class="form-control" placeholder="상품명을 입력하세요" value="">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">카테고리</label>
                            <input id="productCategory" type="text" class="form-control" placeholder="상품명을 입력하세요"
                                   value="">
                        </div>
                        <div class="col-md-12 mt-3">
                            <label class="form-label">가격</label>
                            <input id="productPrice" type="text" class="form-control" placeholder="가격을 입력하세요" value="">
                        </div>
                        <div class="col-md-12 mt-3">
                            <label class="form-label">재고</label>
                            <input id="productStock" type="text" class="form-control" placeholder="재고를 입력하세요" value="">
                        </div>
                    </div>
                    <div class="row mt-5">
                        <div class="col-md-12">
                            <label for="thumbnailInput">상품 썸네일</label>
                            <input type="file" class="form-control" id="thumbnailInput" name='uploadFile'>
                        </div>
                    </div>
                    <div class="row mt-5">
                        <div class="col-md-12">
                            <img id="thumbnail" class="img-fluid" src="">
                        </div>
                    </div>
                    <div class="row mt-5">
                        <div class="col-md-12">
                            <label for="detail">상품 소개 이미지</label>
                            <input type="file" class="form-control" multiple id="detail" name='uploadFiles'>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button onclick="modifyProduct()" type="button" id="registerBtn" class="btn btn-secondary" data-bs-dismiss="modal">
                        등록
                    </button>
                    <button type="button" onclick="initModal()" id="closeBtn" class="btn btn-primary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal -->
    <script>
        function initModal(){
            $(".detailImg").remove()
        }
        // 수정 버튼 클릭
        function insertModal(productNo) {
            $.ajax({
                type: "GET",            // HTTP method type(GET, POST) 형식이다.
                url: "/muscles/admin/product/" + productNo, // 컨트롤러에서 대기중인 URL 주소이다.
                headers: {              // Http header
                    "Content-Type": "application/json",
                },
                success: function (res) {
                    console.log(res)
                    // 기존 상품 데이터를 모달에 적용
                    $("#productNo").val(res.productNo)
                    $("#productName").val(res.productName)
                    $("#productCategory").val(res.productCategory)
                    $("#productPrice").val(res.productPrice)
                    $("#productStock").val(res.productStock)
                    $("#thumbnail").attr("src", res.productImgPath)
                    let productImgDtoList = res.productImgDtoList
                    productImgDtoList.forEach(function (img) {
                        $("#detail").after('<img class="detailImg img-fluid mt-3" src="' + img.uploadPath + '">')
                    })
                },
                error: function () {
                    console.log("AJAX 통신 실패")
                }
            })
        }

        // // 기존 상세 이미지 출력
        // if (res.length !== 0) {
        //     let detailImg = []
        //     res.forEach(function (r) {
        //         let tmp = {}
        //         tmp.uploadName = r.uploadPath.split("&").filter(item => item.includes("fileName"))[0].split("=")[1];
        //         detailImg.push(tmp)
        //     })
        //     showPreview(detailImg, "detail")
        //     $("#modalList").html(append())
        //     // 기존 썸네일 이미지 출력
        //     let thumbnailImg = []
        //     let tmp = {}
        //     if (productImgPath.indexOf("&") != -1) {
        //         tmp.uploadName = productImgPath.split("&").filter(item => item.includes("fileName"))[0].split("=")[1];
        //         thumbnailImg.push(tmp)
        //         showPreview(thumbnailImg, "thumbnail")
        //     }
        // }

        // 모달 "등록" 버튼 클릭
        function modifyProduct() {
            let data = {};
            let productImgDtoList = []
            $("#detailPreview").children().each(function () {
                let tmp = {}
                tmp.productNo = $("#productNo").val();
                tmp.uploadPath = $(this).attr("data-url")
                productImgDtoList.push(tmp)
            })
            data.productNo = $("#productNo").val();
            data.productName = $("#productName").val()
            data.productPrice = $("#productPrice").val()
            data.productStock = $("#productStock").val()
            data.productImgPath = $("#thumbnailInput").attr("src")
            data.productImgDtoList = productImgDtoList
            $.ajax({
                type: "PATCH",            // HTTP method type(GET, POST) 형식이다.
                url: "/muscles/admin/product/", // 컨트롤러에서 대기중인 URL 주소이다.
                headers: {              // Http header
                    "Content-Type": "application/json",
                },
                data: JSON.stringify(data),
                success: function () {
                    alert("수정 완료")
                    loadProductData()
                },
                error: function () {
                    alert("AJAX 통신 실패")
                }
            })
        }

    </script>
    <script>
        // 상품 정보 추가
    </script>

    <script>
        // 모달 내부 제어
        function showPreview(items, type) {
            let tmp = "";
            items.forEach(function (item) {
                let addr = "/muscles/product/display?type=" + type + "&fileName=" + item.uploadName
                tmp += '<div data-type=' + type + ' data-url=' + item.uploadName + '>'
                tmp += '<input class="delPreview" type="button" value="X">'
                tmp += '<img src="' + addr + '">'
                tmp += '</div>'
            });
            if (type == "detail")
                $("#detailPreview").html(tmp)
            else
                $("#thumbnailPreview").html(tmp)
        }

        <!-- 업로드된 이미지 삭제 -->
        $(document).on("click", ".delPreview", function () {
            let fileName = $(this).parent().attr("data-url")
            let type = $(this).parent().attr("data-type")
            let targetdiv = $(this).parent()
            $.ajax({
                type: "POST",            // HTTP method type(GET, POST) 형식이다.
                enctype: 'multipart/form-data',
                url: "/muscles/admin/product/file/delete?type=" + type + "&fileName=" + fileName,
                success: function (res) {
                    console.log(res)
                    // 파일 삭제가 성공적으로 이루어지면
                    if (res == "DEL_OK") {
                        targetdiv.remove()
                    }
                }
            })
        });
        <!-- 이미지 업로드 -->
        $("input[type='file']").on("change", function (e) {
            let formData = new FormData();
            let type = $(this).attr("id");
            let fileList = $(this)[0].files;
            for (let i = 0; i < fileList.length; i++)
                formData.append("uploadFile", fileList[i]);
            $.ajax({
                type: "POST",            // HTTP method type(GET, POST) 형식이다.
                enctype: 'multipart/form-data',
                url: "/muscles/admin/product/file/" + type + "/" + $("#productNo").val(), // 컨트롤러에서 대기중인 URL 주소이다.
                processData: false,
                contentType: false,
                data: formData,
                dataType: 'json',
                success: function (items) {
                    showPreview(items, type)
                }
            })
        });
    </script>
    <script>
        // 상품 정보 읽기
        loadProductData()

        function loadProductData() {
            $.ajax({
                type: "GET",            // HTTP method type(GET, POST) 형식이다.
                url: "/muscles/admin/product/", // 컨트롤러에서 대기중인 URL 주소이다.
                success: function (res) {
                    $("#productList").append(toHtml(res))
                },
                error: function () {
                    alert("AJAX 통신 실패")
                }
            })
            let toHtml = function (items) {
                let tmp = "";
                items.forEach(function (item) {
                    tmp += '<tr>'
                    tmp += '<td>' + item.productName + '</td>'
                    tmp += '<td>' + item.productCategory + '</td>'
                    tmp += '<td>' + item.productPrice + '</td>'
                    tmp += '<td>' + item.productStock + '</td>'
                    tmp += '<td>구현예정</td>'
                    tmp += '<td>구현예정</td>'
                    tmp += '<td><button type="button" data-bs-toggle="modal" data-bs-target="#staticBackdrop" name="modBtn" class="btn btn-primary" onclick="insertModal(' + item.productNo + ')">수정</button></td>'
                    tmp += '<td><button type="button" name="delBtn" class="btn btn-danger" onclick="removeProduct(' + item.productNo + ')">삭제</button></td>'
                    tmp += '</tr>'
                })
                return tmp;
            }
        }
    </script>
    <script>
        // 상품 정보 삭제
        function removeProduct(productNo) {
            $.ajax({
                type: "DELETE",            // HTTP method type(GET, POST) 형식이다.
                url: "/muscles/admin/product/" + productNo, // 컨트롤러에서 대기중인 URL 주소이다.
                success: function () {
                    alert("해당 상품 정보를 삭제하였습니다.")
                    $("#productList").empty()
                    loadProductData()
                },
                error: function () {
                    alert("AJAX 통신 실패")
                }
            })
        }
    </script>
    <!-- footer -->
<%@ include file="../footer.jsp" %>