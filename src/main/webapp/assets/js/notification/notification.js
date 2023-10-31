const baseUrlComment = "/api/v1/comment-notification";
const baseUrlNotification = "/api/v1/notifications";
const notFilled = '<span class="text-danger font-weight-bold font-italic small">This field is not filled</span>'
var snowEditorData = {};
snowEditorData.theme = 'snow'
snowEditorData.modules = {
    'toolbar': [[{ 'font': [] }, { 'size': [] }], ['bold', 'italic', 'underline', 'strike'],
        [{ 'color': [] }, { 'background': [] }], [{ 'script': 'super' }, { 'script': 'sub' }],
        [{ 'header': [false, 1, 2, 3, 4, 5, 6] }, 'blockquote', 'code-block'],
        [{ 'list': 'ordered' }, { 'list': 'bullet' }, { 'indent': '-1' }, { 'indent': '+1' }],
        ['direction', { 'align': [] }], ['link', 'image', 'video'], ['clean']]
}

$(document).on("click","button.removeNotification", function (){
    let notificationId = $(this).parent().parent().attr("data-id")
    $("#deleteNotification").attr("data-id", notificationId)
    $("#deleteNotification").modal("show")
})

$(document).on("click","button.deleteFileBtn",function (){
    let fileName = $(this).children().attr("data-name")
    $("#deleteFileModal").attr("data-name", fileName)
    $("#deleteFileModal").modal("show")
})

function backToList(){
    window.location.href = "/notifications"
}

$(document).on("click","button.backToList", function (){
    backToList()
})

$(document).on("click","#deleteNotificationBtn", function (){
    let notificationId = $("#deleteNotification").attr("data-id")
    let apiUrlNotification = baseUrlNotification;
    if(notificationId){
        callAjaxByJsonWithData(apiUrlNotification + "/" + notificationId, 'DELETE', null, function (rs) {
            if(rs){
                loadDatabase();
                $("#deleteSuccessNotification").modal("show");
            }
            $("#deleteNotification").modal("hide")
        });
    }
})

function downloadFiles(url){
    var link = document.createElement('a');
    link.href = url;
    link.style.display = 'none';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

function removeAlert(){
    $(".alert-danger").remove()
}
function checkLimitFile(count, limit){
    return count <= limit ? true : false
}

function checkTypeFile(type, listType){
    if(listType.includes(type)){
        return true
    }
}

function checkLimitSize(size, limit){
    if(parseInt(size)<= limit){
        return true
    }
}

function showAlertValidate(html){
    let xhtml =  '<li class="mt-2" id=""> '+
        html +
        '</li>'

    let check = $("#dropzone-preview-edit li").children().last()
    if(check.length>0){
        $("#dropzone-preview-edit li").children().last().after(xhtml)
    }else{
        $("#dropzone-preview-edit").html(xhtml)
    }

}

function showAlertValidateCreate(html){
    let xhtml =  '<li class="mt-2" id=""> '+
        html +
        '</li>'

    let check = $("#dropzone-preview li").children().last()
    if(check.length>0){
        $("#dropzone-preview li").children().last().after(xhtml)
    }else{
        $("#dropzone-preview").html(xhtml)
    }

}

$(function () {
    $('[data-toggle="tooltip"]').tooltip();
})

const REPLY_ELEMENT = `
                      <div class="col-md-12">
                                                        <div class="row g-3">
                                                            <div class="col-12">
                                                                <label class="form-label text-body">Leave a Reply</label>
                                                                <textarea class="form-control bg-light border-light" rows="3" placeholder="Enter your reply..."></textarea>
                                                            </div>
                                                            <div class="col-12 text-end">
                                                                <button class="btn btn-sm btn-success" >Reply Comments</button>
                                                            </div>
                                                        </div>
                                                    </div>

`