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
            <div class="col-xl-2">
                <div>
                    <h5 class="mb-1">Staffs</h5>
                    <p class="text-muted">Click to any staff to see info about weekly report of that staff</p>
                    <div class="pe-2 me-n1 mb-3" data-simplebar style="height: 818px">
                        <div id="staff-list"></div>
                    </div>
                </div>
                <!--end card-->
            </div> <!-- end col-->

            <div class="col-xl-10">
                <div class="card">
                    <div class="card-header border-0">
                        <div class="d-flex align-items-center">
                            <h5 class="card-title mb-0 flex-grow-1">Weekly report</h5>
                            <div class="flex-shrink-0">
                                <button class="btn btn-success add-btn" data-bs-toggle="modal" data-bs-target="#registerTaskModal"><i class="ri-add-line align-bottom me-1"></i> Create report</button>
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
                            <table class="table align-middle table-nowrap mb-0 w-100" style="margin-top: 0px!important;" id="weekly-report-table">
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
                        <div class="d-flex justify-content-center mt-4">
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

<script src="/assets/custom/js/weekly-report/weekly-report.js"></script>
<script>
    var tableWR = '';
    var pagingObj = {
        page: 1,
        pageSize: $('#page-count-select').val()
    }

    $(document).ready(function (){
        callAjaxByJsonWithData('/api/v1/users/usernames', 'GET', null, function (rs) {
            rs.forEach(function (user, index) {
                var staff = createStaffE(user);
                $('#staff-list').append(staff);
            });
            var staffFirst = $('#staff-list').find('.staff-name').first();
            staffFirst.addClass('text-decoration-underline');
            var staffId = $(staffFirst).data('id');

            callAjaxByJsonWithData('/api/v1/users/'+staffId, 'GET', null, function (user) {
                tableWR = $('#weekly-report-table').DataTable({
                    ajax: {
                        url: getListApiUrl(staffId, 1, pagingObj.pageSize),
                        method: 'GET',
                        dataSrc: ''
                    },
                    columns: [
                        {data: 'id'},
                        {
                            data: 'title',
                            render: function(data, type, row) {
                                return `<a href="#" class="fw-medium link-primary">` + data + `</a>`;
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

                //loadPaging();

                $('#page-count-select').on('change', function() {
                    var selectedValue = $(this).val();
                    pagingObj.pageSize = selectedValue;
                    console.log(selectedValue);
                });
            });
        });
    });

    $(document).on('click', '.staff-name', function (e){
        $('#staff-list').find('.staff-name').removeClass('text-decoration-underline');
        $(this).addClass('text-decoration-underline');
        var staffId = $(this).data('id');
        callAjaxByJsonWithData('/api/v1/users/'+staffId, 'GET', null, function (user) {
            tableWR.ajax.url(getListApiUrl(staffId, 1, pagingObj.pageSize)).load();
        });
    });



    // function loadPaging(){
    //     callAjaxByJsonWithData(getCountListApiUrl(), 'GET', null, function (totalItem) {
    //
    //         if (window.pagObj) {
    //             window.pagObj.twbsPagination('destroy');
    //         }
    //
    //         //paging
    //         var totalPages = 0;
    //         if(totalItem <= tasksRequest.pageSize) totalPages = 1;
    //         else totalPages = Math.ceil(totalItem / tasksRequest.pageSize);
    //         var currentPage = tasksRequest.page;
    //
    //         $(function () {
    //             window.pagObj = $('#pagination').twbsPagination({
    //                 totalPages: totalPages,
    //                 startPage: currentPage,
    //                 onPageClick: function (event, page) {
    //                     if (currentPage != page) {
    //                         pagingObj.page = page;
    //                         tableWR.ajax.reload();
    //                         currentPage = page;
    //                     }
    //                 }
    //             });
    //         });
    //     });
    // }
</script>
</body>
</html>
