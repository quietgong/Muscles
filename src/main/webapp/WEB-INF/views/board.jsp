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
        width: 30%;
        align-items: center;
        justify-content: space-between;
        display: flex;
    }

    .item {
        display: flex;
        flex-direction: column;
    }

    .item-btn {
        align-self: flex-end;
        justify-content: flex-end;
    }

    .item-comment {
        flex-direction: row;
        justify-content: center;
        align-items: center;
    }

    hr {
        width: 50%;
    }
</style>
<body>
<!-- nav -->
<%@ include file="nav.jsp" %>

<!-- 본문 -->
<h1 id="mode" style="display: none">수정 모드</h1>
<hr/>
<div class="container">
    <form id="form">
        <p style="display: none">${postDto.postNo}</p>
        <input type="text" name="title" readonly value="${postDto.title}">
        <p>${postDto.userId} | ${postDto.createdDate}</p>
</div>
<hr/>
<div class="container">
    <input type="text" name="content" readonly value="${postDto.content}">
    </form>
</div>
<hr/>
<div class="container">
    <div class="item-btn">
        <span>작성된 댓글 (1개)</span>
        <input type="button" value="작성"/>
        <input type="button" value="취소"/>
    </div>
</div>
<hr/>
<div class="container">
    <div class="item-comment">
        <textarea rows="4" cols="50"></textarea><br>
        <input type="submit" value="등록">
        <p>
            └ {작성자 ID 표기} | {작성일 표기}
            {내용표기}
            안녕하세요! 고객님 본인인증(또는 상점인증)이 완료된 고객님만 이용할 수 있는 서비스입니다. 확인 결과 고객님은 아직 본인인증 절차가 진행되지 않습니다. 본인인증 후 진행해 주세요!
        </p>
    </div>
</div>
<hr/>
<div class="container">
    <div class="item-btn">
        <a href="<c:url value='/community/list'/>">
            <input type="button" value="목록"/>
        </a>
        <input id="modifyBtn" type="button" value="수정"/>
        <input id="removeBtn" type="button" value="삭제"/>
    </div>
</div>

<!-- footer -->
<%@ include file="footer.jsp" %>
<script>
    $(document).ready(function () {
        $("#modifyBtn").on("click", function () {
            $("#mode").show();
            let isReadOnly = $("input[name=content]").attr("readonly");
            // readonly가 체크되어있으면 (읽기 모드)
            if (isReadOnly == "readonly") {
                // 1. 수정버튼을 등록버튼으로 바꾼다.
                $("#modifyBtn").attr("value","등록");
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
        $("#removeBtn").on("click", function () {
            if (!confirm("정말로 삭제하시겠습니까?")) return;
            let form = $("#form");
            form.attr("action", "<c:url value="/community/remove?postNo=${postDto.postNo}"/>")
            form.attr("method", "post");
            form.submit();
        });
    });
</script>
</body>
</html>