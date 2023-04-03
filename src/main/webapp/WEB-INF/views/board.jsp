<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<style>
    .container {
        margin: auto;
        align-items: center;
        display: flex;
        flex-direction: column;
    }

    .item {
        display: flex;
        flex-direction: row;
    }

</style>
<!-- nav -->
<%@ include file="nav.jsp" %>
<!-- 본문 -->
<h1 id="mode" style="display: none">수정 모드</h1>
<div class="container">
    <div class="item">
        <p style="display: none">${postDto.postNo}</p>
        <input type="text" name="title" readonly value="${postDto.title}">
        <span>${postDto.userId} | ${postDto.createdDate}</span>
        <hr/>
        <div class="container">
            <input type="text" name="content" readonly value="${postDto.content}">
        </div>
    </div>
    <div class="item">
        <div>
            <input id="inputComment" type="text" placeholder="입력">
        </div>
        <div>
            <button id="createComment" type="button">댓글 등록</button>
        </div>
        <div>
            <button id="modifyComment" type="button" style="display: none">댓글 수정</button>
        </div>
    </div>
    <div id="item">
        <div id="commentList">
        </div>
    </div>
    <div class="item">
        <div class="item-btn">
            <a href="<c:url value='/${postCategory}?page=${param.page}&option=${param.option}&keyword=${param.keyword}'/>">
                <input type="button" value="목록"/>
            </a>
            <input id="modify" type="button" value="수정"/>
            <input id="remove" type="button" value="삭제"/>
        </div>
    </div>
</div>
<script>
    // 글 수정
    $("#modify").on("click", function () {
        $("#mode").show();
        let isReadOnly = $("input[name=content]").attr("readonly");
        if (isReadOnly === "readonly") {
            $("#modifyPost").attr("value", "등록");
            $("input[name=content]").attr("readonly", false);
            $("input[name=title]").attr("readonly", false);
        } else {
            let modData = {}
            modData.postNo = postNo
            modData.title = $("input[name=title]").val()
            modData.content = $("input[name=content]").val()
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
                $("#commentList").html(toHtml(res))
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
            tmp += '<div data-commentNo=' + comment.commentNo
            tmp += ' data-postNo=' + comment.postNo + '>'
            tmp += ' <span style="font-weight: bold" class="commenter">' + "└ " + comment.userId + '</span>'
            if (comment.createdDate === comment.modDate)
                tmp += ' <span style="font-weight: bold" class="commentDate">' + comment.createdDate
            else
                tmp += ' |  <span class="commentDate">' + comment.modDate + "(수정됨)"
            tmp += '</span>'
            tmp += '<br>'
            tmp += ' <span style="font-style: italic" class="comment">' + comment.content + '</span>'
            tmp += '<button class="delBtn">삭제</button>'
            tmp += '<button class="modBtn">수정</button>'
            tmp += '</div>'
        })
        return tmp;
    }
</script>
<!-- footer -->
<%@ include file="footer.jsp" %>