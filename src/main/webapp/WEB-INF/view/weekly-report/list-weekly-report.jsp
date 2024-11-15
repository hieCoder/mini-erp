<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Weekly report</title>
</head>
<body>
<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Weekly report</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Tasks management</a></li>
                    <li class="breadcrumb-item active">Weekly report</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<!-- end page title -->

<div class="row">
    <div class="col-12">
        <div class="row">
            <div class="col-xl-2 list-staff-container d-none">
                <div>
                    <h5 class="mb-1">Staffs</h5>
                    <p class="text-muted">Click to any staff to see info about weekly report of that staff</p>
                    <div class="pe-2 me-n1 mb-3" data-simplebar style="height: 818px">
                        <div id="staff-list"></div>
                    </div>
                </div>
            </div>

            <div class="col-xl-12 list-wr-container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="alert alert-success mb-2 d-none"></div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header border-0">
                        <div class="d-flex align-items-center">
                            <h5 class="card-title mb-0 flex-grow-1">Weekly report</h5>
                            <div class="flex-shrink-0">
                                <button class="btn btn-success add-btn" data-bs-toggle="modal"
                                        data-bs-target="#createReport"><i class="ri-add-line align-bottom me-1"></i>
                                    Create report
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="card-body border border-dashed border-end-0 border-start-0">
                        <div class="row g-3">
                            <div class="col-xxl-4 col-sm-4 d-flex align-items-center justify-content-start">
                                <div style="margin-right: 5px;">Show entries:</div>
                                <div class="page-count-item-container d-flex align-items-center align-items-center">
                                    <select id="page-count-select" class="form-select"
                                            aria-label=".form-select-lg example">
                                        <option value="10">10</option>
                                        <option value="15">15</option>
                                        <option value="20">20</option>
                                    </select>
                                    <span class="btn-load ml-10">
                                        <span class="spinner-border flex-shrink-0 d-none"></span>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive table-card">
                            <table class="table align-middle table-nowrap mb-0 w-100" style="margin: 0px!important;"
                                   id="weekly-report-table">
                                <thead class="table-light text-muted">
                                <tr>
                                    <th>ID</th>
                                    <th>Title</th>
                                    <th>Username</th>
                                    <th>Created date</th>
                                </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                        <div class="d-flex justify-content-center">
                            <div class="pagination-wrap hstack gap-2">
                                <ul id="pagination" class="pagination mb-0"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- create modal -->
<div class="modal modal-xl fade" id="createReport" tabindex="-1" aria-labelledby="createReportLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="createReportLabel">Create weekly report</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="create-wr-form">
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
                        <button type="submit" class="btn btn-success btn-load" style="margin-right: 3px;">
                                <span class="d-flex align-items-center">
                                    <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                    <span class="flex-grow-1">Create</span>
                                </span>
                        </button>
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="/assets/custom/js/weekly-report/weekly-report.js"></script>
<script>
    var tableWR = '';
    var pagingObj = {
        staffId: '',
        page: 1,
        pageSize: $('#page-count-select').val()
    }

    $(document).ready(function () {

        new Promise(function (resolve, reject) {
            if (!isOwner()) {
                $('.list-staff-container').remove();
                pagingObj.staffId = userCurrent.id;
                resolve();
            } else {
                var swal = showAlertLoading();

                $('.list-staff-container').removeClass('d-none');
                $('.list-wr-container').toggleClass('col-xl-12 col-xl-10');

                callAjaxByJsonWithData('/api/v1/users/usernames', 'GET', null, function (rs) {
                    rs.forEach(function (user, index) {
                        var staff = createStaffE(user);
                        $('#staff-list').append(staff);
                    });
                    var staffFirst = $('#staff-list').find('.staff-name').first();
                    staffFirst.addClass('text-decoration-underline');
                    swal.close();
                    pagingObj.staffId = $(staffFirst).data('id');
                    resolve();
                });
            }
        }).then(function () {
            tableWR = $('#weekly-report-table').DataTable({
                ajax: {
                    url: getListApiUrl(pagingObj.staffId, 1, pagingObj.pageSize),
                    method: 'GET',
                    dataSrc: function (json) {
                        if (json.length != 0) {
                            loadPaging();
                            $('#pagination').addClass('mt-4');
                        } else {
                            removePagingIfExsit();
                            $('#pagination').removeClass('mt-4');
                        }
                        return json;
                    }
                },
                columns: [
                    {data: 'id'},
                    {
                        data: 'title',
                        render: function (data, type, row) {
                            return `<a href="/weekly-reports/` + row.id + `" class="fw-medium link-primary text-decoration-underline">` + data + `</a>`;
                        }
                    },
                    {data: 'user.fullname'},
                    {data: 'createdDate'}
                ],
                ordering: false,
                searching: false,
                lengthChange: false,
                paging: false,
                info: false
            });
        }).catch(function (error) {
            console.error(error);
        });
    });

    $(document).on('shown.bs.modal', '#createReport', function () {

        $('#title').val('');

        $('.content-report .ql-editor').html('<p><br></p>');
        $('#create-wr-form .ql-toolbar.ql-snow').remove();
        activeEditor("#create-wr-form");

        Validator({
            form: '#create-wr-form',
            errorSelector: '.form-message',
            rules: [
                Validator.isRequired('#title'),
                Validator.isRequired('#this-week-content'),
                Validator.isRequired('#next-week-content')
            ],
            onSubmit: function (formData) {
                const contentCurrentWeeklyContent = $('#this-week-content').html();
                const contentNextWeeklyContent = $('#next-week-content').html();
                formData.append("currentWeeklyContent", contentCurrentWeeklyContent.replace(/'/g, "\\'"));
                formData.append("nextWeeklyContent", contentNextWeeklyContent.replace(/'/g, "\\'"));
                formData.append("userId", userCurrent.id);

                $('#create-wr-form .spinner-border').removeClass('d-none');
                callAjaxByJsonWithDataForm("/api/v1/weekly-reports", "POST", formData, function (rs) {
                    tableWR.ajax.reload(function () {
                        $('#create-wr-form .spinner-border').addClass('d-none');
                        $("#createReport").modal("hide");
                        showAlert(SUCCESS_ALERT, 'Create success');
                    });
                });
            }
        });
    });

    $(document).on('click', '.staff-name', function (e) {
        $('#staff-list').find('.staff-name').removeClass('text-decoration-underline');
        $(this).addClass('text-decoration-underline');
        pagingObj.staffId = $(this).data('id');
        pagingObj.page = 1;

        if (pagingObj.staffId != userCurrent.id) $('.add-btn').addClass('d-none');
        else $('.add-btn').removeClass('d-none');

        var spinnerE = $(this).closest('.card-body').find('.spinner-border');
        spinnerE.removeClass('d-none');
        tableWR.ajax.url(getListApiUrl(pagingObj.staffId,
            pagingObj.page, pagingObj.pageSize)).load(function () {
            spinnerE.addClass('d-none');
        });
    });

    $(document).on('change', '#page-count-select', function () {
        var selectedValue = $(this).val();
        pagingObj.page = 1;
        pagingObj.pageSize = selectedValue;

        var selectContainerE = $(this).closest('.page-count-item-container');
        selectContainerE.find('.spinner-border').removeClass('d-none');
        tableWR.ajax.url(getListApiUrl(pagingObj.staffId,
            pagingObj.page, pagingObj.pageSize)).load(function () {
            selectContainerE.find('.spinner-border').addClass('d-none');
        });
    });

    $(document).on('keyup', '.content-report', function (e) {
        var ulElement = $(this).siblings('.list-title-by-hashtag');
        const enteredText = e.target.innerText;
        const getCoordinate = getCoordinates(e.target);
        const caretPosition = getCursorPosition(e.target);
        const lastHashIndex = enteredText.lastIndexOf('#', caretPosition);
        const spaceIndex = enteredText.indexOf(' ', caretPosition);
        const lastSpaceIndex = spaceIndex === -1 ? enteredText.length : spaceIndex;
        if (lastHashIndex !== -1 && lastSpaceIndex > lastHashIndex) {
            if (enteredText.trim() != '') {
                var lastHashtag = enteredText.substring(lastHashIndex + 1, lastSpaceIndex);
                const containsSpace = lastHashtag.includes(' ');
                if (containsSpace || (e.which == 13)) {
                    ulElement.empty();
                } else {
                    if (enteredText.includes('#') && (e.which == 13)) lastHashtag = enteredText.substring(lastHashIndex + 1, caretPosition);
                    callAjaxByJsonWithData('/api/v1/tasks/search/' + userCurrent.id + '?title=' + lastHashtag, 'GET', null, function (rs) {
                        ulElement.empty();
                        rs.forEach(function (e) {
                            ulElement.append(`<li class="hashtag-e list-group-item list-group-item-action cursor-pointer" data-task-id="` + e.id + `">` + e.title + `</li>`);
                        });
                    });
                }
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

    function removePagingIfExsit() {
        if (window.pagObj) {
            window.pagObj.twbsPagination('destroy');
        }
    }

    function loadPaging() {
        callAjaxByJsonWithData(getCountListApiUrl(pagingObj.staffId), 'GET', null, function (totalItem) {

            removePagingIfExsit();

            //paging
            var totalPages = 0;
            if (totalItem <= pagingObj.pageSize) totalPages = 1;
            else totalPages = Math.ceil(totalItem / pagingObj.pageSize);
            var currentPage = pagingObj.page;

            $(function () {
                window.pagObj = $('#pagination').twbsPagination({
                    totalPages: totalPages,
                    startPage: currentPage,
                    onPageClick: function (event, page) {
                        if (currentPage != page) {
                            pagingObj.page = page;
                            tableWR.ajax.url(getListApiUrl(pagingObj.staffId,
                                pagingObj.page, pagingObj.pageSize)).load();
                            currentPage = page;
                        }
                    }
                });
            });
        });
    }

</script>
</body>
</html>
