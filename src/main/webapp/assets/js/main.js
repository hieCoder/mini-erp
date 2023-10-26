
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
            resetForm(formId);
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

function callAjaxByDataFormWithDataForm2(urlAPI, methodType, formData, callback, callBackError) {
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
            callBackError();
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
            resetForm(formId);
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
            resetForm(formId);
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

function isAdminOrUserLogin(idUser) {
    return userCurrent.role != U_DEVELOPER || userCurrent.id == idUser;
}

function isDeleveloper() {
    return userCurrent.role == U_DEVELOPER;
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

function createLoadingIndicator() {
    if ($('#loading-indicator').length === 0) {
        var loadingIndicator = $('<div>', {
            id: 'loading-indicator',
            class: 'text-center',
            css: {
                position: 'absolute',
                top: '50%',
                left: '50%',
                transform: 'translate(-50%, -50%)'
            }
        });

        var spinnerIcon = $('<i>', {
            class: 'fa fa-spinner fa-spin fa-3x'
        });

        var loadingText = $('<p>', {
            text: 'Loading...'
        });

        loadingIndicator.append(spinnerIcon, loadingText);

        $('body').append(loadingIndicator);
    }
}

function showLoading(contentId) {
    if ($('#loading-indicator').length === 0) {
        createLoadingIndicator();
    } else {
        $('#loading-indicator').show();
    }

    $('#' + contentId).hide();
}

function hideLoading(contentId) {
    $('#loading-indicator').hide();
    $('#' + contentId).show();
}

function cutShortLink() {
    var fileElements = document.querySelectorAll('a.cut-file-name');

    fileElements.forEach(function (element) {
        var fileName = element.textContent;
        if (fileName.length > 0) {
            var indexOfHyphen = fileName.indexOf("-");
            if (indexOfHyphen !== -1) {
                var remainingPart = fileName.substring(indexOfHyphen + 1);
                if (remainingPart.length > 10) {
                    var truncatedFileName = remainingPart.substring(0, 10) + '...';
                } else {
                    var truncatedFileName = remainingPart;
                }
                element.textContent = truncatedFileName;
            }
        }
    });
}
