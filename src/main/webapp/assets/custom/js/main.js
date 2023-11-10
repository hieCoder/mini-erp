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
    return (bytes / (1024 * 1024)).toFixed(2)
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

function subscribeUser(){
    navigator.serviceWorker.ready.then(function(registration) {
        try {
            if (!registration.pushManager) {
                alert('Push Unsupported');
                return;
            }
            registration.pushManager.getSubscription().then(function(subscription) {
                if (subscription) {
                    console.log('User is already subscribed:', subscription);
                } else {
                    registration.pushManager.subscribe({
                        userVisibleOnly: true,
                        applicationServerKey: urlBase64ToUint8Array("BH9v1XdUflNRCS0s7vExsPf7KPj5h2wXG3hW92S2jpXcFtbCDP4jP_nW4kFOOMV2AFfb_CTTHW8soN74VsT9u9k")
                    }).then(function(subscription) {
                        console.log('User is subscribed:', subscription);
                        const subscriptionJson = subscription.toJSON();
                        updateSubscriptionOnServer({
                            endpoint: subscriptionJson.endpoint,
                            p256dh: subscriptionJson.keys.p256dh,
                            auth: subscriptionJson.keys.auth
                        });
                    }).catch(function(error) {
                        console.log('Failed to subscribe', error.message);
                    });
                }
            });
        }catch (e){
            console.log(e)
            unsubscribeUser()
        }
    });
}

// Helper function
function urlBase64ToUint8Array(base64String) {
    const padding = '='.repeat((4 - base64String.length % 4) % 4);
    const base64 = (base64String + padding)
        .replace(/\-/g, '+')
        .replace(/_/g, '/');

    const rawData = window.atob(base64);
    const outputArray = new Uint8Array(rawData.length);

    for (let i = 0; i < rawData.length; ++i) {
        outputArray[i] = rawData.charCodeAt(i);
    }
    return outputArray;
}

function updateSubscriptionOnServer(subscription) {
    // Sử dụng fetch để gửi thông tin đăng ký đến endpoint '/subscribe' trên server
    fetch('/api/v1/subscribe/', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(subscription)
    })
        .then(function(response) {
            if (!response.ok) {
                throw new Error('Bad status code from server.');
            }
            return response.json();
        })
        .then(function(responseData) {
            console.log(responseData)
            if (responseData != 1) {
                throw new Error('Bad response from server.');
            }
            console.log('User subscription updated on server.');
        })
        .catch(function(error) {
            console.error('Error during subscription update on server:', error);
        });
}

function unsubscribeUser() {
    navigator.serviceWorker.ready.then(function(registration) {
        registration.pushManager.getSubscription().then(function(subscription) {
            if (subscription) {
                subscription.unsubscribe().then(function(successful) {
                    console.log('User is unsubscribed.');
                    fetch('/api/v1/subscribe', {
                        method: 'DELETE',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                            endpoint: subscription.endpoint
                        })
                    }).then(function(response) {
                        console.log('Server is notified about the unsubscription.');
                    }).catch(function(error) {
                        console.error('Failed to notify the server about the unsubscription.', error);
                    });
                }).catch(function(e) {
                    console.log('Failed to unsubscribe the user: ', e);
                });
            } else {
                console.log('User IS NOT subscribed.');
            }
        });
    });
}

function registerServiceWorker(){
    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register("/service-worker.js")
            .then(function(registration) {
                console.log('Service Worker registered with scope:', registration.scope);
            }).catch(function(error) {
            console.log('Service Worker registration failed:', error);
        });
    }
}

registerServiceWorker()

// Check if notification permission has been granted
if( typeof userCurrent !== "undefined"){
    if (Notification.permission === 'granted') {
        // Permission has been granted, you can perform notification operations here
        subscribeUser()
    } else if (Notification.permission === 'default') {
        // Permission hasn't been granted, request notification permission from the user
        Notification.requestPermission().then(function(permission) {
            if (permission === 'granted') {
                // Permission has been granted, you can perform notification operations here
                subscribeUser()
            } else {
                // Permission denied, handle accordingly
                unsubscribeUser()
                console.log('Permission for notifications denied.');
            }
        });
    } else {
        // Permission denied, handle accordingly
        unsubscribeUser()
        console.log('Permission for notifications denied.');
    }
} else{
    unsubscribeUser()
    console.log('Must log in');
}




