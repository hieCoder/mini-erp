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
            <div class="card-body">
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
                    <div class="form-control" id="this-week-content-show">${wr.currentWeeklyContent}</div>
                </div>
                <div>
                    <label class="col-form-label">Next week's content:</label>
                    <div class="form-control" id="next-week-content-show">${wr.nextWeeklyContent}</div>
                </div>
                <div>
                    <label class="col-form-label">Created date:&nbsp</label>${wr.createdDate}
                </div>
                <div>
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editReport" data-bs-whatever="@mdo">Edit</button>
                </div>
            </div>
        </div>
        <!--end card-->
    </div>
</div>

<!-- edit modal -->
<div class="modal fade" id="editReport" tabindex="-1" aria-labelledby="editReportLabel" aria-hidden="true">
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
                        <input name="title" type="text" class="form-control" id="title" value="${wr.title}">
                        <small class="form-message"></small>
                    </div>
                    <div class="mb-3">
                        <label for="this-week-content" class="col-form-label">This week's content:</label>
                        <div class="form-control content-report" id="this-week-content" contenteditable="true">${wr.currentWeeklyContent}</div>
                        <small class="form-message"></small>
                        <ul class="list-group list-title-by-hashtag" style="max-height: 200px; overflow: auto;"></ul>
                    </div>
                    <div class="mb-3">
                        <label for="next-week-content" class="col-form-label">Next week's content:</label>
                        <div class="form-control content-report" id="next-week-content" contenteditable="true">${wr.nextWeeklyContent}</div>
                        <small class="form-message"></small>
                        <ul class="list-group list-title-by-hashtag" style="max-height: 200px; overflow: auto;"></ul>
                    </div>
                    <div class="mb-3 d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary" style="margin-right:2px;">Edit</button>
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function (){
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
                callAjaxByJsonWithDataForm("/api/v1/weekly-reports", "PUT", formData, function (rs) {

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