<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        .calendar {
            display: grid;
            grid-template-columns: repeat(8, 1fr);
            text-align: center;
        }

        .seven_day {
            display: grid;
            grid-template-columns: repeat(8, 1fr);
            text-align: center;
        }

        .calendar .day {
            border: 1px solid #ccc;
            padding: 5px;
        }

        .seven_day .day {
            border: 1px solid #ccc;
            padding: 5px;
        }

        td {
            max-width: 40px;
        }

        tr td:first-child {
            max-width: 80px;
        }

        tr.theSingleMostImportantThing {
            background-color: white;
        }

        tr.lecture {
            background-color: #fcecec;
        }

        tr.dailyEvaluation {
            background-color: #e6f0e2;
        }

        tr.work {
            background-color: #fff9e6;
        }

        tr.reading {
            background-color: #e9e4f5;
        }

        th {
            background-color: #f3f3f3;
        }

        tr > th {
            color: #333333;
            font-size: 20px;
        }

    </style>
    <style>
        /* Tùy chỉnh kiểu của trang loading */
        .loading {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.9);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .modal {
            margin-top: 5%;
        }
    </style>
    <title>Calendars</title>
</head>
<body>
<div class="loading">
    <div class="spinner-border text-primary" role="status">
        <span class="sr-only">Loading...</span>
    </div>
</div>
<div class="container mt-4 calendar-container d-none">
    <h1 class="text-center" id="currentMonthYear"></h1>
    <table class="table table-bordered" id="todoTable">
        <thead>
        <tr class="text-center week">
            <th></th>
            <th class="text-danger">Sun</th>
            <th>Mon</th>
            <th>Tue</th>
            <th>Wed</th>
            <th>Thu</th>
            <th>Fri</th>
            <th class="text-primary">Sat</th>
            <th class="text-success">Weekly To-do List</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <div class="d-flex justify-content-center">
        <button id="prevMonth" class="btn btn-info">Previous Month</button>
        <button id="nextMonth" class="btn btn-info ml-4">Next Month</button>
    </div>
</div>
<div class="modal fade" id="weeklyToDo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Weekly To-do List</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
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
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary saveWeeklyToDo">Save</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="margin-top: 50%;">
            <div class="modal-header">
                <h5 class="modal-title" id="successModalLabel">Message</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script>
    const dot = createLoadingHtml();
    const table = document.getElementById('todoTable');
    const currentMonthYear = document.getElementById('currentMonthYear');
    const prevMonthBtn = document.getElementById('prevMonth');
    const nextMonthBtn = document.getElementById('nextMonth');
    const dayCodeTrTag = ['theSingleMostImportantThing', 'lecture', 'dailyEvaluation', 'work', 'reading'];

    // Get the current date
    let currentDate = new Date();

    $(document).on("click", ".saveWeeklyToDo", function() {
        let target = $(this)
        target.after(dot)
        target.prop("disabled", true)
        let id = $("#weeklyToDo").attr("data-id")
        let content = ""
        let arrContent = []
        $("#weeklyToDo .contentData").each(function (index){
            content += $(this).val();
            arrContent.push($(this).val())
            if (index < $("#weeklyToDo .contentData").length - 1) {
                content += ",";
            }
        })
        let data = {
            id: id,
            content: content,
        }
        callAjaxByJsonWithData('/api/v1/weekly-management-time-day', 'PUT', data, function (rs) {
            if(rs === 1){
                let selector = '.showWeeklyUpdate[data-id="' + id +'"]'
                let button = $(selector)
                let indexMain = parseInt(button.parent().parent().index()) / 6
                arrContent.forEach((item, index)=>{
                    let selector = 'tr.' + dayCodeTrTag[index]
                    $(selector).eq(indexMain).children().last().text(item)
                })
                $("#weeklyToDo").modal("hide")
                var modal = '<strong class="btn-success rounded-circle p-2">Success!</strong> Update successfully.'
                $("#successModal div.modal-body").html(modal)
                $("#successModal").modal("show");

            }
            target.after(dot)
            target.prop("disabled", false)
        })
    })

    $(document).on("click", "button.showWeeklyUpdate", function() {
        let target = $(this)
        target.after(dot)
        target.prop("disabled", true)
        let id = target.attr("data-id")
        let modal = $("#weeklyToDo")
        modal.attr("data-id", id)
        callAjaxByJsonWithData('/api/v1/weekly-management-time-day/' + id, 'GET', null, function (rs) {
            if(rs.weeklyContents != null){
                $("#weeklyToDo div.content > input").each(function (index) {
                    $(this).val(rs.weeklyContents[index])
                })
            }
            modal.modal("show")
            target.prop("disabled", false)
        })
    })

    function populateCalendar(year, month, button) {
        const result = getFirstSundayLastSaturday(year, month);
        const formattedFirstSunday = formatDate(result.firstSunday);
        const formattedLastDay = formatDate(result.lastDay);
        let xhr = new XMLHttpRequest();
        xhr.open("GET", "/api/v1/management-time/" + "${requestScope.user.id}" + "?startDate=" + formattedFirstSunday + "&endDate=" + formattedLastDay, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    var responseData = JSON.parse(xhr.responseText);
                    // Clear the table
                    table.querySelector('tbody').innerHTML = '';

                    // Set the date to the 1st day of the specified month
                    currentDate = new Date(year, month, 1);

                    // Update the display for the current month and year
                    const options = {year: 'numeric', month: 'long'};
                    currentMonthYear.textContent = "Calendar of " + currentDate.toLocaleDateString('en-US', options);
                    currentMonthYear.classList.add('font-italic', 'underline-text');
                    var fullName = "${requestScope.user.fullname}";
                    var span = document.createElement("span");
                    span.textContent = "Username: " + fullName;
                    span.style.fontSize = "20px";
                    span.classList.add("normal-text");
                    currentMonthYear.appendChild(document.createElement("br"));
                    currentMonthYear.appendChild(span);

                    // Calculate the starting day (Sunday to Saturday: 0 to 6)
                    const startDay = currentDate.getDay();

                    // Get the number of days in the specified month
                    const daysInMonth = new Date(year, month + 1, 0).getDate();

                    // Calculate the last day of the previous month
                    const lastDayOfPreviousMonth = getLastDayOfPreviousMonth(year, month);

                    var countLine = -1;
                    // Populate the calendar
                    const tbody = table.querySelector('tbody');
                    for (let i = 0; i < 30; i++) {
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
                                    if (dayNumber < 1) {
                                        let found = false;
                                        if (responseData != null && responseData.length > 0) {
                                            responseData.forEach((e) => {
                                                e.listDayOfWeek.forEach((week) => {
                                                    const dateInResponse = new Date(week.day);
                                                    if (
                                                        currentDate.getFullYear() === dateInResponse.getFullYear() &&
                                                        (lastDayOfPreviousMonth - startDay + j) === dateInResponse.getDate()
                                                    ) {
                                                        const link = document.createElement('a');
                                                        link.textContent = lastDayOfPreviousMonth - startDay + j;
                                                        link.href = "${user.id}" + '/day/?id=' + week.id;
                                                        cell.appendChild(link);
                                                        found = true;
                                                    }
                                                })
                                            });
                                        }

                                        if (!found) {
                                            const link = document.createElement('a');
                                            link.textContent = lastDayOfPreviousMonth - startDay + j;
                                            const year = currentDate.getFullYear();
                                            const month = currentDate.getMonth() + 1;

                                            var day = lastDayOfPreviousMonth - startDay + j;
                                            var dayData = day < 10 ? "0" + day : day;
                                            var monthData = (month -1) < 10 ? '0' + (month -1) : (month -1);
                                            link.href = "day/?day=" + year + "-" + monthData + "-" + dayData;
                                            cell.appendChild(link);
                                        }
                                    } else if (dayNumber > 0 && dayNumber <= daysInMonth) {
                                        let found = false;
                                        if (responseData != null && responseData.length > 0) {
                                            responseData.forEach((e) => {
                                                e.listDayOfWeek.forEach((week) => {
                                                    const dateInResponse = new Date(week.day);
                                                    if (
                                                        currentDate.getFullYear() === dateInResponse.getFullYear() &&
                                                        currentDate.getMonth() === dateInResponse.getMonth() &&
                                                        dayNumber === dateInResponse.getDate()
                                                    ) {
                                                        const link = document.createElement('a');
                                                        link.textContent = dayNumber;
                                                        link.href = "${user.id}" + '/day/?id=' + week.id;
                                                        cell.appendChild(link);
                                                        found = true;
                                                    }
                                                })
                                            });
                                        }

                                        if (!found) {
                                            const link = document.createElement('a');
                                            link.textContent = dayNumber;
                                            const year = currentDate.getFullYear();
                                            const month = currentDate.getMonth() + 1;
                                            link.href = "${user.id}" + "/day/?day=" + year + "-" + (month < 10 ? '0' + month : month) + "-" + (dayNumber < 10 ? '0' + dayNumber : dayNumber);
                                            cell.appendChild(link);
                                        }
                                    }
                                    cell.classList.add("font-weight-bold")
                                    cell.classList.add("font-italic")
                                } else {
                                    if (responseData != null && responseData.length > 0) {
                                        responseData.forEach((e) => {
                                            const startDate = new Date(e.startDate);
                                            const firstDayOfMonth = new Date(startDate.getFullYear(), startDate.getMonth(), 1);
                                            const daysDiff = Math.ceil((startDate - firstDayOfMonth) / (1000 * 60 * 60 * 24));
                                            const weekNumber = Math.ceil((daysDiff + firstDayOfMonth.getDay() + 1) / 7);
                                            if (weekNumber === ((i/6) + 1)) {
                                                const link = document.createElement('button');
                                                link.textContent = "Edit";
                                                link.classList.add("btn");
                                                link.classList.add("btn-primary");
                                                link.classList.add("showWeeklyUpdate");
                                                link.setAttribute("data-id", e.weeklyId);
                                                cell.appendChild(link);
                                            }
                                        })
                                    }
                                }
                            } else {
                                if (j === 0) {
                                    // Đây là hàng đầu tiên của ngày trong tuần, có thể thêm tên thích hợp
                                    const dayNames = ['The Single Most Important Thing', 'Lecture', 'Daily Evaluation', 'Work', 'Reading'];
                                    const dayNamesCode = ['theSingleMostImportantThing', 'lecture', 'dailyEvaluation', 'work', 'reading'];
                                    row.classList.add(dayNamesCode[(i % 6) - 1])
                                    cell.textContent = dayNames[(i % 6) - 1];
                                    cell.classList.add("text-wrap")
                                    cell.classList.add("font-weight-bold")
                                    cell.classList.add("font-italic")
                                } else if (j < 8) {
                                    if (responseData != null && responseData.length > 0) {
                                        cell.classList.add("font-italic")
                                        responseData.forEach((e) => {
                                            e.listDayOfWeek.forEach((week) => {
                                                const dateInResponse = new Date(week.day);
                                                const currentDay = countLine * 7 + j - startDay;
                                                const dayNames = ['theSingleMostImportantThing', 'lecture', 'dailyEvaluation', 'work', 'reading'];
                                                if (
                                                    currentDate.getFullYear() === dateInResponse.getFullYear() &&
                                                    currentDate.getMonth() === dateInResponse.getMonth() &&
                                                    currentDay === dateInResponse.getDate()
                                                ) {
                                                    const dayTodo = dayNames[(i % 6) - 1];
                                                    const targetTodo = week.data.oneThingCalendar[dayTodo];
                                                    if (targetTodo != null) {
                                                        cell.textContent = targetTodo.target;
                                                    } else {
                                                        cell.textContent = "";
                                                    }
                                                }
                                            })
                                        })
                                    }
                                } else {
                                    if (responseData != null && responseData.length > 0) {
                                        cell.classList.add("font-weight-bold")
                                        cell.classList.add("font-italic")
                                        responseData.forEach((e) => {
                                            if (e.weeklyContents === null) {
                                                return;
                                            }
                                            const startDate = new Date(e.startDate);
                                            const firstDayOfMonth = new Date(startDate.getFullYear(), startDate.getMonth(), 1);
                                            const daysDiff = Math.ceil((startDate - firstDayOfMonth) / (1000 * 60 * 60 * 24));
                                            const weekNumber = Math.ceil((daysDiff + firstDayOfMonth.getDay() + 1) / 7);
                                            if (weekNumber === (Math.floor((i/6) + 1))) {
                                                cell.textContent = e.weeklyContents[(i % 6) - 1];
                                            }
                                        });
                                    }
                                }
                            }
                            row.appendChild(cell);
                        }
                        tbody.appendChild(row);
                        $('div.custom-spinner').parent().remove()
                        if (button) {
                            button.prop("disabled", false)
                        } else {
                            $("div.loading").hide()
                            $("div.calendar-container").removeClass("d-none")
                        }
                    }
                } else {
                    window.location.href = "/management-time/";
                }
            }

        }
        xhr.send();
    }

    populateCalendar(currentDate.getFullYear(), currentDate.getMonth());

    prevMonthBtn.addEventListener('click', () => {
        var button = $("#prevMonth")
        button.before(dot)
        button.prop("disabled", true)
        currentDate.setMonth(currentDate.getMonth() - 1);
        populateCalendar(currentDate.getFullYear(), currentDate.getMonth(), button);
    });

    nextMonthBtn.addEventListener('click', () => {
        var button = $("#nextMonth")
        button.after(dot)
        button.prop("disabled", true)
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
        const firstSunday = getLastSundayOfPreviousMonth(year,month);
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
        const lastSundayOfPreviousMonth = new Date(year, month - 1, lastDay - lastDayOfPreviousMonth.getDay());
        return lastSundayOfPreviousMonth;
    }

    function getFirstAndLastDateOfMonth(year, month) {
        // Xác định ngày đầu tiên của tháng
        const firstDay = new Date(year, month, 1);

        // Xác định ngày cuối cùng của tháng
        const lastDay = new Date(year, month + 1, 0);
        return {
            firstDay,
            lastDay
        };
    }

    function formatDate(date) {
        const year = date.getFullYear();
        const month = (date.getMonth() + 1).toString().padStart(2, '0'); // Thêm 1 và định dạng số với 2 chữ số (01-12)
        const day = date.getDate().toString().padStart(2, '0'); // Định dạng số với 2 chữ số (01-31)
        return year + '-' + month + '-' + day;
    }
</script>
</body>
</html>