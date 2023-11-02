<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <link href="../../../assets/custom/css/common/style.css" rel="stylesheet">
</head>
<body>

<div class="row">
    <div class="col-md-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">DASHBOARD</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item active"><a href="javascript: void(0);">Dashboard</a></li>
                </ol>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-xxl-4">
        <div class="card">
            <div class="card-header align-items-center d-flex">
                <h4 class="card-title mb-0 flex-grow-1">Upcoming Activities</h4>
                <div class="flex-shrink-0">
                    <div>
                        <a href="/schedules" class="btn btn-soft-primary btn-sm">
                            View all
                        </a>
                    </div>
                </div>
            </div><!-- end card header -->
            <div class="card-body pt-0">
                <ul class="list-group list-group-flush border-dashed" id="eventList">
                    <li class="list-group-item ps-0">
                        <div class="row align-items-center g-3">
                            <div class="col-auto">
                                <div class="avatar-sm p-1 py-2 h-auto bg-light rounded-3">
                                    <div class="text-center">
                                        <h5 class="mb-0">25</h5>
                                        <div class="text-muted">Tue</div>
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <h5 class="text-muted mt-0 mb-1 fs-13">12:00am - 03:30pm</h5>
                                <a href="#" class="text-reset fs-14 mb-0">Meeting for campaign with sales team</a>
                            </div>
                            <div class="col-sm-auto">
                                <div class="avatar-group">
                                    <div class="avatar-group-item">
                                        <a href="javascript: void(0);" class="d-inline-block" data-bs-toggle="tooltip"
                                           data-bs-placement="top" title="" data-bs-original-title="Stine Nielsen">
                                            <img src="assets/images/users/avatar-1.jpg" alt=""
                                                 class="rounded-circle avatar-xxs">
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end row -->
                    </li>
                </ul><!-- end -->
                <div class="align-items-center mt-2 row g-3 text-center text-sm-start">
                    <div class="col-sm">
                        <div class="text-muted">Showing<span class="fw-semibold">4</span> of <span class="fw-semibold">125</span>
                            Results
                        </div>
                    </div>
                    <div class="col-sm-auto">
                        <ul class="pagination pagination-separated pagination-sm justify-content-center justify-content-sm-start mb-0">
                            <li class="page-item disabled">
                                <a href="#" class="page-link">←</a>
                            </li>
                            <li class="page-item">
                                <a href="#" class="page-link">1</a>
                            </li>
                            <li class="page-item active">
                                <a href="#" class="page-link">2</a>
                            </li>
                            <li class="page-item">
                                <a href="#" class="page-link">3</a>
                            </li>
                            <li class="page-item">
                                <a href="#" class="page-link">→</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div><!-- end card body -->
        </div><!-- end card -->
    </div>
    <div class="col-xxl-4">
        <div class="loader">
            <span>SH SOFT VINA</span>
            <span>SH SOFT VINA</span>
        </div>
    </div>
    <div class="col-xxl-4">
        <div class="card card-height-100">
            <div class="card-header align-items-center d-flex">
                <h4 class="card-title mb-0 flex-grow-1">My Tasks</h4>
                <div class="flex-shrink-0">
                    <div class="dropdown card-header-dropdown">
                        <a class="text-reset dropdown-btn" href="#" data-bs-toggle="dropdown" aria-haspopup="true"
                           aria-expanded="false">
                            <span class="text-muted"><i class="ri-settings-4-line align-middle me-1 fs-15"></i>Settings</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end">
                            <a class="dropdown-item" href="#">Edit</a>
                            <a class="dropdown-item" href="#">Remove</a>
                        </div>
                    </div>
                </div>
            </div><!-- end card header -->

            <div class="card-body p-0">

                <div class="align-items-center p-3 justify-content-between d-flex">
                    <div class="flex-shrink-0">
                        <div class="text-muted"><span class="fw-semibold">4</span> of <span
                                class="fw-semibold">10</span> remaining
                        </div>
                    </div>
                    <button type="button" class="btn btn-sm btn-success"><i class="ri-add-line align-middle me-1"></i>
                        Add Task
                    </button>
                </div><!-- end card header -->

                <div data-simplebar="init" style="max-height: 219px;">
                    <div class="simplebar-wrapper" style="margin: 0px;">
                        <div class="simplebar-height-auto-observer-wrapper">
                            <div class="simplebar-height-auto-observer"></div>
                        </div>
                        <div class="simplebar-mask">
                            <div class="simplebar-offset" style="right: 0px; bottom: 0px;">
                                <div class="simplebar-content-wrapper" tabindex="0" role="region"
                                     aria-label="scrollable content" style="height: auto; overflow: hidden scroll;">
                                    <div class="simplebar-content" style="padding: 0px;">
                                        <ul class="list-group list-group-flush border-dashed px-3">
                                            <li class="list-group-item ps-0">
                                                <div class="d-flex align-items-start">
                                                    <div class="form-check ps-0 flex-sharink-0">
                                                        <input type="checkbox" class="form-check-input ms-0"
                                                               id="task_one">
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <label class="form-check-label mb-0 ps-2" for="task_one">Review
                                                            and make sure nothing slips through cracks</label>
                                                    </div>
                                                    <div class="flex-shrink-0 ms-2">
                                                        <p class="text-muted fs-12 mb-0">15 Sep, 2021</p>
                                                    </div>
                                                </div>
                                            </li>
                                            <li class="list-group-item ps-0">
                                                <div class="d-flex align-items-start">
                                                    <div class="form-check ps-0 flex-sharink-0">
                                                        <input type="checkbox" class="form-check-input ms-0"
                                                               id="task_two">
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <label class="form-check-label mb-0 ps-2" for="task_two">Send
                                                            meeting invites for sales upcampaign</label>
                                                    </div>
                                                    <div class="flex-shrink-0 ms-2">
                                                        <p class="text-muted fs-12 mb-0">20 Sep, 2021</p>
                                                    </div>
                                                </div>
                                            </li>
                                            <li class="list-group-item ps-0">
                                                <div class="d-flex align-items-start">
                                                    <div class="form-check flex-sharink-0 ps-0">
                                                        <input type="checkbox" class="form-check-input ms-0"
                                                               id="task_three">
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <label class="form-check-label mb-0 ps-2" for="task_three">Weekly
                                                            closed sales won checking with sales team</label>
                                                    </div>
                                                    <div class="flex-shrink-0 ms-2">
                                                        <p class="text-muted fs-12 mb-0">24 Sep, 2021</p>
                                                    </div>
                                                </div>
                                            </li>
                                            <li class="list-group-item ps-0">
                                                <div class="d-flex align-items-start">
                                                    <div class="form-check ps-0 flex-sharink-0">
                                                        <input type="checkbox" class="form-check-input ms-0"
                                                               id="task_four">
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <label class="form-check-label mb-0 ps-2" for="task_four">Add
                                                            notes that can be viewed from the individual view</label>
                                                    </div>
                                                    <div class="flex-shrink-0 ms-2">
                                                        <p class="text-muted fs-12 mb-0">27 Sep, 2021</p>
                                                    </div>
                                                </div>
                                            </li>
                                            <li class="list-group-item ps-0">
                                                <div class="d-flex align-items-start">
                                                    <div class="form-check ps-0 flex-sharink-0">
                                                        <input type="checkbox" class="form-check-input ms-0"
                                                               id="task_five">
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <label class="form-check-label mb-0 ps-2" for="task_five">Move
                                                            stuff to another page</label>
                                                    </div>
                                                    <div class="flex-shrink-0 ms-2">
                                                        <p class="text-muted fs-12 mb-0">27 Sep, 2021</p>
                                                    </div>
                                                </div>
                                            </li>
                                            <li class="list-group-item ps-0">
                                                <div class="d-flex align-items-start">
                                                    <div class="form-check ps-0 flex-sharink-0">
                                                        <input type="checkbox" class="form-check-input ms-0"
                                                               id="task_six">
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <label class="form-check-label mb-0 ps-2" for="task_six">Styling
                                                            wireframe design and documentation for velzon admin</label>
                                                    </div>
                                                    <div class="flex-shrink-0 ms-2">
                                                        <p class="text-muted fs-12 mb-0">27 Sep, 2021</p>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul><!-- end ul -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="simplebar-placeholder" style="width: auto; height: 268px;"></div>
                    </div>
                    <div class="simplebar-track simplebar-horizontal" style="visibility: hidden;">
                        <div class="simplebar-scrollbar" style="width: 0px; display: none;"></div>
                    </div>
                    <div class="simplebar-track simplebar-vertical" style="visibility: visible;">
                        <div class="simplebar-scrollbar"
                             style="height: 178px; transform: translate3d(0px, 0px, 0px); display: block;"></div>
                    </div>
                </div>
                <div class="p-3 pt-2">
                    <a href="javascript:void(0);" class="text-muted text-decoration-underline">Show more...</a>
                </div>
            </div><!-- end card body -->
        </div><!-- end card -->
    </div>
</div>
<div class="row">
    <div class="col-xxl-4">
        <div class="card">
            <div class="card-header align-items-center d-flex">
                <h4 class="card-title mb-0 flex-grow-1">Notifications</h4>
                <div>
                    <a href="/notifications" class="btn btn-soft-primary btn-sm">
                        View all
                    </a>
                </div>
            </div><!-- end card-header -->

            <div class="card-body pt-0" id="notificationList">
                <div class="d-flex align-middle">
                    <div class="flex-shrink-0">
                        <img src="assets/images/small/img-1.jpg" class="rounded img-fluid" style="height: 60px;" alt="">
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="mb-1 lh-base"><a href="#" class="text-reset">One stop shop destination on all the
                            latest news in crypto currencies</a></h6>
                        <p class="text-muted fs-12 mb-0">Dec 12, 2021 <i
                                class="mdi mdi-circle-medium align-middle mx-1"></i>09:22 AM</p>
                    </div>
                </div><!-- end -->
                <div class="mt-3 text-center">
                    <a href="javascript:void(0);" class="text-muted text-decoration-underline">View all News</a>
                </div>

            </div><!-- end card body -->
        </div><!-- end card -->
    </div>
    <div class="col-xxl-4"></div>
    <div class="col-xxl-4">
        <div class="row">
            <div class="col-xxl-6 col-sm-6">
                <div class="card card-animate">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <p class="fw-medium text-muted mb-0">Opened Tasks</p>
                                <h2 class="mt-4 ff-secondary fw-semibold"><span
                                        class="counter-value counter-opened-task" data-target="64.5">64.5</span></h2>
                                <p class="mb-0 text-muted"><span class="badge bg-light text-danger mb-0"> <i
                                        class="ri-arrow-down-line align-middle"></i> 0.87 %</span> vs. previous month
                                </p>
                            </div>
                            <div>
                                <div class="avatar-sm flex-shrink-0">
                                                <span class="avatar-title bg-soft-warning text-warning rounded-circle fs-4">
                                                    <i class="mdi mdi-timer-sand"></i>
                                                </span>
                                </div>
                            </div>
                        </div>
                    </div><!-- end card body -->
                </div>
            </div>
            <div class="col-xxl-6 col-sm-6">
                <div class="card card-animate">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <p class="fw-medium text-muted mb-0">Reopened Tasks</p>
                                <h2 class="mt-4 ff-secondary fw-semibold"><span
                                        class="counter-value counter-reopend-task" data-target="64.5">64.5</span></h2>
                                <p class="mb-0 text-muted"><span class="badge bg-light text-danger mb-0"> <i
                                        class="ri-arrow-down-line align-middle"></i> 0.87 %</span> vs. previous month
                                </p>
                            </div>
                            <div>
                                <div class="avatar-sm flex-shrink-0">
                                                <span class="avatar-title bg-soft-secondary text-secondary rounded-circle fs-4">
                                                    <i class="mdi mdi-timer-sand"></i>
                                                </span>
                                </div>
                            </div>
                        </div>
                    </div><!-- end card body -->
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function getDayOfWeek(dateString) {
        const dateParts = dateString.split(' ')[0].split('/');
        const timeParts = dateString.split(' ')[1].split(':');
        const year = parseInt(dateParts[2]);
        const day = parseInt(dateParts[0]);
        const month = parseInt(dateParts[1] - 1);
        const hour = parseInt(timeParts[0]);
        const minute = parseInt(timeParts[1]);
        const second = parseInt(timeParts[2]);

        const date = new Date(year, month, day, hour, minute, second);
        const options = { weekday: 'short' };
        return new Intl.DateTimeFormat('en-US', options).format(date);
    }

    function getDayFromDate(dateString) {
        return dateString.split('/')[0];
    }

    document.addEventListener("DOMContentLoaded", function () {
        var tbodyElement = document.getElementById("notificationList");
        var eventBodyElement = document.getElementById("eventList");
        callAjaxByJsonWithData('/api/v1/notifications', 'GET', null, function (rs) {
                if (rs) {
                    let data = rs;
                    let xhtml = "";
                    data.forEach(function (notification, index) {
                        xhtml += '<div class="d-flex align-middle mt-4">' +
                            '<div class="flex-shrink-0">' +
                            '<img src="assets/images/small/img-1.jpg" class="rounded img-fluid" style="height: 60px;" alt="">' +
                            '</div>' +
                            '<div class="flex-grow-1 ms-3">' +
                            '<h6 class="mb-1 lh-base"><a href="/notifications/' + notification.id + '" class="text-reset">' + notification.title + '</a></h6>' +
                            '<p class="text-muted fs-12 mb-0">' + notification.createdDate + ' <i class="mdi mdi-circle-medium align-middle mx-1"></i>' + notification.user.fullname + '</p>' +
                            '</div>' +
                            '</div><!-- end -->';
                    });
                    xhtml += '<div class="mt-3 text-center"><a href="/notifications" class="text-muted text-decoration-underline">View all News</a></div>';
                    tbodyElement.innerHTML = xhtml
                } else {
                    console.log("Data API Error")
                }
            },
            function (error) {
                console.log("Call API Error")
                console.log(error)
            })
        const currentDay = new Date();

        const day = String(currentDay.getDate()).padStart(2, '0');
        const month = String(currentDay.getMonth() + 1).padStart(2, '0');
        const year = currentDay.getFullYear();

        const dateString = year + '-' + month + '-' + day;
        callAjaxByJsonWithData('/api/v1/events/upcoming?day=' + dateString, 'GET', null, function (rs) {
            if (rs) {
                let data = rs;
                let xhtml = "";
                data.forEach(function (event, index) {
                    xhtml += '<li class="list-group-item ps-0">' +
                        '<div class="row align-items-center g-3">' +
                        '<div class="col-auto">' +
                        '<div class="avatar-sm p-1 py-2 h-auto bg-light rounded-3">' +
                        '<div class="text-center">' +
                        '<h5 class="mb-0">' + getDayFromDate(event.startDate) +'</h5>' +
                        '<div class="text-muted">' + getDayOfWeek(event.startDate) + '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '<div class="col">' +
                        '<h5 class="text-muted mt-0 mb-1 fs-13">' + event.type.code + '</h5>' +
                        '<a href="javascript: void(0);" class="text-reset fs-14 mb-0">' + event.title + '</a>' +
                        '</div>' +
                        '<div class="col-sm-auto">' +
                        '<div class="avatar-group">' +
                        '<div class="avatar-group-item">' +
                        '<a href="javascript: void(0);" class="d-inline-block" data-bs-toggle="tooltip" ' +
                        'data-bs-placement="top" title="" data-bs-original-title="Stine Nielsen">' +
                        '<img src="' + event.user.avatar + '" alt="" class="rounded-circle avatar-xxs">' +
                        '</a>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</li>';
                })
                eventBodyElement.innerHTML = xhtml;
            } else {
                console.log("Data API Error")
            }
        }, function (error) {
            console.log("Call API Error")
            console.log(error)
        })
    })
</script>
</body>
</html>
