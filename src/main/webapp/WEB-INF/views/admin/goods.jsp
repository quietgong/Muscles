<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="false" %>
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
                    <!-- 검색 조건 -->
                    <form>
                        <div class="input-group flex-nowrap">
                            <span class="input-group-text" id="addon-wrapping">상품명</span>
                            <input class="form-control">
                            <button type="submit" class="btn btn-primary">검색</button>
                        </div>
                    </form>
                    <!-- 검색 조건 -->
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-md-12">
                    <button style="float: right" type="button" data-bs-toggle="modal" data-bs-target="#staticBackdrop"
                            name="modBtn" onclick="$('#staticBackdropLabel').html('상품정보 등록');$('#goodsNo').val(0);"
                            class="btn btn-outline-primary btn-lg">상품 등록
                    </button>
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th scope="col">이름</th>
                            <th scope="col">대분류</th>
                            <th scope="col">소분류</th>
                            <th scope="col">가격(₩)</th>
                            <th scope="col">재고</th>
                            <th scope="col">평점</th>
                            <th scope="col">누적 판매량</th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                        </tr>
                        </thead>
                        <tbody id="goodsList"><!-- 동적 요소 추가--></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">상품정보 변경</h5>
                <button type="button" onclick="initModal()" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <input id="goodsNo" type="hidden" value="">
                            <label class="form-label">상품명</label>
                            <input id="goodsName" type="text" class="form-control" placeholder="상품명을 입력하세요" value="">
                        </div>
                        <div class="col-md-6 mt-3">
                            <label class="form-label">대분류</label>
                            <select id="categorySelect" class="form-select" aria-label="Default select example">
                                <option value="">대분류를 선택하세요</option>
                                <option value="유산소">유산소</option>
                                <option value="근력">근력</option>
                                <option value="기타">기타</option>
                            </select>
                        </div>
                        <div class="col-md-6 mt-3">
                            <label class="form-label">소분류</label>
                            <select id="categoryDetailSelect" class="form-select" aria-label="Default select example">
                                <option value="">소분류를 선택하세요</option>
                                <!-- 대분류에 대한 소분류 셀렉트 리스트 출력-->
                            </select>
                            <input style="display: none" id="newCategory" type="text" class="form-control mt-2"
                                   placeholder="카테고리 입력">
                        </div>
                        <div class="col-md-12 mt-3">
                            <label class="form-label">가격(₩)</label>
                            <input id="goodsPrice" type="text" class="form-control" placeholder="가격을 입력하세요" value="">
                        </div>
                        <div class="col-md-12 mt-3">
                            <label class="form-label">재고</label>
                            <input id="goodsStock" type="text" class="form-control" placeholder="재고를 입력하세요" value="">
                        </div>
                        <div class="col-md-12 mt-3">
                            <textarea id="goodsDescription" class="form-control mt-1" placeholder="상품 설명을 작성해주세요."
                                      rows="5"
                                      cols="50"></textarea>
                        </div>
                    </div>
                    <div class="row mt-5">
                        <div class="col-md-12">
                            <label for="thumbnail">상품 썸네일</label>
                            <input type="file" class="form-control" id="thumbnail" name='uploadFile'>
                            <div id="thumbnailPreview"></div>
                        </div>
                    </div>
                    <div class="row mt-5">
                        <div class="col-md-12">
                            <label for="detail">상품 소개 이미지</label>
                            <input type="file" class="form-control" multiple id="detail" name='uploadFiles'>
                            <div id="detailPreview"></div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button onclick="submit()" type="button" id="registerBtn" class="btn btn-secondary"
                            data-bs-dismiss="modal">등록
                    </button>
                    <button type="button" onclick="initModal()" id="closeBtn" class="btn btn-primary"
                            data-bs-dismiss="modal">닫기
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<script>
    // 모달창 close 내용 초기화
    function initModal() {
        $("#goodsNo").val("")
        $("#goodsName").val("")
        $(".subCategory").hide()
        $('#categoryDetailSelect option').eq(0).prop('selected', true)
        $('#categorySelect option').eq(0).prop('selected', true)
        $("#goodsPrice").val("")
        $("#goodsStock").val("")
        $("#goodsDescription").val("")
        $("#thumbnailPreview").html("")
        $("#detailPreview").html("")
    }

    // 수정 버튼 클릭 시 해당 상품 정보 모달창에 입력
    function insertModal(goodsNo) {
        $('#staticBackdropLabel').html('상품정보 변경');
        commonAjax("/muscles/admin/goods/" + goodsNo, null, "GET", function (res) {
            $("#goodsNo").val(res.goodsNo)
            $("#goodsName").val(res.goodsName)
            categoryDetailDisplay(res.goodsCategory)
            $('#categorySelect option[value=' + res.goodsCategory + ']').prop('selected', true);
            $('#categoryDetailSelect option[value=' + res.goodsCategoryDetail + ']').prop('selected', true);
            $("#goodsPrice").val(res.goodsPrice)
            $("#goodsStock").val(res.goodsStock)
            $("#goodsDescription").val(res.goodsDescription)
            if (res.goodsImgPath != null)
                showPreview([{uploadName: res.goodsImgPath.split("&").filter(item => item.includes("fileName"))[0].split("=")[1]}], 'thumbnail')
            if (res.goodsImgDtoList.length !== 0) {
                let items = []
                res.goodsImgDtoList.forEach(function (r) {
                    let tmp = {}
                    tmp.uploadName = r.uploadPath.split("&").filter(item => item.includes("fileName"))[0].split("=")[1]
                    items.push(tmp)
                })
                showPreview(items, 'detail')
            }
        })
    }

    function modifyGoods(data) {
        commonAjax("/muscles/admin/goods/", data, "PATCH", function () {
            alert("수정 완료")
            loadProductData()
            initModal()
        })
    }

    function registerGoods(data) {
        commonAjax("/muscles/admin/goods/", data, "POST", function (res) {
            if (res === "ADD_OK") {
                alert("등록 완료")
                loadProductData()
                initModal()
            } else
                alert("등록 실패")
        })
    }

    // 모달창 내부에서 "등록(수정완료)" 버튼 클릭
    function submit() {
        let data = {};
        let goodsImgDtoList = []

        $('.newDetail').each(function () {
            let tmp = {}
            tmp.goodsNo = $("#goodsNo").val()
            tmp.uploadPath = $(this).attr("src")
            goodsImgDtoList.push(tmp)
        });
        data.goodsNo = $("#goodsNo").val();
        data.goodsName = $("#goodsName").val()
        data.goodsCategory = $('#categorySelect option:selected').val()
        data.goodsCategoryDetail = $('#categoryDetailSelect option:selected').val() === 'new' ? $("#newCategory").val() : $('#categoryDetailSelect option:selected').val()
        data.goodsDescription = $("#goodsDescription").val()
        data.goodsPrice = $("#goodsPrice").val()
        data.goodsStock = $("#goodsStock").val()
        data.goodsImgPath = $("#newThumbnail").attr("src")
        data.goodsImgDtoList = goodsImgDtoList
        // 상품 번호 데이터가 있으면 수정, 없으면 등록
        data.goodsNo === '0' ? registerGoods(data) : modifyGoods(data)
    }
</script>
<script>
    // 이미지 업로드
    $("input[type='file']").on("change", function () {
        let type = $(this).attr("id");
        let fileList = $(this)[0].files;
        if (type === 'thumbnail') {
            if (fileList.length > 1) {
                deleteImg($(this).next().children(), "thumbnail", $(this).next().children().attr("data-url"))
            }
        }
        let formData = new FormData();
        for (let i = 0; i < fileList.length; i++)
            formData.append("uploadFile", fileList[i]);
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/muscles/img/goods/" + type + "/" + $("#goodsNo").val(),
            processData: false,
            contentType: false,
            data: formData,
            dataType: 'json',
            success: function (items) {
                showPreview(items, type)
            }
        })
    });

    function showPreview(items, type) {
        let tmp = "";
        items.forEach(function (item) {
            let addr = "/muscles/img/display?category=goods&type=" + type + "&fileName=" + item.uploadName
            tmp += '<div class="detail" data-type=' + type + ' data-url=' + item.uploadName + '>'
            tmp += '<button class="delPreview btn btn-danger mb-3 mt-3" type="button">X</button>'
            if (type === 'thumbnail')
                tmp += '<img class="img-fluid" id="newThumbnail" src="' + addr + '">'
            else {
                tmp += '<button style="float: right" class="down btn btn-warning mb-3 mt-3" type="button">↓</button>'
                tmp += '<button style="float: right; margin-right: 10px" class="up btn btn-warning mb-3 mt-3" type="button">↑</button>'
                tmp += '<img class="img-fluid newDetail" src="' + addr + '">'
            }
            tmp += '</div>'
        });
        type === "detail" ? $("#detailPreview").append(tmp) : $("#thumbnailPreview").append(tmp);
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
        // Up 버튼 클릭 시 이전 div와 위치 변경
        $('.detail button:contains("↑")').click(function () {
            let currentDiv = $(this).parent();
            let prevDiv = currentDiv.prev('.detail');
            if (prevDiv.length !== 0)
                currentDiv.insertBefore(prevDiv);
            showUpDownBtn()
        });
        // Down 버튼 클릭 시 다음 div와 위치 변경
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
        let type = $(this).parent().attr("data-type")
        let target = $(this).parent()
        deleteImg(target, type, fileName)
    });

    function deleteImg(target, type, fileName) {
        let targetDiv = target
        commonAjax("/muscles/img/delete/goods/" + type + "?fileName=" + fileName, null, "DELETE",
            function (res) {
                if (res === "DEL_OK") targetDiv.empty();// 파일 삭제가 성공적으로 이루어지면
            })
    }
</script>
<script>
    // 상품 정보 읽기
    loadProductData()

    function loadProductData() {
        commonAjax("/muscles/admin/goods/", data, "GET", function (res) {
            $("#goodsList").empty()
            $("#goodsList").append(toHtml(res))
        })
        let toHtml = function (items) {
            let tmp = "";
            items.forEach(function (item) {
                tmp += '<tr>'
                tmp += '<td>' + item.goodsName + '</td>'
                tmp += '<td>' + item.goodsCategory + '</td>'
                tmp += '<td>' + item.goodsCategoryDetail + '</td>'
                tmp += '<td>' + item.goodsPrice.toLocaleString() + '</td>'
                tmp += '<td>' + item.goodsStock + '</td>'
                tmp += '<td>' + item.goodsReviewScore + '</td>'
                tmp += '<td>' + item.goodsSales + '</td>'
                tmp += '<td><button type="button" data-bs-toggle="modal" data-bs-target="#staticBackdrop" name="modBtn" class="btn btn-primary" onclick="insertModal(' + item.goodsNo + ')">수정</button></td>'
                tmp += '<td><button type="button" name="delBtn" class="btn btn-danger" onclick="removeProduct(' + item.goodsNo + ')">삭제</button></td>'
                tmp += '</tr>'
            })
            return tmp;
        }
    }
</script>
<script>
    // 상품 정보 삭제
    function removeProduct(goodsNo) {
        if (!confirm("정말로 삭제하시겠습니까?")) return;
        commonAjax("/muscles/admin/goods/" + goodsNo, null, "DELETE", function () {
            alert("해당 상품 정보를 삭제하였습니다.")
            loadProductData()
        })
    }
</script>
<script>
    loadCategory()

    function loadCategory() {
        commonAjax("/muscles/goods/category", null, "GET", function (items) {
            let tmp = "";
            items.forEach(function (item) {
                tmp += '<option class="subCategory" style="display:none" name=' + item.category + ' value="' + item.subCategory + '">' + item.subCategory + '</option>'
            })
            tmp += '<option class="subCategory" style="display: none" name="new" value="new">신규 카테고리 생성</option>'
            $("#categoryDetailSelect").append(tmp)
        })
    }

    function categoryDetailDisplay(value) {
        $(".subCategory").hide()
        if (value !== '') {
            if (value === '유산소')
                $("option[name='유산소']").show()
            else if (value === '근력')
                $("option[name='근력']").show()
            else
                $("option[name='기타']").show()
            $("option[name='new']").show()
        } else
            $('#categoryDetailSelect option').eq(0).prop('selected', true)
    }

    $("#categorySelect").on("change", function () {
        categoryDetailDisplay(this.value)
    })
    // 신규 카테고리 입력 창
    $("#categoryDetailSelect").on("change", function () {
        this.value === 'new' ? $("#newCategory").show() : $("#newCategory").hide()
    })
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>