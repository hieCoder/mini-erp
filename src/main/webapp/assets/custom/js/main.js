
// CONSTANT
const U_DEVELOPER = 'DEVELOPER';

const INVALID_FILES_LIMIT = 'INVALID_FILES_LIMIT';
const INVALID_FILES_FILESIZE = 'INVALID_FILES_FILESIZE';
const INVALID_FILES_FILETYPE = 'INVALID_FILES_FILETYPE';

// const M_SIX_TO_TWELVE_PM = 'SIX_TO_TWELVE_PM';
// const M_TWELVE_TO_SIX_PM = 'TWELVE_TO_SIX_PM';
// const M_SIX_TO_TWELVE_AM = 'SIX_TO_TWELVE_AM';

//
// FUNCTION

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

// function isBlank(a){
//     return a === '' || a===null;
// }

function formatDateValueToValueOfInputDate(s) {
    var dateArray = s.split('-');
    var date = new Date(Date.UTC(parseInt(dateArray[0]), parseInt(dateArray[1]) - 1, parseInt(dateArray[2])));
    return date.toISOString().slice(0, 10);
}

function isAdminOrUserLogin(idUser) {
    return userCurrent.role != U_DEVELOPER || userCurrent.id == idUser;
}

function isDeleveloper() {
    return userCurrent.role == U_DEVELOPER;
}

// function createLoadingIndicator() {
//     if ($('#loading-indicator').length === 0) {
//         var loadingIndicator = $('<div>', {
//             id: 'loading-indicator',
//             class: 'text-center',
//             css: {
//                 position: 'absolute',
//                 top: '50%',
//                 left: '50%',
//                 transform: 'translate(-50%, -50%)'
//             }
//         });
//
//         var spinnerIcon = $('<i>', {
//             class: 'fa fa-spinner fa-spin fa-3x'
//         });
//
//         var loadingText = $('<p>', {
//             text: 'Loading...'
//         });
//
//         loadingIndicator.append(spinnerIcon, loadingText);
//
//         $('body').append(loadingIndicator);
//     }
// }
//
// function showLoading(contentId) {
//     if ($('#loading-indicator').length === 0) {
//         createLoadingIndicator();
//     } else {
//         $('#loading-indicator').show();
//     }
//
//     $('#' + contentId).hide();
// }
//
// function hideLoading(contentId) {
//     $('#loading-indicator').hide();
//     $('#' + contentId).show();
// }

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

function convertExtensionsList(extensions) {
    const extensionArray = extensions.split(',');
    const formattedExtensions = extensionArray.map(extension => `.${extension.trim()}`);
    return formattedExtensions.join(',');
}

function getMessageLimitFile(limit){
    return 'The number of files must be less than ' + limit;
}

function getMessageSizeFile(fileSize){
    return 'The size of the file must be less than ' + fileSize + ' Mb';
}

function getMessageTypeFile(fileType){
    return 'Files must be of the following types: ' + fileType;
}

function convertMbToB(mb){
    return mb * 1024 * 1024;
}

function alertSuccess(mess){
    Swal.fire(
        {
            title: 'Good job!',
            text: mess,
            icon: 'success',
            showCancelButton: true,
            confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
            cancelButtonClass: 'btn btn-danger w-xs mt-2',
            buttonsStyling: false,
            showCloseButton: true
        }
    )
}