<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
<!-- 검색조건 -->
<div class="admin-condition">
    <div>
        <label for="lname">상품명<input type="text" id="lname" name="lastname"/></label>
        <input type="button" value="검색"/>
    </div>
</div>
<!-- 검색조건 끝 -->

<!-- 컨테이너 -->
<div class="admin-container">
    <!-- 내용 -->
    <div id="admin-item">
        <!-- AJAX 동적추가 -->
    </div>
    <!-- 내용 -->
</div>
<!-- 컨테이너 -->

<ul class="paging">
    <li class="paging"><a href="#"><</a></li>
    <li class="paging"><a href="#">1</a></li>
    <li class="paging"><a href="#">2</a></li>
    <li class="paging"><a href="#">3</a></li>
    <li class="paging"><a href="#">4</a></li>
    <li class="paging"><a href="#">5</a></li>
    <li class="paging"><a href="#">6</a></li>
    <li class="paging"><a href="#">7</a></li>
    <li class="paging"><a href="#">8</a></li>
    <li class="paging"><a href="#">9</a></li>
    <li class="paging"><a href="#">10</a></li>
    <li class="paging"><a href="#">></a></li>
</ul>

<!-- 모달-->
<div id="myModal" class="modal">
    <div class="modal-content">
        <h3 style="text-align: center; font-style: italic;">상품정보 변경</h3>
        <div id="modalList">
            <!-- 동적 추가 -->
        </div>
        <!-- 이미지 파일 -->
        <div>
            <label for="thumbnail">상품 썸네일</label>
            <input type="file" id="thumbnail" name='uploadFile' style="height: 30px;">
            <div id="thumbnailPreview">
            </div>
        </div>
        <div>
            <label for="detail">상품 소개 이미지</label>
            <input type="file" multiple id="detail" name='uploadFiles' style="height: 30px;">
            <div style="display: flex; flex-direction: row" id="detailPreview">
            </div>
            <div style="text-align: center;">
                <button type="button" id="registerBtn">등록</button>
                <button type="button" id="closeBtn">닫기</button>
            </div>
        </div>
    </div>
</div>
<!-- 모달-->
<script>
    // 상품 정보 불러오기
    loadProductData()
    function loadProductData() {
        $.ajax({
            type: "GET",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/admin/product/", // 컨트롤러에서 대기중인 URL 주소이다.
            success: function (res) {
                $("#admin-item").html(toHtml(res))
            },
            error: function () {
                alert("AJAX 통신 실패")
            }
        })
        let toHtml = function (items) {
            let tmp = "";
            items.forEach(function (item) {
                tmp += '<div class="admin-item-detail">'
                tmp += '<div class="admin-detail-section">'
                tmp += '<div>'
                if (item.productImgPath == null)
                    item.productImgPath = "/muscles/img/logo.jpg"
                tmp += '<img style="width: 200px; height: 100px" src=\"' + item.productImgPath + '\"/>'
                tmp += '</div><div>'
                tmp += '<span style=\"font-weight: bold\">[' + item.productCategory + ']</span><br>'
                tmp += '<span>상품명 : ' + item.productName + '</span><br>'
                tmp += '<span>가격 : ' + item.productPrice + '</span><br>'
                tmp += '<span>재고수량 : ' + item.productStock + '</span><br>'
                tmp += '</div>'
                tmp += '<div data-productNo=' + item.productNo + ' data-productName=' + item.productName +
                    ' data-productPrice=' + item.productPrice + ' data-productstock=' + item.productStock + ' data-productImgPath=' + item.productImgPath + '>'
                tmp += '<button class="modBtn" type="button">상품정보 변경</button>'
                tmp += '<button class="delBtn" type="button">상품 삭제</button>'
                tmp += '<input type="hidden" value=\"' + item.productNo + '\">'
                tmp += '</div>'
                tmp += '</div>'
                tmp += '</div>'
            })
            return tmp;
        }
    }

    // 2. 상품 정보 삭제
    $(document).on("click", ".delBtn", function () {
        let productNo = $(this).next().val();
        $.ajax({
            type: "DELETE",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/admin/product/" + productNo, // 컨트롤러에서 대기중인 URL 주소이다.
            success: function () {
                alert("해당 상품 정보를 삭제하였습니다.")
                loadProductData()
            },
            error: function () {
                alert("AJAX 통신 실패")
            }
        })
    })

    // 3. 상품 정보 수정
    $(document).on("click", ".modBtn", function () {
        // 2-1. 기존 작성내용의 모달창 출력
        let clickedDiv = $(this).parent()
        let productNo = clickedDiv.attr("data-productNo");
        let productName = clickedDiv.attr("data-productName");
        let productPrice = clickedDiv.attr("data-productPrice");
        let productStock = clickedDiv.attr("data-productStock");
        let productImgPath = clickedDiv.attr("data-productImgPath");
        // 클릭한 상품의 소개 이미지들을 ajax로 가져온다.
        $.ajax({
            type: "GET",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/admin/product/detailImg/" + productNo, // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function (res) {
                // 기존 상세 이미지 출력
                if (res.length !== 0) {
                    let detailImg = []
                    res.forEach(function (r) {
                        let tmp = {}
                        tmp.uploadName = r.uploadPath.split("&").filter(item => item.includes("fileName"))[0].split("=")[1];
                        detailImg.push(tmp)
                    })
                    showPreview(detailImg, "detail")
                }
            },
            error: function () {
                alert("AJAX 통신 실패")
            }
        })

        $("#modalList").html(append())
        // 기존 썸네일 이미지 출력
        let thumbnailImg = []
        let tmp = {}
        if(productImgPath.indexOf("&")!=-1) {
            tmp.uploadName = productImgPath.split("&").filter(item => item.includes("fileName"))[0].split("=")[1];
            thumbnailImg.push(tmp)
            showPreview(thumbnailImg, "thumbnail")
        }


        // f : 리뷰 작성을 선택한 상품의 정보에 따라 모달 내용을 동적으로 추가
        function append() {
            let tmp = "";
            tmp += '<div class="admin-admin-condition">'
            tmp += '<div class="admin-item">'
            tmp += '<input type="hidden" id="productNo" value=\"' + productNo + '\">'
            tmp += '<h3>상품명</h3></div><div class="admin-item">'
            tmp += '<input type="text" id="productName" value=\"' + productName + '\">'
            tmp += '</div></div><hr />'
            tmp += '<div class="admin-admin-condition"><div class="admin-item"><h3>가격</h3></div>'
            tmp += '<div class="admin-item">'
            tmp += '<input type="text" id="productPrice" value=\"' + productPrice + '\">'
            tmp += '</div></div><hr />'
            tmp += '<div class="admin-admin-condition">'
            tmp += '<div class="admin-item">'
            tmp += '<h3>재고</h3></div><div class="admin-item">'
            tmp += '<input type="text" id="productStock" value=\"' + productStock + '\">'
            tmp += '</div></div>'
            return tmp;
        }

        // 2-2. 모달창 출력
        $("#myModal").css("display", "block")
        // body의 overflow 속성 숨김
        $("body").css("overflow", "hidden");

        // 3. AJAX 모달 내용 DB 반영
        $("#registerBtn").on("click", function () {
            // body의 overflow 속성 활성화
            $("body").css("overflow", "visible");
            let jsonData = {};
            jsonData.productNo = $("#productNo").val();
            jsonData.productName = $("#productName").val()
            jsonData.productPrice = $("#productPrice").val()
            jsonData.productStock = $("#productStock").val()
            jsonData.productImgPath = $("#thumbnailPreview").children().attr("data-url")
            let productImgDtoList = []
            $("#detailPreview").children().each(function () {
                let tmp = {}
                tmp.productNo = $("#productNo").val();
                tmp.uploadPath = $(this).attr("data-url")
                productImgDtoList.push(tmp)
            })
            jsonData.productImgDtoList = productImgDtoList
            $.ajax({
                type: "PATCH",            // HTTP method type(GET, POST) 형식이다.
                url: "/muscles/admin/product/", // 컨트롤러에서 대기중인 URL 주소이다.
                headers: {              // Http header
                    "Content-Type": "application/json",
                },
                data: JSON.stringify(jsonData),
                success: function () {
                    alert("수정 완료")
                    loadProductData()
                },
                error: function () {
                    alert("AJAX 통신 실패")
                }
            })
            $("#myModal").css("display", "none")
        })
    })
    // 모달 닫기
    $("#closeBtn").on("click", function () {
        // 기존 modal data 초기화
        $("#thumbnailPreview").children().remove()
        $("#detailPreview").children().remove()
        // body의 overflow 속성 활성화
        $("body").css("overflow", "visible");
        $("#myModal").css("display", "none")
    })
</script>
<script>
    function showPreview(items, type) {
        let tmp = "";
        items.forEach(function (item) {
            let addr = "/muscles/product/display?type=" + type + "&fileName=" + item.uploadName
            tmp += '<div data-type=' + type + ' data-url=' + item.uploadName + '>'
            tmp += '<input class="delPreview" type="button" value="X">'
            tmp += '<img style="height: 200px; width: 200px" src="' + addr + '">'
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
<!-- footer -->
<%@ include file="../footer.jsp" %>