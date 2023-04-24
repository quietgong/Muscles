<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ include file="../nav.jsp" %>
<div class="container">
    <div class="row mt-5 justify-content-center">
        <div class="col-md-8">
            <label class="form-label" for="title">제목</label>
            <input required class="form-control" id="title" type="text" placeholder="제목을 입력해주세요">
            <label class="form-label mt-3" for="content">내용</label>
            <textarea class="form-control mt-1" required id="content" rows="20" cols="80"
                      placeholder="내용을 입력해주세요"></textarea>
            <label for="postImg" class="form-label text-center mt-3">이미지 업로드</label>
            <input type="file" onchange='uploadImg("/muscles/img/${postCategory}/detail/0", this)' multiple class="form-control" id="postImg" name='uploadFile'>
            <div id="postPreview" class="row flex-nowrap" style="overflow-x: auto">
            </div>
        </div>
        <div class="col-md-8 mt-5 text-center">
            <button class="btn btn-lg btn-outline-primary" onclick="postRegister(this)" type="submit">완료</button>
        </div>
    </div>
</div>
<!-- footer -->
<script>
    function postRegister() {
        if($("#title").val().length===0 || $("#content").val()===''){
            alert("제목과 내용을 입력해주시기 바랍니다.")
            return;
        }
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
        commonAjax("/muscles/${postCategory}/", postDto, "POST", function (res) {
            location.href = "/muscles/${postCategory}/"+res
        })
    }
</script>
<script src="<c:url value='/js/custom/image.js'/>"></script>
<script>
    function showPreview(items, type) {
        let tmp = "";
        items.forEach(function (item) {
            let addr = "/muscles/img/display?category=${postCategory}&type=" + type + "&fileName=" + item.uploadName
            tmp += '<div class="detail col-md-3" data-type=' + type + ' data-url=' + item.uploadName + '>'
            tmp += '<button class="delPreview btn btn-danger mb-3 mt-3" type="button">X</button>'
            tmp += '<button style="float: right" class="down btn btn-warning mb-3 mt-3" type="button">→</button>'
            tmp += '<button style="float: right; margin-right: 10px" class="up btn btn-warning mb-3 mt-3" type="button">←</button>'
            tmp += '<img class="img-fluid newDetail" src="' + addr + '">'
            tmp += '</div>'
        });
        $("#postPreview").append(tmp)
        showLeftRightBtn()
    }
</script>
<%@ include file="../footer.jsp" %>
