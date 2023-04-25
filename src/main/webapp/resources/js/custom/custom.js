// 별점 드래그
$(document).on('mouseup', '.starRange', function () {
    $(this).next().css("width", $(this).val() + '%')
})

// 별점 표시
$(document).ready(function () {
    let star_rating_width = $('.fill-ratings span').width();
    $('.star-ratings').width(star_rating_width);
})