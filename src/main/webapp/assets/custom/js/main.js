// CONSTANT
const U_DEVELOPER = 'DEVELOPER';
const U_OWNER = 'OWNER';
const U_MANAGER = 'MANAGER';

const SUCCESS_ALERT = 'SUCCESS_ALERT';
const DANGER_ALERT = 'DANGER_ALERT';

// loading
const BtnLoadRemove = () => {
    $('.btn-load').remove()
}
const BtnPrimaryLoad = '<button class="btn btn-outline-primary btn-load" style="margin-left: 8px">' +
    '<span class="d-flex align-items-center">' +
    '<span class="spinner-border flex-shrink-0" role="status">' +
    '<span class="visually-hidden">Loading...</span>' +
    '</span>' +
    '<span class="flex-grow-1 ms-2">' +
    'Loading...' +
    '</span>' +
    '</span>' +
    '</button>';
const BtnSuccessLoad = '<button type="button" class="btn btn-success btn-load" style="margin-left: 8px">' +
    '<span class="d-flex align-items-center">' +
    '<span class="spinner-border flex-shrink-0" role="status">' +
    '<span class="visually-hidden">Loading...</span>' +
    '</span>' +
    '<span class="flex-grow-1 ms-2">' +
    'Loading...' +
    '</span>' +
    '</span>' +
    '</button>';
//
// const BtnSecondaryLoad = '<button type="button" class="btn btn-outline-secondary btn-load" style="margin-left: 8px">' +
// '<span class="d-flex align-items-center">' +
// '<span class="spinner-grow flex-shrink-0" role="status">' +
// '<span class="visually-hidden">Loading...</span>' +
// '</span>' +
// '<span class="flex-grow-1 ms-2">' +
// 'Loading...' +
// '</span>' +
// '</span>' +
// '</button>';

const BtnDangerLoad = '<button type="button" class="btn btn-danger btn-load" style="margin-left: 8px">' +
    '<span class="d-flex align-items-center">' +
    '<span class="spinner-grow flex-shrink-0" role="status">' +
    '<span class="visually-hidden">Loading...</span>' +
    '</span>' +
    '<span class="flex-grow-1 ms-2">' +
    'Loading...' +
    '</span>' +
    '</span>' +
    '</button>';

// FUNCTION

// call api
function callAjaxByDataFormWithDataForm(urlAPI, methodType, formData, callbackSuccess, callbackFail) {
    $.ajax({
        url: urlAPI,
        type: methodType,
        processData: false,
        contentType: false,
        data: formData,
        enctype: 'multipart/form-data',
        success: function(response) {
            if(callbackSuccess) callbackSuccess(response);
        },
        error: function (xhr, status, error) {
            if(callbackFail) callbackFail(xhr);
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
        success: function (response) {
            if (callbackSuccess) callbackSuccess(response);
        },
        error: function (xhr, status, error) {
            if (callbackFail) callbackFail(xhr);
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
        success: function (response) {
            if (callbackSuccess) callbackSuccess(response);
        },
        error: function (xhr, status, error) {
            if (callbackFail) callbackFail(xhr);
        }
    });
}

// file
function handleFiles(arrUrl, handleEachFunc) {
    arrUrl.forEach(function (url, index) {
        $.ajax({
            type: "HEAD",
            url: url,
            success: function (data, status, xhr) {
                var fileSize = xhr.getResponseHeader('Content-Length');
                var fileName = url.substring(url.lastIndexOf("/") + 1);
                if (handleEachFunc) handleEachFunc(fileName, fileSize, url);
            }
        });
    });
}
async function handleFilesAsync(arrUrl, handleEachFunc) {
    var promises = arrUrl.map(function (url) {
        return new Promise(function (resolve, reject) {
            $.ajax({
                type: "HEAD",
                url: url,
                success: function (data, status, xhr) {
                    var fileSize = xhr.getResponseHeader('Content-Length');
                    var fileName = url.substring(url.lastIndexOf("/") + 1);
                    if (handleEachFunc) {
                        handleEachFunc(fileName, fileSize, url);
                    }
                    resolve();
                },
                error: function (xhr, status, error) {
                    reject(error);
                }
            });
        });
    });

    await Promise.all(promises);
}
function bytesToMB(bytes) {
    return parseInt((bytes / (1024 * 1024)).toFixed(0));
}
function convertMbToB(mb) {
    return mb * 1024 * 1024;
}
function bToKbShow(bytes) {
    return (bytes / 1024).toFixed(2);
}
function bytesToMBShow(bytes) {
    return (bytes / (1024 * 1024)).toFixed(2);
}
function checkLimitFile(count, limit) {
    return count <= limit ? true : false;
}
function checkTypeFile(type, listType) {
    if (listType.includes(type)) {
        return true;
    }
}
function checkLimitSize(size, limit) {
    if (parseInt(size) <= limit) {
        return true;
    }
}
function downloadFiles(url) {
    var link = document.createElement('a');
    link.download = "";
    link.href = url;
    link.style.display = 'none';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}
function showFileUploaded(fileName, size, url, mode) {
    let html = ""

    if (mode === "edit") {
        html = "<button type='button' class='btn btn-icon text-muted btn-sm fs-18 deleteFileBtn'>"
            + " <i class='ri-delete-bin-fill' data-name='" + fileName + "'></i>"
            + " </button>"
    }

    return "<div class='col-xxl-4 col-lg-6' data-name='" + fileName + "'>"
        + " <div class='border rounded border-dashed p-2'>"
        + " <div class='d-flex align-items-center'>"
        + " <div class='flex-shrink-0 me-3'>"
        + " <div class='avatar-sm'>"
        + " <div class='avatar-title bg-light text-secondary rounded fs-24'>"
        + " <i class='ri-file-download-line'></i>"
        + " </div>"
        + " </div>"
        + " </div>"
        + " <div class='flex-grow-1 overflow-hidden'>"
        + " <h5 class='fs-13 mb-1'><a href='" + url + "' download data-toggle='tooltip' data-placement='bottom' title='" + fileName + "' class='text-body text-truncate d-block'>" + fileName + "</a></h5>"
        + " <div>" + bytesToMBShow(size) + " MB</div>"
        + " </div>"
        + " <div class='flex-shrink-0 ms-2'>"
        + " <div class='d-flex gap-1'>"
        + " <button type='button' class='btn btn-icon text-muted btn-sm fs-18 downFileBtn'>"
        + " <i class='ri-download-2-line' data-url='" + url + "'></i>"
        + " </button>"
        + html
        + " </div>"
        + " </div>"
        + " </div>"
        + " </div>"
        + "</div>";
}
function convertExtensionsList(extensions) {
    const extensionArray = extensions.split(',');
    const formattedExtensions = extensionArray.map(extension => `.${extension.trim()}`);
    return formattedExtensions.join(',');
}

// alert
function removeAlert() {
    $(".alert-danger").remove();
}
function showAlertValidate(html) {
    let xhtml = '<li class="mt-2" id=""> ' +
        html +
        '</li>'

    let check = $("#dropzone-preview-edit li").children().last()
    if (check.length > 0) {
        $("#dropzone-preview-edit li").children().last().after(xhtml)
    } else {
        $("#dropzone-preview-edit").html(xhtml)
    }
}
function showAlertValidateCreate(html) {
    let xhtml = '<li class="mt-2" id=""> ' +
        html +
        '</li>'

    let check = $("#dropzone-preview li").children().last()
    if (check.length > 0) {
        $("#dropzone-preview li").children().last().after(xhtml)
    } else {
        $("#dropzone-preview").html(xhtml)
    }

}
function alertSuccess(mess){
    Swal.fire(
        {
            title: 'Success!',
            text: mess,
            icon: 'success',
            confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
            buttonsStyling: false,
            showCloseButton: true
        }
    );
}
function showAlertLoading() {
    Swal.fire({
        title: 'Wait a minute...',
        allowOutsideClick: false,
        didOpen: () => {
            Swal.showLoading();
        }
    });
    return Swal;
}
function showAlert(type, mess){
    var className = '';
    if(type == SUCCESS_ALERT){
        className = '.alert.alert-success';
    } else if(type == DANGER_ALERT){
        className = '.alert.alert-danger';
    }
    $(className).text(mess);
    $(className).removeClass('d-none');
}


// money format
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(amount);
}

// date format
function formatDateValueToValueOfInputDate(s) {
    var dateArray = s.split('-');
    var date = new Date(Date.UTC(parseInt(dateArray[0]), parseInt(dateArray[1]) - 1, parseInt(dateArray[2])));
    return date.toISOString().slice(0, 10);
}

// string utils
function isBlank(a) {
    return a === '' || a === null;
}

// login utils
function isAdminOrUserLogin(idUser) {
    return userCurrent.role != U_DEVELOPER || userCurrent.id == idUser;
}
function isDeleveloper() {
    return userCurrent.role == U_DEVELOPER;
}
function isOwner() {
    return userCurrent.role == U_OWNER;
}

// error messsage
function getMessageLimitFile(limit) {
    return 'The number of files must be less than ' + limit;
}
function getMessageSizeFile(fileSize) {
    return 'The size of the file must be less than ' + fileSize + ' Mb';
}
function getMessageTypeFile(fileType) {
    return 'Files must be of the following types: ' + fileType;
}

// focus pointer to end element
function focusElement(element) {
    const range = document.createRange();
    const sel = window.getSelection();
    range.selectNodeContents(element[0]);
    range.collapse(false);
    sel.removeAllRanges();
    sel.addRange(range);
}

// function createLoadingIndicator() {
// if ($('#loading-indicator').length === 0) {
// var loadingIndicator = $('<div>', {
// id: 'loading-indicator',
// class: 'text-center',
// css: {
// position: 'absolute',
// top: '50%',
// left: '50%',
// transform: 'translate(-50%, -50%)'
// }
// });
//
// var spinnerIcon = $('<i>', {
// class: 'fa fa-spinner fa-spin fa-3x'
// });
//
// var loadingText = $('<p>', {
// text: 'Loading...'
// });
//
// loadingIndicator.append(spinnerIcon, loadingText);
//
// $('body').append(loadingIndicator);
// }
// }

// function showLoading(contentId) {
// if ($('#loading-indicator').length === 0) {
// createLoadingIndicator();
// } else {
// $('#loading-indicator').show();
// }
//
// $('#' + contentId).hide();
// }

// function hideLoading(contentId) {
// $('#loading-indicator').hide();
// $('#' + contentId).show();
// }






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
            } else if (fileName.length > 14) truncatedFileName = fileName.substring(0, 14) + '...';
            else truncatedFileName = fileName;
            element.textContent = truncatedFileName;
        }
    });
}

