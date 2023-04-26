// 이미지 업로드
function uploadImg(url, e, category, type) {
    let fileList = e.files;

    if (type === 'thumbnail' && fileList.length > 0) {
        alert("나와")
        let target = $(e).next().children()
        let fileName = $(e).next().children().attr("data-filename")
        delPreviewImg("goods", fileName, "thumbnail", target)
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
            showPreview(items, type, category)
        }
    })
}

// 이미지 미리보기 출력
function showPreview(items, type, category) {
    console.log(items)
    let tmp = "";
    if (type === 'thumbnail') {
        tmp += '<div class="detail col-md-12" data-category=' + category + ' data-type=' + type + '>'
        tmp += '<button class="delPreview btn btn-danger mb-3 mt-3" type="button">X</button>'
        let url = "/muscles/img/display?category=" + category + "&type=" + type + "&fileName=" + items[0].fileName
        tmp += '<img class="img-fluid" id="newThumbnail" src="' + url + '">'
    } else {
        items.forEach(function (item) {
            let addr = "/muscles/img/display?category=" + category + "&type=" + type + "&fileName=" + item.fileName
            if (category === 'post')
                tmp += '<div class="detail col-md-4" data-category=' + category + ' data-type=' + type + ' data-fileName=' + item.fileName + '>'
            else
                tmp += '<div class="detail col-md-12" data-category=' + category + ' data-type=' + type + ' data-fileName=' + item.fileName + '>'

            tmp += '<button class="delPreview btn btn-danger mb-3 mt-3" type="button">X</button>'

            if (category === 'post') {
                tmp += '<button style="float: right" class="down btn btn-warning mb-3 mt-3" type="button">→</button>'
                tmp += '<button style="float: right; margin-right: 10px" class="up btn btn-warning mb-3 mt-3" type="button">←</button>'
            } else {
                tmp += '<button style="float: right" class="down btn btn-warning mb-3 mt-3" type="button">↑</button>'
                tmp += '<button style="float: right; margin-right: 10px" class="up btn btn-warning mb-3 mt-3" type="button">↓</button>'
            }
            tmp += '<img class="img-fluid newDetail" src="' + addr + '">'
            tmp += '</div>'
        });
    }
    type === 'thumbnail' ? $("#thumbnailPreview").append(tmp) : $("#detailPreview").append(tmp)
    showUpDownBtn()
    showLeftRightBtn()
}

// 미리보기 이미지 삭제
function delPreviewImg(category, fileName, type, target) {
    $.ajax({
        type: "DELETE",
        enctype: 'multipart/form-data',
        url: "/muscles/img/delete/" + category + "/" + type + "?fileName=" + fileName,
        success: function (res) {
            // 파일 삭제 성공 -> 해당 이미지 영역을 삭제
            if (res === "DEL_OK") {
                target.remove();
            }
        }
    })
}

// X 버튼 클릭시 (미리보기 이미지 삭제 함수 호출)
$(document).on("click", ".delPreview", function () {
    let category = $(this).parent().attr("data-category")
    let fileName = $(this).parent().attr("data-filename")
    let type = $(this).parent().attr("data-type")
    let target = $(this).parent()
    delPreviewImg(category, fileName, type, target)
});


function showImgDetail(src) {
    $("#modalImg").attr("src", src)
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