
// 별점 드래그
$(document).on('mouseup', '.starRange', function () {
    $(this).next().css("width", $(this).val() + '%')
})
$(document).ready(function () {
    let star_rating_width = $('.fill-ratings span').width();
    $('.star-ratings').width(star_rating_width);
})

// 로그인 상태에 따라 버튼 보여주기, 숨기기
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