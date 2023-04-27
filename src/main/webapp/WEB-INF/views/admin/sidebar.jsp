<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    .admin-links{
        text-decoration: none;
        cursor: pointer;
        color: #0a53be;
    }
</style>
<h5 style="font-weight: bold">ADMIN</h5>
<hr class="col-8 mt-2">
<a class="admin-links" href="<c:url value='/admin/user'/>"><p>> 고객 관리</p></a>
<a class="admin-links" href="<c:url value='/admin/order'/>"><p>> 주문 관리</p></a>
<a class="admin-links" href="<c:url value='/admin/goods'/>"><p>> 상품 관리</p></a>