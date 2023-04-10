<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="nav.jsp" %>
<!-- 본문 -->
<input type="hidden" id="chatName" value="${chatName}">
<input type="hidden" id="sessionId" value="">
<section style="background-color: #eee;">
    <div class="container py-5">
        <div class="row d-flex justify-content-center">
            <div class="col-md-10 col-lg-6 col-xl-4">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center p-3"
                         style="border-top: 4px solid #b6c4f8;">
                        <h5 class="mb-0">1:1 상담 문의</h5>
                    </div>
                    <div id="chattingBox" class="card-body" style="position: relative; height: 400px; overflow: auto;">
                        <c:forEach var="pastChat" items="${chatDtoList}">
                            <c:choose>
                                <c:when test="${pageContext.request.session.getAttribute('id') == pastChat.talker}">
                                    <!-- 나의 대화 -->
                                    <div class="d-flex justify-content-between">
                                        <p class="small mb-1 text-muted">${pastChat.createdDate}</p>
                                        <p class="small mb-1">${pastChat.talker}</p>
                                    </div>
                                    <div class="d-flex flex-row justify-content-end mb-4 pt-1">
                                        <div style="max-width: 80%;">
                                            <p class="small p-2 me-3 mb-3 text-white rounded-3 bg-primary">${pastChat.msg}</p>
                                        </div>
                                        <img src="<c:url value='/img/logo.jpg'/>" style="width: 45px; height: 100%;">
                                    </div>
                                    <!-- 나의 대화 -->
                                </c:when>
                                <c:otherwise>
                                    <!-- 상대방 대화 -->
                                    <div class="d-flex justify-content-between">
                                        <p class="small mb-1">${pastChat.talker}</p>
                                        <p class="small mb-1 text-muted">${pastChat.createdDate}</p>
                                    </div>
                                    <div class="d-flex flex-row justify-content-start">
                                        <img src="<c:url value='/img/logo.jpg'/>" style="width: 45px; height: 100%;">
                                        <div style="max-width: 80%;">
                                            <p class="small p-2 ms-3 mb-3 rounded-3" style="background-color: #f5f6f7;">${pastChat.msg}</p>
                                        </div>
                                    </div>
                                    <!-- 상대방 대화 -->
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <div class="card-footer text-muted d-flex justify-content-start align-items-center p-3">
                        <div class="input-group mb-0">
                            <input id="msgInput" type="text" class="form-control" placeholder="Type message"
                                   aria-label="Recipient's username" aria-describedby="button-addon2"/>
                            <button class="btn btn-primary" type="button" id="button-addon2"
                                    style="padding-top: .55rem;">
                                전송
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    let ws;
    let userName = $("#chatName").val() == "" ? '${userId}' : $("#chatName").val();
    let url = "ws://localhost:80/muscles/chatserver/" + userName;

    scrollTop()
    wsOpen();

    function scrollTop() {
        let element = document.getElementById("chattingBox");
        element.scrollTop = element.scrollHeight;
    }

    function wsOpen() {
        ws = new WebSocket(url);
        wsEvt();
    }

    function wsEvt() {
        ws.onopen = function (data) {
            //소켓이 열리면 초기화 세팅하기
        }
        ws.onmessage = function (data) {
            let newChat = $("#chattingBox").children().length === 0
            scrollTop()
            const msg = data.data;
            if (msg != null && msg.trim() != '') {
                let d = JSON.parse(msg)
                console.log(d)
                if (d.type == "getId") {
                    const si = d.sessionId != null ? d.sessionId : "";
                    if (si != '')
                        $("#sessionId").val(si);
                } else if (d.type == "message") {
                    let tmp = ""
                    let currentTime = new Date().toLocaleString()
                    if (d.sessionId === $("#sessionId").val()) {
                        // 내가 메세지를 전달할 때
                        tmp+='<div class="d-flex justify-content-between">'
                        tmp+='<p class="small mb-1 text-muted">'+currentTime+'</p>'
                        tmp+='<p class="small mb-1">' + d.userName + '</p>'
                        tmp+='</div>'
                        tmp+='<div class="d-flex flex-row justify-content-end mb-4 pt-1">'
                        tmp+='<div style="max-width: 80%;">'
                        tmp+='<p class="small p-2 me-3 mb-3 text-white rounded-3 bg-primary">' + d.msg + '</p>'
                        tmp+='</div>'
                        tmp+='<img src="/muscles/img/logo.jpg" style="width: 45px; height: 100%;">'
                        tmp+='</div>'
                    } else {
                        // 상대방의 메세지를 받았을 때
                        tmp+='<div class="d-flex justify-content-between">'
                        tmp+='<p class="small mb-1">' + d.userName + '</p>'
                        tmp+='<p class="small mb-1 text-muted">' +currentTime + '</p>'
                        tmp+='</div>'
                        tmp+='<div class="d-flex flex-row justify-content-start">'
                        tmp+='<img src="/muscles/img/logo.jpg" style="width: 45px; height: 100%;">'
                        tmp+='<div style="max-width: 80%;">'
                        tmp+='<p class="small p-2 ms-3 mb-3 rounded-3" style="background-color: #f5f6f7;">' + d.msg + '</p>'
                        tmp+='</div>'
                        tmp+='</div>'
                    }
                    console.log(newChat)
                    if(newChat) // 신규 대화
                        $("#chattingBox").append(tmp)
                    else // 기존 대화
                        $("#chattingBox").children().last().after(tmp)
                } else
                    console.warn("unknown type!")
            }
        }
        document.addEventListener("keypress", function (e) {
            if (e.keyCode == 13) { //enter press
                send();
            }
        });
    }

    function send() {
        let option = {
            type: "message",
            chatName: userName,
            sessionId: $("#sessionId").val(),
            userName: '${userId}',
            msg: $("#msgInput").val()
        }
        // 웹소켓에 메시지 정보 전달
        ws.send(JSON.stringify(option))

        // 컨트롤러에 메시지 정보 전달
        let data = {
            chatName: userName,
            talker: '${userId}',
            msg: $("#msgInput").val()
        }
        // 채팅 메세지 DB 저장
        $.ajax({
            type: "POST",
            url: '/muscles/chat/post',
            data: data,
            success: function () {
                console.log("ok")
                scrollTop()
            },
            error: function () {
                console.log('error');
            }
        });
        $('#msgInput').val("");
    }
</script>
<!-- footer -->
<%@ include file="footer.jsp" %>