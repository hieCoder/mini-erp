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
                    <button type="button" class="btn btn-danger" id="del-btn" data-value="${wr.id}">Delete</button>
                    <a href="/weekly-reports" class="btn btn-light">Back</a>
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
                        <div class="snow-editor content-report" id="this-week-content" style="height: 150px !important;"></div>
                        <small class="form-message"></small>
                        <ul class="list-group list-title-by-hashtag" style="max-height: 200px; overflow: auto;"></ul>
                    </div>
                    <div class="mb-3">
                        <label for="next-week-content" class="col-form-label">Next week's content:</label>
                        <div class="snow-editor content-report" id="next-week-content" style="height: 150px !important;"></div>
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

    function setWeeklyReport(title, currentWeeklyContent, nextWeeklyContent) {
        $('#title-show').text(title);
        $('#this-week-content-show').html(getContentViewOfEditorSnow(currentWeeklyContent));
        $('#next-week-content-show').html(getContentViewOfEditorSnow(nextWeeklyContent));
    }

    $(document).ready(function (){
        activeEditor(".wr-info-container");
        setWeeklyReport('${wr.title}' ,'${wr.currentWeeklyContent}', '${wr.nextWeeklyContent}');
    });

    $(document).on('keyup', '.content-report', function (e) {
        var ulElement = $(this).siblings('.list-title-by-hashtag');
        const enteredText = e.target.innerText;
        const getCoordinate = getCoordinates(e.target);
        const caretPosition = getCursorPosition(e.target);
        const lastHashIndex = enteredText.lastIndexOf('#', getCoordinate - 1);
        if (lastHashIndex !== -1) {
            var lastHashtag = enteredText.substring(lastHashIndex + 1, caretPosition);
            const containsSpace = lastHashtag.includes(' ');
            if (containsSpace || (e.which == 13)) {
                ulElement.empty();
            } else {
                if (enteredText.includes('#') && (e.which == 13)) lastHashtag = enteredText.substring(lastHashIndex + 1, caretPosition);
                callAjaxByJsonWithData('/api/v1/tasks/search/' + userCurrent.id + '?title=' + lastHashtag,
                    'GET', null, function (rs) {
                        ulElement.empty();
                        rs.forEach(function (e) {
                            ulElement.append(`<li class="hashtag-e list-group-item list-group-item-action cursor-pointer" data-task-id="` + e.id + `">` + e.title + `</li>`);
                        });
                    });
            }
        } else {
            ulElement.empty();
        }
    });

    function getCursorPosition(element) {
        const selection = window.getSelection();
        const range = selection.getRangeAt(0);
        const preCaretRange = range.cloneRange();
        preCaretRange.selectNodeContents(element);
        preCaretRange.setEnd(range.endContainer, range.endOffset);
        const cursorPos = preCaretRange.toString().length;
        return cursorPos;
    }
    function getCoordinates(element) {
        let caretOffset = 0;
        const doc = element.ownerDocument || element.document;
        const win = doc.defaultView || doc.parentWindow;
        let range, rect;

        if (win.getSelection) {
            range = win.getSelection().getRangeAt(0);

            if (range.collapsed) {
                rect = range.getBoundingClientRect();
                caretOffset = rect.left + rect.width;
            } else {
                const preCaretRange = range.cloneRange();
                preCaretRange.selectNodeContents(element);
                preCaretRange.setEnd(range.endContainer, range.endOffset);
                rect = preCaretRange.getBoundingClientRect();
                caretOffset = rect.left + rect.width;
            }
        }

        return caretOffset;
    }

    $(document).on('click', '.hashtag-e', function (e) {
        var taskTitle = $(this).text();
        var taskId = $(this).data('task-id');
        var aE = `<a class="fw-bold" href="/tasks/` + taskId + `">` + taskTitle + `</a>`;

        const containerListHashtag = $(this).closest('.list-title-by-hashtag');
        const contentE = containerListHashtag.siblings('.content-report');
        const lastIndex = contentE.html().lastIndexOf('#');
        if (lastIndex !== -1) {
            const substringAfterLastHash = contentE.html().substring(lastIndex);
            const firstAngleBracketIndex = substringAfterLastHash.indexOf('<');
            if (firstAngleBracketIndex !== -1) {
                var textContentE = contentE[0].textContent;
                var cutContent = textContentE.substring(textContentE.indexOf('#') + 1);
                var replacedText = '';
                if (taskTitle.includes(cutContent)) replacedText = contentE.html().replace(substringAfterLastHash, aE);
                else replacedText = contentE.html().replace(substringAfterLastHash, aE + cutContent);

                contentE.html(replacedText);
            }
        }

        focusElement(contentE.find('.ql-editor').first());

        containerListHashtag.empty();
    });

    $(document).on('click', '#edit-btn', function() {
        var swal = showAlertLoading();
        callAjaxByJsonWithData("/api/v1/weekly-reports/" + ${wr.id}, "GET", null, function (rs) {
            $('#title').val(rs.title);
            const currenWeelyReport = rs.currentWeeklyContent;
            const nextWeeklyReport = rs.nextWeeklyContent;
            $('#this-week-content').html(currenWeelyReport.replace(/\\'/g, "'"));
            $('#next-week-content').html(nextWeeklyReport.replace(/\\'/g, "'"));
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
                const contentCurrentWeeklyContent = $('#this-week-content').html();
                const contentNextWeeklyContent = $('#next-week-content').html();
                formData.append("currentWeeklyContent", contentCurrentWeeklyContent.replace(/'/g, "\\'"));
                formData.append("nextWeeklyContent", contentNextWeeklyContent.replace(/'/g, "\\'"));
                formData.append("id", ${wr.id});

                $('#edit-wr-form .spinner-border').removeClass('d-none');
                callAjaxByJsonWithDataForm("/api/v1/weekly-reports", "PUT", formData, function (rs) {

                    $('#edit-wr-form .spinner-border').addClass('d-none');
                    $('#editReport').modal('hide');

                    const respCurrentWeeklyContent = rs.currentWeeklyContent;
                    const respNextWeeklyContent = rs.nextWeeklyContent;

                    setWeeklyReport(rs.title, respCurrentWeeklyContent.replace(/\\'/g, "'"), respNextWeeklyContent.replace(/\\'/g, "'"));
                });
            }
        });
    });

    $(document).on('click', '#del-btn', function() {
        const weeklyId = $(this).data('value');
            Swal.fire({
                title: "Are you sure?",
                text: "You won't be able to revert this!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
                cancelButtonClass: 'btn btn-danger w-xs mt-2',
                confirmButtonText: "Yes, delete it!",
                buttonsStyling: false,
                showCloseButton: true
            }).then(function (result) {
                if (result.value) {
                    callAjaxByJsonWithData('/api/v1/weekly-reports/' +  weeklyId, 'DELETE', null, function (rs) {
                        if (rs == 1) {
                            Swal.fire({
                                title: 'Deleted!',
                                text: 'Your WeeklyReport has been deleted.',
                                icon: 'success',
                                confirmButtonClass: 'btn btn-primary w-xs mt-2',
                                buttonsStyling: false
                            }).then(function (result2) {
                                window.location = '/weekly-reports';
                            })
                        }
                    });
                }
            });
    });
</script>
</body>
</html>