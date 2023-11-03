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
                <div class="card card-h-100">
                    <div class="card-body">
                        <div class="table-responsive table-card mb-4">
                            <table class="table align-middle table-nowrap mb-0 w-100" id="weekly-report-table">
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
                                <ul id="pagination" class="pagination"></ul>
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
                console.log(456);
                var roleUser = user.role.code;
                tableWR = $('#weekly-report-table').DataTable({
                    ajax: {
                        url: getApiUrl(roleUser, staffId, 1, 10),
                        method: 'GET',
                        dataSrc: ''
                    },
                    columns: [
                        {data: 'id'},
                        {data: 'title'},
                        {data: 'user.fullname'},
                        {data: 'createdDate'}
                    ],
                    ordering: false,
                    searching: false,
                    lengthChange: false,
                    paging: false,
                    info: false
                });
            });
        });
    });

    // $(document).on('click', '.staff-name', function (e){
    //     $('#staff-list').find('.staff-name').removeClass('text-decoration-underline');
    //     $(this).addClass('text-decoration-underline');
    //     var staffId = $(this).data('id');
    //     callAjaxByJsonWithData('/api/v1/users/'+staffId, 'GET', null, function (user) {
    //         console.log(123);
    //         var roleUser = user.role.code;
    //         tableWR.ajax.url(getApiUrl(roleUser, staffId, 1, 10)).load();
    //     });
    // });
</script>
</body>
</html>
