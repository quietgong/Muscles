<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ include file="../nav.jsp" %>
<div class="container">
    <div class="row mt-5">
        <div class="col-md-12">
            <div class="mb-3">
                <label class="form-label" for="title">제목</label>
                <input required class="form-control" id="title"type="text" placeholder="제목을 입력해주세요">
            </div>
        </div>
    </div>
    <div class="row mt-5">
        <div class="col-md-12">
            <div class="mb-3">
                    <textarea class="form-control mt-1" required id="content" rows="20" cols="80"
                              placeholder="내용을 입력해주세요"></textarea>
            </div>
        </div>
    </div>
    <div class="row mt-3">
        <div class="col-md-12">
            <label for="postImg" class="form-label text-center">이미지 업로드</label>
            <input type="file" multiple class="form-control" id="postImg" name='uploadFile'>
        </div>
    </div>
    <div id="postPreview" class="row flex-nowrap" style="overflow-x: auto">
    </div>
    <div class="row mt-5">
        <div class="col-md-2">
            <button class="btn btn-lg btn-outline-primary" onclick="postRegister(this)" type="submit">완료</button>
        </div>
    </div>
</div>
<!-- footer -->
<script>
    // 이미지 업로드
    $("input[type='file']").on("change", function () {
        let fileList = $(this)[0].files;
        let formData = new FormData();
        for (let i = 0; i < fileList.length; i++)
            formData.append("uploadFile", fileList[i]);
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/muscles/img/${postCategory}/detail/0",
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
        console.log(items)
        let tmp = "";
        items.forEach(function (item) {
            let addr = "/muscles/img/display?category=${postCategory}&type=" + type + "&fileName=" + item.uploadName
            tmp += '<div class="detail col-md-2" data-type=' + type + ' data-url=' + item.uploadName + '>'
            tmp += '<button class="delPreview btn btn-danger mb-3 mt-3" type="button">X</button>'
            tmp += '<button style="float: right" class="down btn btn-warning mb-3 mt-3" type="button">→</button>'
            tmp += '<button style="float: right; margin-right: 10px" class="up btn btn-warning mb-3 mt-3" type="button">←</button>'
            tmp += '<img class="img-fluid newDetail" src="' + addr + '">'
            tmp += '</div>'
        });
        $("#postPreview").append(tmp)
        showLeftRightBtn()
    }
    function showLeftRightBtn() {
        // 첫번째 div Left 버튼 숨기기
        $("button:contains('←')").show()
        $('.detail:first-child button:contains("←")').hide();
        // 마지막 div Right 버튼 숨기기
        $("button:contains('→')").show()
        $('.detail:last-child button:contains("→")').hide();
    }
    // Left 버튼 클릭 시 이전 div와 위치 변경
    $(document).on("click", '.detail button:contains("←")', function (){
        let currentDiv = $(this).parent();
        let prevDiv = currentDiv.prev('.detail');
        if (prevDiv.length !== 0)
            currentDiv.insertBefore(prevDiv);
        showLeftRightBtn()
    });
    // Right 버튼 클릭 시 다음 div와 위치 변경
    $(document).on("click", '.detail button:contains("→")', function (){
        let currentDiv = $(this).parent();
        let nextDiv = currentDiv.next('.detail');
        if (nextDiv.length !== 0)
            currentDiv.insertAfter(nextDiv);
        showLeftRightBtn()
    });

    function deleteImg(target, type, fileName) {
        let targetDiv = target
        $.ajax({
            type: "DELETE",
            enctype: 'multipart/form-data',
            url: "/muscles/img/delete/post/detail?fileName=" + fileName,
            success: function (res) {
                console.log(res)
                // 파일 삭제가 성공적으로 이루어지면
                if (res === "DEL_OK") {
                    targetDiv.empty();
                }
            }
        })
    }
    <!-- 업로드된 이미지 삭제 -->
    $(document).on("click", ".delPreview", function () {
        let fileName = $(this).parent().attr("data-url")
        let target = $(this).parent()
        deleteImg(target, "detail", fileName)
    });
    function postRegister() {
        let postDto = {}
        postDto.type = '${postCategory}'
        postDto.userId = '${userId}'
        postDto.title = $("#title").val()
        postDto.content = $("#content").val()
        let postImgDtoList = []
        $('.newDetail').each(function () {
            let tmp = {}
            tmp.uploadPath = $(this).attr("src")
            postImgDtoList.push(tmp)
        });
        postDto.postImgDtoList = postImgDtoList

        $.ajax({
            type: "POST",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/${postCategory}/",
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            data: JSON.stringify(postDto),
            success: function (postNo) {
                location.href = "/muscles/${postCategory}/"+postNo
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    }
</script>
<%@ include file="../footer.jsp" %>
