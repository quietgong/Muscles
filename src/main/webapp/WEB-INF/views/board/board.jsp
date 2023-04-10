<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<%@ include file="nav.jsp" %>
<div class="container">
    <div class="row mt-5">
        <div class="col-md-12">
            <div class="mb-3">
                <label class="form-label" for="title">제목</label>
                <input id="title" class="form-control" type="text" name="title" readonly value="${postDto.title}">
            </div>
        </div>
    </div>
    <div class="row mt-2">
        <div class="col-md-12">
            <div class="mb-3">
                <label class="form-label" for="writer">작성자 (작성일자 : <fmt:formatDate value="${postDto.createdDate}"
                                                                                   pattern="yyyy-MM-dd"
                                                                                   type="date"/>)</label>
                <input id="writer" class="form-control" type="text" name="title" readonly value="${postDto.userId}">
            </div>
        </div>
    </div>
    <div class="row mt-3">
        <div class="col-md-12">
            <textarea readonly id="board_textarea" class="form-control mt-1" name="content" rows="20"
                      cols="80">${postDto.content}</textarea>
        </div>
    </div>
    <input id="commentList" type="hidden">
    <!-- 댓글 -->
    <div class="row mt-5">
        <div class="col-md-12" style="text-align: right">
            <button onclick='location.href="<c:url
                    value='/${postCategory}?page=${param.page}&option=${param.option}&keyword=${param.keyword}'/>"'
                    class="btn btn-lg btn-outline-primary" type="button">목록
            </button>
            <%--            <c:if test="${userId == postDto.userId}">--%>
            <button id="modify" class="btn btn-lg btn-primary" type="button">수정</button>
            <button id="remove" class="btn btn-lg btn-primary" type="button">삭제</button>
            <%--            </c:if>--%>
        </div>
    </div>
</div>

<script src="https://cdn.ckeditor.com/ckeditor5/36.0.1/classic/ckeditor.js"></script>
<script>
    // 글 수정
    $("#modify").on("click", function () {
        let isReadOnly = $("textarea[name=content]").attr("readonly");
        // 글 수정 시작
        if (isReadOnly === "readonly") {
            // 에디터로 전환
            ClassicEditor
                .create(document.querySelector('#board_textarea'))
                .then(editor => {
                    editor.getData(${postDto.content})
                    editor.ui.view.editable.element.style.minHeight = '500px';
                })
                .catch(error => {
                    console.error(error);
                });
            $("#modifyPost").html("등록");
            $("#writer").attr("readonly", true)
            $("input[name=title]").attr("readonly", false);
            $("textarea[name=content]").attr("readonly", false);
        }
        // 글 수정 완료
        else {
            let modData = {}
            modData.postNo = postNo
            modData.userId = '${userId}'
            modData.title = $("input[name=title]").val()
            modData.content = $("textarea[name=content]").val()
            $.ajax({
                type: "PATCH",
                url: "/muscles/${postCategory}",
                headers: {              // Http header
                    "Content-Type": "application/json",
                },
                data: JSON.stringify(modData),
                success: function (res) {
                    if (res === "MOD_OK")
                        // 수정 성공 시, 새로 고침
                        location.reload()
                },
                error: function () {
                    console.log("수정 실패")
                }
            });
        }
    });

    // 글 삭제
    $("#remove").on("click", function () {
        if (!confirm("정말로 삭제하시겠습니까?")) return;
        $.ajax({
            type: "DELETE",
            url: "/muscles/${postCategory}/" + postNo,
            success: function (res) {
                if (res === "DEL_OK")
                    // 삭제 성공 시, 해당 게시판 목록으로 이동
                    location.href = "<c:url value='/${postCategory}'/>"
            },
            error: function () {
                console.log("삭제 실패")
            }
        });
    });
</script>
<script>
    // 댓글 기능
    let postNo = ${postDto.postNo};
    // 댓글 불러오기
    loadComments()

    function loadComments() {
        $.ajax({
            type: "GET",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/comments?postNo=" + postNo, // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function (res) {
                $("#commentList").after(toHtml(res))
            },
            error: function () {
                alert("AJAX 통신 실패")
            }
        })
    }

    // 댓글 생성
    $("#createComment").on("click", function () {
        let userId = '${userId}';
        let content = $("#inputComment").val()
        $.ajax({
            type: "POST",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/comments/", // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            data: JSON.stringify({
                userId: userId,
                postNo: postNo,
                content: content
            }),
            success: function () {
                loadComments()
            },
            error: function () {
                alert("AJAX 통신 실패")
            }
        })
        $("#inputComment").val("")
    })
    // 댓글 삭제
    $("#commentList").on("click", ".delBtn", function () {
        let commentNo = $(this).parent().attr('data-commentno')
        $.ajax({
            type: "DELETE",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/comments/" + commentNo,
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function () {
                loadComments()
            },
            error: function () {
                alert("AJAX 통신 실패")
            }
        })
    })

    // 댓글 수정
    $("#commentList").on("click", ".modBtn", function () {
        let commentNo = $(this).parent().attr('data-commentNo')
        $("#createComment").hide()
        $("#modifyComment").show()
        let content = $(this).parent().children('.comment').text()
        $("#inputComment").val(content)

        $("#modifyComment").on("click", function () {
            let content = $("#inputComment").val()
            let data = {content: content}

            $.ajax({
                type: "PATCH",            // HTTP method type(GET, POST) 형식이다.
                url: "/muscles/comments/" + commentNo,
                headers: {              // Http header
                    "Content-Type": "application/json",
                },
                data: JSON.stringify(data),
                success: function () {
                    loadComments()
                },
                error: function () {
                    alert("AJAX 통신 실패")
                }
            })
            $("#createComment").show()
            $("#modifyComment").hide()
            $("#inputComment").val("")
        })
    })

    let toHtml = function (comments) {
        let tmp = "";
        comments.forEach(function (comment) {
            tmp += '<div class="row">'
            tmp += '<div class="col-md-12" data-commentNo=' + comment.commentNo + ' data-postNo=' + comment.postNo + '>'
            tmp += '<div class="mb-0" style="border: 1px solid #e2e3e5">'
            tmp += '<span style="font-weight: bold" class="commenter">' + comment.userId + '</span>'
            tmp += '<button style="float: right" type="button" class="delBtn btn btn-outline-primary">삭제</button>'
            tmp += '<button style="float: right" type="button" class="modBtn btn btn-outline-primary">수정</button>'
            tmp += ' <p style="font-style: italic" class="comment">' + comment.content + '</p>'
            if (comment.createdDate === comment.modDate)
                tmp += ' <p style="font-weight: bold" class="commentDate">' + comment.createdDate
            else
                tmp += ' |  <p class="commentDate">' + comment.modDate + "(수정됨)"
            tmp += '</p>'
            tmp += '</div>'
            tmp += '</div>'
            tmp += '</div>'
        })
        tmp += '<div class="input-group mb-3">'
        tmp += '<input style="background-color: #ced4da" id="inputComment" class="form-control" type="text" placeholder="댓글을 입력하세요">'
        tmp += '<button id="createComment" type="button" class="btn btn-outline-primary">댓글 등록</button>'
        tmp += '</div>'
        return tmp;
    }
</script>
<!-- footer -->
<%@ include file="footer.jsp" %>