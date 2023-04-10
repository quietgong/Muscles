<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>
<section>
    <div class="container py-5">
        <div class="row">
            <div class="col-md-6" style="margin: auto;">
                <h3>채팅상담 목록</h3>
                <div class="card" style="border-radius: 15px; overflow: auto;">
                    <div class="card-body" id="roomList">
                        <!-- 반복부 -->

                        <!-- 반복부 -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    let ws;
    getRoom();

    function getRoom() {
        commonAjax('/muscles/getRoom', "", 'get', function (result) {
            console.log(result)
            createChatingRoom(result);
        });
    }

    function goRoom(name) {
        location.href = "/muscles/moveChating?chatName=" + name;
    }

    function removeRoom(name) {
        commonAjax('/muscles/removeRoom/' + name, "", 'delete', function (result) {
            console.log(result)
            createChatingRoom(result)
        })
    }

    function createChatingRoom(res) {
        if (res != null) {
            let tmp = "";
            res.forEach(function (d) {
                console.log(d)
                if (d.chatName != null) {
                    const rn = d.chatName.trim()
                    tmp += '<div class="row mt-3">'
                    tmp += '<div class="col-md-3">'
                    tmp += '<span class="badge bg-danger rounded float-end mb-0" style="float: right;">3</span>'
                    tmp += '<img src="/muscles/img/logo.jpg" class="d-flex align-self-center me-3" width="60">'
                    tmp += '</div>'
                    tmp += '<div class="col-md-3 pt-3">'
                    tmp += "<a onclick='goRoom(\"" + rn + "\")' style='text-decoration: none; cursor: pointer' class='fw-bold mb-0'>" + d.chatName + '</a>'
                    tmp += '</div>'
                    tmp += '<div class="col-md-3 pt-3">'
                    tmp += '<p class="small text-muted mb-0">마지막메세지시간</p>'
                    tmp += '</div>'
                    tmp += '<div class="col-md-3 pt-3">'
                    tmp += "<button type='button' onclick='removeRoom(\"" + rn + "\")' style='float: right;' class='small btn btn-primary'>상담종료</button>"
                    tmp += '</button>'
                    tmp += '</div>'
                    tmp += '</div>'
                    tmp += '<hr>'
                }
            });
            $("#roomList").empty().append(tmp);
        }
    }

    function commonAjax(url, parameter, type, callback, contentType) {
        $.ajax({
            url: url,
            data: parameter,
            type: type,
            contentType: contentType != null ? contentType : 'application/x-www-form-urlencoded; charset=UTF-8',
            success: function (res) {
                callback(res);
            },
            error: function (err) {
                console.log('error');
                callback(err);
            }
        });
    }
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>