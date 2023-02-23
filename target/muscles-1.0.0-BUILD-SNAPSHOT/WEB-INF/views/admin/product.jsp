<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<body>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
<!-- 검색조건 -->
<div class="admin-condition">
    <div>
        <span for="pw1">상품명</span>
        <input type="text" id="lname" name="lastname" />
        <input type="button" value="검색" />
    </div>
</div>
<!-- 검색조건 끝 -->

<!-- 컨테이너 -->
<div class="admin-container">
    <!-- 사이드바 -->
    <%@include file="sidebar.jsp" %>
    <!-- 사이드바 -->
    <!-- 내용 -->
    <div class="admin-item">
        <!-- 반복부 -->
        <div class="admin-item-detail">
            <div class="admin-detail-section">
            </div>
            <div class="admin-detail-section">
                <div>
                    <!-- 상품사진 -->
                    <img src="http://via.placeholder.com/200X100/000000/ffffff" />
                </div>
                <div>
                    <!-- 상품정보 -->
                    <span style="font-weight: bold;">[카테고리]</span><br>
                    <span>상품명 : </span><br>
                    <span>가격 : </span><br>
                    <span>재고수량 : </span><br>
                </div>

                <div>
                    <!-- 상품정보 변경 버튼 -->
                    <button id="modalBtn" type="button">상품정보 변경</button>
                </div>
            </div>
        </div>
        <!-- 반복부 -->
        <!-- 반복부 -->
        <div class="admin-item-detail">
            <div class="admin-detail-section">
            </div>
            <div class="admin-detail-section">
                <div>
                    <!-- 상품사진 -->
                    <img src="http://via.placeholder.com/200X100/000000/ffffff" />
                </div>
                <div>
                    <!-- 상품정보 -->
                    <span style="font-weight: bold;">[카테고리]</span><br>
                    <span>상품명 : </span><br>
                    <span>가격 : </span><br>
                    <span>재고수량 : </span><br>
                </div>
                <div>
                    <!-- 상품정보 변경 버튼 -->
                    <button id="modalBtn" type="button">상품정보 변경</button>
                </div>
            </div>
        </div>
        <!-- 반복부 -->

    </div>
    <!-- 내용 -->
</div>
<!-- 컨테이너 -->

<ul class="paging">
    <li class="paging"><a href="#"><</a></li>
    <li class="paging"><a href="#">1</a></li>
    <li class="paging"><a href="#">2</a></li>
    <li class="paging"><a href="#">3</a></li>
    <li class="paging"><a href="#">4</a></li>
    <li class="paging"><a href="#">5</a></li>
    <li class="paging"><a href="#">6</a></li>
    <li class="paging"><a href="#">7</a></li>
    <li class="paging"><a href="#">8</a></li>
    <li class="paging"><a href="#">9</a></li>
    <li class="paging"><a href="#">10</a></li>
    <li class="paging"><a href="#">></a></li>
</ul>

<!-- 상품정보 변경 모달-->
<dialog>
    <h3 style="background-color: rgb(227, 217, 204)">상품 정보 변경</h3>
    <div class="admin-admin-condition">
        <div class="admin-item">
            <h3>상품명</h3>
        </div>
        <div class="admin-item">
            <input />
        </div>
    </div>
    <hr />
    <div class="admin-admin-condition">
        <div class="admin-item">
            <h3>가격</h3>
        </div>
        <div class="admin-item">
            <input />
        </div>
    </div>
    <hr />
    <div class="admin-admin-condition">
        <div class="admin-item">
            <h3>카테고리</h3>
        </div>
        <div class="admin-item">
            <select id="country" name="country">
                <option value="" selected>대분류</option>
                <option value="">유산소</option>
                <option value="">근력</option>
            </select>
            <select id="country" name="country">
                <option value="" selected>소분류</option>
                <option value="">사이클</option>
                <option value="">러닝머신</option>
            </select>
        </div>
    </div>
    <hr />

    <div class="admin-admin-condition">
        <div class="admin-item">
            <h3>재고</h3>
        </div>
        <div class="admin-item">
            <input />
        </div>
    </div>
    <form method="dialog">
        <button type="submit">변경</button>
        <button type="button">닫기</button>
    </form>
</dialog>
<script>

    const button = document.querySelector("#modalBtn")
    const dialog = document.querySelector("dialog");
    button.addEventListener("click", () => {
        dialog.showModal();
    });
    dialog.addEventListener("close", () => {
        alert("cancel");
    });
</script>

<!-- footer -->
<%@ include file="../footer.jsp" %>
</body>
</html>