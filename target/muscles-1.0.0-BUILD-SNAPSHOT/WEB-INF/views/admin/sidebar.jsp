<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="admin-item">
  <div id="side_bar_title">
    <span style="font-weight: bold">ADMIN</span>
  </div>
  <div id="side_bar_content">
    <p style="font-weight: bold">관리</p>
    <a href="<c:url value='/admin/user'/>"><p>> 유저</p></a>
    <a href="<c:url value='/admin/order'/>"><p>> 주문</p></a>
    <a href="<c:url value='/admin/product'/>"><p>> 상품</p></a>
  </div>
</div>