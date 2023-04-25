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
            <input type="file" onchange='uploadImg("/muscles/img/post/detail/0", this, "post", "detail")'
                   multiple class="form-control" id="postImg" name='uploadFile'>
            <div id="detailPreview" class="row flex-nowrap" style="overflow-x: auto">
                <!-- 미리보기 사진 출력 영역 -->
            </div>
        </div>
        <div class="col-md-8 mt-5 text-center">
            <button class="btn btn-lg btn-outline-primary" onclick="postRegister(this)" type="submit">완료</button>
        </div>
    </div>
</div>
<script>
    function postRegister() {
        if($("#title").val().length===0 || $("#content").val()===''){
            alert("제목 또는 내용을 입력해주시기 바랍니다.")
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
            tmp.fileName = $(this).parent().attr("data-fileName")
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
<%@ include file="../footer.jsp" %>
