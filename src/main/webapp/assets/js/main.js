
// CONSTANT
const U_DEVELOPER = 'DEVELOPER';
const T_REGISTERED = 'REGISTERED';
const T_POSTPONSED = 'POSTPONSED';
const T_CLOSED = 'CLOSED';

const M_SIX_TO_TWELVE_PM = 'SIX_TO_TWELVE_PM';
const M_TWELVE_TO_SIX_PM = 'TWELVE_TO_SIX_PM';
const M_SIX_TO_TWELVE_AM = 'SIX_TO_TWELVE_AM';

// FUNCTION

function callAjaxByDataFormWithDataForm(urlAPI, methodType, formData, callback, formId) {
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
            resetForm(formId);
            Swal.fire({
                icon: 'error',
                text: JSON.parse(xhr.responseText).message
            });
        }
    });
}

function callAjaxByJsonWithDataForm(urlAPI, methodType, formData, callback, formId) {

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
            resetForm(formId);
            Swal.fire({
                icon: 'error',
                text: JSON.parse(xhr.responseText).message
            });
        }
    });
}

function callAjaxByJsonWithData(urlAPI, methodType, data, callback, formId) {

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
            resetForm(formId);
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

function isAdminOrUserLogin() {
    return userCurrent.role != U_DEVELOPER;
}

function isUser(idUser) {
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