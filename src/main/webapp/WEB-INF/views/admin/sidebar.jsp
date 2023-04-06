<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Sidebar -->
<nav id="sidebarMenu" class="collapse d-lg-block sidebar collapse bg-white">
  <div class="position-sticky">
    <div class="list-group list-group-flush mx-3 mt-4">
<%--      <a href="#" class="list-group-item list-group-item-action py-2 ripple">--%>
<%--        <i class="fas fa-tachometer-alt fa-fw me-3"></i><span>Main</span>--%>
<%--      </a>--%>
<%--      <a href="#" class="list-group-item list-group-item-action py-2 ripple"><i--%>
<%--              class="fas fa-chart-line fa-fw me-3"></i><span>분석</span></a>--%>
      <a href="<c:url value='/admin/user'/>" class="list-group-item list-group-item-action py-2 ripple"><i
              class="fas fa-users fa-fw me-3"></i><span>고객 관리</span></a>
      <a href="<c:url value='/admin/order'/>" class="list-group-item list-group-item-action py-2 ripple"><i
              class="fas fa-money-bill fa-fw me-3"></i><span>주문 관리</span></a>
      <a href="<c:url value='/admin/product'/>" class="list-group-item list-group-item-action py-2 ripple"><i
              class="fas fa-dumpster fa-fw me-3"></i><span>상품 관리</span></a>
    </div>
  </div>
</nav>
<!-- Sidebar -->