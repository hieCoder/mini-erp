<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Timesheets</title>

    <!-- fullcalendar css -->
    <link href="/assets/libs/fullcalendar/main.min.css" rel="stylesheet" type="text/css" />
</head>
<body>
<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Timesheets</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Human management</a></li>
                    <li class="breadcrumb-item active">Timesheets</li>
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
                    <h5 class="mb-1">Import file to system</h5>
                    <p class="text-muted">Save timesheet off employee all in a month to system</p>
                    <div class="card-body">
                        <form class="form-control import-timesheest-form">
                            <div class="row g-3">
                                <div class="col-lg-12">
                                    <input name="file" class="form-control form-control-sm file-import-input" type="file">
                                    <small class="form-message" style="color:red;"></small>
                                    <div>
                                        <button type="button" class="btn btn-success waves-effect waves-light btn-sm btn-submit-file-import mt-1">Submit</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="mt-3">
                    <h5 class="mb-1">Staffs</h5>
                    <p class="text-muted">Click to any staff to see info about timesheets of that staff</p>
                    <div class="pe-2 me-n1 mb-3" data-simplebar style="height: 818px">
                        <div id="staff-list"></div>
                    </div>
                </div>
                <!--end card-->
            </div> <!-- end col-->

            <div class="col-xl-10">
                <div class="card card-h-100">
                    <div class="card-body">
                        <div id="calendar"></div>
                    </div>
                </div>
            </div><!-- end col -->
        </div>
        <!--end row-->
    </div>
</div> <!-- end row-->

<!-- dropzone min -->
<script src="/assets/libs/dropzone/dropzone-min.js"></script>

<script src="/assets/custom/js/task/task.js"></script>

<!-- calendar min js -->
<script src="/assets/libs/fullcalendar/main.min.js"></script>

<script src="/assets/custom/js/timesheets/timesheets.js"></script>

<script>

    var calendar;
    var month;
    var year;

    $(document).ready(function (){

        callAjaxByJsonWithData('/api/v1/users/usernames', 'GET', null, function (rs){
            rs.forEach(function(user, index) {
                var staff = createStaffE(user);
                $('#staff-list').append(staff);
            });
            $('#staff-list').find('.staff-name').first().addClass('text-decoration-underline');

            function handleCalendarViewChange(info) {
                var newDate = info.view.currentStart;

                var dateObj = new Date(newDate);
                month = dateObj.getMonth() + 1;
                year = dateObj.getFullYear();

                var staffCurent = document.querySelector('.staff-name.text-decoration-underline');
                var dataId =staffCurent.getAttribute('data-id');
                callAjaxByJsonWithData('/api/v1/timesheets/'+dataId+'?year='+year+"&month="+month, 'GET', null, function (data) {
                    calendar.setOption('events', convertListTimesheetToCalendar(data));
                });
            }

            var calendarElement = document.getElementById("calendar");
            calendar = new FullCalendar.Calendar(calendarElement, {
                timeZone: "local",
                editable: false,
                droppable: true,
                selectable: true,
                navLinks: true,
                themeSystem: "bootstrap",
                headerToolbar: {
                    left: "prev,next",
                    center: "title",
                    right: false
                },
                events: [],
                datesSet: handleCalendarViewChange
            });

            calendar.render();
        });
    });

    $(document).on('click', '.staff-name', function (e){
        $('#staff-list').find('.staff-name').removeClass('text-decoration-underline');
        $(this).addClass('text-decoration-underline');
        var staffId = $(this).data('id');
        callAjaxByJsonWithData('/api/v1/timesheets/'+staffId+'?year='+year+"&month="+month, 'GET', null, function (data) {
            calendar.setOption('events', convertListTimesheetToCalendar(data));
        });
    });

    $(document).on('click', '.btn-submit-file-import', function (e) {
        var formClass = '.import-timesheest-form';
        var inputE = $(formClass + ' .file-import-input');
        var errorE = $(formClass + ' .form-message');
        if(inputE.val() == ''){
            errorE.text('This field is not filled');
        } else{
            var formData=new FormData();
            var fileInput = $(formClass + ' input[type="file"]')[0];

            if (fileInput.files.length > 0) {
                var file = fileInput.files[0];
                formData.append(fileInput.name, file);
                callAjaxByDataFormWithDataForm('/api/v1/timesheets/upload', 'POST', formData, function (rs){
                    inputE.val('');
                    alertSuccess('Import success');
                }, function (err) {
                    if('Some user not exist in system' == err.responseJSON.message){
                        errorE.text('Some user not exist in system');
                    } else{
                        errorE.text('Import fail! Can not import');
                    }
                });
            }
        }
    });
</script>
</body>
</html>
