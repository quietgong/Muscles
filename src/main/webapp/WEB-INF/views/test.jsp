<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Muscles</title>
    <script src="https://code.jquery.com/jquery-1.11.3.js"/>
</head>
<body>
<!-- nav -->
<%@ include file="nav.jsp" %>
<!-- 본문 -->
<form id="myForm">
<input type="checkbox" value="1"/><span>A</span>
<input type="checkbox" value="2"/><span>B</span>
<input type="checkbox" value="3"/><span>C</span>
<input type="checkbox" value="4"/><span>D</span>

    <input id="submit" type="submit" value="전송">
</form>
<script>
    $("#submit").on("click", function () {
        const form = $('#myForm');
        let checkedItems = $('input[type=checkbox]:checked');
        let json = new Array();
        $(checkedItems).each(function () {
            var data = new Object() ;
            data.key = $(this).val()
            data.value = $(this).next().html()
            json.push(data) ;
        });
        // form.append($('<input>').attr({
        //     type: 'hidden',
        //     name: 'chk',
        //     value: arr.join(",")
        // }))
        var jsonData = JSON.stringify(json)
        console.log(jsonData)
        form.val(jsonData)
        form.attr("action", "<c:url value='/test/checkbox'/>");
        form.attr("method", "post");
        form.submit();
    });
</script>
</body>
</html>