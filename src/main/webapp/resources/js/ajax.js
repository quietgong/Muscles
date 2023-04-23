function commonAjax(url, parameter, type, callback) {
    $.ajax({
        type: type,
        url: url,
        data: JSON.stringify(parameter),
        headers: {              // Http header
            "Content-Type": "application/json",
        },
        success: function (res) {
            callback(res);
        },
        error: function (err) {
            console.log('error');
            callback(err);
        }
    });
}