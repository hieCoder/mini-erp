function callAjaxByDataForm(urlAPI, methodType, formData, callback) {
    $.ajax({
        url: urlAPI,
        type: methodType,
        processData: false,
        contentType: false,
        data: formData,
        enctype: 'multipart/form-data',
        success: function(response) {
            callback(response);
        },
        error: function (xhr, status, error) {
            Swal.fire({
                icon: 'error',
                text: JSON.parse(xhr.responseText).message
            });
        }
    });
}

function callAjaxByJson(urlAPI, methodType, formData, callback) {

    var data = {};
    formData.forEach((value, key) => data[key] = value);

    $.ajax({
        url: urlAPI,
        type: methodType,
        data: JSON.stringify(data),
        contentType: "application/json",
        dataType: 'json',
        success: function(response) {
            callback(response);
        },
        error: function (xhr, status, error) {
            Swal.fire({
                icon: 'error',
                text: JSON.parse(xhr.responseText).message
            });
        }
    });
}