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
        border-left: 3px solid #FFBB00;
        margin-bottom: 20px;
    }

    .roomContainer {
        background-color: #F6F6F6;
        width: 500px;
        height: 500px;
        overflow: auto;
    }

    .roomList {
        border: none;
    }

    .roomList th {
        border: 1px solid #FFBB00;
        background-color: #fff;
        color: #FFBB00;
    }

    .roomList td {
        border: 1px solid #FFBB00;
        background-color: #fff;
        text-align: left;
        color: #FFBB00;
    }

    .roomList .num {
        width: 75px;
        text-align: center;
    }

    .roomList .room {
        width: 350px;
    }

    .roomList .go {
        width: 71px;
        text-align: center;
    }

    button {
        background-color: #FFBB00;
        font-size: 14px;
        color: #000;
        border: 1px solid #000;
        border-radius: 5px;
        padding: 3px;
        margin: 3px;
    }

    .inputTable th {
        padding: 5px;
    }

    .inputTable input {
        width: 330px;
        height: 25px;
    }
</style>
<!-- 본문 -->
<div class="container">
    <h1>채팅문의 목록</h1>
    <div id="roomContainer" class="roomContainer">
        <table id="roomList" class="roomList"></table>
    </div>
</div>
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

    function removeRoom(name){
        commonAjax('/muscles/removeRoom/'+name,"",'delete',function (result){
            console.log(result)
            createChatingRoom(result)
        })
    }

    function createChatingRoom(res) {
        if (res != null) {
            let tag = "<tr><th class='num'>순서</th><th class='room'>방 이름</th><th class='go'></th><th></th></tr>";
            res.forEach(function (d, idx) {
                if(d.chatName!=null) {
                    const rn = d.chatName.trim();
                    tag += "<tr>" +
                        "<td class='num'>" + (idx + 1) + "</td>" +
                        "<td class='room'>" + rn + "</td>" +
                        "<td class='go'><button type='button' onclick='goRoom(\"" + rn + "\")'>참여</button></td>" +
                        "<td><button type='button' onclick='removeRoom(\"" + rn + "\")'>상담 종료</button></td>" +
                        "</tr>";
                }
            });
            $("#roomList").empty().append(tag);
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
<%@ include file="footer.jsp" %>