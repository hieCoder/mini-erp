<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Task detail</title>
    <style>
        .summernote p img{
            width: 100% !important;
        }
    </style>
</head>
<body>
    <div class="container mt-4" id="content-container">
        <div class="row">
            <div class="col-md-12">
                <h1 class="text-center">Task detail</h1>
                <c:if test="${param.updateSuccess != null}">
                    <div class="alert alert-success">
                        Update success!
                    </div>
                </c:if>
                <form id="taskDetailForm">
                    <div class="form-group mt-3">
                        <label>Username: <b id="fullnameUser"></b></label>
                    </div>
                    <div class="form-group mt-3">
                        <label for="title">Title:</label>
                        <input id="title" name="title" type="text" class="form-control" aria-describedby="emailHelp">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group mt-3">
                        <label for="content">Content:</label>
                        <div id="content" class="summernote"></div>
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group mt-3">
                        <label>Status:</label>
                        <div class="d-flex align-items-end">
                            <label id="statusTask" class="mr-3"></label>
                            <label class="mr-1">Select action:</label>
                            <select id="selectAction" name="action" class="form-control w-auto" aria-label="Default select example"></select>
                        </div>
                    </div>
                    <div class="form-group mt-3">
                        <label>Priority:</label>
                        <select id="selectPriority" name="priority" class="form-control" aria-label="Default select example">
                            <option value="LOW" class="text-warning">Low</option>
                            <option value="MEDIUM" class="text-primary">Medium</option>
                            <option value="HIGH" class="text-danger">High</option>
                        </select>
                    </div>
                    <div class="form-group mt-3">
                        <label>Progress:</label>
                        <input id="progress" max="100" name="progress" type="number" class="form-control" aria-describedby="emailHelp">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group mt-3">
                        <label for="registeredDate">Registered date:</label>
                        <input id="registeredDate" type="text" class="form-control" aria-describedby="emailHelp" disabled>
                    </div>
                    <div class="form-group mt-3">
                        <label for="startDate">Start date:</label>
                        <input id="startDate" name="startDate" type="text" class="form-control" aria-describedby="emailHelp" disabled>
                    </div>
                    <div class="form-group mt-3">
                        <label for="dueDate">Due date:</label>
                        <input id="dueDate" name="dueDate" type="date" class="form-control">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group mt-3">
                        <label for="closeDate">Closed date:</label>
                        <input id="closeDate" name="closeDate" type="text" class="form-control" aria-describedby="emailHelp" disabled>
                    </div>
                    <div class="form-group text-right">
                        <span id="group-button-task-detail" class="d-none">
                            <button type="submit" class="btn btn-primary">Update</button>
                            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteTaskModal">Delete</button>
                        </span>
                        <a href="/tasks" class="btn btn-secondary" id="btn-cancel-task-detail">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <h1 class="text-center">Your comment</h1>
                <form id="yourCommentForm">
                    <div class="form-group">
                        <label for="yourCommentTitle">Title:</label>
                        <input id="yourCommentTitle" name="title" type="text" class="form-control" aria-describedby="emailHelp">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group">
                        <label for="yourCommentTitle">Content:</label>
                        <div id="yourCommentContent" class="summernote"></div>
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group">
                        <input name="fileList" type="file" class="form-control" id="yourCommentFiles" multiple>
                    </div>
                    <div class="form-group text-right">
                        <button id="yourCommentSubmitComment" type="submit" class="btn btn-success">Comment</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <h1 class="text-center">List of comment</h1>
                <ul id="comment-list" class="list-group">
<%--                    <li class="list-group-item">--%>
<%--                        <div class="row">--%>
<%--                            <div class="col-md-2 text-center"></div>--%>
<%--                            <div class="col-md-10">--%>
<%--                                <form>--%>
<%--                                    <div class="form-group">--%>
<%--                                        <input type="text" class="form-control fw-bold" placeholder="Title">--%>
<%--                                    </div>--%>
<%--                                    <div class="form-group mt-2">--%>
<%--                                        <div class="form-control summernote" style="height: auto;"></div>--%>
<%--                                    </div>--%>
<%--                                    <div class="form-group mt-2 row">--%>
<%--                                        <div class="col-md-6">--%>
<%--                                            <input type="file" name="newFiles" class="form-control mt-2 attract-update-comment" multiple="">--%>
<%--                                        </div>--%>
<%--                                        <div class="col-md-6 text-right">--%>
<%--                                            <button class="btn btn-primary">Reply</button>--%>
<%--                                            <button class="btn btn-danger">Cancel</button>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </form>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </li>--%>
                </ul>
            </div>
        </div>

        <%-- modal confirm delete task --%>
        <div class="modal fade" id="deleteTaskModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="staticBackdropLabel">Confirm delete task</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Are you sure?
                    </div>
                    <div class="modal-footer">
                        <button id="delete-task" type="button" class="btn btn-danger">Confirm</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <%-- modal confirm delete comment --%>
        <div class="modal fade" id="deleteCommentModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirm delete comment</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Are you sure?
                    </div>
                    <div class="modal-footer">
                        <button id="delete-comment" type="button" class="btn btn-danger">Confirm</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="/assets/js/task/task.js"></script>
    <script>

        var idTask = '${id}';
        var commentObj = {
            idComment: null,
            liEComment: null
        };
        var objectUpdate = {
            valTitle: null,
            valContent: null
        };

        $(document).ready(function() {

            showLoading('content-container');

            callAjaxByJsonWithData('/api/v1/tasks/' + idTask, "GET", null, function (rs) {

                // TASK DETAIL
                $('#fullnameUser').text(rs.fullnameUser);

                $('#title').val(rs.title);

                $('#content').summernote('code', rs.content);

                var statusTask = rs.statusTask;
                $('#statusTask').html('<span class="p-2 badge ' + getStatusColor(statusTask.code) + '">' + statusTask.name + '</span>');

                $('#selectAction').empty();
                $('#selectAction').html('<option value="">-- Actions --</option>');
                statusTask.actions.forEach(function(action) {
                    var option = $('<option></option>');
                    option.attr('value', action.code);
                    option.text(action.name);
                    $('#selectAction').append(option);
                });

                $('#selectPriority').val(rs.priority.code);

                $('#progress').val(rs.progress);
                if([T_REGISTERED, T_POSTPONSED, T_CLOSED].includes(statusTask.code)){
                    $('#progress').prop('disabled', true);
                }

                $('#registeredDate').val(rs.createdDate);

                $('#startDate').val(rs.startDate);

                $('#dueDate').val(formatDateValueToValueOfInputDate(rs.dueDate));
                if(userCurrent.role == U_DEVELOPER){
                    $('#dueDate').prop('disabled', true);
                }

                $('#closeDate').val(rs.closeDate);

                if(userCurrent.role != U_DEVELOPER || userCurrent.id == rs.idUser){
                    $('#group-button-task-detail').removeClass('d-none');
                }


                // YOUR COMMENT
                $('#yourCommentContent').summernote();


                // LIST OF COMMENT
                var comments = rs.comments;

                comments.forEach(function (comment) {
                    $('#comment-list').append(createCommentForm(comment));
                });

                cutShortLink();

                hideLoading('content-container');
            });
        });

        Validator({
            form:'#taskDetailForm',
            errorSelector: '.form-message',
            rules:[
                Validator.isRequired('#title'),
                Validator.isRequired('#dueDate'),
                Validator.isRequired('#content'),
                Validator.isRequired('#progress')
            ],
            onSubmit: function (formData) {

                $('#btn-cancel-task-detail').after(createLoadingHtml());

                formData.append('id', idTask);
                formData.append('content', $('#content').summernote().summernote('code'));

                callAjaxByJsonWithDataForm("/api/v1/tasks", "PUT", formData, function (rs) {
                    window.location.href = "/tasks/"+idTask + "?updateSuccess";
                }, 'taskDetailForm');
            }
        });

        Validator({
            form:'#yourCommentForm',
            errorSelector: '.form-message',
            rules:[
                Validator.isRequired('#yourCommentTitle'),
                Validator.isRequired('#yourCommentContent')
            ],
            onSubmit: function (formData) {
                formData.append('taskId', idTask);
                formData.append('content', $('#yourCommentContent').summernote().summernote('code'));
                formData.append('userId', userCurrent.id);

                $('#yourCommentSubmitComment').after(createLoadingHtml());

                 callAjaxByDataFormWithDataForm("/api/v1/comment-task", "POST", formData, function (rs) {
                     var liE = createCommentForm(rs);
                     liE.prependTo('#comment-list');


                    $('#yourCommentTitle').val('');
                    $('#yourCommentContent').summernote('code', '<p><br></p>');

                    cutShortLink();
                }, 'yourCommentForm');
            }
        });

        $('#delete-task').click(function() {
            $('#deleteTaskModal .modal-footer').after(createLoadingHtml());
            callAjaxByJsonWithData("/api/v1/tasks/" + idTask, "DELETE", null, function (rs) {
                window.location.href = "/tasks?deleteSuccess";
            }, 'deleteTaskModal');
        });

        $('#delete-comment').click(function() {

            $('#deleteCommentModal .modal-footer').after(createLoadingHtml());

            callAjaxByJsonWithData("/api/v1/comment-task/" + commentObj.idComment, "DELETE", null, function (rs) {
                commentObj.liEComment.remove();
                $('#deleteCommentModal').modal('hide');

            }, 'deleteCommentModal');
        });

        $(document).on('click','.btn-modify-comment',function(){
            var id = $(this).data('comment-id');
            var closestLI = $(this).closest('li');

            updateCommemtForm(closestLI);

            objectUpdate.valTitle = $('#updateCommentTitle'+id).val();
            objectUpdate.valContent = $('#updateCommentContent'+id).html();

            // update
            Validator({
                form:'#updateCommentForm'+id,
                errorSelector: '.form-message',
                rules:[
                    Validator.isRequired('#updateCommentTitle'+id),
                    Validator.isRequired('#updateCommentContent'+id)
                ],
                onSubmit: function (formData) {
                    var idForm = '#updateCommentForm'+id;
                    var listFile = $(idForm + ' .list-file');
                    var oldFiles = listFile.find('a').map(function() {
                        var href = $(this).attr('href');
                        var fileName = getFileNameFromPath(href);
                        return fileName;
                    }).get().join(',');

                    formData.append('id', id);
                    formData.append('remainFiles', oldFiles);
                    formData.append('content', $('#updateCommentContent'+id).summernote().summernote('code'));

                    $(idForm+' .list-button').after(createLoadingHtml());
                    callAjaxByDataFormWithDataForm('/api/v1/comment-task/updation', 'POST', formData, function (rs){
                        closestLI.replaceWith(createCommentForm(rs));
                        cutShortLink();
                    }, 'updateCommentForm'+id);
                }
            });
        });
        $(document).on('click','.btn-cancel-update-comment',function(){
            var idComment = $(this).data('comment-id');

            $('#updateCommentTitle'+idComment).val(objectUpdate.valTitle);
            $('#updateCommentTitle'+idComment).prop('disabled', true);

            $('#updateCommentContent'+idComment).summernote('destroy');
            $('#updateCommentContent'+idComment).html(objectUpdate.valContent);

            $('#updateCommentForm' + idComment + ' .file').css("border", "none");
            $('#updateCommentForm' + idComment + ' .remove-file').addClass('d-none');
            $('#updateCommentForm'+idComment).find('input[name="newFiles"]').addClass('d-none');

            $("#updateCommentForm" + idComment + " .btn-update-comment").addClass('d-none');
            $("#updateCommentForm" + idComment + " .btn-cancel-update-comment").addClass('d-none');
            if(isAdminOrUserLogin(userCurrent.id)){
                $("#updateCommentForm" + idComment + " .btn-delete-comment").removeClass('d-none');
                $("#updateCommentForm" + idComment + " .btn-modify-comment").removeClass('d-none');
            }
            if(!isDeleveloper()){
                $("#updateCommentForm" + idComment + " .btn-reply-comment").removeClass('d-none');
            }

            // $('#updateCommentForm'+ idComment +' .list-button').after(createLoadingHtml());
            // callAjaxByJsonWithData('/api/v1/comment-task/' + idComment, "GET", null, function (rs) {
            //     closestLI.replaceWith(createCommentForm(rs));
            // }, 'updateCommentForm'+idComment);
        });
        $(document).on('click','.btn-delete-comment',function(){
            commentObj.idComment = $(this).data('comment-id');
            commentObj.liEComment = $(this).closest('li');
        });
        $(document).on('click','.btn-reply-comment',function(){
            var parentId = $(this).data('comment-id');
            var closestLI = $(this).closest('li');
            var containerReplyForm = closestLI.find('.reply-form-container').first();

            replyCommentForm(parentId).appendTo(containerReplyForm);
            var contentEditor = closestLI.find('#replyCommentForm'+parentId+' .summernote').first();
            contentEditor.summernote();
            closestLI.find('.list-button').first().hide();

            Validator({
                form:'#replyCommentForm'+parentId,
                errorSelector: '.form-message',
                rules:[
                    Validator.isRequired('#titleReply'+parentId),
                    Validator.isRequired('#contentReply'+parentId)
                ],
                onSubmit: function (formData) {
                    formData.append('taskId', idTask);
                    formData.append('content', $('#contentReply'+parentId).summernote().summernote('code'));
                    formData.append('userId', userCurrent.id);
                    formData.append('parentId', parentId);

                    $('#replyCommentForm'+ parentId +' .list-button').after(createLoadingHtml());
                    callAjaxByDataFormWithDataForm("/api/v1/comment-task", "POST", formData, function (rs) {
                        var liE = createCommentForm(rs);
                        var ulChildsComment = closestLI.find('.childs-comment-list').first();
                        liE.prependTo(ulChildsComment);

                        closestLI.find('.reply-form-container form').first().remove();
                        closestLI.find('.list-button').first().show();

                        cutShortLink();
                    }, 'replyCommentForm'+parentId);
                }
            });
        });
        $(document).on('click','.btn-cancel-reply-comment',function(){
            var closestLI = $(this).closest('li');
            closestLI.find('.reply-form-container form').first().remove();
            closestLI.find('.list-button').first().show();
        });

        function createCommentForm(comment) {
            var listItem = $('<li class="list-group-item">');
            var row = $('<div class="row">');
            var userCol = $('<div class="col-md-2 d-flex flex-column align-items-center">');
            var commentCol = $('<div class="col-md-10">');

            userCol.append('<img class="rounded-circle-container" src="' + comment.avatarUser + '" alt="User Avatar">');
            userCol.append('<figcaption><b>' + comment.fullnameUser + '</b></figcaption>');
            userCol.append('<small>' + comment.createdDate + '</small>');

            var commentForm = $('<form id="updateCommentForm'+comment.id+'">');

            commentForm.append('<div class="form-group"><input id="updateCommentTitle'+comment.id+'" name="title" type="text" class="form-control fw-bold" value="' + comment.title + '" disabled><small class="form-message"></small></div>');
            commentForm.append('<div class="form-group"><div id="updateCommentContent'+comment.id+'" class="form-control summernote" style="height: auto;">' + comment.content + '</div><small class="form-message"></small></div>');

            var fileLinksCol = $('<div class="col-md-6">');
            var buttonCol = $('<div class="col-md-6 text-right list-button">');

            var fileLinks = $('<div class="form-group list-file">');
            if (comment.files && comment.files.length > 0) {
                comment.files.forEach(function (file) {
                    var fileSpan = $('<span class="file">');
                    var fileA = $('<a class="p-2 cut-file-name" href="' + file + '" download>' + getFileNameFromPath(file) + '</a>');
                    var closeSpan = $('<span style="font-size: 20px;cursor: pointer;" class="d-none remove-file" aria-hidden="true">&times;</span>');

                    fileSpan.append(fileA);
                    fileSpan.append(closeSpan);

                    fileLinks.append(fileSpan);
                });
            }

            var fileInput = $('<input type="file" name="newFiles" class="form-control mt-2 attract-update-comment d-none" multiple>');
            fileLinks.append(fileInput);

            fileLinksCol.append(fileLinks);

            var modifyButton = $('<button type="button" class="btn btn-warning btn-modify-comment d-none mr-1"">Modify</button>');
            modifyButton.attr('data-comment-id', comment.id);
            var deleteButton = $('<button type="button" class="btn btn-danger btn-delete-comment d-none mr-1" data-toggle="modal" data-target="#deleteCommentModal">Delete</button>');
            deleteButton.attr('data-comment-id', comment.id);
            var updateButton = $('<button type="submit" class="btn btn-primary btn-update-comment d-none mr-1">Update</button>');
            var cancelUpdateButton = $('<button type="button" class="btn btn-secondary btn-cancel-update-comment d-none mr-1">Cancel</button>');
            cancelUpdateButton.attr('data-comment-id', comment.id);

            if(comment.parentId == null && !isDeleveloper()){
                var replyButton = $('<button type="button" class="btn btn-info btn-reply-comment mr-1">Reply</button>');
                replyButton.attr('data-comment-id', comment.id);
                buttonCol.append(replyButton);
            }
            buttonCol.append(modifyButton);
            buttonCol.append(updateButton);
            buttonCol.append(deleteButton);
            buttonCol.append(cancelUpdateButton);
            if(isAdminOrUserLogin(comment.idUser)){
                deleteButton.removeClass('d-none');
                modifyButton.removeClass('d-none');
            }

            commentForm.append('<div class="form-group row">');
            commentForm.find('.row').append(fileLinksCol).append(buttonCol);

            commentCol.append(commentForm);

            row.append(userCol).append(commentCol);
            listItem.append(row);

            listItem.append('<div class="row"><div class="col-md-2"></div><div class="col-md-10 reply-form-container"></div></div>');

            var childComments = comment.childComments;
            var ul = $('<ul class="childs-comment-list w-100"></ul>');
            if (childComments && childComments.length > 0) {

                childComments.forEach(function (comment) {
                    var liE = createCommentForm(comment);
                    ul.append(liE);
                });
            }
            var rowCommentChilds = $('<div class="row"></div>');
            rowCommentChilds.append(ul);
            listItem.append(rowCommentChilds);

            return listItem;
        }

        function updateCommemtForm(closestLI) {
            // title
            var titleInput = closestLI.find('input[name="title"]').first();
            titleInput.prop('disabled', false);
            var currentValue = titleInput.val();
            titleInput.val('');
            titleInput.val(currentValue);
            titleInput.focus();
            // content
            var summernoteDiv = closestLI.find('.summernote').first();
            summernoteDiv.summernote();
            // files
            var files = closestLI.find('.list-file').first().find('.file');
            files.css({
                'border': '1px solid #9f9292',
                'margin-right': '20px'
            });
            files.find('span').removeClass('d-none');

            // attach file
            closestLI.find('input.attract-update-comment').first().removeClass('d-none');

            // remove file
            $('.remove-file').click(function () {
                $(this).closest('.file').remove();
            });

            // list button
            closestLI.find('.list-button').first().find('.btn-update-comment, .btn-cancel-update-comment').removeClass('d-none');
            closestLI.find('.list-button').first().find('.btn-modify-comment, .btn-reply-comment, .btn-delete-comment').addClass('d-none');
        }

        function replyCommentForm(parentId) {
            var form = $('<form id="replyCommentForm'+parentId+'"></form>');

            var titleFormGroup = $('<div class="form-group"></div>');
            var titleInput = $('<input id="titleReply'+parentId+'" name="title" type="text" class="form-control fw-bold" placeholder="Title"><small class="form-message"></small>');
            titleFormGroup.append(titleInput);

            var contentFormGroup = $('<div class="form-group"></div>');
            var contentTextarea = $('<div id="contentReply'+parentId+'" class="form-control summernote" style="height: auto;"></div><small class="form-message"></small>');
            contentFormGroup.append(contentTextarea);

            var buttonFormGroup = $('<div class="form-group row"></div>');

            var fileInputContainer = $('<div class="col-md-6"></div>');
            var fileInput = $('<input type="file" name="fileList" class="form-control attract-update-comment" multiple>');
            fileInputContainer.append(fileInput);

            var buttonContainer = $('<div class="col-md-6 text-right list-button"></div>');
            var replyButton = $('<button type="submit" class="btn btn-info mr-1">Reply</button>');
            var cancelButton = $('<button type="button"class="btn btn-secondary btn-cancel-reply-comment" >Cancel</button>');
            buttonContainer.append(replyButton);
            buttonContainer.append(cancelButton);

            buttonFormGroup.append(fileInputContainer);
            buttonFormGroup.append(buttonContainer);

            form.append(titleFormGroup);
            form.append(contentFormGroup);
            form.append(buttonFormGroup);

            return form;
        }
    </script>
</body>
</html>
