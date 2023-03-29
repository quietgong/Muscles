<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="nav.jsp" %>
<style>
    * {
        margin: 0;
        padding: 0;
    }

    .container {
        width: 500px;
        margin: 0 auto;
        padding: 25px
    }

    .container h1 {
        text-align: left;
        padding: 5px 5px 5px 15px;
        color: #FFBB00;
        border-left: 3px solid #FFBB00;
        margin-bottom: 20px;
    }

    .chating {
        background-color: #000;
        width: 500px;
        height: 500px;
        overflow: auto;
    }

    .chating .me {
        color: #F6F6F6;
        text-align: right;
    }

    .chating .others {
        color: #FFE400;
        text-align: left;
    }

    input {
        width: 330px;
        height: 25px;
    }
</style>
<!-- 본문 -->
<div id="container" class="container">
    <h1>채팅</h1>
    <input type="hidden" id="chatName" value="${chatName}">
    <input type="hidden" id="sessionId" value="">

    <div id="chating" class="chating">
        <c:forEach var="pastChat" items="${chatDtoList}">
            <c:set var="myMsg" value="${pageContext.request.session.getAttribute('id') == pastChat.talker ? 'me' : 'others'}"/>
            <p class="${myMsg}">${pastChat.talker} : ${pastChat.msg} : ${pastChat.createdDate}</p>
        </c:forEach>
    </div>

    <div id="yourMsg">
        <table class="inputTable">
            <tr>
                <th>메시지</th>
                <th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
                <th>
                    <button onclick="send()" id="sendBtn">보내기</button>
                </th>
            </tr>
        </table>
    </div>
</div>
<form action="<c:url value='/removeRoom?chatName=${chatName}'/>" id="disconnectForm" method="post">
<input type="submit" id="disconnect" value="상담 완료">
</form>

<script>
    let ws;
    let userName = $("#chatName").val() == "" ? '${pageContext.request.session.getAttribute('id')}' : $("#chatName").val();
    let url = "ws://localhost:80/muscles/chatserver/" + userName;

    wsOpen();

    function wsOpen() {
        ws = new WebSocket(url);
        wsEvt();
    }

    function wsEvt() {
        ws.onopen = function (data) {
            //소켓이 열리면 초기화 세팅하기
        }
        ws.onmessage = function (data) {
            const msg = data.data;
            if (msg != null && msg.trim() != '') {
                let d = JSON.parse(msg)
                console.log(d)
                if (d.type == "getId") {
                    var si = d.sessionId != null ? d.sessionId : "";
                    if (si != '') {
                        $("#sessionId").val(si);
                    }
                } else if (d.type == "message") {
                    if (d.sessionId == $("#sessionId").val())
                        $("#chating").append("<p class='me'>나 :" + d.msg + "</p>");
                    else
                        $("#chating").append("<p class='others'>" + d.userName + " :" + d.msg + "</p>");
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
            userName: '${pageContext.request.session.getAttribute('id')}',
            msg: $("#chatting").val()
        }
        // 웹소켓에 메시지 정보 전달
        ws.send(JSON.stringify(option))

        // 컨트롤러에 메시지 정보 전달
        let data = {
            chatName: userName,
            talker: '${pageContext.request.session.getAttribute('id')}',
            msg: $("#chatting").val()
        }
        // 채팅 메세지 DB 저장
        $.ajax({
            type: "POST",
            url: '/muscles/chat/post',
            data: data,
            success: function () {
                console.log("ok")
            },
            error: function () {
                console.log('error');
            }
        });
        $('#chatting').val("");
    }
</script>
<!-- footer -->
<%@ include file="footer.jsp" %>