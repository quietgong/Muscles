<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
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
                <div class="col-md-4">
                    <!-- 조건 -->
                    <form>
                        <div class="input-group flex-nowrap">
                            <span class="input-group-text" id="addon-wrapping">기간</span>
                            <select class="form-select">
                                <option selected value="option-1">전체</option>
                                <option value="option-2">This week</option>
                                <option value="option-3">This month</option>
                                <option value="option-4">Last 3 months</option>
                            </select>
                            <button type="submit" class="btn btn-primary">검색</button>
                        </div>
                    </form>
                    <!-- 조건 -->
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-md-12">
                    <nav id="orders-table-tab"
                         class="orders-table-tab app-nav-tabs nav shadow-sm flex-column flex-sm-row mb-4">
                        <a class="flex-sm-fill text-sm-center nav-link active" id="orders-all-tab" data-bs-toggle="tab"
                           href="#orders-all" onclick="loadAllUser()" role="tab" aria-controls="orders-all"
                           aria-selected="true">전체</a>
                        <a class="flex-sm-fill text-sm-center nav-link" id="orders-paid-tab" data-bs-toggle="tab"
                           href="#orders-paid" onclick="loadActiveUser()" role="tab" aria-controls="orders-paid"
                           aria-selected="false">일반 회원</a>
                        <a class="flex-sm-fill text-sm-center nav-link" id="orders-pending-tab" data-bs-toggle="tab"
                           href="#orders-pending" onclick="loadInactiveUser()" role="tab" aria-controls="orders-pending"
                           aria-selected="false">탈퇴
                            회원</a>
                    </nav>
                </div>
                <div class="col-md-12">
                    <div class="tab-content" id="orders-table-tab-content">
                        <!-- 전체 회원 테이블 -->
                        <div class="tab-pane fade show active" id="orders-all" role="tabpanel"
                             aria-labelledby="orders-all-tab">
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
                                            </tr>
                                            </thead>
                                            <tbody id="loadAllUser">

                                            </tbody>
                                        </table>
                                    </div><!--//table-responsive-->
                                </div><!--//app-card-body-->
                            </div><!--//app-card-->
                        </div><!--//tab-pane-->
                        <!-- 전체 회원 테이블 -->

                        <!-- 일반 회원 테이블 -->
                        <div class="tab-pane fade show" id="orders-paid" role="tabpanel"
                             aria-labelledby="orders-paid-tab">
                            <div class="app-card app-card-orders-table mb-5">
                                <div class="app-card-body">
                                    <div class="table-responsive">
                                        <table class="table app-table-hover mb-0 text-center">
                                            <thead>
                                            <tr>
                                                <th class="cell">고객 번호</th>
                                                <th class="cell">고객 ID</th>
                                                <th class="cell">가입일자</th>
                                                <th class="cell"></th>
                                            </tr>
                                            </thead>
                                            <tbody id="loadActiveUser">

                                            </tbody>
                                        </table>
                                    </div><!--//table-responsive-->
                                </div><!--//app-card-body-->
                            </div><!--//app-card-->
                        </div><!--//tab-pane-->
                        <!-- 일반 회원 테이블 -->

                        <!-- 탈퇴 회원 테이블 -->
                        <div class="tab-pane fade show" id="orders-pending" role="tabpanel"
                             aria-labelledby="orders-pending-tab">
                            <div class="app-card app-card-orders-table mb-5">
                                <div class="app-card-body">
                                    <div class="table-responsive">
                                        <table class="table app-table-hover mb-0 text-center">
                                            <thead>
                                            <tr>
                                                <th class="cell">고객 번호</th>
                                                <th class="cell">고객 ID</th>
                                                <th class="cell">가입일자</th>
                                                <th class="cell"></th>
                                            </tr>
                                            </thead>
                                            <tbody id="loadInactiveUser">

                                            </tbody>
                                        </table>
                                    </div><!--//table-responsive-->
                                </div><!--//app-card-body-->
                            </div><!--//app-card-->
                        </div>
                        <!-- 탈퇴 회원 테이블 -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- footer -->
<%@ include file="../footer.jsp" %>
<script>
    loadAllUser()

    // 모든 고객 정보 불러오기
    function loadAllUser() {
        $("#orders-all-tab").html("<strong>전체 회원</strong>")
        $("#orders-paid-tab").html("일반 회원");
        $("#orders-pending-tab").html("탈퇴 회원");
        $("#loadAllUser").empty()
        $("#loadAllUser").append(insertData(getUserData()))
    }

    // 일반 고객 정보 불러오기
    function loadActiveUser() {
        $("#orders-all-tab").html("전체 회원");
        $("#orders-paid-tab").html("<strong>일반 회원</strong>")
        $("#orders-pending-tab").html("탈퇴 회원");
        $("#loadActiveUser").empty()
        $("#loadActiveUser").append(insertData(getUserData(), 'active'))
    }

    // 탈퇴 정보 불러오기
    function loadInactiveUser() {
        $("#orders-all-tab").html("전체 회원")
        $("#orders-paid-tab").html("일반 회원");
        $("#orders-pending-tab").html("<strong>탈퇴 회원</strong>");
        $("#loadInactiveUser").empty()
        $("#loadInactiveUser").append(insertData(getUserData(), 'inactive'))
    }

    // tr 데이터 삽입
    function insertData(items, condition) {
        let tmp = "";
        function makeTmp(item) {
            tmp = "";
            tmp += '<tr>'
            tmp += '<td class="cell">' + item.userNo + '</td>'
            tmp += '<td class="cell">' + item.userId + '</td>'
            tmp += '<td class="cell"><span class="note">' + item.createdDate + '</span></td>'
            return tmp;
        }

        if (condition === 'active') {
            items.filter(item => item.expiredDate == null).forEach(function (item) {
                tmp += makeTmp(item)
                tmp += '<td class="cell"><button type="button" class="btn btn-outline-primary" onclick="expireUser(\'' + item.userId + '\')">탈퇴처리</button></td>'
            })
        } else if (condition === 'inactive') {
            items.filter(item => item.expiredDate != null).forEach(function (item) {
                tmp += makeTmp(item)
                tmp += '<td class="cell"><button type="button" class="btn btn-danger disabled">탈퇴 회원</button></td>'
            })
        } else {
            items.forEach(function (item) {
                tmp += makeTmp(item)
                if (item.expiredDate == null)
                    tmp += '<td class="cell"><button type="button" class="btn btn-outline-primary" onclick="expireUser(\'' + item.userId + '\')">탈퇴처리</button></td>'
                else
                    tmp += '<td class="cell"><button type="button" class="btn btn-danger disabled">탈퇴 회원</button></td>'
            })
        }
        tmp += '</tr>'

        return tmp
    }

    // AJAX로 고객 데이터 가져오기
    function getUserData() {
        let ret
        $.ajax({
            async: false,
            type: "GET",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/admin/user/", // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function (res) {
                ret = res
            },
            error: function () {
                console.log("통신 실패")
            }
        })
        return ret
    }

    // 고객 탈퇴 처리
    function expireUser(userId){
        $.ajax({
            type: "DELETE",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/admin/user/" + userId, // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {              // Http header
                "Content-Type": "application/json",
            },
            success: function (msg) {
                if (msg == "DEL_OK") {
                    alert("탈퇴 처리 완료")
                } else {
                    alert("탈퇴 처리 실패")
                }
                location.reload()
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    }
</script>
