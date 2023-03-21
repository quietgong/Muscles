<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
<!-- 검색조건 -->
<div class="admin-condition">
    <div>
        <span for="pw1">유저 ID </span>
        <input type="text" id="lname" name="lastname"/>
        <span for="pw1">가입 기간 </span>
        <input type="date" id="lname" name="lastname"/>
        <span for="pw1"> ~ </span>
        <input type="date" id="lname" name="lastname"/>
        <input type="button" value="검색"/>
    </div>
</div>
<!-- 검색조건 끝 -->

<!-- 컨테이너 -->
<div class="container">
    <!-- 내용 -->
    <div class="admin-item">
        <div class="admin-item-detail" style="border: none;">
            <table id="myTable">
            <!-- AJAX 동적 추가 -->
            </table>
        </div>
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

<!-- footer -->
<%@ include file="../footer.jsp" %>
<script>
    // 유저 정보 삭제
    $(document).on("click", ".delBtn", function () {
        let userId = $(this).parent().parent().attr("data-userid");
        $.ajax({
            type: "DELETE",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/admin/user/manage/" + userId, // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function () {
                alert("탈퇴 처리 완료")
                loadUserData()
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    })
    loadUserData()

    // 유저 정보 불러오기
    function loadUserData() {
        $.ajax({
            type: "GET",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/admin/user/manage", // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function (res) {
                console.log(res)
                $("#myTable").html(toHtml(res))
            },
            error: function () {
                console.log("통신 실패")
            }
        })
        let toHtml = function (items) {
            let tmp = "";
            tmp += '<tr>'
            tmp += '<th>번호</th>'
            tmp += '<th>작성 ID</th>'
            tmp += '<th>가입일자</th>'
            tmp += '<th>설정</th>'
            tmp += '</tr>'
            items.forEach(function (item) {
                tmp += '<tr data-userid=' + item.userId + '>'
                tmp += '<td>' + item.userNo + '</td>'
                tmp += '<td>' + item.userId + '</td>'
                tmp += '<td>' + item.createdDate + '</td>'
                tmp += '<td><input class="delBtn" type="button" value="탈퇴처리"></td>'
                tmp += '</tr>'
            })
            return tmp
        }
    }
</script>
