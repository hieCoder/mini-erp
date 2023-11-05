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
            <div class="col-xl-2 list-staff-container">
                <div>
                    <h5 class="mb-1">Staffs</h5>
                    <p class="text-muted">Click to any staff to see info about weekly report of that staff</p>
                    <div class="pe-2 me-n1 mb-3" data-simplebar style="height: 818px">
                        <div id="staff-list"></div>
                    </div>
                </div>
                <!--end card-->
            </div> <!-- end col-->

            <div class="col-xl-10 list-wr-container">
                <div class="card">
                    <div class="card-header border-0">
                        <div class="d-flex align-items-center">
                            <h5 class="card-title mb-0 flex-grow-1">Weekly report</h5>
                            <div class="flex-shrink-0">
                                <button class="btn btn-success add-btn" data-bs-toggle="modal" data-bs-target="#createReport"><i class="ri-add-line align-bottom me-1"></i> Create report</button>
                            </div>
                        </div>
                    </div>
                    <div class="card-body border border-dashed border-end-0 border-start-0">
                        <div class="row g-3">
                            <div class="col-xxl-4 col-sm-4 d-flex align-items-center justify-content-start">
                                <div style="margin-right: 5px;">Show entries: </div>
                                <div>
                                    <select id="page-count-select" class="form-select" aria-label=".form-select-lg example">
                                        <option value="10">10</option>
                                        <option value="15">15</option>
                                        <option value="20">20</option>
                                    </select>
                                </div>
                            </div>
                            <!--end col-->
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive table-card">
                            <table class="table align-middle table-nowrap mb-0 w-100" style="margin: 0px!important;" id="weekly-report-table">
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
                            <!--end table-->
                        </div>
                        <div class="d-flex justify-content-center">
                            <div class="pagination-wrap hstack gap-2">
                                <ul id="pagination" class="pagination mb-0"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!-- end col -->
        </div>
        <!--end row-->
    </div>
</div> <!-- end row-->

<!-- create modal -->
<div class="modal fade" id="createReport" tabindex="-1" aria-labelledby="createReportLabel" aria-hidden="true">
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
                        <div class="form-control content-report" id="this-week-content" contenteditable="true"></div>
                        <small class="form-message"></small>
                        <ul class="list-group list-title-by-hashtag" style="max-height: 200px; overflow: auto;"></ul>
                    </div>
                    <div class="mb-3">
                        <label for="next-week-content" class="col-form-label">Next week's content:</label>
                        <div class="form-control" id="next-week-content" contenteditable="true"></div>
                        <small class="form-message"></small>
                    </div>
                    <div class="mb-3 d-flex justify-content-end">
                        <button type="submit" class="btn btn-success" style="margin-right:2px;">Create</button>
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

    $(document).ready(function (){

        if(isDeleveloper()){
            $('.list-staff-container').remove();
            $('.list-wr-container').toggleClass('col-xl-10 col-xl-12');
            pagingObj.staffId = userCurrent.id;
        } else{
            callAjaxByJsonWithData('/api/v1/users/usernames', 'GET', null, function (rs) {
                rs.forEach(function (user, index) {
                    var staff = createStaffE(user);
                    $('#staff-list').append(staff);
                });
                var staffFirst = $('#staff-list').find('.staff-name').first();
                staffFirst.addClass('text-decoration-underline');
                pagingObj.staffId = $(staffFirst).data('id');
            });

            $(document).on('click', '.staff-name', function (e){
                $('#staff-list').find('.staff-name').removeClass('text-decoration-underline');
                $(this).addClass('text-decoration-underline');
                pagingObj.staffId = $(this).data('id');
                pagingObj.page = 1;
                tableWR.ajax.url(getListApiUrl(pagingObj.staffId,
                    pagingObj.page, pagingObj.pageSize)).load();
            });
        }

        callAjaxByJsonWithData('/api/v1/users/'+pagingObj.staffId, 'GET', null, function (user) {
            tableWR = $('#weekly-report-table').DataTable({
                ajax: {
                    url: getListApiUrl(pagingObj.staffId, 1, pagingObj.pageSize),
                    method: 'GET',
                    dataSrc: function (json) {
                        if(json.length != 0) {
                            loadPaging();
                            $('#pagination').addClass('mt-4');
                        }
                        else {
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
                        render: function(data, type, row) {
                            return `<a href="/weekly-reports/`+ row.id +`" class="fw-medium link-primary text-decoration-underline">` + data + `</a>`;
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

            $('#page-count-select').on('change', function() {
                var selectedValue = $(this).val();
                pagingObj.page = 1;
                pagingObj.pageSize = selectedValue;
                tableWR.ajax.url(getListApiUrl(pagingObj.staffId,
                    pagingObj.page, pagingObj.pageSize)).load();
            });
        });

        Validator({
            form:'#create-wr-form',
            errorSelector: '.form-message',
            rules:[
                Validator.isRequired('#title'),
                Validator.isRequired('#this-week-content'),
                Validator.isRequired('#next-week-content')
            ],
            onSubmit: function (formData) {
                console.log(123);
                // formData.append('content', $('#content').html());
                // callAjaxByJsonWithDataForm("/api/v1/tasks/register", "POST", formData, function (rs) {
                //     window.location.href = "/tasks?registerSuccess";
                // });
            }
        });
    });

    $(document).on('input', '.content-report', function (e){

        const enteredText = $(this).html();
        const wordsArray = enteredText.split(' ');

        if (wordsArray.length > 0) {
            const lastWord = wordsArray[wordsArray.length - 1];
            if (lastWord.includes('#')) {
                const contentAfterHashtag = lastWord.split('#').pop();
                callAjaxByJsonWithData('/api/v1/tasks/hashtag/'+userCurrent.id+'?hashtag='+contentAfterHashtag,
                    'GET', null, function (rs) {
                    var ulElement = $('.list-title-by-hashtag');
                    ulElement.empty();
                    rs.forEach(function (e) {
                        ulElement.append(`<li class="hashtag-e list-group-item list-group-item-action` +
                            ` cursor-pointer" data-task-id="`+e.id+`">` + e.title + `</li>`);
                    });
                });
            }
        }
    });

    $(document).on('click', '.hashtag-e', function (e){
        var taskTitle = $(this).text();
        var taskId = $(this).data('task-id');
        var aE = `<a href="/tasks/`+ taskId+`">`+taskTitle+`</a>`;

        const containerListHashtag = $(this).closest('.list-title-by-hashtag');
        const contentE = containerListHashtag.siblings('.content-report');

        if (lastIndex !== -1) {
            const lastIndex = contentE.html().lastIndexOf('#');
            const newContent = contentE.html().substring(0, lastIndex) + aE;
            contentE.empty().append(newContent);
        }

        containerListHashtag.empty();
    });

    function removePagingIfExsit(){
        if (window.pagObj) {
            window.pagObj.twbsPagination('destroy');
        }
    }

    function loadPaging(){
        callAjaxByJsonWithData(getCountListApiUrl(pagingObj.staffId), 'GET', null, function (totalItem) {

            removePagingIfExsit();

            //paging
            var totalPages = 0;
            if(totalItem <= pagingObj.pageSize) totalPages = 1;
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
