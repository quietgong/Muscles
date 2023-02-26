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
</head>
<style>
    .item-head {
        text-align: center;
        flex: 1 1 20%;
    }

    .item {
        text-align: center;
        flex: 1 1 20%;
    }

    .modal-container {
        align-items: center;
        justify-content: flex-start;
        display: flex;
    }

    .modal-item:nth-child(odd) {
        flex-grow: 1;
    }

    .modal-item:nth-child(even) {
        flex-grow: 2;
    }
</style>
<body>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
<!-- 사이드바 시작 -->
<%@include file="sidebar.jsp" %>
<!-- 사이드바 끝 -->

<!-- 작성한 리뷰 -->
<h1>리뷰작성 목록 (2)</h1>
<div class="mypage-container">
    <img src="http://via.placeholder.com/100X100/000000/ffffff"/>
    <div class="item"><h3>상품명</h3></div>
    <div class="item"><span>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Libero voluptates aliquam quo possimus ab consectetur expedita minus illo. Aut, quo? Rerum numquam nobis esse necessitatibus vitae tempora asperiores, libero porro.</span>
    </div>
    <div class="item">
        <div>
            <span class="star">★★★★★<span>★★★★★</span></span>
        </div>
        <span>주문일자 : 2022-03-20</span>
    </div>
    <div class="item">
        <span>
            <button type="button" class="modalBtn">수정</button>
            <button type="button" class="delBtn">삭제</button>
        </span>
    </div>
</div>
<hr/>
<!-- 작성한 리뷰 끝 -->
<!-- 작성한 리뷰 -->
<div class="mypage-container">
    <img src="http://via.placeholder.com/100X100/000000/ffffff"/>
    <div class="item"><h3>상품명</h3></div>
    <div class="item"><span>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Libero voluptates aliquam quo possimus ab consectetur expedita minus illo. Aut, quo? Rerum numquam nobis esse necessitatibus vitae tempora asperiores, libero porro.</span>
    </div>
    <div class="item"><h3>★★★★☆</h3><span>주문일자 : 2022-03-20</span></div>
    <div class="item"><span><a href="login.html">수정</a> | <a href="register.html">삭제</a></span><br></div>
</div>
<hr/>
<!-- 작성한 리뷰 끝 -->
<!-- 모달 -->
<dialog>
    <h3 style="background-color: rgb(227, 217, 204)">리뷰 작성</h3>
    <div class="modal-container">
        <div class="modal-item">
            <h3>상품명</h3>
        </div>
        <div class="modal-item">
            <h3>상품명 123</h3>
        </div>
    </div>
    <hr/>
    <div class="modal-container">
        <div class="modal-item">
            <h3>별점</h3>
        </div>
        <div class="modal-item">
            <div>
                <span class="modal-star">★★★★★
                    <span>★★★★★</span>
                <input
                        type="range"
                        oninput="drawStar(this)"
                        value="1"
                        step="0.5"
                        min="0"
                        max="5"
                />
                </span>
            </div>
        </div>
    </div>
    <hr/>
    <div class="modal-container">
        <div class="modal-item">
            <h3>후기</h3>
        </div>
        <div class="modal-item">
            <textarea rows="4" cols="20"></textarea>
        </div>
    </div>
    <form method="dialog">
        <button type="submit">등록</button>
        <button type="button">닫기</button>
    </form>
</dialog>

<!-- footer -->
<%@ include file="../footer.jsp" %>
<script>
    const drawStar = (target) => {
        document.querySelector(`.star span`).style.width = `${target.value * 20}%`;
    };
    // 별점
    document.querySelector(`.star span`).style.width = `20%`;
    // 리뷰 별점 JS CODE

    const button = document.querySelector(".modalBtn");
    const dialog = document.querySelector("dialog");
    button.addEventListener("click", () => {
        dialog.showModal();
    });
    dialog.addEventListener("close", () => {
        alert("cancel");
    });
</script>
</body>
</html>