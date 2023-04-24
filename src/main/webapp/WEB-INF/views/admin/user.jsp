<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ include file="../nav.jsp" %>
<div class="container">
    <div class="row mt-5">
        <div class="col-md-2">
            <%@include file="sidebar.jsp" %>
        </div>
        <div class="col-md-10">
            <div class="row">
                <div class="col-md-8">
                    <h1 class="app-page-title mb-0">고객 관리</h1>
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-md-12">
                    <nav class="orders-table-tab app-nav-tabs nav shadow-sm flex-column flex-sm-row mb-4">
                        <a style="cursor: pointer" class="flex-sm-fill text-center nav-link" onclick="loadUser('all', this)">전체</a>
                        <a style="cursor: pointer" class="flex-sm-fill text-center nav-link" onclick="loadUser('active', this)">일반 회원</a>
                        <a style="cursor: pointer" class="flex-sm-fill text-center nav-link" onclick="loadUser('inactive', this)">탈퇴 회원</a>
                    </nav>
                </div>
                <div class="col-md-12">
                    <div class="app-card app-card-orders-table shadow-sm mb-5">
                        <div class="app-card-body">
                            <div class="table-responsive">
                                <table class="table app-table-hover mb-0 text-center">
                                    <thead>
                                    <tr>
                                        <th class="cell">고객 번호</th>
                                        <th class="cell">고객 ID</th>
                                        <th class="cell">가입일자</th>
                                        <th class="cell"></th>
                                        <th class="cell"></th>
                                    </tr>
                                    </thead>
                                    <tbody id="loadData"><!-- 동적 추가 부분--></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    loadUser('all')

    function loadUser(status, e) {
        $(".nav-link").removeClass("fw-bold")
        $(e).addClass("fw-bold")
        commonAjax("/muscles/admin/user/find?status=" + status, null, "GET", function (res) {
            $("#loadData").empty()
            let tmp = "";
            res.forEach(function (item) {
                tmp += '<tr>'
                tmp += '<td class="cell">' + item.userNo + '</td>'
                tmp += '<td class="cell">' + item.userId + '</td>'
                tmp += '<td class="cell">' + item.createdDate + '</span></td>'
                if (status === 'active')
                    tmp += '<td class="cell"><button type="button" class="btn btn-outline-primary" onclick="expireUser(\'' + item.userId + '\')">탈퇴처리</button></td>'
                else if (status === 'inactive')
                    tmp += '<td class="cell"><button type="button" class="btn btn-danger disabled">탈퇴 회원</button></td>'
                else {
                    if (item.expiredDate == null)
                        tmp += '<td class="cell"><button type="button" class="btn btn-outline-primary" onclick="expireUser(\'' + item.userId + '\')">탈퇴처리</button></td>'
                    else
                        tmp += '<td class="cell"><button type="button" class="btn btn-danger disabled">탈퇴 회원</button></td>'
                }
                tmp += '</tr>'
            })
            $("#loadData").append(tmp)
        })
    }

    // 탈퇴 처리
    function expireUser(userId) {
        commonAjax("/muscles/admin/user/" + userId, null, "DELETE", function (msg) {
            msg === "DEL_OK" ? alert("탈퇴 처리 완료") : alert("탈퇴 처리 실패");
            location.reload()
        })
    }
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>