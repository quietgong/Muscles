<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Muscles</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
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
<body>
<!-- nav -->
<%@ include file="nav.jsp" %>

<!-- 본문 -->
<h1 id="mode" style="display: none">수정 모드</h1>
<div class="container">
    <div class="item">
        <form id="form">
            <p style="display: none">${postDto.postNo}</p>
            <input type="text" name="title" readonly value="${postDto.title}">
            <span>${postDto.userId} | ${postDto.createdDate}</span>
            <hr/>
            <div class="container">
                <input type="text" name="content" readonly value="${postDto.content}">
            </div>
        </form>
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
            <a href="<c:url value='/community/list'/>">
                <input type="button" value="목록"/>
            </a>
            <input id="modifyPost" type="button" value="수정"/>
            <input id="removePost" type="button" value="삭제"/>
        </div>
    </div>
</div>

<!-- footer -->
<%@ include file="footer.jsp" %>
<script>
    // 글쓰기 수정, 삭제
    $(document).ready(function () {
        $("#modifyPost").on("click", function () {
            $("#mode").show();
            let isReadOnly = $("input[name=content]").attr("readonly");
            // readonly가 체크되어있으면 (읽기 모드)
            if (isReadOnly == "readonly") {
                // 1. 수정버튼을 등록버튼으로 바꾼다.
                $("#modifyPost").attr("value", "등록");
                // 2. 제목, 내용의 readonly 태그를 해제한다.
                $("input[name=content]").attr("readonly", false);
                $("input[name=title]").attr("readonly", false);
            }
            // readonly가 체크되어 있지 않으면 (수정 모드)
            else {
                // 수정된 내용을 DB에 반영한다.
                let form = $("#form");
                form.attr("action", "<c:url value="/community/modify?postNo=${postDto.postNo}"/>")
                form.attr("method", "post");
                form.submit();
            }
        });
        $("#removePost").on("click", function () {
            if (!confirm("정말로 삭제하시겠습니까?")) return;
            let form = $("#form");
            form.attr("action", "<c:url value="/community/remove?postNo=${postDto.postNo}"/>")
            form.attr("method", "post");
            form.submit();
        });
    });
</script>
<script>
    // 댓글 기능
    let postNo = ${postDto.postNo}
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
                console.log("통신 실패")
            }
        })
    }

    // 댓글 생성
    $("#createComment").on("click", function () {
        let content = $("#inputComment").val()
        $.ajax({
            type: "POST",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/comments?postNo=" + postNo, // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            data: JSON.stringify({content: content}),
            success: function () {
                loadComments()
            },
            error: function () {
                console.log("통신 실패")
            }
        })
        $("#inputComment").val("")
    })
    // 댓글 삭제
    $("#commentList").on("click", ".delBtn", function () {
        let commentNo = $(this).parent().attr('data-commentno')
        $.ajax({
            type: "DELETE",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/comments/" + commentNo + "?postNo=" + postNo, // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function (res) {
                loadComments()
            },
            error: function () {
                console.log("통신 실패")
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
                url: "/muscles/comments/" + commentNo + "?postNo=" + postNo, // 컨트롤러에서 대기중인 URL 주소이다.
                headers: {              // Http header
                    "Content-Type": "application/json",
                },
                data: JSON.stringify(data),
                success: function () {
                    loadComments()
                },
                error: function () {
                    console.log("통신 실패")
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
                tmp += ' <span style="font-weight: bold" class="commentDate">' + JavaDateToJavaScriptDate(comment.createdDate)
            else
                tmp += ' |  <span class="commentDate">' + JavaDateToJavaScriptDate(comment.modDate) + "(수정됨)"
            tmp += '</span>'
            tmp += '<br>'
            tmp += ' <span style="font-style: italic" class="comment">' + comment.content + '</span>'
            tmp += '<button class="delBtn">삭제</button>'
            tmp += '<button class="modBtn">수정</button>'
            tmp += '</div>'
        })
        return tmp;
    }

    function JavaDateToJavaScriptDate(source) {
        const date = new Date(source);
        const year = date.getFullYear();
        const month = leftPad(date.getMonth() + 1);
        const day = leftPad(date.getDate());
        return [year, month, day].join('-');
    }

    function leftPad(value) {
        if (Number(value) >= 10)
            return value;
        return "0" + value;
    }
</script>
</body>
</html>