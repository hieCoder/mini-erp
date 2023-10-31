
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
            if(callback) callback(response);
        },
        error: function (xhr, status, error) {
            if(callBackError) callBackError(xhr);
        }
    });
}

function callAjaxByJsonWithDataForm(urlAPI, methodType, formData, callbackSuccess, callbackFail) {
    var data = {};
    formData.forEach((value, key) => data[key] = value);

    $.ajax({
        url: urlAPI,
        type: methodType,
        data: JSON.stringify(data),
        contentType: "application/json",
        dataType: 'json',
        success: function(response) {
            if(callbackSuccess) callbackSuccess(response);
        },
        error: function (xhr, status, error) {
            if(callbackFail) callbackFail(xhr);
        }
    });
}

function callAjaxByJsonWithData(urlAPI, methodType, data, callbackSuccess, callbackFail) {
    $.ajax({
        url: urlAPI,
        type: methodType,
        data: JSON.stringify(data),
        contentType: "application/json",
        dataType: 'json',
        success: function(response) {
            if(callbackSuccess) callbackSuccess(response);
        },
        error: function (xhr, status, error) {
            if(callbackFail) callbackFail(xhr);
        }
    });
}

function handleFiles(arrUrl, handleEachFunc){
    arrUrl.forEach(function (url,index) {
        $.ajax({
            type: "HEAD",
            url: url,
            success: function (data, status, xhr) {
                var fileSize = xhr.getResponseHeader('Content-Length');
                var fileName = url.substring(url.lastIndexOf("/") + 1);
                if(handleEachFunc) handleEachFunc(fileName, fileSize, url);
            }
        });
    });
}

function showFileUploaded(fileName, size, url, mode){
    let html =""

    if(mode === "edit"){
        html =  "<button type='button' class='btn btn-icon text-muted btn-sm fs-18 deleteFileBtn'>"
            + "    <i class='ri-delete-bin-fill' data-name='"+ fileName +"'></i>"
            + "  </button>"
    }

    return "<div class='col-xxl-4 col-lg-6' data-name='"+ fileName +"'>"
        + "    <div class='border rounded border-dashed p-2'>"
        + "        <div class='d-flex align-items-center'>"
        + "            <div class='flex-shrink-0 me-3'>"
        + "                <div class='avatar-sm'>"
        + "                    <div class='avatar-title bg-light text-secondary rounded fs-24'>"
        + "                        <i class='ri-file-download-line'></i>"
        + "                    </div>"
        + "                </div>"
        + "            </div>"
        + "            <div class='flex-grow-1 overflow-hidden'>"
        + "                <h5 class='fs-13 mb-1'><a href='"+ url +"' download data-toggle='tooltip' data-placement='bottom' title='"+ fileName+"' class='text-body text-truncate d-block'>" + fileName + "</a></h5>"
        + "                <div>"+ bytesToMBShow(size)+" MB</div>"
        + "            </div>"
        + "            <div class='flex-shrink-0 ms-2'>"
        + "                <div class='d-flex gap-1'>"
        + "                    <button type='button' class='btn btn-icon text-muted btn-sm fs-18 downFileBtn'>"
        + "                        <i class='ri-download-2-line' data-url='"+ url +"'></i>"
        + "                    </button>"
        + html
        + "                </div>"
        + "            </div>"
        + "        </div>"
        + "    </div>"
        + "</div>";
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
                var truncatedFileName;
                if (remainingPart.length > 14) {
                    truncatedFileName = remainingPart.substring(0, 10) + '...';
                } else {
                    truncatedFileName = remainingPart;
                }
            } else {
                if (fileName.length > 14) truncatedFileName = fileName.substring(0, 14) + '...';
            }
            element.textContent = truncatedFileName;
        }
    });
}
