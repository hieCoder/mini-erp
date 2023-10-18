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
    </style>
</head>
<body>
<div class="container mt-4 calendar-container">
    <h2 class="text-center" id="currentMonthYear"></h2>
    <table class="table table-bordered" id="todoTable">
        <thead>
        <tr>
            <th></th>
            <th>Sun</th>
            <th>Mon</th>
            <th>Tue</th>
            <th>Wed</th>
            <th>Thu</th>
            <th>Fri</th>
            <th>Sat</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>
<button id="prevMonth">Previous Month</button>
<button id="nextMonth">Next Month</button>
<script>
    const table = document.getElementById('todoTable');
    const currentMonthYear = document.getElementById('currentMonthYear');
    const prevMonthBtn = document.getElementById('prevMonth');
    const nextMonthBtn = document.getElementById('nextMonth');

    // Get the current date
    let currentDate = new Date();

    function populateCalendar(year, month) {
        let xhr = new XMLHttpRequest();
        xhr.open("GET", "/api/v1/management-time/" + "${requestScope.userId}" + "?year=" + year + "&month=" + (month + 1), true);
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

                    // Calculate the starting day (Sunday to Saturday: 0 to 6)
                    const startDay = currentDate.getDay();

                    // Get the number of days in the specified month
                    const daysInMonth = new Date(year, month + 1, 0).getDate();

                    // Calculate the last day of the previous month
                    const lastDayOfPreviousMonth = getLastDayOfPreviousMonth(year, month);

                    var count = -1;
                    // Populate the calendar
                    const tbody = table.querySelector('tbody');
                    for (let i = 0; i < 24; i++) {
                        const row = document.createElement('tr');

                        for (let j = 0; j < 8; j++) {
                            const cell = document.createElement('td');
                            if (i % 6 === 0) {
                                if (j === 0) {
                                    count += 1;
                                    cell.textContent = '';
                                } else {
                                    const dayNumber = count * 7 + j - startDay;
                                    if (dayNumber < 1) {
                                        // Display the last days of the previous month
                                        cell.textContent = lastDayOfPreviousMonth - startDay + j;
                                    } else
                                    if (dayNumber > 0 && dayNumber <= daysInMonth) {
                                        let found = false;
                                        if(responseData != null && responseData.length > 0){
                                            responseData.forEach((e)=>{
                                                const dateInResponse = new Date(e.day);
                                                if (
                                                    currentDate.getFullYear() === dateInResponse.getFullYear() &&
                                                    currentDate.getMonth() === dateInResponse.getMonth() &&
                                                    dayNumber === dateInResponse.getDate()
                                                ) {
                                                    const link = document.createElement('a');
                                                    link.textContent = dayNumber;
                                                    link.href = 'day/?id=' + e.id;
                                                    cell.appendChild(link);
                                                    found = true;
                                                }
                                            });
                                        }

                                        if (!found) {
                                            const link = document.createElement('a');
                                            link.textContent = dayNumber;
                                            const year = currentDate.getFullYear();
                                            const month = currentDate.getMonth() + 1;
                                            link.href = "day/?day=" + year + "-" + month + "-" + dayNumber;
                                            cell.appendChild(link);
                                        }
                                    }
                                }
                            } else {
                                if (j === 0) {
                                    // Đây là hàng đầu tiên của ngày trong tuần, có thể thêm tên thích hợp
                                    const dayNames = ['The Single Most Important Thing', 'Lecture', 'Daily Evaluation', 'Work', 'Reading'];
                                    cell.textContent = dayNames[(i%6)-1];
                                    cell.classList.add("text-wrap")
                                } else {
                                    if(responseData != null && responseData.length > 0){
                                        responseData.forEach((e)=>{
                                            const dateInResponse = new Date(e.day);
                                            const currentDay = count * 7 + j - startDay;
                                            const dayNames = ['theSingleMostImportantThing', 'lecture', 'dailyEvaluation', 'work', 'reading'];
                                            if (
                                                currentDate.getFullYear() === dateInResponse.getFullYear() &&
                                                currentDate.getMonth() === dateInResponse.getMonth() &&
                                                currentDay === dateInResponse.getDate()
                                            ) {
                                                const dayTodo = dayNames[(i%6)-1];
                                                const targetTodo = e.data.oneThingCalendar[dayTodo];
                                                if (targetTodo != null) {
                                                    cell.textContent = targetTodo.target;
                                                } else {
                                                    cell.textContent = "";
                                                }
                                            }
                                        })
                                    }
                                }
                            }
                            row.appendChild(cell);
                        }
                        tbody.appendChild(row);
                    }
                }
            }
        }
        xhr.send();
    }

    populateCalendar(currentDate.getFullYear(), currentDate.getMonth());

    prevMonthBtn.addEventListener('click', () => {
        currentDate.setMonth(currentDate.getMonth() - 1);
        populateCalendar(currentDate.getFullYear(), currentDate.getMonth());
    });

    nextMonthBtn.addEventListener('click', () => {
        currentDate.setMonth(currentDate.getMonth() + 1);
        populateCalendar(currentDate.getFullYear(), currentDate.getMonth());
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
</script>
</body>
</html>
