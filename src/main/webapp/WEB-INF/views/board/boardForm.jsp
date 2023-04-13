<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ include file="../nav.jsp" %>
<form method="post">
    <input type="hidden" name="postCategory" value="${postCategory}">
    <input type="hidden" name="userId" value="${userId}">
    <div class="container">
        <div class="row mt-5">
            <div class="col-md-12">
                <div class="mb-3">
                    <label class="form-label" for="title">제목</label>
                    <input required class="form-control" name="title" type="text" placeholder="제목을 입력해주세요">
                </div>
            </div>
        </div>
        <div class="row mt-5">
            <div class="col-md-12">
                <div class="mb-3">
                    <textarea class="form-control mt-1" required name="content" rows="20" cols="80"
                              placeholder="내용을 입력해주세요"></textarea>
                </div>
            </div>
        </div>
        <div class="row mt-5">
            <div class="col-md-12" style="text-align: center">
                <button class="w-50 btn btn-lg btn-outline-primary" type="submit">완료</button>
            </div>
        </div>
    </div>
</form>
<!-- footer -->
<%@ include file="../footer.jsp" %>
