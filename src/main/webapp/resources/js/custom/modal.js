// 모달 내 입력값 초기화
$('#modal').on('hidden.bs.modal', function () {
    console.log('modal close');
    $("input").val("")
    $("textarea").val("")
    $("select").find('option:first').prop('selected', true);
    document.getElementById("thumbnail").select();
    document.getElementById("detail").select();
    document.getSelection().empty()
    $("#thumbnailPreview").empty()
    $("#detailPreview").empty()
    $("#reviewPreview").empty()
    $("#starRange").val("")
    $("#starRange").next().css("width", "100%")
    $("#orderCancelDetail").val("")
});