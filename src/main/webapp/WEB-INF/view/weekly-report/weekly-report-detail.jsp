<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Weekly report detail</title>
</head>
<body>
<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Weekly report detail</h4>
            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Tasks management</a></li>
                    <li class="breadcrumb-item active">Weekly report detail</li>
                </ol>
            </div>
        </div>
    </div>
</div>
<!-- end page title -->

<div class="row">
    <div class="col-xxl-12">
        <div class="card mb-3">
            <div class="card-body wr-info-container">
                <div>
                    <label class="col-form-label">Id:&nbsp</label>${wr.id}
                </div>
                <div>
                    <label class="col-form-label">Username:&nbsp</label>${wr.user.fullname}
                </div>
                <div>
                    <label class="col-form-label">Title:&nbsp</label>
                    <b id="title-show">${wr.title}</b>
                </div>
                <div>
                    <label class="col-form-label">This week's content:</label>
                    <div id="this-week-content-show"></div>
                </div>
                <div>
                    <label class="col-form-label">Next week's content:</label>
                    <div id="next-week-content-show"></div>
                </div>
                <div>
                    <label class="col-form-label">Created date:&nbsp</label>${wr.createdDate}
                </div>
                <div>
                    <button type="button" class="btn btn-primary" id="edit-btn">Edit</button>
                </div>
            </div>
        </div>
        <!--end card-->
    </div>
</div>

<!-- edit modal -->
<div class="modal modal-xl fade" id="editReport" tabindex="-1" aria-labelledby="editReportLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editReportLabel">Edit weekly report</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="edit-wr-form">
                    <div class="mb-3">
                        <label for="title" class="col-form-label">Title:</label>
                        <input name="title" type="text" class="form-control" id="title">
                        <small class="form-message"></small>
                    </div>
                    <div class="mb-3">
                        <label for="this-week-content" class="col-form-label">This week's content:</label>
                        <div class="snow-editor content-report" id="this-week-content"></div>
                        <small class="form-message"></small>
                        <ul class="list-group list-title-by-hashtag" style="max-height: 200px; overflow: auto;"></ul>
                    </div>
                    <div class="mb-3">
                        <label for="next-week-content" class="col-form-label">Next week's content:</label>
                        <div class="snow-editor content-report" id="next-week-content"></div>
                        <small class="form-message"></small>
                        <ul class="list-group list-title-by-hashtag" style="max-height: 200px; overflow: auto;"></ul>
                    </div>
                    <div class="mb-3 d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary btn-load" style="margin-right: 3px;">
                            <span class="d-flex align-items-center">
                                <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                <span class="flex-grow-1">Edit</span>
                            </span>
                        </button>
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>

    $(document).ready(function (){
        activeEditor(".wr-info-container");
       var currentWeeklyContent =  '${wr.currentWeeklyContent}';
        var nextWeeklyContent =  '${wr.nextWeeklyContent}';
        $('#this-week-content-show').html(getContentViewOfEditorSnow(currentWeeklyContent));
        $('#next-week-content-show').html(getContentViewOfEditorSnow(nextWeeklyContent));
    });

    $(document).on('input', '.content-report', function (e){
        var ulElement = $(this).siblings('.list-title-by-hashtag');

        const enteredText = e.target.innerText;
        const lastIndexOfHash = enteredText.lastIndexOf('#');

        if (lastIndexOfHash !== -1) {
            const textAfterLastHash = enteredText.slice(lastIndexOfHash + 1);
            const firstSpaceIndex = textAfterLastHash.indexOf(' ');

            if (firstSpaceIndex === -1) {
                callAjaxByJsonWithData('/api/v1/tasks/search/'+userCurrent.id+'?title='+textAfterLastHash,
                    'GET', null, function (rs) {
                        ulElement.empty();
                        rs.forEach(function (e) {
                            ulElement.append(`<li class="hashtag-e list-group-item list-group-item-action` +
                                ` cursor-pointer" data-task-id="`+e.id+`">` + e.title + `</li>`);
                        });
                    });
            }
        } else{
            ulElement.empty();
        }
    });

    $(document).on('click', '.hashtag-e', function (e){
        var taskTitle = $(this).text();
        var taskId = $(this).data('task-id');
        var aE = `<a class="fw-bold" href="/tasks/`+ taskId+`">`+taskTitle+`</a>`;

        const containerListHashtag = $(this).closest('.list-title-by-hashtag');
        const contentE = containerListHashtag.siblings('.content-report');

        const lastIndex = contentE.html().lastIndexOf('#');
        if (lastIndex !== -1) {
            const newContent = contentE.html().substring(0, lastIndex) + aE;
            contentE.empty().append(newContent);
        }

        focusElement(contentE);

        containerListHashtag.empty();
    });

    $(document).on('click', '#edit-btn', function() {
        var swal = showAlertLoading();
        callAjaxByJsonWithData("/api/v1/weekly-reports/" + ${wr.id}, "GET", null, function (rs) {
            $('#title').val(rs.title);

            $('#this-week-content').html(rs.currentWeeklyContent);
            $('#next-week-content').html(rs.nextWeeklyContent);
            $('#edit-wr-form .ql-toolbar.ql-snow').remove();
            activeEditor("#edit-wr-form");

            swal.close();
            $('#editReport').modal('show');
        });

        Validator({
            form:'#edit-wr-form',
            errorSelector: '.form-message',
            rules:[
                Validator.isRequired('#title'),
                Validator.isRequired('#this-week-content'),
                Validator.isRequired('#next-week-content')
            ],
            onSubmit: function (formData) {
                formData.append("currentWeeklyContent", $('#this-week-content').html());
                formData.append("nextWeeklyContent", $('#next-week-content').html());
                formData.append("id", ${wr.id});

                $('#edit-wr-form .spinner-border').removeClass('d-none');
                callAjaxByJsonWithDataForm("/api/v1/weekly-reports", "PUT", formData, function (rs) {

                    $('#edit-wr-form .spinner-border').addClass('d-none');
                    $('#editReport').modal('hide');

                    $('#title-show').text(rs.title);
                    $('#this-week-content-show').html(rs.currentWeeklyContent);
                    $('#next-week-content-show').html(rs.nextWeeklyContent);
                });
            }
        });
    });
</script>
</body>
</html>