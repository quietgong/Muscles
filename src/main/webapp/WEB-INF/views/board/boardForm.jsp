<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ include file="../nav.jsp" %>
<input type="hidden" name="postCategory" value="${postCategory}">
<form action="<c:url value='/${postCategory}'/>" method="post">
<div class="container">
    <div class="row mt-5">
        <div class="col-md-12">
            <div class="mb-3">
                <label class="form-label" for="title">제목</label>
                 <input id="title" class="form-control" name="title" type="text" placeholder="제목을 입력해주세요">
            </div>
        </div>
    </div>
    <div class="row mt-5">
        <div class="col-md-12">
        <textarea id="board_textarea" name="content" rows="20" cols="80" placeholder="내용을 입력해주세요"></textarea>
        </div>
    </div>
    <div class="row mt-5">
        <div class="col-md-12" style="text-align: center">
            <button class="w-50 btn btn-lg btn-outline-primary" type="submit">완료</button>
        </div>
    </div>
</div>
</form>
<script src="https://cdn.ckeditor.com/ckeditor5/36.0.1/classic/ckeditor.js"></script>
<script>
    ClassicEditor
        .create(document.querySelector('#board_textarea'))
        .then( editor => {
            editor.ui.view.editable.element.style.minHeight = '500px';
        } )
        .catch(error=>{
            console.error(error);
        });
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>
