// 상품 등록/수정 모달 초기화
$('#goodsModal').on('hidden.bs.modal', function () {
    $("input").val("")
    $("textarea").val("")
    $("select").find('option:first').prop('selected', true);
    $("#thumbnailPreview").empty()
    $("#detailPreview").empty()
    $("#reviewPreview").empty()
    $("#starRange").val("")
    $("#starRange").next().css("width", "100%")
    $("#orderCancelDetail").val("")

    document.getElementById("thumbnail").select();
    document.getElementById("detail").select();
    document.getSelection().empty()
});
// 주문 취소 모달 초기화
$('#orderCancelModal').on('hidden.bs.modal', function () {
    $("input[name='orderCancelOption']").eq(0).attr("checked", true)
    $("#orderCancelDetail").hide()
    $("#orderCancelContent").val("")
});

// 리뷰 작성 모달 초기화
$("#reviewModal").on('hidden.bs.modal', function () {
    $("#starRange").val("100");
    $("#reviewContent").val("");
    document.getElementById("reviewImg").select();
    document.getSelection().empty()
    $("#detailPreview").empty()
});

// FAQ 등록 모달 초기화
$("#faqModal").on('hidden.bs.modal', function () {
    $("#content").val("")
});