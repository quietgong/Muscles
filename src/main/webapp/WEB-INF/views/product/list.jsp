<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Muscles</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>"/>
</head>
<body>
<!-- nav -->
<%@ include file="../nav.jsp" %>

<!-- 본문 -->
<div>
    <p>${param.category}</p>
    <p>총 ${totalCnt}개의 상품이 있습니다.</p>
</div>
<div class="product-list-container" style="justify-content: flex-end;">
    <form action="" id="conditionSearch">
        <input class="condition" type="button" value="낮은가격 순"/>
        |
        <input class="condition" type="button" value="높은가격 순"/>
        |
        <input class="condition" type="button" value="리뷰점수 높은 순"/>
    </form>
</div>
<!-- 반복부 -->
<div class="product-list-container">
    <c:forEach var="productDto" items="${list}">
        <div class="product-list-item">
            <a href="<c:url value='/product/detail?productNo=${productDto.productNo}'/>">
                <img style="width: 250px; height: 250px;" src="${productDto.productImgPath}">
            </a>
            <span style="font-weight: bold;">${productDto.productName}</span>
            <div>
                <span class="star">★★★★★<span style="width: ${productDto.productReviewScore}%">★★★★★</span></span>
            </div>
            <span style="font-weight: bold;">${productDto.productPrice}</span>
            <span style="font-weight: bold;">리뷰개수 : ${productDto.reviewDtoList.size()}</span>
        </div>
    </c:forEach>
</div>
<c:if test="${totalCnt!=null&&totalCnt!=0}">
    <ul class="paging">
        <c:if test="${ph.showPrev}">
            <li>
                <a href="<c:url value='/product/list${ph.sc.getQueryString(ph.beginPage-1)}'/>">&lt</a>
            </li>
        </c:if>
        <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
            <li>
                <a href="<c:url value='/product/list${ph.sc.getQueryString(i)}'/>">${i}</a>
            </li>
        </c:forEach>
        <c:if test="${ph.showNext}">
            <li>
                <a href="<c:url value='/product/list${ph.sc.getQueryString(ph.endPage+1)}'/>">&gt</a>
            </li>
        </c:if>
    </ul>
</c:if>
<hr>
<!-- 반복부 -->
<!-- footer -->
<%@ include file="../footer.jsp" %>
<script>
    $(".condition").on("click", function () {
        let option = "";
        if ($(this).val() == "낮은가격 순")
            option = 'lowPrice'
        else if($(this).val() == "높은가격 순")
            option = 'highPrice'
        else
            option = 'review'

        const form = $("#conditionSearch")
        form.append($('<input>').attr({
            type: 'hidden',
            name: 'page',
            value: ${ph.sc.page}
        }))
        form.append($('<input>').attr({
            type: 'hidden',
            name: 'category',
            value: '${ph.sc.category}'
        }))
        form.append($('<input>').attr({
            type: 'hidden',
            name: 'option',
            value: option
        }))
        form.append($('<input>').attr({
            type: 'hidden',
            name: 'keyword',
            value: '${ph.sc.keyword}'
        }))
        form.submit()
    })
</script>
</body>
</html>