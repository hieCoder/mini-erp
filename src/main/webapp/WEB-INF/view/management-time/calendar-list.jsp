<%@ page import="com.shsoftvina.erpshsoftvina.security.Principal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="userId" value="${Principal.getUserCurrent().getId()}"/>
<c:set var="userRole" value="${Principal.getUserCurrent().getRole()}"/>
<!DOCTYPE html>
<html>
<head>
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

        input {
            display: none;
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
        <div class="d-flex justify-content-between">
            <div class="card ribbon-box border shadow-none overflow-hidden mt-2 mb-2" style="width: 16rem">
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
            <h1 class="text-center" id="currentMonthYear"></h1>
            <div style="width: 345px" class="m-3 p-1 position-relative">
                <button class="btn btn-primary bottom-left createCalendar" type="button">Save</button>
            </div>
        </div>
        <table class="table table-bordered" id="todoTable">
            <thead>
            <tr class="text-center week">
                <th scope="col"></th>
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
<script>
    const numberOfRowsPerWeek = 6;
    const table = document.getElementById('todoTable');
    const currentMonthYear = document.getElementById('currentMonthYear');
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
                    let dayData = parseData.days;
                    let weekData = parseData.weeklys;
                    let monthlyTarget = document.getElementById("monthlyTarget");
                    let monthTarget = document.getElementById("monthTarget");
                    let xhtml = '';
                    if (parseData.monthlyContents != null) {
                        parseData.monthlyContents.forEach((e) => {
                            if (e === "") {
                                xhtml +=  '<p class="editable m-0" ondblclick="toggleEdit(this)">Double click to edit</p>'
                            } else {
                                xhtml +=  '<p class="editable m-0" ondblclick="toggleEdit(this)">' + e + '</p>'
                            }
                        })
                        monthlyTarget.innerHTML = xhtml;
                    } else {
                        for (let i =0;i<3;i++) {
                            xhtml +=  '<p class="editable m-0" ondblclick="toggleEdit(this)">Double click to edit</p>'
                        }
                        monthlyTarget.innerHTML = xhtml;
                    }
                    table.querySelector('tbody').innerHTML = '';

                    let startDateOfCurrentDate = new Date(year, month, 1);

                    const options = {year: 'numeric', month: 'long'};
                    const targetOptions = {month: 'long'};
                    currentMonthYear.textContent = "Calendar of " + startDateOfCurrentDate.toLocaleDateString('en-US', options);
                    monthTarget.textContent = 'Target of ' + startDateOfCurrentDate.toLocaleDateString('en-US', targetOptions);
                    currentMonthYear.classList.add('fst-italic', 'p-3');
                    var fullName = "${requestScope.user.fullname}";
                    var span = document.createElement("span");
                    span.textContent = "Username: " + fullName;
                    span.style.fontSize = "20px";
                    currentMonthYear.appendChild(document.createElement("br"));
                    currentMonthYear.appendChild(span);

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
                                    <%--if (dayNumber < 1) {--%>
                                    <%--    let found = false;--%>
                                    <%--    if (responseData != null && responseData.length > 0) {--%>
                                    <%--        responseData.forEach((e) => {--%>
                                    <%--            e.listDayOfWeek.forEach((week) => {--%>
                                    <%--                const dateInResponse = new Date(week.day);--%>
                                    <%--                if (--%>
                                    <%--                    currentDate.getFullYear() === dateInResponse.getFullYear() &&--%>
                                    <%--                    (lastDayOfPreviousMonth - startDay + j) === dateInResponse.getDate()--%>
                                    <%--                ) {--%>
                                    <%--                    const link = document.createElement('a');--%>
                                    <%--                    link.textContent = lastDayOfPreviousMonth - startDay + j;--%>
                                    <%--                    link.href = "${user.id}" + '/day/?id=' + week.id;--%>
                                    <%--                    cell.appendChild(link);--%>
                                    <%--                    found = true;--%>
                                    <%--                }--%>
                                    <%--            })--%>
                                    <%--        });--%>
                                    <%--    }--%>

                                    <%--    if (!found) {--%>
                                    <%--        const link = document.createElement('a');--%>
                                    <%--        link.textContent = lastDayOfPreviousMonth - startDay + j;--%>
                                    <%--        const year = currentDate.getFullYear();--%>
                                    <%--        const month = currentDate.getMonth() + 1;--%>

                                    <%--        var day = lastDayOfPreviousMonth - startDay + j;--%>
                                    <%--        var dayData = day < 10 ? "0" + day : day;--%>
                                    <%--        var monthData = (month - 1) < 10 ? '0' + (month - 1) : (month - 1);--%>
                                    <%--        link.href = "${user.id}" + "/day/?day=" + year + "-" + monthData + "-" + dayData;--%>
                                    <%--        cell.appendChild(link);--%>
                                    <%--    }--%>
                                    <%--} else --%>
                                    if (dayNumber > 0 && dayNumber <= daysInMonth) {
                                        <%--let found = false;--%>
                                        <%--if (responseData != null && responseData.length > 0) {--%>
                                        <%--    responseData.forEach((e) => {--%>
                                        <%--        e.listDayOfWeek.forEach((week) => {--%>
                                        <%--            const dateInResponse = new Date(week.day);--%>
                                        <%--            if (--%>
                                        <%--                currentDate.getFullYear() === dateInResponse.getFullYear() &&--%>
                                        <%--                currentDate.getMonth() === dateInResponse.getMonth() &&--%>
                                        <%--                dayNumber === dateInResponse.getDate()--%>
                                        <%--            ) {--%>
                                        <%--                const link = document.createElement('a');--%>
                                        <%--                link.classList.add("p-2");--%>
                                        <%--                link.classList.add("fs-6");--%>
                                        <%--                link.textContent = dayNumber;--%>
                                        <%--                link.href = "${user.id}" + '/day/?id=' + week.id;--%>
                                        <%--                if (dayNumber === currentDate.getDate() && month === new Date().getMonth()) {--%>
                                        <%--                    link.classList.add("badge", "badge-soft-danger", "rounded-pill");--%>
                                        <%--                }--%>
                                        <%--                cell.appendChild(link);--%>
                                        <%--                found = true;--%>
                                        <%--            }--%>
                                        <%--        })--%>
                                        <%--    });--%>
                                        <%--}--%>

                                        // if (!found) {
                                        const link = document.createElement('a');
                                        link.textContent = dayNumber;
                                        link.classList.add("p-2");
                                        link.classList.add("fs-6");
                                        if (dayNumber === currentDate.getDate() && month === new Date().getMonth()) {
                                            link.classList.add("badge", "badge-soft-danger", "rounded-pill");
                                        }
                                        const year = currentDate.getFullYear();
                                        const currentMonth = currentDate.getMonth() + 1;
                                        link.href = "weekly-detail/" + "${user.id}" + "?currentDay=" + year + "-" + (currentMonth < 10 ? '0' + currentMonth : currentMonth) + "-" + (dayNumber < 10 ? '0' + dayNumber : dayNumber);
                                        cell.appendChild(link);
                                        // }
                                    }
                                    cell.classList.add("fw-bold")
                                    cell.classList.add("fst-italic")
                                }
                                // else {
                                //     if (responseData != null && responseData.length > 0) {
                                //         responseData.forEach((e) => {
                                //             const startDate = new Date(e.startDate);
                                //             const firstDayOfMonth = new Date(startDate.getFullYear(), startDate.getMonth(), 1);
                                //             const daysDiff = Math.ceil((startDate - firstDayOfMonth) / (1000 * 60 * 60 * 24));
                                //             var weekNumber;
                                //             if (e.startDate === formattedFirstSunday) {
                                //                 weekNumber = 1;
                                //             } else {
                                //                 weekNumber = Math.ceil((daysDiff + firstDayOfMonth.getDay() + 1) / 7);
                                //             }
                                //             if (weekNumber === ((i / 6) + 1)) {
                                //                 const link = document.createElement("button");
                                //                 link.textContent = "Edit";
                                //                 link.classList.add("btn");
                                //                 link.classList.add("btn-primary");
                                //                 link.classList.add("showWeeklyUpdate");
                                //                 link.setAttribute("data-id", e.weeklyId);
                                //                 cell.appendChild(link);
                                //             }
                                //         })
                                //         cell.classList.add("fw-bold")
                                //         cell.classList.add("fst-italic")
                                //     }
                                // }
                            } else {
                                if (j === 0) {
                                    const dayNames = ['The Single Most Important Thing', 'Lecture', 'Daily Evaluation', 'Work', 'Reading'];
                                    row.classList.add(dayCodeTrTag[(i % 6) - 1])
                                    cell.textContent = dayNames[(i % 6) - 1];
                                    cell.classList.add("text-wrap")
                                    cell.classList.add("fw-bold")
                                    cell.classList.add("fst-italic")
                                } else if (j < 8) {
                                    const dayNumber = countLine * 7 + j - startDay;
                                    if (dayNumber > 0 && dayNumber <= daysInMonth) {
                                        const dayTodo = dayCodeTrTag[(i % 6) - 1];
                                        const year = currentDate.getFullYear();
                                        const currentMonth = currentDate.getMonth() + 1;
                                        const currentColDay = year + "-" + (currentMonth < 10 ? '0' + currentMonth : currentMonth) + "-" + ((0 < dayNumber && dayNumber < 10) ? '0' + dayNumber : dayNumber);
                                        if (dayData != null && dayData.length > 0) {
                                            cell.classList.add("fst-italic")
                                            cell.classList.add("text-wrap")
                                            dayData.forEach((day) => {
                                                    const dateInResponse = new Date(day.day);
                                                    const currentDay = countLine * 7 + j - startDay;
                                                    if (
                                                        currentDate.getMonth() === dateInResponse.getMonth() &&
                                                        currentDay === dateInResponse.getDate()
                                                    ) {
                                                        const targetTodo = day.data.oneThingCalendar[dayTodo];
                                                        if (targetTodo != null) {
                                                            cell.textContent = targetTodo.target;
                                                        }
                                                    }
                                            })
                                        } else {
                                            cell.setAttribute('data-name', dayTodo);
                                            cell.setAttribute('data-day', currentColDay);
                                        }
                                        cell.setAttribute('data-name', dayTodo);
                                        cell.setAttribute('data-day', currentColDay);
                                        cell.setAttribute('contenteditable', 'true');
                                    }
                                } else {
                                    const dayTodo = dayCodeTrTag[(i % 6) - 1];
                                    const dayNumber = countLine * 7 + j - startDay;
                                    const year = currentDate.getFullYear();
                                    const currentMonth = currentDate.getMonth() + 1;
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
                                            if (e.weeklyContents === null) {
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
                                            if (weekNumber === (Math.floor((i / 6) + 1))) {
                                                cell.textContent = e.weeklyContents[dayTodo];
                                            }
                                            if ((dayNumber - 7) === daysInMonth) {
                                                cell.setAttribute('data-week', getPreviousSunday(currentColDay,true));
                                            } else {
                                                cell.setAttribute('data-week', getPreviousSunday(currentColDay,false));
                                            }
                                            cell.setAttribute('data-name', dayTodo);
                                        });
                                    } else {
                                        cell.setAttribute('data-name', dayTodo);
                                        if ((dayNumber - 7) === daysInMonth) {
                                            cell.setAttribute('data-week', getPreviousSunday(currentColDay,true));
                                        } else {
                                            cell.setAttribute('data-week', getPreviousSunday(currentColDay,false));
                                        }
                                    }
                                    cell.setAttribute('contenteditable', 'true');
                                }
                            }
                            row.appendChild(cell);
                        }
                        tbody.appendChild(row);
                        $('div.custom-spinner').parent().remove()
                        if (button) {
                            button.prop("disabled", false)
                        }
                        $(".containerLoading ").addClass("d-none")
                        $("div.calendar-container").removeClass("d-none")
                    }
                }
                else {
                    window.location.href = "/management-time/";
                }
            }
        }
        xhr.send();
    }

    populateCalendar(currentDate.getFullYear(), currentDate.getMonth());

    prevMonthBtn.addEventListener('click', () => {
        $(".containerLoading ").removeClass("d-none")
        $("div.calendar-container").addClass("d-none")
        var button = $("#prevMonth")
        currentDate.setMonth(currentDate.getMonth() - 1);
        populateCalendar(currentDate.getFullYear(), currentDate.getMonth(), button);
    });

    nextMonthBtn.addEventListener('click', () => {
        $(".containerLoading ").removeClass("d-none")
        $("div.calendar-container").addClass("d-none")
        var button = $("#nextMonth")
        currentDate.setMonth(currentDate.getMonth() + 1);
        populateCalendar(currentDate.getFullYear(), currentDate.getMonth(), button);
    });


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

    $(document).on("click", "button.createCalendar", function () {
        $(".containerLoading ").removeClass("d-none")
        $("div.calendar-container").addClass("d-none")
        const data = {
            userId: userCurrent.id,
            days: [],
            weeklys: [],
            monthly : {}
        }
        const days = [];
        const weeklys = [];
        console.log(currentDate.getMonth() + 1)
        const monthly = {
            month : currentDate.getFullYear()  + '-' + ((currentDate.getMonth() <10) ? '0' + currentDate.getMonth() : currentDate.getMonth() + 1),
            content: []
        };
        $('.editable').each(function () {
            if ($(this).hasClass('editing')) {
                const content = $(this).val();
                monthly.content.push(content);
            } else {
                const content = $(this).text();
                monthly.content.push(content);
            }
        })
        $('td[contenteditable="true"]').each(function () {
            const day = $(this).data('day');
            const name = $(this).data('name');
            const value = $(this).text().trim();
            const week = $(this).data('week');
            if(value !== "") {
                if (day != null) {
                    let dayObj = days.find(d => d.day === day);
                    if (!dayObj) {
                        dayObj = {
                            day: day,
                            content: {}
                        };
                        days.push(dayObj);
                    }
                    dayObj.content[name] = value;
                }
                if (week != null) {
                    let weekObj = weeklys.find(w => w.startDay === week);
                    if (!weekObj) {
                        weekObj = {
                            startDay: week,
                            content: {}
                        };
                        weeklys.push(weekObj);
                    }
                    weekObj.content[name] = value;
                }
            }
        })
        data.days.push(...days);
        data.weeklys.push(...weeklys);
        data.monthly = monthly;
        console.log(data);
        callAjaxByJsonWithData("/api/v1/management-time/calendar", "POST", data, function (rs) {
            BtnLoadRemove()
            $("button.createCalendar").removeClass("d-none")
            populateCalendar(currentDate.getFullYear(), currentDate.getMonth());
            rsSuccess("Add");
        },function (error) {
            rsUnSuccess();
            console.log(error);
        })
    })

    function getPreviousSunday(currentDate,isLastSunday) {
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

    document.addEventListener('click', function(event) {
        var editableElements = document.querySelectorAll('.editing');
        editableElements.forEach(function(element) {
            if (!element.contains(event.target)) {
                toggleEdit(element);
            }
        });
    });

    function toggleEdit(element) {
        var isEditing = element.classList.contains('editing');

        if (isEditing) {
            var paragraphElement = document.createElement('p');
            paragraphElement.innerText = element.value;
            paragraphElement.classList.add('editable','m-0');
            paragraphElement.ondblclick = function() { toggleEdit(paragraphElement); };

            element.replaceWith(paragraphElement);
        } else {
            var inputElement = document.createElement('input');
            inputElement.value = element.innerText;
            inputElement.classList.add('editable', 'editing','m-0','w-100');
            inputElement.ondblclick = function() { toggleEdit(inputElement); };

            element.replaceWith(inputElement);

            inputElement.style.display = 'block';

            inputElement.focus();
        }
    }
</script>
</body>
</html>