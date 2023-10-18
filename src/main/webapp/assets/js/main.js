
// CONSTANT
const U_DEVELOPER = 'DEVELOPER';
const T_REGISTERED = 'REGISTERED';
const T_POSTPONSED = 'POSTPONSED';
const T_CLOSED = 'CLOSED';

// FUNCTION

function callAjaxByDataFormWithDataForm(urlAPI, methodType, formData, callback) {
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

function callAjaxByJsonWithDataForm(urlAPI, methodType, formData, callback) {

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

function callAjaxByJsonWithData(urlAPI, methodType, data, callback) {

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

function isBlank(a){
    return a === '' || a===null;
}

function formatDateValueToValueOfInputDate(s) {
    var dateArray = s.split('-');
    var date = new Date(Date.UTC(parseInt(dateArray[0]), parseInt(dateArray[1]) - 1, parseInt(dateArray[2])));
    return date.toISOString().slice(0, 10);
}

function getFileNameFromPath(path) {
    var parts = path.split("/");
    var lastPart = parts[parts.length - 1];
    return lastPart;
}

function isAdminOrUserLogin(idUser) {
    return userCurrent.role != U_DEVELOPER || userCurrent.id == idUser;
}

function createLoadingHtml() {
    return `
            <div class="text-center d-flex align-items-center justify-content-center">
                <div class="custom-spinner d-flex align-items-center justify-content-center">
                    <div class="dot"></div>
                </div>
            </div>
        `;
}

function resetForm(idForm){
    $('#'+idForm).find('*').prop('disabled', false);
    $('div.custom-spinner').parent().remove();
}