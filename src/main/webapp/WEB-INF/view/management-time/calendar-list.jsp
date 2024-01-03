<%@ page import="com.shsoftvina.erpshsoftvina.security.Principal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="userRole" value="${Principal.getUserCurrent().getRole()}"/>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../../../../assets/custom/css/management-time/style.css">
    <link rel="stylesheet" href="/assets/libs/@simonwep/pickr/themes/classic.min.css"/>
    <link rel="stylesheet" href="/assets/libs/@simonwep/pickr/themes/monolith.min.css"/>
    <link rel="stylesheet" href="/assets/libs/@simonwep/pickr/themes/nano.min.css"/>
    <link href="/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css"/>
    <style>
        td {
            max-width: 40px;
        }

        tr td:first-child {
            max-width: 80px;
        }

        th {
            background-color: #f3f3f3;
        }

        tr > th {
            color: #333333;
            font-size: 20px;
        }

        .bottom-left {
            position: absolute;
            bottom: 0;
            left: 0;
        }

        .bottom-right {
            position: absolute;
            bottom: 0;
            right: 150px;
        }

        input {
            display: none;
        }

        .dropdown-toggle::after {
            font-size: 25px !important;
            margin-left: 0 !important;
        }
    </style>
    <title>Calendars</title>
    <link rel="stylesheet" href="../../../assets/custom/css/management-time/style.css">
</head>
<body>
<div class="row position-relative full-height">
    <div class="col-md-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">MANAGEMENT TIME CALENDAR</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="/home">Dashboard</a></li>
                    <c:if test="${userRole != 'DEVELOPER'}">
                        <li class="breadcrumb-item"><a href="/management-time">Management Time</a></li>
                    </c:if>
                    <li class="breadcrumb-item active">Management Time Calendar</li>
                </ol>
            </div>

        </div>
    </div>
    <div style="width: 3rem; height: 3rem; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);"
         class="containerLoading d-flex align-items-center justify-content-center">
        <div>
            <div class="spinner-grow" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
    </div>
    <div class="bg-white calendar-container d-none">
        <div class="d-flex ">
            <div class="card ribbon-box border shadow-none overflow-hidden mt-2 mb-2"
                 style="width: 16rem; margin-right: 20px">
                <div class="card-body text-muted">
                    <div class="ribbon ribbon-info ribbon-shape trending-ribbon">
                        <span class="trending-ribbon-text">Focus</span> <i
                            class="ri-flashlight-fill text-white align-bottom float-end ms-1"></i>
                    </div>
                    <h5 class="fs-14 text-end mb-3" id="yearCurrent"></h5>
                    <div class="m-0" id="yearTarget">
                    </div>
                </div>
            </div>
            <div class="card ribbon-box border shadow-none overflow-hidden mt-2 mb-2"
                 style="width: 16rem; margin-right: 80px">
                <div class="card-body text-muted">
                    <div class="ribbon ribbon-info ribbon-shape trending-ribbon">
                        <span class="trending-ribbon-text">Focus</span> <i
                            class="ri-flashlight-fill text-white align-bottom float-end ms-1"></i>
                    </div>
                    <h5 class="fs-14 text-end mb-3" id="monthTarget"></h5>
                    <div class="m-0" id="monthlyTarget">
                    </div>
                </div>
            </div>
            <div class="d-flex flex-column align-items-center" style="margin-top: 25px; margin-right: 80px"
                 id="currentCalendar">
                <div class="d-flex align-items-center">
                    <h1 class="text-center">Calendar of</h1>
                    <div class="btn-group ms-2">
                        <h1 class="dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
                            id="currentMonth"></h1>
                        <div class="dropdown-menu dropdownmenu-secondary" data-simplebar style="max-height: 300px">
                            <a class="dropdown-item" href="#" onclick="updateMonth('January')">January</a>
                            <a class="dropdown-item" href="#" onclick="updateMonth('February')">February</a>
                            <a class="dropdown-item" href="#" onclick="updateMonth('March')">March</a>
                            <a class="dropdown-item" href="#" onclick="updateMonth('April')">April</a>
                            <a class="dropdown-item" href="#" onclick="updateMonth('May')">May</a>
                            <a class="dropdown-item" href="#" onclick="updateMonth('June')">June</a>
                            <a class="dropdown-item" href="#" onclick="updateMonth('July')">July</a>
                            <a class="dropdown-item" href="#" onclick="updateMonth('August')">August</a>
                            <a class="dropdown-item" href="#" onclick="updateMonth('September')">September</a>
                            <a class="dropdown-item" href="#" onclick="updateMonth('October')">October</a>
                            <a class="dropdown-item" href="#" onclick="updateMonth('November')">November</a>
                            <a class="dropdown-item" href="#" onclick="updateMonth('December')">December</a>
                        </div>
                    </div>
                    <div class="btn-group ms-2">
                        <h1 class="dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
                            id="currentYear"></h1>
                        <div class="dropdown-menu dropdownmenu-secondary dropdown-year" data-simplebar
                             style="max-height: 300px">

                        </div>
                    </div>
                </div>
            </div>
            <div style="width: 345px" class="m-3 position-relative">
                <span class="d-flex align-items-center border p-2">
                    <h4 class="m-0 me-2">Color Category: </h4>
                    <div scope="col" class="panel colorPicker btn-change-color me-1">
                        <div class="pickr"></div>
                        <p hidden="hidden" class="pickedColor currentColor">#FFFFFF</p>
                    </div>
                    <div scope="col" class="panel colorPicker btn-change-color me-1">
                        <div class="pickr"></div>
                        <p hidden="hidden" class="pickedColor currentColor">#FFFFFF</p>
                    </div>
                    <div scope="col" class="panel colorPicker btn-change-color me-1">
                        <div class="pickr"></div>
                        <p hidden="hidden" class="pickedColor currentColor">#FFFFFF</p>
                    </div>
                    <div scope="col" class="panel colorPicker btn-change-color me-1">
                        <div class="pickr"></div>
                        <p hidden="hidden" class="pickedColor currentColor">#FFFFFF</p>
                    </div>
                    <div scope="col" class="panel colorPicker btn-change-color me-1">
                        <div class="pickr"></div>
                        <p hidden="hidden" class="pickedColor currentColor">#FFFFFF</p>
                    </div>
                </span>
                <button class="btn btn-primary bottom-left createCalendar" id="save-calendar" type="button">Save</button>
                <button type="button" class="btn btn-info bottom-right" data-bs-toggle="modal"
                        data-bs-target="#exampleModalgrid">Dream Board</button>
            </div>
        </div>
        <table class="table table-bordered" id="todoTable">
            <thead>
            <tr class="text-center week">
                <th scope="col" class="text-warning">Categories</th>
                <th scope="col" class="text-danger">Sun</th>
                <th scope="col">Mon</th>
                <th scope="col">Tue</th>
                <th scope="col">Wed</th>
                <th scope="col">Thu</th>
                <th scope="col">Fri</th>
                <th scope="col" class="text-primary">Sat</th>
                <th scope="col" class="text-success">Weekly To-do List</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <div class="d-flex justify-content-center">
            <button id="prevMonth" class="btn btn-info">Previous Month</button>
            <button id="nextMonth" class="btn btn-info ms-4">Next Month</button>
        </div>
    </div>
</div>
<div class="modal fade" id="weeklyToDo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Weekly To-do List</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group content">
                        <label for="mostImportant">The Single Most Important Thing:</label>
                        <input type="text" class="form-control contentData" id="mostImportant">
                    </div>
                    <div class="form-group content">
                        <label for="lecture">Lecture:</label>
                        <input type="text" class="form-control contentData" id="lecture">
                    </div>
                    <div class="form-group content">
                        <label for="dailyEvaluation">Daily Evaluation:</label>
                        <input type="text" class="form-control contentData" id="dailyEvaluation">
                    </div>
                    <div class="form-group content">
                        <label for="work">Work:</label>
                        <input type="text" class="form-control contentData" id="work">
                    </div>
                    <div class="form-group content">
                        <label for="reading">Reading:</label>
                        <input type="text" class="form-control contentData" id="reading">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary saveWeeklyToDo">Save</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="successModalLabel">Message</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                </button>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="exampleModalgrid" tabindex="-1"
     aria-labelledby="exampleModalgridLabel" aria-modal="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalgridLabel">Choose image</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <input class="form-control" type="file" id="quoteImage"
                       accept="image/jpeg, image/png, image/gif" onchange="previewImage()">
                <div id="imagePreview" class="border mt-2 d-none"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close
                </button>
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">OK
                </button>
            </div>
        </div>
    </div>
</div>
<script src="/assets/libs/@simonwep/pickr/pickr.min.js"></script>
<script src="/assets/custom/js/management-time/management-time.js"></script>
<script src="/assets/libs/sweetalert2/sweetalert2.min.js"></script>
<script>

    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll('.btn-change-color').forEach(function (e, index) {
            var divBtnChangeColor = e;
            var observer = new MutationObserver(function (mutations) {
                mutations.forEach(function (mutation) {
                    if (mutation.attributeName === 'style') {
                        handleBackgroundColorChange(divBtnChangeColor);
                    }
                });
            });

            var config = {attributes: true};
            observer.observe(divBtnChangeColor, config);

            function handleBackgroundColorChange(divBtnChangeColor) {
                var style = window.getComputedStyle(divBtnChangeColor);
                var newColor = style.backgroundColor;
                changeColor(newColor, index)
            }
        });
    });

    function changeColor(newColor, index) {
        if (index == 0) $('.theSingleMostImportantThing').css('background-color', newColor)
        else if (index == 1) $('.lecture').css('background-color', newColor)
        else if (index == 2) $('.dailyEvaluation').css('background-color', newColor)
        else if (index == 3) $('.work').css('background-color', newColor)
        else if (index == 4) $('.reading').css('background-color', newColor);
    }

    function previewImage() {
        var input = document.getElementById('quoteImage');
        var preview = document.getElementById('imagePreview');

        if (input.files && input.files[0]) {
            $(preview).removeClass('d-none');
            var reader = new FileReader();

            reader.onload = function (e) {
                var image = document.createElement('img');
                image.src = e.target.result;
                image.style.maxWidth = '100%';
                image.style.maxHeight = '200px';

                preview.innerHTML = '';
                preview.appendChild(image);
            };

            reader.readAsDataURL(input.files[0]);
        } else {
            $(preview).addClass('d-none');
            $(preview).find('img').remove();
        }
    }

    document.addEventListener("DOMContentLoaded", function () {
        var dropdownMenu = document.querySelector('.dropdown-year');

        var startYear = 2023;
        var endYear = new Date().getFullYear() + 20;

        for (var year = endYear; year >= startYear; year--) {
            var dropdownItem = document.createElement('a');
            dropdownItem.innerHTML = '<a href="#" class="dropdown-item" onclick="updateYear(\'' + year + '\')">' + year + '</a>';
            dropdownMenu.appendChild(dropdownItem);
        }

        var fullName = "${requestScope.user.fullname}";
        var span = document.createElement("span");
        span.textContent = "Username: " + fullName;
        span.style.fontSize = "20px";
        document.getElementById('currentCalendar').appendChild(span);
    })
    const numberOfRowsPerWeek = 6;
    const table = document.getElementById('todoTable');
    const currentMonth = document.getElementById('currentMonth');
    const currentYear = document.getElementById('currentYear');
    const prevMonthBtn = document.getElementById('prevMonth');
    const nextMonthBtn = document.getElementById('nextMonth');
    const dayCodeTrTag = ['theSingleMostImportantThing', 'lecture', 'dailyEvaluation', 'work', 'reading'];

    const currentDate = new Date();

    function getWeeksInMonth(year, month) {
        const firstDayOfMonth = new Date(year, month, 1);

        const lastDayOfMonth = new Date(year, month + 1, 0);

        const daysInMonth = lastDayOfMonth.getDate();

        const firstWeekStart = firstDayOfMonth.getDay();

        return Math.ceil((daysInMonth + firstWeekStart) / 7);
    }

    function populateCalendar(year, month, button) {
        const result = getFirstSundayLastSaturday(year, month);
        const formattedFirstSunday = formatDate(getLastSundayOfPreviousMonth(year, month));
        const formattedFirstDay = formatDate(result.firstSunday);
        const formattedLastDay = formatDate(result.lastDay);
        let xhr = new XMLHttpRequest();
        xhr.open("GET", "/api/v1/management-time/calendar/" + "${requestScope.user.id}" + "?startDate=" + formattedFirstDay + "&endDate=" + formattedLastDay, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    const parseData = JSON.parse(xhr.responseText);
                    console.log(parseData)
                    let dayData = parseData.days;
                    let weekData = parseData.weeklys;
                    let colors = parseData.color;
                    let monthlyTarget = document.getElementById("monthlyTarget");
                    let monthTarget = document.getElementById("monthTarget");
                    let yearCurrent = document.getElementById('yearCurrent');
                    let yearTarget = document.getElementById('yearTarget');

                    let xhtml = '';
                    if (parseData.monthlyContents != null) {
                        parseData.monthlyContents.forEach((e) => {
                            if (e.content === "") {
                                xhtml += '<p class="editable m-0" ondblclick="toggleEdit(this)">Double click to edit</p>'
                            } else {
                                xhtml += '<p class="editable m-0" ondblclick="toggleEdit(this)" data-value="' + e.status + '">' + e.content + '</p>'
                            }
                        })
                        monthlyTarget.innerHTML = xhtml;
                    } else {
                        for (let i = 0; i < 3; i++) {
                            xhtml += '<p class="editable m-0" ondblclick="toggleEdit(this)">Double click to edit</p>'
                        }
                        monthlyTarget.innerHTML = xhtml;
                    }

                    let yearHtml = '';
                    if (parseData.year != null) {
                        parseData.year.target.forEach((e) => {
                            if (e === "") {
                                yearHtml += '<p class="editableYear m-0 yearTarget" ondblclick="toggleEditYear(this)">Double click to edit</p>'
                            } else {
                                yearHtml += '<p class="editableYear m-0 yearTarget" ondblclick="toggleEditYear(this)">' + e + '</p>'
                            }
                        })
                        yearTarget.innerHTML = yearHtml;
                    } else {
                        for (let i = 0; i < 3; i++) {
                            yearHtml += '<p class="editableYear m-0 yearTarget" ondblclick="toggleEditYear(this)">Double click to edit</p>'
                        }
                        yearTarget.innerHTML = yearHtml;
                    }
                    table.querySelector('tbody').innerHTML = '';

                    let startDateOfCurrentDate = new Date(year, month, 1);

                    const optionsMonth = {month: 'long'};
                    const optionsYear = {year: 'numeric'};
                    const targetOptions = {month: 'long'};
                    currentMonth.textContent = startDateOfCurrentDate.toLocaleDateString('en-US', optionsMonth);
                    currentYear.textContent = startDateOfCurrentDate.toLocaleDateString('en-US', optionsYear);
                    monthTarget.textContent = 'Target of ' + startDateOfCurrentDate.toLocaleDateString('en-US', targetOptions);
                    const targetOfYear = parseData.year == null ? currentYear.textContent : parseData.year.year;
                    yearCurrent.textContent = 'Target of ' + targetOfYear;

                    const startDay = startDateOfCurrentDate.getDay();

                    const daysInMonth = new Date(year, month + 1, 0).getDate();

                    const lastDayOfPreviousMonth = getLastDayOfPreviousMonth(year, month);

                    var countLine = -1;
                    const tbody = table.querySelector('tbody');
                    const weeksInSpecificMonth = getWeeksInMonth(year, month) * numberOfRowsPerWeek;
                    for (let i = 0; i < weeksInSpecificMonth; i++) {
                        const row = document.createElement('tr');
                        for (let j = 0; j < 9; j++) {
                            const cell = document.createElement('td');
                            cell.classList.add("text-center")
                            cell.classList.add("align-middle")
                            if (i % 6 === 0) {
                                if (j === 0) {
                                    countLine += 1;
                                    cell.textContent = '';
                                } else if (j < 8) {
                                    const dayNumber = countLine * 7 + j - startDay;
                                    if (dayNumber > 0 && dayNumber <= daysInMonth) {
                                        const link = document.createElement('a');
                                        link.textContent = dayNumber;
                                        link.classList.add("p-2");
                                        link.classList.add("fs-6");
                                        if (dayNumber === currentDate.getDate() && month === currentDate.getMonth()) {
                                            link.classList.add("badge", "badge-soft-danger", "rounded-pill");
                                        }
                                        const year = getCurentYear(document.getElementById('currentYear').textContent);
                                        const currentMonth = getCurentMonth(document.getElementById('currentMonth').textContent) + 1;
                                        link.href = "weekly-detail/" + "${user.id}" + "?currentDay=" + year + "-" + (currentMonth < 10 ? '0' + currentMonth : currentMonth) + "-" + (dayNumber < 10 ? '0' + dayNumber : dayNumber);
                                        cell.appendChild(link);
                                    }
                                    cell.classList.add("fw-bold")
                                    cell.classList.add("fst-italic")
                                }
                            } else {
                                if (j === 0) {
                                    const dayTodo = (i % 6) - 1;
                                    const dayNumber = countLine * 7 + 3;
                                    const year = getCurentYear(document.getElementById('currentYear').textContent);
                                    const currentMonth = getCurentMonth(document.getElementById('currentMonth').textContent) + 1;
                                    let currentColDay;
                                    if (dayNumber > daysInMonth) {
                                        currentColDay = year + "-" + (currentMonth < 10 ? '0' + currentMonth : currentMonth) + "-" + daysInMonth;
                                    } else {
                                        currentColDay = year + "-" + (currentMonth < 10 ? '0' + currentMonth : currentMonth) + "-" + ((0 < dayNumber && dayNumber < 10) ? '0' + dayNumber : dayNumber);
                                    }
                                    if (weekData != null && weekData.length > 0) {
                                        weekData.forEach((e) => {
                                            if (e.weeklys === null) {
                                                return;
                                            }
                                            const startDate = new Date(e.startDate);
                                            const firstDayOfMonth = new Date(startDate.getFullYear(), startDate.getMonth(), 1);
                                            const daysDiff = Math.ceil((startDate - firstDayOfMonth) / (1000 * 60 * 60 * 24));
                                            var weekNumber;
                                            if (e.startDate === formattedFirstSunday) {
                                                weekNumber = 1;
                                            } else {
                                                weekNumber = Math.ceil((daysDiff + firstDayOfMonth.getDay() + 1) / 7);
                                            }
                                            if ((dayNumber - 7) === daysInMonth) {
                                                cell.setAttribute('data-week', getPreviousSunday(currentColDay, true));
                                            } else {
                                                cell.setAttribute('data-week', getPreviousSunday(currentColDay, false));
                                            }
                                            if (weekNumber === (Math.floor((i / 6) + 1))) {
                                                cell.textContent = e.weeklys[dayTodo].title;
                                                cell.setAttribute('data-status', e.weeklys[dayTodo].status)
                                            }
                                            cell.setAttribute('data-array', dayTodo);
                                        });
                                    } else {
                                        cell.setAttribute('data-array', dayTodo);
                                        if ((dayNumber - 7) === daysInMonth) {
                                            cell.setAttribute('data-week', getPreviousSunday(currentColDay, true));
                                        } else {
                                            cell.setAttribute('data-week', getPreviousSunday(currentColDay, false));
                                        }
                                    }
                                    row.classList.add(dayCodeTrTag[(i % 6) - 1])
                                    cell.classList.add("title");
                                    cell.classList.add("text-wrap")
                                    cell.classList.add("fw-bold")
                                    cell.classList.add("fst-italic")
                                    cell.setAttribute('contenteditable', 'true');
                                } else if (j < 8) {
                                    const dayNumber = countLine * 7 + j - startDay;
                                    if (dayNumber > 0 && dayNumber <= daysInMonth) {
                                        const dayTodo = (i % 6) - 1;
                                        const year = getCurentYear(document.getElementById('currentYear').textContent);
                                        const currentMonth = getCurentMonth(document.getElementById('currentMonth').textContent) + 1;
                                        const currentColDay = year + "-" + (currentMonth < 10 ? '0' + currentMonth : currentMonth) + "-" + ((0 < dayNumber && dayNumber < 10) ? '0' + dayNumber : dayNumber);
                                        if (dayData != null && dayData.length > 0) {
                                            cell.classList.add("fst-italic")
                                            cell.classList.add("text-wrap")
                                            dayData.forEach((day) => {
                                                const dateInResponse = new Date(day.day);
                                                const currentDay = countLine * 7 + j - startDay;
                                                if (
                                                    currentMonth === dateInResponse.getMonth() + 1 &&
                                                    currentDay === dateInResponse.getDate()
                                                ) {
                                                    const targetTodo = day.data[dayTodo];
                                                    if (targetTodo != null) {
                                                        cell.textContent = targetTodo.target;
                                                    }
                                                }
                                            })
                                        }
                                        cell.setAttribute('data-array', dayTodo);
                                        cell.setAttribute('data-day', currentColDay);
                                        cell.setAttribute('contenteditable', 'true');
                                    }
                                } else {
                                    const dayTodo = (i % 6) - 1;
                                    const dayNumber = countLine * 7 + j - startDay;
                                    const year = getCurentYear(document.getElementById('currentYear').textContent);
                                    const currentMonth = getCurentMonth(document.getElementById('currentMonth').textContent) + 1;
                                    let currentColDay;
                                    if (dayNumber > daysInMonth) {
                                        currentColDay = year + "-" + (currentMonth < 10 ? '0' + currentMonth : currentMonth) + "-" + daysInMonth;
                                    } else {
                                        currentColDay = year + "-" + (currentMonth < 10 ? '0' + currentMonth : currentMonth) + "-" + ((0 < dayNumber && dayNumber < 10) ? '0' + dayNumber : dayNumber);
                                    }
                                    if (weekData != null && weekData.length > 0) {
                                        cell.classList.add("fw-bold")
                                        cell.classList.add("fst-italic")
                                        cell.classList.add("text-wrap")
                                        weekData.forEach((e) => {
                                            if (e.weeklys === null) {
                                                return;
                                            }
                                            const startDate = new Date(e.startDate);
                                            const firstDayOfMonth = new Date(startDate.getFullYear(), startDate.getMonth(), 1);
                                            const daysDiff = Math.ceil((startDate - firstDayOfMonth) / (1000 * 60 * 60 * 24));
                                            var weekNumber;
                                            if (e.startDate === formattedFirstSunday) {
                                                weekNumber = 1;
                                            } else {
                                                weekNumber = Math.ceil((daysDiff + firstDayOfMonth.getDay() + 1) / 7);
                                            }
                                            if ((dayNumber - 7) === daysInMonth) {
                                                cell.setAttribute('data-week', getPreviousSunday(currentColDay, true));
                                            } else {
                                                cell.setAttribute('data-week', getPreviousSunday(currentColDay, false));
                                            }
                                            if (weekNumber === (Math.floor((i / 6) + 1))) {
                                                cell.textContent = e.weeklys[dayTodo].content;
                                                cell.setAttribute('data-status', e.weeklys[dayTodo].status)
                                            }
                                            cell.setAttribute('data-array', dayTodo);
                                        });
                                    } else {
                                        cell.setAttribute('data-array', dayTodo);
                                        if ((dayNumber - 7) === daysInMonth) {
                                            cell.setAttribute('data-week', getPreviousSunday(currentColDay, true));
                                        } else {
                                            cell.setAttribute('data-week', getPreviousSunday(currentColDay, false));
                                        }
                                    }
                                    cell.classList.add("content");
                                    cell.setAttribute('contenteditable', 'true');
                                }
                            }
                            row.classList.add('color');
                            row.appendChild(cell);
                        }
                        tbody.appendChild(row);
                        changeTrColor();
                        $('div.custom-spinner').parent().remove()
                        if (button) {
                            button.prop("disabled", false)
                        }
                        $(".containerLoading ").addClass("d-none")
                        $("div.calendar-container").removeClass("d-none")
                    }
                    $.each(colors, function (index, value) {
                        switch (index) {
                            case 0:
                                $('.theSingleMostImportantThing').css('background-color', colors[index]);
                                break;
                            case 1:
                                $('.lecture').css('background-color', colors[index]);
                                break;
                            case 2:
                                $('.dailyEvaluation').css('background-color', colors[index]);
                                break;
                            case 3:
                                $('.work').css('background-color', colors[index]);
                                break;
                            case 4:
                                $('.reading').css('background-color', colors[index]);
                                break;
                            default:
                                break;
                        }
                    })
                } else {
                    window.location.href = "/management-time/";
                }
            }
        }
        xhr.send();
    }

    function changeTrColor() {
        document.querySelectorAll('.color').forEach(function (e) {
            e.style.backgroundColor = e.querySelector('td').style.backgroundColor;
        })
    }

    populateCalendar(currentDate.getFullYear(), currentDate.getMonth());

    function updateMonth(month) {
        document.getElementById('currentMonth').textContent = month;
        const currentMonth = getCurentMonth(document.getElementById('currentMonth').textContent);
        const currentYear = getCurentYear(document.getElementById('currentYear').textContent);
        populateCalendar(currentYear, currentMonth);
    }

    function updateYear(year) {
        document.getElementById('currentYear').textContent = year;
        const currentMonth = getCurentMonth(document.getElementById('currentMonth').textContent);
        const currentYear = getCurentYear(document.getElementById('currentYear').textContent);
        populateCalendar(currentYear, currentMonth);
    }

    prevMonthBtn.addEventListener('click', () => {
        $(".containerLoading ").removeClass("d-none")
        $("div.calendar-container").addClass("d-none")
        var button = $("#prevMonth")
        const month = getCurentMonth(document.getElementById('currentMonth').textContent);
        const year = getCurentYear(document.getElementById('currentYear').textContent);
        populateCalendar(year, month - 1, button);
    });

    nextMonthBtn.addEventListener('click', () => {
        $(".containerLoading ").removeClass("d-none")
        $("div.calendar-container").addClass("d-none")
        var button = $("#nextMonth")
        const month = getCurentMonth(document.getElementById('currentMonth').textContent);
        const year = getCurentYear(document.getElementById('currentYear').textContent);
        populateCalendar(year, month + 1, button);
    });

    function getCurentMonth(month) {
        var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
        var getCurrentMonth = months.indexOf(month);


        if (getCurrentMonth < 0) {
            getCurrentMonth = 11;
        }
        return getCurrentMonth;
    }

    function getCurentYear(year) {
        var currentYear = parseInt(year);
        return currentYear;
    }

    function getLastDayOfPreviousMonth(year, month) {
        if (month === 0) {
            year--;
            month = 11;
        } else {
            month--;
        }
        return new Date(year, month + 1, 0).getDate();
    }

    function getFirstSundayLastSaturday(year, month) {
        const firstSunday = new Date(year, month, 1);
        const lastDay = new Date(year, month + 1, 0);

        return {
            firstSunday,
            lastDay
        };
    }

    function getLastSundayOfPreviousMonth(year, month) {
        const firstSundayIsBeginningDay = new Date(year, month, 1);
        const lastDayOfPreviousMonth = new Date(year, month, 0);
        if (firstSundayIsBeginningDay.getDay() === 0) {
            return firstSundayIsBeginningDay;
        }
        const lastDay = lastDayOfPreviousMonth.getDate();
        return new Date(year, month - 1, lastDay - lastDayOfPreviousMonth.getDay());
    }

    function formatDate(date) {
        const year = date.getFullYear();
        const month = (date.getMonth() + 1).toString().padStart(2, '0');
        const day = date.getDate().toString().padStart(2, '0');
        return year + '-' + month + '-' + day;
    }

    document.addEventListener("DOMContentLoaded", function () {
        const statusMonthly = [];
        document.getElementById('monthlyTarget').querySelectorAll('p').forEach( function (e) {
            statusMonthly.push(e.getAttribute('data-value'));
        })
        $(document).on("click", "button.createCalendar", function (event) {
            $(".containerLoading ").removeClass("d-none")
            $("div.calendar-container").addClass("d-none")
            var editableElements = document.querySelectorAll('.editing');
            editableElements.forEach(function (element) {
                if (!element.contains(event.target)) {
                    toggleEdit(element);
                }
            });
            var editableElements = document.querySelectorAll('.editingYear');
            editableElements.forEach(function (element) {
                if (!element.contains(event.target)) {
                    toggleEditYear(element);
                }
            });
            var month = getCurentMonth(document.getElementById('currentMonth').textContent);
            var year = getCurentYear(document.getElementById('currentYear').textContent);
            const data = {
                userId: '${user.id}',
                days: [],
                weeklys: [],
                monthly: {},
                quotes: {},
                year: {}
            }
            const days = [];
            const weeklys = [];
            const monthly = {
                month: year + '-' + ((month + 1 < 10) ? '0' + (month + 1) : month + 1),
                content: [],
                color: []
            };

            $('.editable').each(function (index) {
                let obj = {};
                if ($(this).hasClass('editing')) {
                    const content = $(this).val();
                    obj.content = content;
                    obj.status = statusMonthly[index];
                    monthly.content.push(obj);
                } else {
                    const content = $(this).text();
                    obj.content = content;
                    obj.status = statusMonthly[index];
                    monthly.content.push(obj);
                }
            })

            var count = 5;
            $('.color').each(function (index) {
                if (index != 0) {
                    if (count != 0) {
                        const colorMonthLy = $(this).css('background-color');
                        monthly.color.push(colorMonthLy)
                        count--;
                    }
                }
            })

            $('td[contenteditable="true"]').each(function () {
                const day = $(this).data('day');
                const index = $(this).data('array');
                const hasTitleClass = $(this).hasClass('title');
                const hasContentClass = $(this).hasClass('content');
                const value = $(this).text().trim();
                const week = $(this).data('week');
                if (value !== "") {
                    if (day != null) {
                        let dayObj = days.find(d => d.day === day);
                        if (!dayObj) {
                            dayObj = {
                                day: day,
                                content: ["", "", "", "", ""]
                            };
                            days.push(dayObj);
                        }
                        dayObj.content[index] = value;
                    }
                    if (week != null && index != null) {
                        let weekObj = weeklys.find(w => w.startDay === week);

                        if (!weekObj) {
                            weekObj = {
                                startDay: week == undefined ? '' : week,
                                weeklys: [{}, {}, {}, {}, {}]
                            };
                            weeklys.push(weekObj);
                        }
                        const currentWeekly = weekObj.weeklys[index];
                        if (hasTitleClass) {
                            currentWeekly.title = value;
                            if (!currentWeekly.hasOwnProperty('content')) {
                                currentWeekly.content = '';
                            }
                            currentWeekly.status = $(this).data('status')
                        } else if (hasContentClass) {
                            if (!currentWeekly.hasOwnProperty('title')) {
                                currentWeekly.title = '';
                            }
                            currentWeekly.content = value;
                            currentWeekly.status = $(this).data('status')
                        }
                    }
                }
            })

            data.year = {
                year: currentYear.textContent,
                target: []
            };

            var yearTargetValue = document.querySelectorAll('.yearTarget');
            yearTargetValue.forEach(function (target) {
                data.year.target.push(target.textContent);
            })

            data.days.push(...days);
            data.weeklys.push(...weeklys);
            data.monthly = monthly;

            const imageQuote = document.getElementById('quoteImage').files[0];
            const formData = new FormData();
            formData.append('files', imageQuote);
            callAjaxByDataFormWithDataForm("/api/v1/upload?typeFile=" + M_QUOTE, "POST", formData, function (rs) {
                data.quotes.quotes = [];
                data.quotes.image = rs[0];
                callAjaxByJsonWithData("/api/v1/management-time/calendar", "POST", data, function (rs) {
                    BtnLoadRemove()
                    $("button.createCalendar").removeClass("d-none")
                    const month = getCurentMonth(document.getElementById('currentMonth').textContent);
                    const year = getCurentYear(document.getElementById('currentYear').textContent);
                    populateCalendar(year, month);
                    rsSuccess("Add");
                }, function (error) {
                    rsUnSuccess();
                    console.log(error);
                })
            });
        })
    })


    function getPreviousSunday(currentDate, isLastSunday) {
        const dateObject = new Date(currentDate);

        let currentDayOfWeek = dateObject.getDay();

        let daysToSubtract = currentDayOfWeek === 0 ? 7 : currentDayOfWeek;

        const sundayDate = new Date(dateObject);
        if (isLastSunday) {
            sundayDate.setDate(dateObject.getDate());
        } else {
            sundayDate.setDate(dateObject.getDate() - daysToSubtract);
        }
        return sundayDate.toISOString().split('T')[0];
    }

    document.addEventListener('click', function (event) {
        var editableElements = document.querySelectorAll('.editing');
        editableElements.forEach(function (element) {
            if (!element.contains(event.target)) {
                toggleEdit(element);
            }
        });
        var editableElements = document.querySelectorAll('.editingYear');
        editableElements.forEach(function (element) {
            if (!element.contains(event.target)) {
                toggleEditYear(element);
            }
        });
    });

    function toggleEdit(element) {
        var isEditing = element.classList.contains('editing');

        if (isEditing) {
            var paragraphElement = document.createElement('p');
            paragraphElement.innerText = element.value;
            paragraphElement.classList.add('editable', 'm-0');
            paragraphElement.ondblclick = function () {
                toggleEdit(paragraphElement);
            };

            element.replaceWith(paragraphElement);
        } else {
            var inputElement = document.createElement('input');
            inputElement.value = element.innerText;
            inputElement.classList.add('editable', 'editing', 'm-0', 'w-100');
            inputElement.ondblclick = function () {
                toggleEdit(inputElement);
            };

            element.replaceWith(inputElement);

            inputElement.style.display = 'block';

            inputElement.focus();
        }
    }

    function toggleEditYear(element) {
        var isEditing = element.classList.contains('editingYear');

        if (isEditing) {
            var paragraphElement = document.createElement('p');
            paragraphElement.innerText = element.value;
            paragraphElement.classList.add('editableYear', 'm-0', 'yearTarget');
            paragraphElement.ondblclick = function () {
                toggleEditYear(paragraphElement);
            };

            element.replaceWith(paragraphElement);
        } else {
            var inputElement = document.createElement('input');
            inputElement.value = element.innerText;
            inputElement.classList.add('editableYear', 'editingYear', 'm-0', 'w-100');
            inputElement.ondblclick = function () {
                toggleEditYear(inputElement);
            };

            element.replaceWith(inputElement);

            inputElement.style.display = 'block';

            inputElement.focus();
        }
    }


</script>
</body>
</html>