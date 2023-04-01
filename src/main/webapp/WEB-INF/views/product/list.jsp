<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- nav -->
<%@ include file="../nav.jsp" %>
<style>
    img{
        border-radius: 20px;
        transition: all 0.3s ease-in-out;
        z-index: 20;
        box-shadow: 5px 5px 26px 0px rgba(0,0,0,0.49);
    }
</style>
<!-- 본문 -->
<div>
    <span>${param.category}</span><br>
    <span>${param.keyword} 검색 결과</span><br>
    <span>총 ${totalCnt}개의 상품이 있습니다.</span>
</div>
<div class="product-list-container" style="justify-content: flex-end;">
    <form action="" id="conditionSearch">
        <input class="condition" type="button" value="낮은가격 순"/>
        <input class="condition" type="button" value="높은가격 순"/>
        <input class="condition" type="button" value="리뷰점수 높은 순"/>
    </form>
</div>
<!-- 반복부 -->
<div class="product-list-container" style="padding: 30px">
    <c:forEach var="productDto" items="${list}">
        <div class="product-list-item" style="padding: 30px">
            <a href="<c:url value='/product/detail?productNo=${productDto.productNo}'/>">
                <c:choose>
                    <c:when test="${productDto.productImgPath eq null}">
                        <img style="width: 300px; height: 400px;" src="<c:url value='/img/logo.jpg'/>">
                    </c:when>
                    <c:otherwise>
                        <img style="width: 300px; height: 400px;" src="${productDto.productImgPath}">
                    </c:otherwise>
                </c:choose>
            </a>
            <span style="font-weight: bold;">${productDto.productName}</span>
            <div>
                <span class="star">★★★★★<span style="width: ${productDto.productReviewScore}%">★★★★★</span></span>
            </div>
            <div>
            <span style="font-weight: bold;">${productDto.productPrice}</span>
            <span>리뷰개수 : ${productDto.reviewDtoList.size()}</span>
            </div>
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
<!-- 반복부 -->
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
<!-- footer -->
<%@ include file="../footer.jsp" %>