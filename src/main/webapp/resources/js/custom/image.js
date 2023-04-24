// 이미지 확대 모달 출력
function showImgDetail(src) {
    $("#modalImg").attr("src", src)
}
// 업로드된 이미지 삭제
function RemoveUploadImg(url){
    let fileName = $(this).parent().attr("data-url")
    let target = $(this).parent()
    deleteImg(target, "detail", fileName, url)
}

// 이미지 업로드
function uploadImg(url, e){
    let fileList = e.files;
    let formData = new FormData();
    for (let i = 0; i < fileList.length; i++)
        formData.append("uploadFile", fileList[i]);
    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: url,
        processData: false,
        contentType: false,
        data: formData,
        dataType: 'json',
        success: function (items) {
            showPreview(items, 'detail')
        }
    })
}

function showPreview(items, type) {
    let tmp = "";
    items.forEach(function (item) {
        let addr = "/muscles/img/display?category=goods&type=" + type + "&fileName=" + item.uploadName
        tmp += '<div class="detail" data-type=' + type + ' data-url=' + item.uploadName + '>'
        tmp += '<button class="delPreview btn btn-danger mb-3 mt-3" type="button">X</button>'
        if (type === 'thumbnail')
            tmp += '<img class="img-fluid" id="newThumbnail" src="' + addr + '">'
        else {
            tmp += '<button style="float: right" class="down btn btn-warning mb-3 mt-3" type="button">↓</button>'
            tmp += '<button style="float: right; margin-right: 10px" class="up btn btn-warning mb-3 mt-3" type="button">↑</button>'
            tmp += '<img class="img-fluid newDetail" src="' + addr + '">'
        }
        tmp += '</div>'
    });
    type === "detail" ? $("#detailPreview").append(tmp) : $("#thumbnailPreview").append(tmp);
    showUpDownBtn()
}

// 업로드된 이미지 삭제
$(document).on("click", ".delPreview", function () {
    let fileName = $(this).parent().attr("data-url")
    let type = $(this).parent().attr("data-type")
    let target = $(this).parent()
    deleteImg(target, type, "/muscles/img/delete/goods/" + type + "?fileName=" + fileName)
});

function deleteImg(target, type, url) {
    let targetDiv = target
    $.ajax({
        type: "DELETE",
        enctype: 'multipart/form-data',
        url: url,
        success: function (res) {
            // 파일 삭제가 성공적으로 이루어지면 해당 이미지 영역을 삭제한다.
            if (res === "DEL_OK") {
                targetDiv.empty();
            }
        }
    })
}

function uploadGoodsImg(url){
    let type = $(this).attr("id");
    let fileList = $(this)[0].files;
    if (type === 'thumbnail') {
        if (fileList.length > 1) {
            deleteImg($(this).next().children(), "thumbnail", $(this).next().children().attr("data-url"))
        }
    }
    let formData = new FormData();
    for (let i = 0; i < fileList.length; i++)
        formData.append("uploadFile", fileList[i]);
    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: url,
        processData: false,
        contentType: false,
        data: formData,
        dataType: 'json',
        success: function (items) {
            showPreview(items, type)
        }
    })
}

function showGoodsImgPreview(items,type){
    let tmp = "";
    items.forEach(function (item) {
        let addr = "/muscles/img/display?category=goods&type=" + type + "&fileName=" + item.uploadName
        tmp += '<div class="detail" data-type=' + type + ' data-url=' + item.uploadName + '>'
        tmp += '<button class="delPreview btn btn-danger mb-3 mt-3" type="button">X</button>'
        if (type === 'thumbnail')
            tmp += '<img class="img-fluid" id="newThumbnail" src="' + addr + '">'
        else {
            tmp += '<button style="float: right" class="down btn btn-warning mb-3 mt-3" type="button">↓</button>'
            tmp += '<button style="float: right; margin-right: 10px" class="up btn btn-warning mb-3 mt-3" type="button">↑</button>'
            tmp += '<img class="img-fluid newDetail" src="' + addr + '">'
        }
        tmp += '</div>'
    });
    type === "detail" ? $("#detailPreview").append(tmp) : $("#thumbnailPreview").append(tmp);
    showUpDownBtn()
}

function showUpDownBtn() {
    $("button:contains('↑')").show()
    $('.detail:first-child button:contains("↑")').hide();
    $("button:contains('↓')").show()
    $('.detail:last-child button:contains("↓")').hide();
}

function showLeftRightBtn() {
    $("button:contains('←')").show()
    $('.detail:first-child button:contains("←")').hide();
    $("button:contains('→')").show()
    $('.detail:last-child button:contains("→")').hide();
}
$(document).on("click", '.detail button:contains("←")', function () {
    let currentDiv = $(this).parent();
    let prevDiv = currentDiv.prev('.detail');
    if (prevDiv.length !== 0) currentDiv.insertBefore(prevDiv);
    showLeftRightBtn()
});
$(document).on("click", '.detail button:contains("→")', function () {
    let currentDiv = $(this).parent();
    let nextDiv = currentDiv.next('.detail');
    if (nextDiv.length !== 0) currentDiv.insertAfter(nextDiv);
    showLeftRightBtn()
});
$(document).on("click", '.detail button:contains("↑")', function () {
    let currentDiv = $(this).parent();
    let prevDiv = currentDiv.prev('.detail');
    if (prevDiv.length !== 0) currentDiv.insertBefore(prevDiv);
    showUpDownBtn()
});
$(document).on("click", '.detail button:contains("↓")', function () {
    let currentDiv = $(this).parent();
    let nextDiv = currentDiv.next('.detail');
    if (nextDiv.length !== 0) currentDiv.insertAfter(nextDiv);
    showUpDownBtn()
});