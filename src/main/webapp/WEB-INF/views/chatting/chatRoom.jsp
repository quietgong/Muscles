<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <h3>채팅상담 목록</h3>
            <div class="card" style="border-radius: 15px; overflow: auto;">
                <div class="card-body" id="roomList">
                    <!-- 반복부 -->
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    let ws;
    getRoom();

    function getRoom() {
        commonAjax('/muscles/chat/roomList', null, 'get', function (result) {
            createChatRoom(result);
        });
    }
    function goRoom(name) {
        location.href = "/muscles/admin/chatList?chatName=" + name;
    }

    function createChatRoom(res) {
        if (res != null) {
            let tmp = "";
            res.forEach(function (d) {
                console.log(d)
                if (d.chatName != null) {
                    const rn = d.chatName.trim()
                    tmp += '<div class="row mt-3 align-items-center">'
                    tmp += '<div class="col-md-3">'
                    tmp += '<img src="/muscles/img/logo.jpg" class="img-fluid rounded">'
                    tmp += '</div>'
                    tmp += '<div class="col-md-5">'
                    tmp += "<a onclick='goRoom(\"" + rn + "\")' style='text-decoration: none; cursor: pointer' class='fw-bold mb-0'>" + d.chatName + '</a>'
                    tmp += '<span class="badge bg-danger rounded m-2">' + d.newMsgCnt + '</span>'
                    tmp += '</div>'
                    tmp += '<div class="col-md-4">'
                    tmp += '<p class="small text-muted mb-0">마지막 메세지</p>'
                    tmp += '<p class="small text-muted mb-0">' + d.lastMsgDate + '</p>'
                    tmp += '</div>'
                    tmp += '</div>'
                    tmp += '<hr>'
                }
            });
            $("#roomList").empty().append(tmp);
        }
    }
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>