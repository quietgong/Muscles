<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="nav.jsp" %>
<style>
    .container h1 {
        text-align: left;
        padding: 5px 5px 5px 15px;
        border-left: 3px solid black;
        margin-bottom: 20px;
    }

    .chating {
        display: flex;
        flex-direction: column;
        margin: auto;
        border-radius: 10px;
        background-color: #c7c4c4;
        width: 700px;
        height: 500px;
        overflow: auto;
        font-size: 1.2rem;
        font-family: Arial, Helvetica, sans-serif;
    }

    #msgInput {
        width: 500px;
        height: 40px;
        font-size: 1.2rem;
        border-radius: 10px;
        text-align: center;
        margin: 20px auto auto;
    }

    .msgBox {
        position: relative;
        border-radius: 3px;
        padding: 10px;
        background-color: #d9d9ee;
        max-width: 50%;
        margin-top: 10px;
    }

    .msgDate {
        font-size: 0.7rem;
        text-align: right;
    }
</style>
<!-- 본문 -->
<h1>1:1 상담 문의</h1>
<input type="hidden" id="chatName" value="${chatName}">
<input type="hidden" id="sessionId" value="">

<div id="chating" class="chating">
    <c:forEach var="pastChat" items="${chatDtoList}">
        <c:set var="myMsg"
               value="${pageContext.request.session.getAttribute('id') == pastChat.talker ? 'left' : 'right'}"/>
        <div class="msgBox" style="margin-${myMsg}: auto">
            <span>
                    ${pastChat.talker} : ${pastChat.msg}
            </span>
            <p class="msgDate">${pastChat.createdDate}</p>
        </div>
    </c:forEach>
</div>

<div style="text-align: center">
    <input id="msgInput" placeholder="메시지를 입력하세요.">
</div>

<script>
    let ws;
    let userName = $("#chatName").val() == "" ? '${pageContext.request.session.getAttribute('id')}' : $("#chatName").val();
    let url = "ws://localhost:80/muscles/chatserver/" + userName;

    scrollTop()
    wsOpen();

    function scrollTop() {
        var element = document.getElementById("chating");
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
            scrollTop()
            const msg = data.data;
            if (msg != null && msg.trim() != '') {
                let d = JSON.parse(msg)
                console.log(d)
                if (d.type == "getId") {
                    var si = d.sessionId != null ? d.sessionId : "";
                    if (si != '')
                        $("#sessionId").val(si);
                } else if (d.type == "message") {
                    let tmp = ""
                    if (d.sessionId == $("#sessionId").val()) {
                        tmp += "<div class='msgBox' style='margin-left: auto'>"
                        tmp += "<span>나 :" + d.msg + "</span>"
                    } else {
                        tmp += "<div class='msgBox' style='margin-right: auto'>"
                        tmp += "<span>" + d.userName + " :" + d.msg + "</span>"
                    }
                    tmp += "<p class='msgDate'>now</p>"
                    tmp += "</div>"
                    $(".msgBox").last().after(tmp)
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
            msg: $("#msgInput").val()
        }
        // 웹소켓에 메시지 정보 전달
        ws.send(JSON.stringify(option))

        // 컨트롤러에 메시지 정보 전달
        let data = {
            chatName: userName,
            talker: '${pageContext.request.session.getAttribute('id')}',
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