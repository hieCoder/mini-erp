<%@ page import="com.shsoftvina.erpshsoftvina.security.Principal" %>
<%@ page import="com.shsoftvina.erpshsoftvina.enums.user.RoleEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    session.setAttribute("pathMain", "/notifications/");
    session.setAttribute("apiURL", "/api/v1");
%>
<html>
<head>
    <title>Notification</title>
    <link rel="stylesheet" href="/assets/css/notification/style.css">
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card">
                <div class="card-header font-weight-bold">
                    <h1>Notification Details</h1>
                </div>
                <div class="card-body">
                    <table id="tableNotification" data-id="${notification.id}" class="table table-bordered">
                        <tr>
                            <th class="text-center align-middle">Title</th>
                            <td id="titleNotification">${notification.title}</td>
                        </tr>
                        <tr>
                            <th class="text-center align-middle">Content</th>
                            <td id="contentNotification">${notification.content}</td>
                        </tr>
                        <tr>
                            <th class="text-center align-middle">Author</th>
                            <td id="authorNotification">${notification.fullnameUser}</td>
                        </tr>
                        <tr>
                            <th class="text-center align-middle">Created Date</th>
                            <td id="createdDateNotification">${notification.createdDate}</td>
                        </tr>
                        <tr>
                            <th class="text-center align-middle">Attached Files</th>
                            <td id="attachedFilesNotification">
                                <c:forEach items="${notification.files}" var="file">
                                    <a href="${file}" download class="btn btn-link text-primary">${file.split("-")[1]}</a>
                                </c:forEach>
                            </td>
                        </tr>
                    </table>
                    <div class="d-flex justify-content-end">
                        <a href="${pathMain}" class="btn btn-secondary ml-2">Back to list</a>
                        <c:set var="userRole" value="${Principal.getUserCurrent().getRole()}" />
                        <c:if test="${userRole.equals(RoleEnum.MANAGER) or userRole.equals(RoleEnum.OWNER)}">
                            <button type="button" class="btn btn-danger ml-3" data-toggle="modal" data-target="#deleteConfirmationModalNotification">Delete</button>
                            <button id="editButtonNotification" class="btn btn-primary ml-3">Edit</button>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="mb-3 mt-2">
                <div class="row mb-4 mt-4">
                    <div class="col-md-10 d-flex">
                        <img id="avatar-user-login" alt="Avatar" class="avatar rounded-circle img-thumbnail mr-4">
                        <textarea id="newComment" class="form-control" placeholder="Add a comment..." style="min-height: 90px;"></textarea>
                    </div>
                    <div class="col-md-2">
                        <button class="btn btn-primary submit-button mt-2 mb-2 w-100" id="newCommentBtn">Submit</button>
                    </div>
                </div>

                <ul id="commentList" class="list-group">
                    <c:forEach items="${notification.comments}" var="comment">
                        <li class="list-group-item" data-id="${comment.id}">
                            <div class="comment-header d-flex align-items-center">
                                <img src="${comment.avatarUser}" alt="Avatar" class="avatar rounded-circle img-thumbnail">
                                <div class="user-info">
                                    <p class="user-name">${comment.fullnameUser}</p>
                                    <p class="comment-date">${comment.createdDate}</p>
                                </div>
                            </div>
                            <p class="comment-content" data-id="${comment.id}">${comment.content}</p>
                            <div class="ml-auto">
                                <c:if test="${comment.userId.equals(Principal.getUserCurrent().getId())}">
                                    <button type="button" class="btn btn-primary btn-sm edit-button" data-toggle="modal" data-target="#popupForm" data-id="${comment.id}">Edit</button>
                                    <button type="button" class="btn btn-sm btn-danger" data-toggle="modal" data-id="${comment.id}" data-target="#deleteConfirmationModal">Delete</button>
                                </c:if>
                                <button class="btn btn-success btn-sm reply-button" data-id="${comment.id}">Reply</button>
                            </div>
                                <ul id="commentChildList-${comment.id}" class="list-group mt-2 ml-4">
                                    <c:if test="${not empty comment.childComments}">
                                    <c:forEach items="${comment.childComments}" var="childComment">
                                        <li class="list-group-item" data-id="${childComment.id}">
                                            <div class="comment-header d-flex align-items-center">
                                                <img src="${childComment.avatarUser}" alt="Avatar" class="avatar rounded-circle img-thumbnail">
                                                <div class="user-info">
                                                    <p class="user-name">${childComment.fullnameUser}</p>
                                                    <p class="comment-date">${childComment.createdDate}</p>
                                                </div>
                                            </div>
                                            <p class="comment-content" data-id="${childComment.id}">${childComment.content}</p>
                                            <div class="ml-auto">
                                                <c:if test="${childComment.userId.equals(Principal.getUserCurrent().getId())}">
                                                    <button class="btn btn-primary btn-sm edit-button" data-id="${childComment.id}">Edit</button>
                                                    <button type="button" class="btn btn-sm btn-danger" data-id="${childComment.id}" data-toggle="modal" data-target="#deleteConfirmationModal">Delete</button>
                                                </c:if>
                                            </div>
                                        </li>
                                    </c:forEach>
                                    </c:if>
                                </ul>
                        </li>
                    </c:forEach>
                </ul>

            </div>

        </div>
    </div>
</div>
<div class="modal fade" id="popupForm" tabindex="-1" role="dialog" aria-labelledby="popupFormLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="popupFormLabel">Edit Comment</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="contentCommentEdit">Content</label>
                        <textarea class="form-control" id="contentCommentEdit" rows="3"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" id="saveChangesButton" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="popupFormEditNotification" tabindex="-1" role="dialog" aria-labelledby="popupFormLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="popupFormEditNotificationLabel">Edit Notification</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" id="saveChangesButtonNotification" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="successModalLabel">Message</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteConfirmationModal" tabindex="-1" role="dialog" aria-labelledby="deleteConfirmationModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteConfirmationModalLabel">Confirm Deletion</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this comment?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" id="deleteButton" class="btn btn-danger">Delete</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteConfirmationModalFile" tabindex="-1" role="dialog" aria-labelledby="deleteConfirmationModalFile" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteConfirmationModalFileLabel">Confirm Deletion</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this file?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" id="deleteFileButton" class="btn btn-danger">Delete</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="deleteConfirmationModalNotification" tabindex="-1" role="dialog" aria-labelledby="deleteConfirmationModalNotification" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteConfirmationModalNotificationLabel">Confirm Deletion</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this notification?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" id="deleteNotificationButton" class="btn btn-danger">Delete</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="deleteNotificationModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Notification Deleted</h5>
            </div>
            <div class="modal-body">
                <p>Your notification has been deleted.</p>
            </div>
            <div class="modal-footer">
                <a href="${pathMain}" class="btn btn-secondary ml-2">Back to list</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
<script>
    function generateClientID() {
        const timestamp = new Date().getTime();
        const random = Math.floor(Math.random() * 1000);
        return 'client-'+timestamp+'-'+random
    }
    const clientID = generateClientID();
    var stompClient = Stomp.over(new SockJS("/websocket"));

    stompClient.connect({}, function (frame) {
        stompClient.subscribe("/notification/comments", function (comment) {
            var data = JSON.parse(comment.body);
            if (data != null) {
                if ($('li.list-group-item[data-id="' + data.id + '"]').length <= 0) {
                    var buttonHtml = ""
                    if(userCurrent.id == data.userId){
                        buttonHtml =
                            '<button type="button" class="btn btn-primary btn-sm edit-button" data-toggle="modal" data-target="#popupForm" data-id="' + data.id + '">Edit</button>' +
                            '<button type="button" class="btn btn-sm btn-danger ml-1" data-toggle="modal" data-id="' + data.id + '" data-target="#deleteConfirmationModal">Delete</button>'
                    }
                    $("textarea#newComment").val('');
                    var html = '<li class="list-group-item" data-id="' + data.id + '">' +
                        '<div class="comment-header d-flex align-items-center">' +
                        '<img src="' + data.avatarUser + '" alt="Avatar" class="avatar rounded-circle img-thumbnail">' +
                        '<div class="user-info">' +
                        '<p class="user-name">' + data.fullnameUser + '</p>' +
                        '<p class="comment-date">' + data.createdDate + '</p>' +
                        '</div>' +
                        '</div>' +
                        '<p class="comment-content" data-id="' + data.id + '">' + data.content + '</p>' +
                        '<div class="ml-auto">' + buttonHtml +
                        '<button class="btn btn-success btn-sm reply-button ml-1" data-id="' + data.id + '">Reply</button>' +
                        '</div>' +
                        '<ul id="commentChildList-' + data.id + '" class="list-group mt-2 ml-4">' +
                        '</li>';

                    if ($("ul#commentList li.list-group-item:first").length > 0) {
                        $("ul#commentList li.list-group-item:first").before(html);
                    } else {
                        $("ul#commentList").html(html);
                    }
                    if(data.clientId == clientID){
                        var modal = `<strong class="btn-success rounded-circle p-2">Success!</strong>  Comment posted successfully.
                            `
                        $("#successModal div.modal-body").html(modal)
                        $("#successModal").modal("show");
                        $("button#newCommentBtn").prop("disabled", false);
                        $("textarea#newComment").prop("disabled", false);
                        $('div.custom-spinner').parent().remove()
                    }
                }
            }
        });
        stompClient.subscribe("/notification/editcomments", function (comment) {
            var data = JSON.parse(comment.body);
            if (data != null) {
                var $pElement = $('p.comment-content[data-id="' + data.id + '"]');
                $pElement.text(data.content)
                if(data.clientId == clientID){
                    $("#popupForm").modal("hide");
                    var modal = `
                               <strong class="btn-success rounded-circle p-2">Success!</strong>  Comment update successfully.
                                `
                    $("#successModal div.modal-body").html(modal)
                    $("#successModal").modal("show");
                    $(".modal-footer button").each(function() {
                            $(this).prop("disabled", false);
                    });
                    $('div.custom-spinner').parent().remove()
                }
            }
        });
        stompClient.subscribe("/notification/deletecomments", function (comment) {
            var data = JSON.parse(comment.body);
            if (data != null) {
                $('li.list-group-item[data-id="'+data.id+'"]').remove()
                if(data.clientId == clientID){
                    var modal = `
                <strong class="btn-success rounded-circle p-2">Success!</strong>  Comment delete successfully.
                `
                    $("#successModal div.modal-body").html(modal)
                    $("#popupForm").modal("hide");
                    $("#successModal").modal("show");
                        $(".modal-footer button").each(function() {
                            $(this).prop("disabled", false);
                        });
                        $('div.custom-spinner').parent().remove()
                }
            }
        });

        stompClient.subscribe("/notification/replycomments", function (comment) {
            var data = JSON.parse(comment.body);
            if (data != null) {
                var buttonHtml = ""
                if(userCurrent.id == data.userId){
                    buttonHtml =
                        '<button type="button" class="btn btn-primary btn-sm edit-button" data-toggle="modal" data-target="#popupForm" data-id="' + data.id + '">Edit</button>' +
                        '<button type="button" class="btn btn-sm btn-danger ml-1" data-toggle="modal" data-id="' + data.id + '" data-target="#deleteConfirmationModal">Delete</button>'
                }
                        var html = '<li class="list-group-item" data-id="' + data.id + '">' +
                            '<div class="comment-header d-flex align-items-center">' +
                            '<img src="' + data.avatarUser + '" alt="Avatar" class="avatar rounded-circle img-thumbnail">' +
                            '<div class="user-info">' +
                            '<p class="user-name">' + data.fullnameUser + '</p>' +
                            '<p class="comment-date">' + data.createdDate + '</p>' +
                            '</div>' +
                            '</div>' +
                            '<p class="comment-content" data-id="' + data.id + '">' + data.content + '</p>' +
                            '<div class="ml-auto">' + buttonHtml +
                            '</div>' +
                            '<ul id="commentChildList-'+ data.id +'" class="list-group mt-2 ml-4">' +
                            '</li>'
                        var inputReply = $('#commentList #commentChildList-'+data.parentId+' > div.row')
                        var listChild = $('#commentList #commentChildList-'+data.parentId+' > li.list-group-item:first')
                        if(inputReply.length>0){
                            inputReply.after(html)
                        }else if(listChild.length>0){
                            listChild.before(html)
                        } else{
                            $('#commentList #commentChildList-'+data.parentId).html(html)
                        }
                if(data.clientId == clientID){
                            var modal = `
                                <strong class="btn-success rounded-circle p-2">Success!</strong>  Reply successfully.
                                `
                            $('textarea#replyComment[data-id='+ data.parentId +']').val('');
                            $("#successModal div.modal-body").html(modal)
                            $("#successModal").modal("show");
                            $('div.custom-spinner').parent().remove()
                            $('textarea#replyComment[data-id='+ data.parentId +']').prop("disabled", false);
                            $('button#replyCommentBtn[data-id='+ data.parentId +']').prop("disabled", false);
                }
            }
        });
    });
    function sendComment(data) {
            stompClient.send("/app/comment", {
                clientID: clientID
            }, data);
    }
    function editComment(data) {
        stompClient.send("/app/editcomment", {
            clientID: clientID
        }, data);
    }

    function deleteComment(data) {
        stompClient.send("/app/deletecomment", {
            clientID: clientID
        },data);
    }

    function replyComment(data) {
        stompClient.send("/app/replycomment", {
            clientID: clientID
        },data);
    }
</script>
<script>
    const baseUrlComment = "/api/v1/comment-notification";
    const baseUrlNotification = "/api/v1/notifications";
    var dot = createLoadingHtml();

    document.addEventListener("DOMContentLoaded", function() {

        $(document).on("click", "#saveChangesButtonNotification", function (e) {
            $("#popupFormEditNotification .modal-footer button").each(function() {
                $(this).prop("disabled", true);
            });
            $("#popupFormEditNotification .modal-footer button:first-child").before(dot)
            var apiUrlNotification = baseUrlNotification + "/update/"
            var xhttp = new XMLHttpRequest();
            var notificationId = $("table#tableNotification").attr("data-id");
            var title = document.getElementById("editNotificationTitle").value;
            var content = document.getElementById("editNotificationContent").value;
            var files = document.getElementById("editNotificationFile").files;
            var oldFile = []
            $("li.listFilesEdit").each(function() {
                oldFile.push($(this).attr("data-name"));
            });

            var formData = new FormData();
            formData.append("notificationId", title);
            formData.append("title", title);
            formData.append("content", content);
            formData.append("oldFile", oldFile);
            for (var i = 0; i < files.length; i++) {
                formData.append("files", files[i]);
            }

            callAjaxByDataFormWithDataForm(apiUrlNotification + notificationId, 'POST', formData, function (rs) {
                var data = rs;
                $("#titleNotification").text(data.title)
                $("#contentNotification").text(data.content)
                $("#authorNotification").text(data.title)
                $("#createdDateNotification").text(data.createdDate)
                var xhtml = ''
                if(data.files!=null){
                    data.files.forEach((e)=>{
                        xhtml += '<a href="'+ e +'" download class="btn btn-link text-primary">'+e.split("-")[1]+'</a>'
                    })
                }
                $("#attachedFilesNotification").html(xhtml)
                var modal = `
                        <strong class="btn-success rounded-circle p-2">Success!</strong>  Notification Updated successfully.
                        `
                $("#successModal div.modal-body").html(modal)
                $("#successModal").modal("show");

                $('div.custom-spinner').parent().remove()
                $("#popupFormEditNotification .modal-footer button").each(function() {
                    $(this).prop("disabled", false);
                });
                $("#popupFormEditNotification").modal("hide");
            });
        });

        $(document).on("click", ".listFilesEdit button", function (e) {
            $("#deleteConfirmationModalFile #deleteFileButton").attr("data-name", $(this).attr("data-name"))
        });
        $(document).on("click", "#deleteFileButton", function (e) {
            $('.listFilesEdit button[data-name="'+ $(this).attr("data-name") +'"]').parent().remove()
            $("#deleteConfirmationModalFile").modal("hide");
        });

        $(document).on("click","#deleteNotificationButton",function (e){
            $("div.card-body button").each(function() {
                $(this).prop("disabled", true);
            });
            $("#editButtonNotification").parent().append(dot);
            $('#popupFormEditNotification div.modal-content').append(dot)
            $("#deleteConfirmationModalNotification").modal("hide");
            var notificationId = $("table#tableNotification").attr("data-id");
            var apiUrlNotification = baseUrlNotification;

            callAjaxByJsonWithData(apiUrlNotification + "/" + notificationId, 'DELETE', null, function (rs) {
                $("#deleteNotificationModal").modal("show");
                $('div.custom-spinner').parent().remove()
                $("#popupFormEditNotification .modal-footer button").each(function() {
                    $(this).prop("disabled", false);
                });
            });
        });

        $(document).on("change", "#editNotificationFile", function (event) {
            const selectedFiles = event.target.files;
            var countFile = selectedFiles.length;
            var countCurrentFile = $("li.listFilesEdit").length
            if((countFile+countCurrentFile)>${uploadFileLimit}){
                var modal = `
                        <strong class="btn-danger rounded-circle p-2">Invalid!</strong> Maximum Files is ${uploadFileLimit}.
                        `
                $("#successModal div.modal-body").html(modal)
                $("#successModal").modal("show");
                $(this).val('')
            }
        });

        $(document).on("click", "#editButtonNotification", function() {
            $(this).prop("disabled", true);
            $(this).parent().append(dot);
            var notificationId = $("table#tableNotification").attr("data-id");
            var apiUrlNotification = baseUrlNotification;

            callAjaxByJsonWithData(apiUrlNotification + "/" + notificationId, 'GET', null, function (rs) {
                var data = rs;
                var fileList = data.files;
                var fileListHTML = '<ul class="list-group">';
                if (fileList != null) {
                    for (var i = 0; i < fileList.length; i++) {
                        var fileName = fileList[i].trim();
                        fileListHTML += '<li class="list-group-item listFilesEdit" data-name="' + fileName.split("/")[fileName.split("/").length - 1] + '">' +
                            '<a href="' + fileName + '" class="btn btn-link" download>' +
                            fileName.split("-")[1] +
                            '</a>' +
                            '<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteConfirmationModalFile" data-name="' + fileName.split("/")[fileName.split("/").length - 1] + '">' +
                            '<span>×</span>' +
                            '</button>' +
                            '</li>';
                    }
                }
                fileListHTML += '<label for="file">Attached Files:</label>'
                    +'<input type="file" id="editNotificationFile" name="files" class="form-control-file" multiple>'
                    +'</ul>'
                    +'<table class="table table-bordered text-center">'
                    +'<thead>'
                    +'<tr>'
                    +' <th class="text-center col-6">File Format</th>'
                    +' <th class="text-center col-3">Maximum Size</th>'
                    +' <th class="text-center col-3">Maximum Files</th>'
                    +'</tr>'
                    +'</thead>'
                    +'<tbody>'
                    +'<tr>'
                    +'<td class="text-center col-6">${listTypeFile}</td>'
                    +'<td class="text-center col-3">${maxFileSize}</td>'
                    +'<td class="text-center col-3">${uploadFileLimit}</td>'
                    +'</tr>'
                    +'</tbody>'
                    +' </table>';
                var xhtml = '<form id="editNotificationForm">'
                    +'<div class="form-group">'
                    +'<label for="title">Title:</label>'
                    +'<input type="text" id="editNotificationTitle" name="title" value="'+data.title+'" class="form-control">'
                    +'</div>'
                    +'<div class="form-group">'
                    +'<label for="content">Content:</label>'
                    +'<textarea id="editNotificationContent" name="content" class="form-control">'+data.content+'</textarea>'
                    +'</div>'
                    +'<div class="form-group">'
                    + fileListHTML
                    +'</div>'
                    +'</form>';
                $("#popupFormEditNotification div.modal-body").html(xhtml)
                $("#popupFormEditNotification").modal("show");

                $('div.custom-spinner').parent().remove()
                $('button#editButtonNotification').prop("disabled", false);
            });
        });

        $("ul#commentList").on("click", ".edit-button", function() {
            var commentId = $(this).attr("data-id");
            var commentElement = $('p.comment-content[data-id="' + commentId + '"]').text();
            $("#contentCommentEdit").val(commentElement);
            $("#popupForm div.modal-content").attr("data-id", commentId);
            $("#popupForm").modal("show");
        });

        $("ul#commentList").on("click", ".reply-button", function() {
            var parentId = $(this).attr("data-id");
            var html =
                '<div class="row mb-4 mt-4">'
                    +'<div class="col-md-10 d-flex">'
                    +'<img src="' + userCurrent.avatar + '" alt="Avatar" class="avatar rounded-circle img-thumbnail mr-4">'
                    +'<textarea id="replyComment" data-id="'+parentId+'" class="form-control" placeholder="Add a comment..." style="min-height: 90px;"></textarea>'
                    +'</div>'
                    +'<div class="col-md-2">'
                    +   ' <button class="btn btn-primary submit-button mt-2 mb-2 w-100" id="replyCommentBtn" data-id="'+parentId+'">Submit</button>'
                    +'</div>'
                +'</div>'
            if( $('ul#commentChildList-'+parentId+' li.list-group-item').length > 0){
                $(document).find('ul#commentChildList-'+parentId+' li.list-group-item:first-child').before(html);
            }else{
                $(document).find('ul#commentChildList-'+parentId).html(html);
            }
        });

        $(document).on("click", "#replyCommentBtn", function(e) {
            var parentId = $(this).data("id");
            var content = $('textarea#replyComment[data-id='+ parentId +']').val();
            var notificationId = $("table#tableNotification").attr("data-id");
            $(this).prop("disabled", true);
            $(this).parent().append(dot);
            $('textarea#replyComment[data-id='+ parentId +']').prop("disabled", true);
            if(content == ""){
                var modal = `
                        <strong class="btn-danger rounded-circle p-2">Invalid!</strong> Please input comment.
                        `
                $("#successModal div.modal-body").html(modal)
                $("#successModal").modal("show");
                $(this).prop("disabled", false);
                $('textarea#replyComment[data-id='+ parentId +']').prop("disabled", false);
                $('div.custom-spinner').parent().remove()
                return
            }
            var data = {
                content: content,
                notificationId: notificationId,
                parentId: parentId,
                userId: userCurrent.id
                // Add any other data you want to send to the server
            };
            var jsonData = JSON.stringify(data);
            replyComment(jsonData)
        });
        document.getElementById("newCommentBtn").addEventListener("click", function () {
            $("button#newCommentBtn").prop("disabled", true);
            $("textarea#newComment").prop("disabled", true);
            $("button#newCommentBtn").parent().append(dot);

            var content = $("textarea#newComment").val()
            if(content == ""){
                var modal = `
                        <strong class="btn-danger rounded-circle p-2">Invalid!</strong> Please input comment.
                        `
                $("#successModal div.modal-body").html(modal)
                $("#successModal").modal("show");
                $("button#newCommentBtn").prop("disabled", false);
                $("textarea#newComment").prop("disabled", false);
                $('div.custom-spinner').parent().remove()
                return
            }
            var notificationId = $("table#tableNotification").attr("data-id")
            var data = {
                content: content,
                notificationId: notificationId,
                userId: userCurrent.id
            };

            var jsonData = JSON.stringify(data);
            sendComment(jsonData)
            })

        $(document).on("click", "#commentList button.btn-danger", function(e) {
            var commentId = $(this).data("id");
            $("#deleteConfirmationModal").attr("data-id",commentId)
        });

        document.getElementById("deleteButton").addEventListener("click", function () {
            $("#deleteConfirmationModal").modal("hide");
            var id= $("#deleteConfirmationModal").attr("data-id")
            $('li.list-group-item[data-id="' + id + '"] > div.ml-auto button').each(function() {
                $(this).prop("disabled", true);
            });
            var data = {
                id: id,
                userId: userCurrent.id
            };
            var jsonData = JSON.stringify(data);
            deleteComment(jsonData)
        })

        document.getElementById("saveChangesButton").addEventListener("click", function () {
            $('div.modal-content[data-id="'+id+'"]').append(dot)
            $(".modal-footer button").each(function() {
                $(this).prop("disabled", true);
            });
            // Create an XMLHttpRequest object
            var xhttp = new XMLHttpRequest();
            var apiUrl = baseUrlComment
            // Configure the request
            xhttp.open("PUT", apiUrl, true); // Replace "/your-api-endpoint" with your actual API URL
            xhttp.setRequestHeader("Content-Type", "application/json");

            // Define the data you want to send (if needed)
            var id= $("div.modal-content").attr("data-id")
            var content =  $("#contentCommentEdit").val()
            var data = {
                id: id,
                content: content,
                userId: userCurrent.id
            };
            // Convert the data to JSON
            var jsonData = JSON.stringify(data);
            editComment(jsonData);
        });
    });
</script>
<script>
    document.getElementById('avatar-user-login').setAttribute('src', userCurrent.avatar);
</script>
</body>
</html>
