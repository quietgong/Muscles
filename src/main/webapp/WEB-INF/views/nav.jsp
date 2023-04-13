<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<c:set var="userId"
       value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="isAdmin"
       value="${pageContext.request.session.getAttribute('id')=='admin' ? 'true' : 'false'}"/>
<html>
<head>
    <title>Muscles</title>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- css files -->
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/templatemo.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/custom.css'/>">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="<c:url value='/css/fontawesome.min.css'/>">
    <!-- jQuery -->
    <script src="<c:url value='/js/jquery-1.11.0.min.js'/>"></script>
    <script src="<c:url value='/js/jquery-migrate-1.2.1.min.js'/>"></script>
</head>
<body>
<div class="mt-3 container d-grid gap-2 d-md-flex justify-content-md-end">
    <h1>접속ID : ${userId}</h1>
    <button id="admin" onclick="location.href='<c:url value='/admin/user'/>'" type="button"
            class="me-md-2 btn btn-outline-primary" style="float: left">
        관리자 페이지
    </button>
    <button id="login" onclick="location.href='<c:url value='/login'/>'" type="button" class="me-md-2 btn btn-outline-primary">
        로그인
    </button>
    <button id="logout" onclick="location.href='<c:url value='/logout'/>'" type="button" class="me-md-2 btn btn-outline-primary">로그아웃</button>
    <button id="register" onclick="location.href='<c:url value='/register'/>'" type="button"
            class="me-md-2 btn btn-outline-primary">
        회원가입
    </button>
    <button id="chatting" onclick="location.href='<c:url value='/chatting'/>'" type="button"
            class="me-md-2 btn btn-outline-primary">
        채팅상담
    </button>
</div>
<!-- Close Top Nav -->

<!-- Header -->
<nav class="navbar navbar-expand-lg navbar-light shadow">
    <div class="container d-flex justify-content-between align-items-center">
        <a class="navbar-brand text-success logo h1 align-self-center" href="<c:url value='/'/>">
            Muscles
        </a>
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse"
                data-bs-target="#templatemo_main_nav" aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="align-self-center collapse navbar-collapse flex-fill  d-lg-flex justify-content-lg-between"
             id="templatemo_main_nav">
            <div class="flex-fill">
                <ul class="nav navbar-nav d-flex justify-content-between mx-lg-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/'/>">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/notice'/>">공지사항</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/goods/list'/>">Shop</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/community'/>">커뮤니티</a>
                    </li>
                </ul>
            </div>
            <div class="navbar align-self-center d-flex">
                <div class="d-lg-none flex-sm-fill mt-3 mb-4 col-7 col-sm-auto pr-3">
                    <div class="input-group">
                        <input type="text" class="form-control" id="inputMobileSearch" placeholder="Search ...">
                        <div class="input-group-text">
                            <i class="fa fa-fw fa-search"></i>
                        </div>
                    </div>
                </div>
                <a class="nav-icon d-none d-lg-inline" href="#" data-bs-toggle="modal"
                   data-bs-target="#templatemo_search">
                    <i class="fa fa-fw fa-search text-dark mr-2 fa-2x"></i>
                </a>
                <a class="nav-icon position-relative text-decoration-none" href="<c:url value='/cart'/>">
                    <i class="fa fa-fw fa-cart-arrow-down text-dark mr-1 fa-2x"></i>
                    <span id="cartNum"
                          class="position-absolute top-0 left-100 translate-middle badge rounded-pill bg-light text-dark">
                        <!-- 장바구니 아이템 개수 -->
                    </span>
                </a>
                <a class="nav-icon position-relative text-decoration-none" href="<c:url value='/mypage/order'/>">
                    <i class="fa fa-fw fa-user text-dark mr-3 fa-2x"></i>
                </a>
            </div>
        </div>
    </div>
</nav>
<!-- Close Header -->
<!-- Modal -->
<div class="modal fade bg-white" id="templatemo_search" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="w-100 pt-1 mb-5 text-right">
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <form action="<c:url value='/goods/list'/>" class="modal-content modal-body border-0 p-0">
            <div class="input-group mb-2">
                <input type="text" class="form-control" id="inputModalSearch" name="keyword" placeholder="상품을 검색해보세요">
                <button type="submit" class="input-group-text bg-success text-light">
                    <i class="fa fa-fw fa-search text-white"></i>
                </button>
            </div>
        </form>
    </div>
</div>
<script>
    checkLoginStatus()
    function checkLoginStatus() {
        let userId = '${userId}'
        if (userId === "") { // 로그아웃 상태
            $("#login").css("display", "inline-block")
            $("#register").css("display", "inline-block")
            $("#chatting").css("display", "none")
            // $("#admin").css("display", "none")
            $("#logout").css("display", "none")
            $("#cartNum").html("0")
        } else {
            getCartItemsNum()
            $("#login").css("display", "none")
            $("#register").css("display", "none")
            $("#chatting").css("display", "inline-block")
            // $("#admin").css("display", "inline-block")
            $("#logout").css("display", "inline-block")
        }
    }

    function getCartItemsNum(){
        $.ajax({
            type: "GET",            // HTTP method type(GET, POST) 형식이다.
            url: "/muscles/cart/" + '${userId}', // 컨트롤러에서 대기중인 URL 주소이다.
            headers: {"Content-Type": "application/json"},
            success: function (res) {
                $("#cartNum").html(res)
            },
            error: function () {
                console.log("통신 실패")
            }
        })
    }

</script>
</body>
</html>