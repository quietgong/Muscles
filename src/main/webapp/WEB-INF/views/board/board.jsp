<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<%@ include file="../nav.jsp" %>
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
                <input id="writer" class="form-control" type="text" name="userId" readonly value="${postDto.userId}">
            </div>
        </div>
    </div>
</div>
<div class="container form-control">
    <div class="row mt-3">
        <div class="col-md-12">
            <textarea readonly class="form-control mt-1" name="content" rows="20"
                      cols="80">${postDto.content}</textarea>
        </div>
    </div>

    <div style="display: none" id="uploadImg" class="row mt-3">
        <div class="col-md-12">
            <label for="postImg" class="form-label text-center">이미지 업로드</label>
            <input type="file" multiple class="form-control" id="postImg" name='uploadFile'>
        </div>
    </div>
    <div id="postPreview" class="row flex-nowrap" style="overflow-x: auto">
        <c:forEach var="postImgDto" items="${postDto.postImgDtoList}">
            <div class="detail col-md-2" data-type="detail" data-url="${postImgDto.uploadPath}">
                <button style="display:none;" class="delPreview modPosition btn btn-danger mb-3 mt-3" type="button">X
                </button>
                <button style="display:none; float: right" class="modPosition down btn btn-warning mb-3 mt-3"
                        type="button">→
                </button>
                <button style="display:none; float: right; margin-right: 10px"
                        class="modPosition up btn btn-warning mb-3 mt-3" type="button">←
                </button>
                <img src="${postImgDto.uploadPath}" class="img-fluid newDetail">
            </div>
        </c:forEach>
    </div>
</div>
<div class="container">
    <input id="commentList" type="hidden">
    <div class="input-group mt-2 mb-3">
        <input style="background-color: #e9eff5" id="inputComment" class="form-control" type="text"
               placeholder="댓글을 입력하세요">
        <button id="registerComment" onclick="registerComment()" type="button" class="btn btn-outline-primary">댓글 등록
        </button>
        <button style="display: none" id="modifyComment" type="button" class="btn btn-outline-primary">수정</button>
        <button style="display: none" id="modifyCancel" type="button" class="btn btn-outline-danger">취소</button>
    </div>
    <!-- 댓글 -->
    <div class="row mt-5">
        <div class="col-md-12" style="text-align: right">
            <c:choose>
                <c:when test="${param.page eq null}">
                    <button class="btn btn-lg btn-outline-primary" type="button" onclick='location.href="<c:url
                            value='/${postCategory}?page=1&option=${param.option}&keyword=${param.keyword}'/>"'>목록
                    </button>
                </c:when>
                <c:otherwise>
                    <button class="btn btn-lg btn-outline-primary" type="button" onclick='location.href="<c:url
                            value='/${postCategory}?page=${param.page}&option=${param.option}&keyword=${param.keyword}'/>"'>
                        목록
                    </button>
                </c:otherwise>
            </c:choose>
            <c:if test="${userId == postDto.userId}">
                <button id="modify" class="btn btn-lg btn-primary" type="button">수정</button>
                <button id="remove" class="btn btn-lg btn-primary" type="button">삭제</button>
            </c:if>
        </div>
    </div>
</div>
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
            tmp += '<div class="detail col-md-2" data-type=' + type + ' data-url=' + addr + '>'
            tmp += '<button class="delPreview btn btn-danger mb-3 mt-3" type="button">X</button>'
            tmp += '<button style="float: right" class="down btn btn-warning mb-3 mt-3" type="button">→</button>'
            tmp += '<button style="float: right; margin-right: 10px" class="up btn btn-warning mb-3 mt-3" type="button">←</button>'
            tmp += '<img class="img-fluid newDetail" src="' + addr + '">'
            tmp += '</div>'
        });
        $("#postPreview").append(tmp)
        showLeftRightBtn()
    }

    // Left 버튼 클릭 시 이전 div와 위치 변경
    $(document).on("click", '.detail button:contains("←")', function () {
        let currentDiv = $(this).parent();
        let prevDiv = currentDiv.prev('.detail');
        if (prevDiv.length !== 0)
            currentDiv.insertBefore(prevDiv);
        showLeftRightBtn()
    });
    // Right 버튼 클릭 시 다음 div와 위치 변경
    $(document).on("click", '.detail button:contains("→")', function () {
        let currentDiv = $(this).parent();
        let nextDiv = currentDiv.next('.detail');
        if (nextDiv.length !== 0)
            currentDiv.insertAfter(nextDiv);
        showLeftRightBtn()
    });

    function showLeftRightBtn() {
        // 첫번째 div Left 버튼 숨기기
        $("button:contains('←')").show()
        $('.detail:first-child button:contains("←")').hide();
        // 마지막 div Right 버튼 숨기기
        $("button:contains('→')").show()
        $('.detail:last-child button:contains("→")').hide();
    }

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
</script>
<script>
    // 글 수정
    $("#modify").on("click", function () {
        let isReadOnly = $("textarea[name=content]").attr("readonly");
        // 글 수정 시작
        if (isReadOnly === "readonly") {
            $("#modify").html("등록");
            $("#remove").hide()
            $("input[name=title]").attr("readonly", false);
            $("textarea[name=content]").attr("readonly", false);
            $("#uploadImg").show()
            $(".modPosition").show()
            showLeftRightBtn()
        }
        // 글 수정 완료
        else {
            let modData = {}
            modData.postNo = postNo
            modData.userId = '${userId}'
            modData.title = $("input[name=title]").val()
            modData.content = $("textarea[name=content]").val()
            let postImgDtoList = []
            $('.newDetail').each(function () {
                let tmp = {}
                tmp.postNo = postNo
                tmp.uploadPath = $(this).attr("src")
                postImgDtoList.push(tmp)
            });
            modData.postImgDtoList = postImgDtoList
            $.ajax({
                type: "PATCH",
                url: "/muscles/${postCategory}/" + postNo,
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
                $(".comment-area").remove()
                $("#commentList").after(toHtml(res))
            },
            error: function () {
                alert("AJAX 통신 실패")
            }
        })
    }

    // 댓글 생성
    function registerComment() {
        let userId = '${userId}';
        let content = $("#inputComment").val()
        if (content === '') {
            alert("댓글을 입력해주시기 바랍니다.")
            return;
        }
        $.ajax({
            type: "POST",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/comments", // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            data: JSON.stringify({
                userId: userId, postNo: postNo, content: content
            }),
            success: function () {
                loadComments()
            },
            error: function () {
                alert("AJAX 통신 실패")
            }
        })
        $("#inputComment").val("")
    }

    // 댓글 삭제
    $(document).on("click", ".delBtn", function () {
        if (!confirm("정말로 삭제하시겠습니까?")) return;
        let commentNo = $(this).parent().parent().attr('data-commentno')
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
    $(document).on("click", ".modBtn", function () {
        $("#registerComment").hide()
        $("#modifyComment").show()
        $("#modifyCancel").show()
        document.body.scrollTop = document.body.scrollHeight;
        let commentNo = $(this).parent().parent().attr('data-commentNo')
        let content = $(this).parent().children('.comment').text()
        $("#inputComment").val(content)

        $(document).on("click", "#modifyComment", function () {
            let content = $("#inputComment").val()
            let data = {commentNo: commentNo, content: content}
            $.ajax({
                type: "PATCH",            // HTTP method type(GET, POST) 형식이다.
                url: "/muscles/comments",
                headers: {              // Http header
                    "Content-Type": "application/json",
                },
                data: JSON.stringify(data),
                success: function () {
                    $("#registerComment").show()
                    $("#modifyComment").hide()
                    $("#modifyCancel").hide()
                    loadComments()
                },
                error: function () {
                    alert("AJAX 통신 실패")
                }
            })
            $("#inputComment").val("")
        })
    })
    // 댓글 수정 취소
    $("#modifyCancel").click(function () {
        $("#registerComment").show()
        $("#modifyComment").hide()
        $("#modifyCancel").hide()
        $("#inputComment").val("")
    })


    let toHtml = function (comments) {
        let tmp = "";
        comments.forEach(function (comment) {
            tmp += '<div class="row comment-area">'
            tmp += '<div class="col-md-12" data-commentNo=' + comment.commentNo + ' data-postNo=' + comment.postNo + '>'
            tmp += '<div class="mb-0" style="border: 1px solid #e2e3e5">'
            tmp += '<span style="font-weight: bold" class="commenter">' + comment.userId + '</span>'
            if (comment.userId === '${userId}') {
                tmp += '<button style="float: right" type="button" class="delBtn btn btn-outline-primary">삭제</button>'
                tmp += '<button style="float: right" type="button" class="modBtn btn btn-outline-primary">수정</button>'
            }
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
        return tmp;
    }
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>