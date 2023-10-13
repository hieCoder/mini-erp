<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 9/25/2023
  Time: 11:46 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    session.setAttribute("pathMain", "/notifications/");
    session.setAttribute("apiURL", "/api/v1");
%>
<html>
<head>
    <title>Notification</title>
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card">
                <div class="card-header font-weight-bold">
                    Notification Details
                </div>
                <div class="card-body">
                    <table id="tableNotification" data-id="${notification.id}" class="table table-bordered">
                        <tr>
                            <th class="text-center align-middle">Title</th>
                            <td id="title">${notification.title}</td>
                        </tr>
                        <tr>
                            <th class="text-center align-middle">Content</th>
                            <td id="content">${notification.content}</td>
                        </tr>
                        <tr>
                            <th class="text-center align-middle">Author</th>
                            <td id="author">${notification.title}</td>
                        </tr>
                        <tr>
                            <th class="text-center align-middle">Created Date</th>
                            <td>${notification.createdDate}</td>
                        </tr>
                        <tr>
                            <th class="text-center align-middle">Attached Files</th>
                            <td>
                                <c:forEach items="${notification.files}" var="file">
                                    <a href="${file}" download class="btn btn-link text-primary">${file.split("-")[1]}</a>
                                </c:forEach>
                            </td>
                        </tr>
                    </table>
                    <div class="d-flex justify-content-end">
                        <a href="${pathMain}" class="btn btn-secondary ml-2">Back to list</a>
                        <button id="editButtonNotification" class="btn btn-primary ml-3">Edit</button>
                    </div>
                </div>
            </div>
            <div class="mb-3 mt-2">
                <div class="row mb-4 mt-4">
                    <div class="col-md-10 d-flex">
                        <img src="/assets/avatars/231003123245-Cat03.jpg" alt="Avatar" class="avatar rounded-circle img-thumbnail mr-4">
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
                                <img src="/assets/avatars/${comment.avatarUser}" alt="Avatar" class="avatar rounded-circle img-thumbnail">
                                <div class="user-info">
                                    <p class="user-name">${comment.fullnameUser}</p>
                                    <p class="comment-date">${comment.createdDate}</p>
                                </div>
                            </div>
                            <p class="comment-content" data-id="${comment.id}">${comment.content}</p>
                            <div class="ml-auto">
                                <button type="button" class="btn btn-primary btn-sm edit-button" data-toggle="modal" data-target="#popupForm" data-id="${comment.id}">Edit</button>
                                <button class="btn btn-success btn-sm reply-button" data-id="${comment.id}">Reply</button>
                            </div>
                                <ul id="commentChildList" data-id="${comment.id}" class="list-group mt-2 ml-4">
                                    <c:if test="${not empty comment.childComments}">
                                    <c:forEach items="${comment.childComments}" var="childComment">
                                        <li class="list-group-item" data-id="${childComment.id}">
                                            <div class="comment-header d-flex align-items-center">
                                                <img src="/assets/avatars/${childComment.avatarUser}" alt="Avatar" class="avatar rounded-circle img-thumbnail">
                                                <div class="user-info">
                                                    <p class="user-name">${childComment.fullnameUser}</p>
                                                    <p class="comment-date">${childComment.createdDate}</p>
                                                </div>
                                            </div>
                                            <p class="comment-content" data-id="${childComment.id}">${childComment.content}</p>
                                            <div class="ml-auto">
                                                <button class="btn btn-primary btn-sm edit-button" data-id="${childComment.id}">Edit</button>
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
                <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteConfirmationModal">Delete</button>
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
                <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteConfirmationModalNotification">Delete</button>
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

<style>
    div.modal-content {
            margin-top: 20%;
    }

    #successModal div.modal-content{
        margin-top: 50%;
    }

    #deleteNotificationModal div.modal-content{
        margin-top: 50%;
    }
</style>
<script>
    const baseUrlComment = "/api/v1/comment-notification";
    const baseUrlNotification = "/api/v1/notifications";
    var dot = `
            <div class="text-center d-flex align-items-center justify-content-center">
                <div class="custom-spinner d-flex align-items-center justify-content-center">
                    <div class="dot"></div>
                </div>
            </div>
        `
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
            formData.append("title", title);
            formData.append("content", content);
            formData.append("oldFile", oldFile);
            for (var i = 0; i < files.length; i++) {
                formData.append("files", files[i]);
            }
            xhttp.open("POST", apiUrlNotification + notificationId, true); // Replace "/your-api-endpoint" with your actual API URL
            xhttp.onreadystatechange  = function () {
                if (xhttp.status === 200 && xhttp.readyState === 4) {
                    var data = JSON.parse(xhttp.responseText);
                    console.log(data)
                }else{
                    console.error("Request failed with status: " + xhttp.status);
                }
                $('div.custom-spinner').parent().remove()
                $("#popupFormEditNotification .modal-footer button").each(function() {
                    $(this).prop("disabled", false);
                });
            }

            xhttp.send(formData);
        });

        $(document).on("click", ".listFilesEdit button", function (e) {
            $("#deleteConfirmationModalFile #deleteFileButton").attr("data-name", $(this).attr("data-name"))
        });
        $(document).on("click", "#deleteFileButton", function (e) {
            $('.listFilesEdit button[data-name="'+ $(this).attr("data-name") +'"]').parent().remove()
            $("#deleteConfirmationModalFile").modal("hide");
        });

        $(document).on("click","#deleteNotificationButton",function (e){
            $("#popupFormEditNotification .modal-footer button").each(function() {
                $(this).prop("disabled", true);
            });
            $('#popupFormEditNotification div.modal-content').append(dot)
            $("#deleteConfirmationModalNotification").modal("hide");
            var notificationId = $("table#tableNotification").attr("data-id");
            var apiUrlNotification = baseUrlNotification
            var xhttp = new XMLHttpRequest();
            xhttp.open("DELETE", apiUrlNotification + "/" + notificationId, true); // Replace "/your-api-endpoint" with your actual API URL
            xhttp.onreadystatechange  = function () {
                if (xhttp.status === 200 && xhttp.readyState === 4) {
                    $("#deleteNotificationModal").modal("show");
                }else{
                    console.error("Request failed with status: " + xhttp.status);
                }
                $('div.custom-spinner').parent().remove()
                $("#popupFormEditNotification .modal-footer button").each(function() {
                    $(this).prop("disabled", false);
                });
            }
            xhttp.send();
        })

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
            var apiUrlNotification = baseUrlNotification
            var xhttp = new XMLHttpRequest();
            xhttp.open("GET", apiUrlNotification + "/" + notificationId, true); // Replace "/your-api-endpoint" with your actual API URL
            xhttp.onreadystatechange  = function () {
                if (xhttp.status === 200 && xhttp.readyState === 4) {
                    var data = JSON.parse(xhttp.responseText);
                    var fileList = data.files
                    if (fileList.length > 0) {
                        var fileListHTML = '<ul class="list-group">';
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
                    }
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
                        +'<label for="author">Author:</label>'
                        +'<input type="text" id="editNotificationAuthor" name="author" value="'+data.title+'" class="form-control">'
                        +'</div>'
                        +'<div class="form-group">'
                        + fileListHTML
                        +'</div>'
                        +'</form>';
                    $("#popupFormEditNotification div.modal-body").html(xhtml)
                    $("#popupFormEditNotification").modal("show");
                }else{
                    console.error("Request failed with status: " + xhttp.status);
                }
                $('div.custom-spinner').parent().remove()
                $('button#editButtonNotification').prop("disabled", false);
            }
            xhttp.send();

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
                    +'<img src="/assets/avatars/${user.avatar}" alt="Avatar" class="avatar rounded-circle img-thumbnail mr-4">'
                    +'<textarea id="replyComment" data-id="'+parentId+'" class="form-control" placeholder="Add a comment..." style="min-height: 90px;"></textarea>'
                    +'</div>'
                    +'<div class="col-md-2">'
                    +   ' <button class="btn btn-primary submit-button mt-2 mb-2 w-100" id="replyCommentBtn" data-id="'+parentId+'">Submit</button>'
                    +'</div>'
                +'</div>'
            if( $('ul#commentChildList[data-id="'+ parentId +'"] li.list-group-item').length > 0){
                $(document).find('ul#commentChildList[data-id="' + parentId + '"] li.list-group-item:first-child').before(html);
            }else{
                $(document).find('ul#commentChildList[data-id="' + parentId + '"]').html(html);
            }
        });

        $(document).on("click", "#replyCommentBtn", function(e) {
            var parentId = $(this).data("id");
            var content = $('textarea#replyComment[data-id='+ parentId +']').val();
            var notificationId = $("table#tableNotification").attr("data-id");
            $(this).prop("disabled", true);
            $(this).parent().append(dot);
            $('textarea#replyComment[data-id='+ parentId +']').prop("disabled", true);
            var apiUrl = baseUrlComment
            var xhttp = new XMLHttpRequest();
            var data = {
                content: content,
                notificationId: notificationId,
                parentId: parentId
                // Add any other data you want to send to the server
            };
            var jsonData = JSON.stringify(data);
            xhttp.open("POST", apiUrl, true); // Replace "/your-api-endpoint" with your actual API URL
            xhttp.setRequestHeader("Content-Type", "application/json");
            xhttp.onreadystatechange  = function () {
                if (xhttp.status === 200 && xhttp.readyState === 4) {
                    var data = JSON.parse(xhttp.responseText);
                    $('textarea#replyComment[data-id='+ parentId +']').val('');
                    var modal = `
                        <strong class="btn-success rounded-circle p-2">Success!</strong>  Reply successfully.
                        `
                    $("#successModal div.modal-body").html(modal)
                    $("#successModal").modal("show");

                } else{
                    console.error("Request failed with status: " + xhttp.status);
                }
                $('div.custom-spinner').parent().remove()
                $('textarea#replyComment[data-id='+ parentId +']').prop("disabled", false);
                $('button#replyCommentBtn[data-id='+ parentId +']').prop("disabled", false);
            }
            xhttp.send(jsonData);
        });
        document.getElementById("newCommentBtn").addEventListener("click", function () {
            $("button#newCommentBtn").prop("disabled", true);
            $("textarea#newComment").prop("disabled", true);
            $("button#newCommentBtn").parent().append(dot);

            var content = $("textarea#newComment").val()
            var notificationId = $("table#tableNotification").attr("data-id")
            var apiUrl = baseUrlComment
            var xhttp = new XMLHttpRequest();
            var data = {
                content: content,
                notificationId: notificationId,
                // Add any other data you want to send to the server
            };
            var jsonData = JSON.stringify(data);
            xhttp.open("POST", apiUrl, true); // Replace "/your-api-endpoint" with your actual API URL
            xhttp.setRequestHeader("Content-Type", "application/json");
            xhttp.onreadystatechange  = function () {
                    if (xhttp.status === 200 && xhttp.readyState === 4) {
                        var data = JSON.parse(xhttp.responseText);
                        $("textarea#newComment").val('');
                        var modal = `
                        <strong class="btn-success rounded-circle p-2">Success!</strong>  Comment posted successfully.
                        `
                        $("#successModal div.modal-body").html(modal)
                        $("#successModal").modal("show");
                        var html = '<li class="list-group-item" data-id="' + data.id + '">' +
                            '<div class="comment-header d-flex align-items-center">' +
                            '<img src="' + data.avatarUser + '" alt="Avatar" class="avatar rounded-circle img-thumbnail">' +
                            '<div class="user-info">' +
                            '<p class="user-name">' + data.fullnameUser + '</p>' +
                            '<p class="comment-date">' + data.createdDate + '</p>' +
                            '</div>' +
                            '</div>' +
                            '<p class="comment-content" data-id="' + data.id + '">' + data.content + '</p>' +
                            '<div class="ml-auto">' +
                            '<button type="button" class="btn btn-primary btn-sm edit-button" data-toggle="modal" data-target="#popupForm" data-id="' + data.id + '">Edit</button>' +
                            '<button class="btn btn-success btn-sm reply-button ml-1" data-id="' + data.id + '">Reply</button>' +
                            '</div>' +
                            '<ul id="commentChildList" data-id="'+ data.id +'" class="list-group mt-2 ml-4">' +
                            '</li>'

                             if( $("ul#commentList li.list-group-item:first").length >0){
                                 $("ul#commentList li.list-group-item:first").before(html)
                             }else{
                                 $("ul#commentList").html(html)
                             }
                    } else {
                        // Request failed, handle errors or display a message to the user
                        console.error("Request failed with status: " + xhttp.status);
                    }
                    $("button#newCommentBtn").prop("disabled", false);
                    $("textarea#newComment").prop("disabled", false);
                    $('div.custom-spinner').parent().remove()
            };
            // Send the request with the JSON data
            xhttp.send(jsonData);
            })
        document.getElementById("deleteButton").addEventListener("click", function () {
            $("#deleteConfirmationModal").modal("hide");
            $(".modal-footer button").each(function() {
                $(this).prop("disabled", true);
            });
            var id= $("div.modal-content").attr("data-id")
            var apiUrl = baseUrlComment + "/" + id
            $('div.modal-content[data-id="'+id+'"]').append(dot)
            var xhttp = new XMLHttpRequest();
            xhttp.open("DELETE", apiUrl, true); // Replace "/your-api-endpoint" with your actual API URL
            // Set up the callback function to handle the response
            xhttp.onload = function () {
                if (xhttp.status === 200 && xhttp.readyState === 4) {
                    $('li.list-group-item[data-id="'+id+'"]').remove()
                    var modal = `
                        <strong class="btn-success rounded-circle p-2">Success!</strong>  Comment delete successfully.
                        `
                    $("#successModal div.modal-body").html(modal)
                    $("#popupForm").modal("hide");
                    $("#successModal").modal("show");
                } else {
                    // Request failed, handle errors or display a message to the user
                    console.error("Request failed with status: " + xhttp.status);
                }
                $(".modal-footer button").each(function() {
                    $(this).prop("disabled", false);
                });
                $('div.custom-spinner').parent().remove()
            };
            // Send the request with the JSON data
            xhttp.send();
        })

        document.getElementById("saveChangesButton").addEventListener("click", function () {
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
                content: content
                // Add any other data you want to send to the server
            };

            // Convert the data to JSON
            var jsonData = JSON.stringify(data);
            $(".modal-footer button").each(function() {
                $(this).prop("disabled", true);
            });
            $('div.modal-content[data-id="'+id+'"]').append(dot)

            // Set up the callback function to handle the response
            xhttp.onload = function () {
                if (xhttp.status === 200 && xhttp.readyState === 4) {
                    $("#popupForm").modal("hide");
                    // Request was successful, handle the response data here
                    var $pElement = $('p.comment-content[data-id="' + id + '"]');
                    $pElement.text(content)
                    var modal = `
                        <strong class="btn-success rounded-circle p-2">Success!</strong>  Comment update successfully.
                        `
                    $("#successModal div.modal-body").html(modal)
                    $("#successModal").modal("show");
                    // You can update the UI or perform other actions with the response data
                } else {
                    // Request failed, handle errors or display a message to the user
                    console.error("Request failed with status: " + xhttp.status);
                }
                $(".modal-footer button").each(function() {
                    $(this).prop("disabled", false);
                });
                $('div.custom-spinner').parent().remove()
            };
            // Send the request with the JSON data
            xhttp.send(jsonData);
        });


    })
</script>
</body>
</html>
