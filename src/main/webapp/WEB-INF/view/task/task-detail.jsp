<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Task detail</title>

    <!-- quill css -->
    <link href="/assets/libs/quill/quill.core.css" rel="stylesheet" type="text/css" />
    <link href="/assets/libs/quill/quill.bubble.css" rel="stylesheet" type="text/css" />
    <link href="/assets/libs/quill/quill.snow.css" rel="stylesheet" type="text/css" />

    <!-- Sweet Alert css-->
    <link href="/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />

    <!-- dropzone css -->
    <link rel="stylesheet" href="/assets/libs/dropzone/dropzone.css" type="text/css" />
</head>
<body>
<%--    <div class="container mt-4" id="content-container">--%>
<%--        <div class="row">--%>
<%--            <div class="col-md-12">--%>
<%--                <h1 class="text-center">Your comment</h1>--%>
<%--                <form id="yourCommentForm">--%>
<%--                    <div class="form-group">--%>
<%--                        <label for="yourCommentTitle">Title:</label>--%>
<%--                        <input id="yourCommentTitle" name="title" type="text" class="form-control" aria-describedby="emailHelp">--%>
<%--                        <small class="form-message"></small>--%>
<%--                    </div>--%>
<%--                    <div class="form-group">--%>
<%--                        <label for="yourCommentTitle">Content:</label>--%>
<%--                        <div id="yourCommentContent" class="summernote"></div>--%>
<%--                        <small class="form-message"></small>--%>
<%--                    </div>--%>
<%--                    <div class="form-group">--%>
<%--                        <input name="fileList" type="file" class="form-control" id="yourCommentFiles" multiple>--%>
<%--                    </div>--%>
<%--                    <div class="form-group text-right">--%>
<%--                        <button id="yourCommentSubmitComment" type="submit" class="btn btn-success">Comment</button>--%>
<%--                    </div>--%>
<%--                </form>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <div class="row">--%>
<%--            <div class="col-md-12">--%>
<%--                <h1 class="text-center">List of comment</h1>--%>
<%--                <ul id="comment-list" class="list-group">--%>
<%--&lt;%&ndash;                    <li class="list-group-item">&ndash;%&gt;--%>
<%--&lt;%&ndash;                        <div class="row">&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <div class="col-md-2 text-center"></div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            <div class="col-md-10">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                <form>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    <div class="form-group">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        <input type="text" class="form-control fw-bold" placeholder="Title">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    <div class="form-group mt-2">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        <div class="form-control summernote" style="height: auto;"></div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    <div class="form-group mt-2 row">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        <div class="col-md-6">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            <input type="file" name="newFiles" class="form-control mt-2 attract-update-comment" multiple="">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        <div class="col-md-6 text-right">&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            <button class="btn btn-primary">Reply</button>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                            <button class="btn btn-danger">Cancel</button>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                        </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                    </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                                </form>&ndash;%&gt;--%>
<%--&lt;%&ndash;                            </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                        </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </li>&ndash;%&gt;--%>
<%--                </ul>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        &lt;%&ndash; modal confirm delete task &ndash;%&gt;--%>
<%--        <div class="modal fade" id="deleteTaskModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">--%>
<%--            <div class="modal-dialog modal-dialog-centered">--%>
<%--                <div class="modal-content">--%>
<%--                    <div class="modal-header">--%>
<%--                        <h5 class="modal-title" id="staticBackdropLabel">Confirm delete task</h5>--%>
<%--                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">--%>
<%--                            <span aria-hidden="true">&times;</span>--%>
<%--                        </button>--%>
<%--                    </div>--%>
<%--                    <div class="modal-body">--%>
<%--                        Are you sure?--%>
<%--                    </div>--%>
<%--                    <div class="modal-footer">--%>
<%--                        <button id="delete-task" type="button" class="btn btn-danger">Confirm</button>--%>
<%--                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        &lt;%&ndash; modal confirm delete comment &ndash;%&gt;--%>
<%--        <div class="modal fade" id="deleteCommentModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">--%>
<%--            <div class="modal-dialog modal-dialog-centered">--%>
<%--                <div class="modal-content">--%>
<%--                    <div class="modal-header">--%>
<%--                        <h5 class="modal-title">Confirm delete comment</h5>--%>
<%--                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">--%>
<%--                            <span aria-hidden="true">&times;</span>--%>
<%--                        </button>--%>
<%--                    </div>--%>
<%--                    <div class="modal-body">--%>
<%--                        Are you sure?--%>
<%--                    </div>--%>
<%--                    <div class="modal-footer">--%>
<%--                        <button id="delete-comment" type="button" class="btn btn-danger">Confirm</button>--%>
<%--                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <script src="/assets/js/task/task.js"></script>--%>
<%--    <script>--%>

<%--        var idTask = '${id}';--%>
<%--        var commentObj = {--%>
<%--            idComment: null,--%>
<%--            liEComment: null--%>
<%--        };--%>
<%--        var objectUpdate = {--%>
<%--            valTitle: null,--%>
<%--            valContent: null--%>
<%--        };--%>

<%--        $(document).ready(function() {--%>

<%--            showLoading('content-container');--%>

<%--            callAjaxByJsonWithData('/api/v1/tasks/' + idTask, "GET", null, function (rs) {--%>

<%--                // TASK DETAIL--%>
<%--                $('#fullnameUser').text(rs.fullnameUser);--%>

<%--                $('#title').val(rs.title);--%>

<%--                $('#content').summernote('code', rs.content);--%>

<%--                var statusTask = rs.statusTask;--%>
<%--                $('#statusTask').html('<span class="p-2 badge ' + getStatusColor(statusTask.code) + '">' + statusTask.name + '</span>');--%>

<%--                $('#selectAction').empty();--%>
<%--                $('#selectAction').html('<option value="">-- Actions --</option>');--%>
<%--                statusTask.actions.forEach(function(action) {--%>
<%--                    var option = $('<option></option>');--%>
<%--                    option.attr('value', action.code);--%>
<%--                    option.text(action.name);--%>
<%--                    $('#selectAction').append(option);--%>
<%--                });--%>

<%--                $('#selectPriority').val(rs.priority.code);--%>

<%--                $('#progress').val(rs.progress);--%>
<%--                if([T_REGISTERED, T_POSTPONSED, T_CLOSED].includes(statusTask.code)){--%>
<%--                    $('#progress').prop('disabled', true);--%>
<%--                }--%>

<%--                $('#registeredDate').val(rs.createdDate);--%>

<%--                $('#startDate').val(rs.startDate);--%>

<%--                $('#dueDate').val(formatDateValueToValueOfInputDate(rs.dueDate));--%>
<%--                if(userCurrent.role == U_DEVELOPER){--%>
<%--                    $('#dueDate').prop('disabled', true);--%>
<%--                }--%>

<%--                $('#closeDate').val(rs.closeDate);--%>

<%--                if(userCurrent.role != U_DEVELOPER || userCurrent.id == rs.idUser){--%>
<%--                    $('#group-button-task-detail').removeClass('d-none');--%>
<%--                }--%>


<%--                // YOUR COMMENT--%>
<%--                $('#yourCommentContent').summernote();--%>


<%--                // LIST OF COMMENT--%>
<%--                var comments = rs.comments;--%>

<%--                comments.forEach(function (comment) {--%>
<%--                    $('#comment-list').append(createCommentForm(comment));--%>
<%--                });--%>

<%--                cutShortLink();--%>

<%--                hideLoading('content-container');--%>
<%--            });--%>
<%--        });--%>

<%--        Validator({--%>
<%--            form:'#taskDetailForm',--%>
<%--            errorSelector: '.form-message',--%>
<%--            rules:[--%>
<%--                Validator.isRequired('#title'),--%>
<%--                Validator.isRequired('#dueDate'),--%>
<%--                Validator.isDayAfterToday("#dueDate", 'Due day is not before today'),--%>
<%--                Validator.isRequired('#content'),--%>
<%--                Validator.isRequired('#progress')--%>
<%--            ],--%>
<%--            onSubmit: function (formData) {--%>

<%--                $('#btn-cancel-task-detail').after(createLoadingHtml());--%>

<%--                formData.append('id', idTask);--%>
<%--                formData.append('content', $('#content').summernote().summernote('code'));--%>

<%--                callAjaxByJsonWithDataForm("/api/v1/tasks", "PUT", formData, function (rs) {--%>
<%--                    window.location.href = "/tasks/"+idTask + "?updateSuccess";--%>
<%--                }, 'taskDetailForm');--%>
<%--            }--%>
<%--        });--%>

<%--        Validator({--%>
<%--            form:'#yourCommentForm',--%>
<%--            errorSelector: '.form-message',--%>
<%--            rules:[--%>
<%--                Validator.isRequired('#yourCommentTitle'),--%>
<%--                Validator.isRequired('#yourCommentContent')--%>
<%--            ],--%>
<%--            onSubmit: function (formData) {--%>
<%--                formData.append('taskId', idTask);--%>
<%--                formData.append('content', $('#yourCommentContent').summernote().summernote('code'));--%>
<%--                formData.append('userId', userCurrent.id);--%>

<%--                $('#yourCommentSubmitComment').after(createLoadingHtml());--%>

<%--                 callAjaxByDataFormWithDataForm("/api/v1/comment-task", "POST", formData, function (rs) {--%>
<%--                     var liE = createCommentForm(rs);--%>
<%--                     liE.prependTo('#comment-list');--%>


<%--                    $('#yourCommentTitle').val('');--%>
<%--                    $('#yourCommentContent').summernote('code', '<p><br></p>');--%>

<%--                    cutShortLink();--%>
<%--                }, 'yourCommentForm');--%>
<%--            }--%>
<%--        });--%>

<%--        $('#delete-task').click(function() {--%>
<%--            $('#deleteTaskModal .modal-footer').after(createLoadingHtml());--%>
<%--            callAjaxByJsonWithData("/api/v1/tasks/" + idTask, "DELETE", null, function (rs) {--%>
<%--                window.location.href = "/tasks?deleteSuccess";--%>
<%--            }, 'deleteTaskModal');--%>
<%--        });--%>

<%--        $('#delete-comment').click(function() {--%>

<%--            $('#deleteCommentModal .modal-footer').after(createLoadingHtml());--%>

<%--            callAjaxByJsonWithData("/api/v1/comment-task/" + commentObj.idComment, "DELETE", null, function (rs) {--%>
<%--                commentObj.liEComment.remove();--%>
<%--                $('#deleteCommentModal').modal('hide');--%>

<%--            }, 'deleteCommentModal');--%>
<%--        });--%>

<%--        $(document).on('click','.btn-modify-comment',function(){--%>
<%--            var id = $(this).data('comment-id');--%>
<%--            var closestLI = $(this).closest('li');--%>

<%--            updateCommemtForm(closestLI);--%>

<%--            objectUpdate.valTitle = $('#updateCommentTitle'+id).val();--%>
<%--            objectUpdate.valContent = $('#updateCommentContent'+id).html();--%>

<%--            // update--%>
<%--            Validator({--%>
<%--                form:'#updateCommentForm'+id,--%>
<%--                errorSelector: '.form-message',--%>
<%--                rules:[--%>
<%--                    Validator.isRequired('#updateCommentTitle'+id),--%>
<%--                    Validator.isRequired('#updateCommentContent'+id)--%>
<%--                ],--%>
<%--                onSubmit: function (formData) {--%>
<%--                    var idForm = '#updateCommentForm'+id;--%>
<%--                    var listFile = $(idForm + ' .list-file');--%>
<%--                    var oldFiles = listFile.find('a').map(function() {--%>
<%--                        var href = $(this).attr('href');--%>
<%--                        var fileName = getFileNameFromPath(href);--%>
<%--                        return fileName;--%>
<%--                    }).get().join(',');--%>

<%--                    formData.append('id', id);--%>
<%--                    formData.append('remainFiles', oldFiles);--%>
<%--                    formData.append('content', $('#updateCommentContent'+id).summernote().summernote('code'));--%>

<%--                    $(idForm+' .list-button').after(createLoadingHtml());--%>
<%--                    callAjaxByDataFormWithDataForm('/api/v1/comment-task/updation', 'POST', formData, function (rs){--%>
<%--                        closestLI.replaceWith(createCommentForm(rs));--%>
<%--                        cutShortLink();--%>
<%--                        console.log(123);--%>
<%--                    }, 'updateCommentForm'+id);--%>
<%--                }--%>
<%--            });--%>
<%--        });--%>
<%--        $(document).on('click','.btn-cancel-update-comment',function(){--%>
<%--            var idComment = $(this).data('comment-id');--%>

<%--            $('#updateCommentTitle'+idComment).val(objectUpdate.valTitle);--%>
<%--            $('#updateCommentTitle'+idComment).prop('disabled', true);--%>

<%--            $('#updateCommentContent'+idComment).summernote('destroy');--%>
<%--            $('#updateCommentContent'+idComment).html(objectUpdate.valContent);--%>

<%--            $('#updateCommentForm' + idComment + ' .file').css("border", "none");--%>
<%--            $('#updateCommentForm' + idComment + ' .remove-file').addClass('d-none');--%>
<%--            $('#updateCommentForm'+idComment).find('input[name="newFiles"]').addClass('d-none');--%>

<%--            $("#updateCommentForm" + idComment + " .btn-update-comment").addClass('d-none');--%>
<%--            $("#updateCommentForm" + idComment + " .btn-cancel-update-comment").addClass('d-none');--%>
<%--            if(isAdminOrUserLogin(userCurrent.id)){--%>
<%--                $("#updateCommentForm" + idComment + " .btn-delete-comment").removeClass('d-none');--%>
<%--                $("#updateCommentForm" + idComment + " .btn-modify-comment").removeClass('d-none');--%>
<%--            }--%>
<%--            if(!isDeleveloper()){--%>
<%--                $("#updateCommentForm" + idComment + " .btn-reply-comment").removeClass('d-none');--%>
<%--            }--%>

<%--            // var idComment = $(this).data('comment-id');--%>
<%--            // var closestLI = $(this).closest('li');--%>
<%--            // $('#updateCommentForm'+ idComment +' .list-button').after(createLoadingHtml());--%>
<%--            // callAjaxByJsonWithData('/api/v1/comment-task/' + idComment, "GET", null, function (rs) {--%>
<%--            //     closestLI.replaceWith(createCommentForm(rs));--%>
<%--            // }, 'updateCommentForm'+idComment);--%>
<%--        });--%>
<%--        $(document).on('click','.btn-delete-comment',function(){--%>
<%--            commentObj.idComment = $(this).data('comment-id');--%>
<%--            commentObj.liEComment = $(this).closest('li');--%>
<%--        });--%>
<%--        $(document).on('click','.btn-reply-comment',function(){--%>
<%--            var parentId = $(this).data('comment-id');--%>
<%--            var closestLI = $(this).closest('li');--%>
<%--            var containerReplyForm = closestLI.find('.reply-form-container').first();--%>

<%--            replyCommentForm(parentId).appendTo(containerReplyForm);--%>
<%--            var contentEditor = closestLI.find('#replyCommentForm'+parentId+' .summernote').first();--%>
<%--            contentEditor.summernote();--%>
<%--            closestLI.find('.list-button').first().hide();--%>

<%--            Validator({--%>
<%--                form:'#replyCommentForm'+parentId,--%>
<%--                errorSelector: '.form-message',--%>
<%--                rules:[--%>
<%--                    Validator.isRequired('#titleReply'+parentId),--%>
<%--                    Validator.isRequired('#contentReply'+parentId)--%>
<%--                ],--%>
<%--                onSubmit: function (formData) {--%>
<%--                    formData.append('taskId', idTask);--%>
<%--                    formData.append('content', $('#contentReply'+parentId).summernote().summernote('code'));--%>
<%--                    formData.append('userId', userCurrent.id);--%>
<%--                    formData.append('parentId', parentId);--%>

<%--                    $('#replyCommentForm'+ parentId +' .list-button').after(createLoadingHtml());--%>
<%--                    callAjaxByDataFormWithDataForm("/api/v1/comment-task", "POST", formData, function (rs) {--%>
<%--                        var liE = createCommentForm(rs);--%>
<%--                        var ulChildsComment = closestLI.find('.childs-comment-list').first();--%>
<%--                        liE.prependTo(ulChildsComment);--%>

<%--                        closestLI.find('.reply-form-container form').first().remove();--%>
<%--                        closestLI.find('.list-button').first().show();--%>

<%--                        cutShortLink();--%>
<%--                    }, 'replyCommentForm'+parentId);--%>
<%--                }--%>
<%--            });--%>
<%--        });--%>
<%--        $(document).on('click','.btn-cancel-reply-comment',function(){--%>
<%--            var closestLI = $(this).closest('li');--%>
<%--            closestLI.find('.reply-form-container form').first().remove();--%>
<%--            closestLI.find('.list-button').first().show();--%>
<%--        });--%>

<%--        function updateCommemtForm(closestLI) {--%>
<%--            // title--%>
<%--            var titleInput = closestLI.find('input[name="title"]').first();--%>
<%--            titleInput.prop('disabled', false);--%>
<%--            var currentValue = titleInput.val();--%>
<%--            titleInput.val('');--%>
<%--            titleInput.val(currentValue);--%>
<%--            titleInput.focus();--%>
<%--            // content--%>
<%--            var summernoteDiv = closestLI.find('.summernote').first();--%>
<%--            summernoteDiv.summernote();--%>
<%--            // files--%>
<%--            var files = closestLI.find('.list-file').first().find('.file');--%>
<%--            files.css({--%>
<%--                'border': '1px solid #9f9292',--%>
<%--                'margin-right': '20px'--%>
<%--            });--%>
<%--            files.find('span').removeClass('d-none');--%>

<%--            // attach file--%>
<%--            closestLI.find('input.attract-update-comment').first().removeClass('d-none');--%>

<%--            // remove file--%>
<%--            $('.remove-file').click(function () {--%>
<%--                $(this).closest('.file').remove();--%>
<%--            });--%>

<%--            // list button--%>
<%--            closestLI.find('.list-button').first().find('.btn-update-comment, .btn-cancel-update-comment').removeClass('d-none');--%>
<%--            closestLI.find('.list-button').first().find('.btn-modify-comment, .btn-reply-comment, .btn-delete-comment').addClass('d-none');--%>
<%--        }--%>

<%--        function replyCommentForm(parentId) {--%>
<%--            var form = $('<form id="replyCommentForm'+parentId+'"></form>');--%>

<%--            var titleFormGroup = $('<div class="form-group"></div>');--%>
<%--            var titleInput = $('<input id="titleReply'+parentId+'" name="title" type="text" class="form-control fw-bold" placeholder="Title"><small class="form-message"></small>');--%>
<%--            titleFormGroup.append(titleInput);--%>

<%--            var contentFormGroup = $('<div class="form-group"></div>');--%>
<%--            var contentTextarea = $('<div id="contentReply'+parentId+'" class="form-control summernote" style="height: auto;"></div><small class="form-message"></small>');--%>
<%--            contentFormGroup.append(contentTextarea);--%>

<%--            var buttonFormGroup = $('<div class="form-group row"></div>');--%>

<%--            var fileInputContainer = $('<div class="col-md-8"></div>');--%>
<%--            var fileInput = $('<input type="file" name="fileList" class="form-control attract-update-comment" multiple>');--%>
<%--            fileInputContainer.append(fileInput);--%>

<%--            var buttonContainer = $('<div class="col-md-4 text-right list-button"></div>');--%>
<%--            var replyButton = $('<button type="submit" class="btn btn-info mr-1">Reply</button>');--%>
<%--            var cancelButton = $('<button type="button"class="btn btn-secondary btn-cancel-reply-comment" >Cancel</button>');--%>
<%--            buttonContainer.append(replyButton);--%>
<%--            buttonContainer.append(cancelButton);--%>

<%--            buttonFormGroup.append(fileInputContainer);--%>
<%--            buttonFormGroup.append(buttonContainer);--%>

<%--            form.append(titleFormGroup);--%>
<%--            form.append(contentFormGroup);--%>
<%--            form.append(buttonFormGroup);--%>

<%--            return form;--%>
<%--        }--%>
<%--    </script>--%>


<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Task Details</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Tasks</a></li>
                    <li class="breadcrumb-item active">Task Details</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<!-- end page title -->

<div class="row">
    <div class="col-xxl-3">
        <div class="card mb-3">
            <div class="card-body">
                <div class="table-card">
                    <table class="table mb-0">
                        <tbody>
                        <tr>
                            <td class="fw-medium">Username</td>
                            <td class="task-username"></td>
                        </tr>
                        <tr>
                            <td class="fw-medium">Task id</td>
                            <td class="task-id"></td>
                        </tr>
                        <tr>
                            <td class="fw-medium">Task title</td>
                            <td class="task-title"></td>
                        </tr>
                        <tr>
                            <td class="fw-medium">Status</td>
                            <td><span class="task-status"></span></td>
                        </tr>
                        <tr>
                            <td class="fw-medium">Priority</td>
                            <td><span class="task-priority"></span></td>
                        </tr>
                        <tr>
                            <td class="fw-medium">Progress</td>
                            <td><span class="task-progress"></span></td>
                        </tr>
                        <tr>
                            <td class="fw-medium">Register date</td>
                            <td class="task-registered-date"></td>
                        </tr>
                        <tr>
                            <td class="fw-medium">Started date</td>
                            <td class="task-started-date"></td>
                        </tr>
                        <tr>
                            <td class="fw-medium">Due date</td>
                            <td class="task-due-date"></td>
                        </tr>
                        <tr>
                            <td class="fw-medium">Closed date</td>
                            <td class="task-closed-date"></td>
                        </tr>
                        </tbody>
                    </table>
                    <!--end table-->
                </div>
            </div>
        </div>
        <!--end card-->
    </div>
    <!---end col-->
    <div class="col-xxl-9">
        <div class="card">
            <div class="card-body">
                <div class="text-muted">
                    <h6 class="mb-3 fw-semibold text-uppercase">Task content</h6>
                    <div class="task-content"></div>
                </div>
            </div>
        </div>
        <!--end card-->
        <div class="card">
            <div class="card-header">
                <div>
                    <ul class="nav nav-tabs-custom rounded card-header-tabs border-bottom-0" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" data-bs-toggle="tab" href="#home-1" role="tab">
                                Comments (5)
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="tab" href="#messages-1" role="tab">
                                Attachments File (4)
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="tab" href="#profile-1" role="tab">
                                Time Entries (9 hrs 13 min)
                            </a>
                        </li>
                    </ul>
                    <!--end nav-->
                </div>
            </div>
            <div class="card-body">
                <div class="tab-content">
                    <div class="tab-pane active" id="home-1" role="tabpanel">
                        <h5 class="card-title">Comments</h5>
                        <div data-simplebar class="px-3 mx-n3 mb-2" id="comment-list"></div>
                        <form class="mt-4">
                            <div class="row g-3">
                                <div class="col-lg-12">
                                    <label for="exampleFormControlTextarea1" class="form-label">Leave a Comments</label>
                                    <textarea class="form-control bg-light border-light" id="exampleFormControlTextarea1" rows="3" placeholder="Enter comments"></textarea>
                                </div>
                                <!--end col-->
                                <div class="col-12 text-end">
                                    <button type="button" class="btn btn-ghost-secondary btn-icon waves-effect me-1"><i class="ri-attachment-line fs-16"></i></button>
                                    <a href="javascript:void(0);" class="btn btn-success">Post Comments</a>
                                </div>
                            </div>
                            <!--end row-->
                        </form>
                    </div>
                    <!--end tab-pane-->
                    <div class="tab-pane" id="messages-1" role="tabpanel">
                        <div class="table-responsive table-card">
                            <table class="table table-borderless align-middle mb-0">
                                <thead class="table-light text-muted">
                                <tr>
                                    <th scope="col">File Name</th>
                                    <th scope="col">Type</th>
                                    <th scope="col">Size</th>
                                    <th scope="col">Upload Date</th>
                                    <th scope="col">Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-sm">
                                                <div class="avatar-title bg-soft-primary text-primary rounded fs-20">
                                                    <i class="ri-file-zip-fill"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3 flex-grow-1">
                                                <h6 class="fs-15 mb-0"><a href="javascript:void(0)">App pages.zip</a></h6>
                                            </div>
                                        </div>
                                    </td>
                                    <td>Zip File</td>
                                    <td>2.22 MB</td>
                                    <td>21 Dec, 2021</td>
                                    <td>
                                        <div class="dropdown">
                                            <a href="javascript:void(0);" class="btn btn-light btn-icon" id="dropdownMenuLink1" data-bs-toggle="dropdown" aria-expanded="true">
                                                <i class="ri-equalizer-fill"></i>
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuLink1" data-popper-placement="bottom-end" style="position: absolute; inset: 0px 0px auto auto; margin: 0px; transform: translate(0px, 23px);">
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-eye-fill me-2 align-middle text-muted"></i>View</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-download-2-fill me-2 align-middle text-muted"></i>Download</a></li>
                                                <li class="dropdown-divider"></li>
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-delete-bin-5-line me-2 align-middle text-muted"></i>Delete</a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-sm">
                                                <div class="avatar-title bg-soft-danger text-danger rounded fs-20">
                                                    <i class="ri-file-pdf-fill"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3 flex-grow-1">
                                                <h6 class="fs-15 mb-0"><a href="javascript:void(0);">Velzon admin.ppt</a></h6>
                                            </div>
                                        </div>
                                    </td>
                                    <td>PPT File</td>
                                    <td>2.24 MB</td>
                                    <td>25 Dec, 2021</td>
                                    <td>
                                        <div class="dropdown">
                                            <a href="javascript:void(0);" class="btn btn-light btn-icon" id="dropdownMenuLink2" data-bs-toggle="dropdown" aria-expanded="true">
                                                <i class="ri-equalizer-fill"></i>
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuLink2" data-popper-placement="bottom-end" style="position: absolute; inset: 0px 0px auto auto; margin: 0px; transform: translate(0px, 23px);">
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-eye-fill me-2 align-middle text-muted"></i>View</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-download-2-fill me-2 align-middle text-muted"></i>Download</a></li>
                                                <li class="dropdown-divider"></li>
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-delete-bin-5-line me-2 align-middle text-muted"></i>Delete</a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-sm">
                                                <div class="avatar-title bg-soft-info text-info rounded fs-20">
                                                    <i class="ri-folder-line"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3 flex-grow-1">
                                                <h6 class="fs-15 mb-0"><a href="javascript:void(0);">Images.zip</a></h6>
                                            </div>
                                        </div>
                                    </td>
                                    <td>ZIP File</td>
                                    <td>1.02 MB</td>
                                    <td>28 Dec, 2021</td>
                                    <td>
                                        <div class="dropdown">
                                            <a href="javascript:void(0);" class="btn btn-light btn-icon" id="dropdownMenuLink3" data-bs-toggle="dropdown" aria-expanded="true">
                                                <i class="ri-equalizer-fill"></i>
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuLink3" data-popper-placement="bottom-end" style="position: absolute; inset: 0px 0px auto auto; margin: 0px; transform: translate(0px, 23px);">
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-eye-fill me-2 align-middle"></i>View</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-download-2-fill me-2 align-middle"></i>Download</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-delete-bin-5-line me-2 align-middle"></i>Delete</a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-sm">
                                                <div class="avatar-title bg-soft-danger text-danger rounded fs-20">
                                                    <i class="ri-image-2-fill"></i>
                                                </div>
                                            </div>
                                            <div class="ms-3 flex-grow-1">
                                                <h6 class="fs-15 mb-0"><a href="javascript:void(0);">Bg-pattern.png</a></h6>
                                            </div>
                                        </div>
                                    </td>
                                    <td>PNG File</td>
                                    <td>879 KB</td>
                                    <td>02 Nov 2021</td>
                                    <td>
                                        <div class="dropdown">
                                            <a href="javascript:void(0);" class="btn btn-light btn-icon" id="dropdownMenuLink4" data-bs-toggle="dropdown" aria-expanded="true">
                                                <i class="ri-equalizer-fill"></i>
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuLink4" data-popper-placement="bottom-end" style="position: absolute; inset: 0px 0px auto auto; margin: 0px; transform: translate(0px, 23px);">
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-eye-fill me-2 align-middle"></i>View</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-download-2-fill me-2 align-middle"></i>Download</a></li>
                                                <li><a class="dropdown-item" href="javascript:void(0);"><i class="ri-delete-bin-5-line me-2 align-middle"></i>Delete</a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <!--end table-->
                        </div>
                    </div>
                    <!--end tab-pane-->
                    <div class="tab-pane" id="profile-1" role="tabpanel">
                        <h6 class="card-title mb-4 pb-2">Time Entries</h6>
                        <div class="table-responsive table-card">
                            <table class="table align-middle mb-0">
                                <thead class="table-light text-muted">
                                <tr>
                                    <th scope="col">Member</th>
                                    <th scope="col">Date</th>
                                    <th scope="col">Duration</th>
                                    <th scope="col">Timer Idle</th>
                                    <th scope="col">Tasks Title</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <th scope="row">
                                        <div class="d-flex align-items-center">
                                            <img src="/assets/images/users/avatar-8.jpg" alt="" class="rounded-circle avatar-xxs">
                                            <div class="flex-grow-1 ms-2">
                                                <a href="pages-profile.html" class="fw-medium">Thomas Taylor</a>
                                            </div>
                                        </div>
                                    </th>
                                    <td>02 Jan, 2022</td>
                                    <td>3 hrs 12 min</td>
                                    <td>05 min</td>
                                    <td>Apps Pages</td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="/assets/images/users/avatar-10.jpg" alt="" class="rounded-circle avatar-xxs">
                                            <div class="flex-grow-1 ms-2">
                                                <a href="pages-profile.html" class="fw-medium">Tonya Noble</a>
                                            </div>
                                        </div>
                                    </td>
                                    <td>28 Dec, 2021</td>
                                    <td>1 hrs 35 min</td>
                                    <td>-</td>
                                    <td>Profile Page Design</td>
                                </tr>
                                <tr>
                                    <th scope="row">
                                        <div class="d-flex align-items-center">
                                            <img src="/assets/images/users/avatar-10.jpg" alt="" class="rounded-circle avatar-xxs">
                                            <div class="flex-grow-1 ms-2">
                                                <a href="pages-profile.html" class="fw-medium">Tonya Noble</a>
                                            </div>
                                        </div>
                                    </th>
                                    <td>27 Dec, 2021</td>
                                    <td>4 hrs 26 min</td>
                                    <td>03 min</td>
                                    <td>Ecommerce Dashboard</td>
                                </tr>
                                </tbody>
                            </table>
                            <!--end table-->
                        </div>
                    </div>
                    <!--edn tab-pane-->

                </div>
                <!--end tab-content-->
            </div>
        </div>
        <!--end card-->
    </div>
    <!--end col-->
</div>
<!--end row-->

<div class="modal fade" id="inviteMembersModal" tabindex="-1" aria-labelledby="inviteMembersModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0">
            <div class="modal-header p-3 ps-4 bg-soft-success">
                <h5 class="modal-title" id="inviteMembersModalLabel">Team Members</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <div class="search-box mb-3">
                    <input type="text" class="form-control bg-light border-light" placeholder="Search here...">
                    <i class="ri-search-line search-icon"></i>
                </div>

                <div class="mb-4 d-flex align-items-center">
                    <div class="me-2">
                        <h5 class="mb-0 fs-13">Members :</h5>
                    </div>
                    <div class="avatar-group justify-content-center">
                        <a href="javascript: void(0);" class="avatar-group-item" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-placement="top" title="Tonya Noble">
                            <div class="avatar-xs">
                                <img src="/assets/images/users/avatar-10.jpg" alt="" class="rounded-circle img-fluid">
                            </div>
                        </a>
                        <a href="javascript: void(0);" class="avatar-group-item" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-placement="top" title="Thomas Taylor">
                            <div class="avatar-xs">
                                <img src="/assets/images/users/avatar-8.jpg" alt="" class="rounded-circle img-fluid">
                            </div>
                        </a>
                        <a href="javascript: void(0);" class="avatar-group-item" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-placement="top" title="Nancy Martino">
                            <div class="avatar-xs">
                                <img src="/assets/images/users/avatar-2.jpg" alt="" class="rounded-circle img-fluid">
                            </div>
                        </a>
                    </div>
                </div>
                <div class="mx-n4 px-4" data-simplebar style="max-height: 225px;">
                    <div class="vstack gap-3">
                        <div class="d-flex align-items-center">
                            <div class="avatar-xs flex-shrink-0 me-3">
                                <img src="/assets/images/users/avatar-2.jpg" alt="" class="img-fluid rounded-circle">
                            </div>
                            <div class="flex-grow-1">
                                <h5 class="fs-13 mb-0"><a href="javascript:void(0);" class="text-body d-block">Nancy Martino</a></h5>
                            </div>
                            <div class="flex-shrink-0">
                                <button type="button" class="btn btn-light btn-sm">Add</button>
                            </div>
                        </div>
                        <!-- end member item -->
                        <div class="d-flex align-items-center">
                            <div class="avatar-xs flex-shrink-0 me-3">
                                <div class="avatar-title bg-soft-danger text-danger rounded-circle">
                                    HB
                                </div>
                            </div>
                            <div class="flex-grow-1">
                                <h5 class="fs-13 mb-0"><a href="javascript:void(0);" class="text-body d-block">Henry Baird</a></h5>
                            </div>
                            <div class="flex-shrink-0">
                                <button type="button" class="btn btn-light btn-sm">Add</button>
                            </div>
                        </div>
                        <!-- end member item -->
                        <div class="d-flex align-items-center">
                            <div class="avatar-xs flex-shrink-0 me-3">
                                <img src="/assets/images/users/avatar-3.jpg" alt="" class="img-fluid rounded-circle">
                            </div>
                            <div class="flex-grow-1">
                                <h5 class="fs-13 mb-0"><a href="javascript:void(0);" class="text-body d-block">Frank Hook</a></h5>
                            </div>
                            <div class="flex-shrink-0">
                                <button type="button" class="btn btn-light btn-sm">Add</button>
                            </div>
                        </div>
                        <!-- end member item -->
                        <div class="d-flex align-items-center">
                            <div class="avatar-xs flex-shrink-0 me-3">
                                <img src="/assets/images/users/avatar-4.jpg" alt="" class="img-fluid rounded-circle">
                            </div>
                            <div class="flex-grow-1">
                                <h5 class="fs-13 mb-0"><a href="javascript:void(0);" class="text-body d-block">Jennifer Carter</a></h5>
                            </div>
                            <div class="flex-shrink-0">
                                <button type="button" class="btn btn-light btn-sm">Add</button>
                            </div>
                        </div>
                        <!-- end member item -->
                        <div class="d-flex align-items-center">
                            <div class="avatar-xs flex-shrink-0 me-3">
                                <div class="avatar-title bg-soft-success text-success rounded-circle">
                                    AC
                                </div>
                            </div>
                            <div class="flex-grow-1">
                                <h5 class="fs-13 mb-0"><a href="javascript:void(0);" class="text-body d-block">Alexis Clarke</a></h5>
                            </div>
                            <div class="flex-shrink-0">
                                <button type="button" class="btn btn-light btn-sm">Add</button>
                            </div>
                        </div>
                        <!-- end member item -->
                        <div class="d-flex align-items-center">
                            <div class="avatar-xs flex-shrink-0 me-3">
                                <img src="/assets/images/users/avatar-7.jpg" alt="" class="img-fluid rounded-circle">
                            </div>
                            <div class="flex-grow-1">
                                <h5 class="fs-13 mb-0"><a href="javascript:void(0);" class="text-body d-block">Joseph Parker</a></h5>
                            </div>
                            <div class="flex-shrink-0">
                                <button type="button" class="btn btn-light btn-sm">Add</button>
                            </div>
                        </div>
                        <!-- end member item -->
                    </div>
                    <!-- end list -->
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light w-xs" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-success w-xs">Assigned</button>
            </div>
        </div>
        <!-- end modal-content -->
    </div>
    <!-- modal-dialog -->
</div>
<!-- end modal -->


<div class="modal fade flip" id="deleteCommentModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body p-5 text-center">
                <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop" colors="primary:#405189,secondary:#f06548" style="width:90px;height:90px"></lord-icon>
                <div class="mt-4 text-center">
                    <h4>You are about to delete a task comment ?</h4>
                    <p class="text-muted fs-14 mb-4">Deleting your task will remove all of
                        your information from our database.</p>
                    <div class="hstack gap-2 justify-content-center remove">
                        <button class="btn btn-danger" id="delete-comment" data-id="">Yes, Delete It</button>
                        <button class="btn btn-link btn-ghost-success fw-medium text-decoration-none" data-bs-dismiss="modal"><i class="ri-close-line me-1 align-middle"></i> Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--end delete modal -->

<!-- ckeditor -->
<script src="/assets/libs/@ckeditor/ckeditor5-build-classic/build/ckeditor.js"></script>
<!-- quill js -->
<script src="/assets/libs/quill/quill.min.js"></script>
<!-- init js -->
<script src="/assets/js/pages/form-editor.init.js"></script>

<!-- Sweet Alerts js -->
<script src="/assets/libs/sweetalert2/sweetalert2.min.js"></script>

<!-- dropzone min -->
<script src="/assets/libs/dropzone/dropzone-min.js"></script>

<script src="/assets/custom/js/task/task.js"></script>
<script>
    $(document).ready(function() {
        var idTask = ${id};
        callAjaxByJsonWithData('/api/v1/tasks/' + idTask, "GET", null, function (rs) {
            $('.task-username').text(rs.user.fullname);
            $('.task-id').text(rs.id);
            $('.task-title').text(rs.title);
            $('.task-status').replaceWith(`<span class="badge ` + getStatusColor(rs.statusTask.code) + `">` + rs.statusTask.code + `</span>`);
            $('.task-priority').replaceWith(`<span class="badge ` + getPriorityColor(rs.priority.code) + ` text-uppercase">` + rs.priority.code + `</span>`);
            $('.task-progress').replaceWith(rs.progress + '%' + getProgressE(rs.progress));
            $('.task-registered-date').text(rs.createdDate);
            $('.task-started-date').text(rs.startDate);
            $('.task-due-date').text(rs.dueDate);
            $('.task-closed-date').text(rs.closeDate);

            $('.task-content').html(getContentViewOfEditorSnow(rs.content));

            // LIST OF COMMENT
            rs.comments.forEach(function (comment) {
                createCommentForm(comment)
                    .then(function (commentHTML) {
                        $('#comment-list').append(commentHTML);
                    }).catch(function (error) {
                        console.error(error);
                    });
            });
        });
    });

    $(document).on('click', '.remove-comment-btn', function (e) {
        var id = $(this).data('id');
        $('#delete-comment').attr('data-id', id);
    });

    $(document).on('click', '#delete-comment', function (e) {
        var id = $(this).attr('data-id');
        callAjaxByJsonWithData("/api/v1/comment-task/" + id, "DELETE", null, function (rs) {
            $(".comment-container[data-id='" + id + "']").remove();
            $('#deleteCommentModal').modal('hide');
        });
    });

    $(document).on('click', '.btn-reply', function (e){
        var id = $(this).data('id');
        var replyContainer = $(".form-reply[data-id='" + id + "']");
        replyContainer.html(replyCommentForm(id));

        var dropzonePreviewNode = document.querySelector("#dropzone-preview-list");
        dropzonePreviewNode.id = "";
        var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
        dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);
        var dropzone = new Dropzone(".dropzone", {
            url: 'https://httpbin.org/post',
            method: "post",
            previewTemplate: previewTemplate,
            previewsContainer: "#dropzone-preview",
            autoProcessQueue: false,
        });

        $.getScript("/assets/js/pages/form-editor.init.js");


        Validator({
            form:'.reply-comment-form[data-id="'+ id+ '"]',
            errorSelector: '.form-message',
            rules:[
                Validator.isRequired('.reply-comment-form[data-id="'+ id+ '"] .title-reply'),
                Validator.isRequired('.reply-comment-form[data-id="'+ id+ '"] .content-reply')
            ],
            onSubmit: function (formData) {
                formData.append('taskId', ${id});
                formData.append('content', $('.reply-comment-form[data-id="'+ id+ '"] .content-reply').html());
                formData.append('userId', userCurrent.id);
                formData.append('parentId', id);
                dropzone.files.forEach((file) => {
                    formData.append('fileList', file);
                });

                var data = {};
                formData.forEach((value, key) => data[key] = value);
                console.log(data);

                // callAjaxByDataFormWithDataForm("/api/v1/comment-task", "POST", formData, function (rs) {
                //     // var liE = createCommentForm(rs);
                //     // var ulChildsComment = closestLI.find('.childs-comment-list').first();
                //     // liE.prependTo(ulChildsComment);
                //     //
                //     // closestLI.find('.reply-form-container form').first().remove();
                //     // closestLI.find('.list-button').first().show();
                //     console.log(123);
                //
                // });
            }
        });
    });

    $(document).on('click', '.close-reply-form', function (e){
        var parentElement = $(this).closest(".reply-comment-form");
        if (parentElement.length > 0) parentElement.remove();
    });

</script>
</body>
</html>
