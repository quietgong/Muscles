<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>
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
                                        <p class="small mb-1 text-muted"><fmt:formatDate value="${pastChat.createdDate}"
                                                                                         pattern="HH:mm"
                                                                                         type="date"/></p>
                                        <p class="small mb-1">${pastChat.talker}</p>
                                    </div>
                                    <div class="d-flex flex-row justify-content-end mb-4 pt-1">
                                        <div style="max-width: 80%;">
                                            <p class="small p-2 me-3 mb-3 text-white rounded-3 bg-primary">${pastChat.msg}</p>
                                        </div>
                                        <img src="<c:url value='/img/logo.jpg'/>" style="width: 45px; height: 100%;">
                                    </div>
                                </c:when>
                                <c:when test="${pastChat.talker == 'system'}">
                                    <!-- 상담 종료 메세지 -->
                                    <p class="small mt-3 mb-3 text-muted text-center">--- 상담이 종료 되었습니다 ---</p>
                                    <p class="small mt-3 mb-3 text-muted text-center">
                                        <fmt:formatDate value="${pastChat.createdDate}"
                                                        pattern="yyyy-MM-dd HH:ss"
                                                        type="date"/>
                                    </p>
                                </c:when>
                                <c:otherwise>
                                    <!-- 상대방 대화 -->
                                    <div class="d-flex justify-content-between">
                                        <p class="small mb-1">${pastChat.talker}</p>
                                        <p class="small mb-1 text-muted"><fmt:formatDate value="${pastChat.createdDate}"
                                                                                         pattern="HH:mm"
                                                                                         type="date"/></p>
                                    </div>
                                    <div class="d-flex flex-row justify-content-start">
                                        <img src="<c:url value='/img/logo.jpg'/>" style="width: 45px; height: 100%;">
                                        <div style="max-width: 80%;">
                                            <p class="small p-2 ms-3 mb-3 rounded-3"
                                               style="background-color: #f5f6f7;">${pastChat.msg}</p>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <div class="card-footer text-muted d-flex justify-content-start align-items-center p-3">
                        <div class="input-group mb-0">
                            <input id="msgInput" type="text" class="form-control" placeholder="메세지를 입력하세요"
                                   aria-label="Recipient's username" aria-describedby="button-addon2"/>
                            <button class="btn btn-primary" type="button" id="button-addon2"
                                    style="padding-top: .55rem;">
                                전송
                            </button>
                        </div>
                    </div>
                    <c:if test="${isAdmin == 'true'}">
                        <button type='button' onclick='removeRoom()' class='btn btn-primary'>상담종료</button>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    function removeRoom() {
        if (!confirm("상담을 종료합니까?")) return;
        commonAjax("/muscles/admin/chat/" + $("#chatName").val(), null, "DELETE", function (res) {
            if (res === 'DEL_OK') {
                let option = {
                    type: "notify", chatName: userName, sessionId: $("#sessionId").val(), userName: 'admin',
                    msg: "상담이 종료되었습니다."
                }
                // 웹소켓에 메시지 정보 전달
                ws.send(JSON.stringify(option))

                // 컨트롤러에 메시지 정보 전달
                let data = {
                    chatName: userName,
                    talker: 'system',
                    msg: "상담종료"
                }
                saveChat(data)
                alert("상담이 종료되었습니다.")
                location.href = "/muscles";
            }
        })
    }
</script>
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
            const msg = data.data;
            if (msg != null && msg.trim() !== '') {
                let d = JSON.parse(msg)
                console.log(d)
                if (d.type === "message") { // 데이터가 "메세지" 타입 일 때
                    let tmp = ""
                    let today = new Date();
                    let hours = ('0' + today.getHours()).slice(-2);
                    let minutes = ('0' + today.getMinutes()).slice(-2);
                    let currentTime = hours + ':' + minutes;
                    // 내가 메세지를 전달할 때
                    if (d.sessionId === $("#sessionId").val()) {
                        tmp += '<div class="d-flex justify-content-between">'
                        tmp += '<p class="small mb-1 text-muted">' + currentTime + '</p>'
                        tmp += '<p class="small mb-1">' + d.userName + '</p>'
                        tmp += '</div>'
                        tmp += '<div class="d-flex flex-row justify-content-end mb-4 pt-1">'
                        tmp += '<div style="max-width: 80%;">'
                        tmp += '<p class="small p-2 me-3 mb-3 text-white rounded-3 bg-primary">' + d.msg + '</p>'
                        tmp += '</div>'
                        tmp += '<img src="/muscles/img/logo.jpg" style="width: 45px; height: 100%;">'
                        tmp += '</div>'
                        // 상대방의 메세지를 받았을 때
                    } else {
                        tmp += '<div class="d-flex justify-content-between">'
                        tmp += '<p class="small mb-1">' + d.userName + '</p>'
                        tmp += '<p class="small mb-1 text-muted">' + currentTime + '</p>'
                        tmp += '</div>'
                        tmp += '<div class="d-flex flex-row justify-content-start">'
                        tmp += '<img src="/muscles/img/logo.jpg" style="width: 45px; height: 100%;">'
                        tmp += '<div style="max-width: 80%;">'
                        tmp += '<p class="small p-2 ms-3 mb-3 rounded-3" style="background-color: #f5f6f7;">' + d.msg + '</p>'
                        tmp += '</div>'
                        tmp += '</div>'
                    }
                    // 신규 대화이면 append, 기존 대화가 있을 때는 마지막 자손요소에 추가
                    newChat ? $("#chattingBox").append(tmp) : $("#chattingBox").children().last().after(tmp)
                } else if (d.type === 'notify') { // 데이터가 "알림" 타입 일 때
                    let today = new Date();
                    let formattedDate = today.getFullYear() + "-" + (today.getMonth() + 1).toString().padStart(2, "0") + "-" + today.getDate().toString().padStart(2, "0") + " " + today.getHours().toString().padStart(2, "0") + ":" + today.getMinutes().toString().padStart(2, "0");
                    let tmp = ""
                    tmp += '<p class="small mt-3 mb-3 text-muted text-center">--- 상담이 종료 되었습니다 ---</p>'
                    tmp += '<p class="small mt-3 mb-3 text-muted text-center">' + formattedDate + '</p>'
                    $("#chattingBox").children().last().after(tmp)
                    location.href = "/muscles"
                } else if (d.type === 'getId')
                    $("#sessionId").val(d.sessionId)
                else
                    console.warn("알 수 없는 메세지 타입입니다.")
            }
            scrollTop()
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
        saveChat(data)
        $('#msgInput').val("");
    }

    function saveChat(data) {
        // 채팅 메세지 DB 저장
        commonAjax("/muscles/chat/save", data, "POST", function (res) {
            if(res==="ADD_OK")
                scrollTop()
        });
    }
</script>
<!-- footer -->
<%@ include file="../footer.jsp" %>