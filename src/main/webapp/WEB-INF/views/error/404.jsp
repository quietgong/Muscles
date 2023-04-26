<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>Muscles</title>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/templatemo.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/fontawesome.min.css'/>">
    <script src="<c:url value='/js/jquery-1.11.0.min.js'/>"></script>
    <script src="<c:url value='/js/jquery-migrate-1.2.1.min.js'/>"></script>
    <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
</head>
<body>
<div class="d-flex align-items-center justify-content-center vh-100">
    <div class="text-center">
        <h1 class="display-1 fw-bold">404</h1>
        <p class="fs-3">페이지를 찾을 수 없습니다.</p>
        <p class="lead">
            해당 페이지는 존재하지 않습니다. 죄송합니다.
        </p>
        <a href="/muscles" class="btn btn-primary">Go Home</a>
    </div>
</div>
</body>
</html>