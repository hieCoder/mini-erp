<%@ page import="com.shsoftvina.erpshsoftvina.security.Principal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="userRole" value="${Principal.getUserCurrent().getRole()}"/>
<!DOCTYPE html>
<html>
<head>
    <title>Calendars Of Years</title>
</head>
<body>
<div class="row position-relative full-height">
    <div class="col-md-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">MANAGEMENT TIME CALENDAR OF YEARS</h4>
            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="/home">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/management-time">Management Time Of Year</a></li>
                </ol>
            </div>
        </div>
    </div>

    <div class="bg-white">
        <div class="col-md-12 text-center d-flex justify-content-center align-items-center">
            <i class="ri-arrow-left-line fs-2 me-4 cursor-pointer" id="back-year"></i>
            <h1 class="text-center mt-2">TIME MANAGEMENT <span id="calendar-year" class="text-danger"></span></h1>
            <i class="ri-arrow-right-line fs-2 ms-4 cursor-pointer" id="next-year"></i>
        </div>
        <div class="row" id="calendarContainer">
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Change year
        const elCalendarYear = document.getElementById('calendar-year');
        const currentUrl = new URL(window.location.href);
        const yearParameter = currentUrl.searchParams.get("year");
        elCalendarYear.textContent = yearParameter;
        generateCalendar(parseInt(yearParameter));
        const backYear = document.getElementById('back-year');
        const nextYear = document.getElementById('next-year');
        backYear.addEventListener('click', function () {
            elCalendarYear.textContent = parseInt(elCalendarYear.textContent) - 1;
        })
        nextYear.addEventListener('click', function () {
            elCalendarYear.textContent = parseInt(elCalendarYear.textContent) + 1;
        })

        // Change calendar follow year
        const calendarYear = document.getElementById('calendar-year');

        const observer = new MutationObserver((mutationsList) => {
            for (const mutation of mutationsList) {
                if (mutation.type === 'childList') {
                    generateCalendar(parseInt(calendarYear.textContent));
                }
            }
        });

        observer.observe(calendarYear, { childList: true });
    })

    function generateCalendar(year) {
        var calendarContainer = document.getElementById('calendarContainer');
        calendarContainer.innerHTML = '';
        const currentUrl = new URL(window.location.href);
        const userId = currentUrl.searchParams.get("id");
        for (var month = 1; month <= 12; month++) {
            var daysInMonth = new Date(year, month, 0).getDate();
            var table = document.createElement('table');
            table.className = 'table table-bordered';

            var row = table.insertRow();
            var monthHeaderCell = row.insertCell(0);
            monthHeaderCell.colSpan = 7;
            monthHeaderCell.classList.add('text-center');
            monthHeaderCell.style.backgroundColor = 'rgba(3, 169, 244, 0.7)';
            monthHeaderCell.innerHTML = '<h4><a href="/management-time/' + userId + '?year=' + year +  '&month=' + month + '" class="text-white">' + getMonthName(month) + '</a></h4>';

            row = table.insertRow();
            var daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
            for (var i = 0; i < 7; i++) {
                var dayOfWeekCell = row.insertCell(i);
                dayOfWeekCell.className = (i === 0) ? 'text-danger fw-bolder' : '';
                dayOfWeekCell.classList.add('text-center');
                dayOfWeekCell.innerHTML = daysOfWeek[i];
            }

            var firstDayOfWeek = new Date(year, month - 1, 1).getDay();

            row = table.insertRow();
            var dayCounter = 1;
            for (var j = 0; j < firstDayOfWeek; j++) {
                var emptyCell = row.insertCell(j);
                emptyCell.innerHTML = '';
            }
            for (var dayOfWeek = firstDayOfWeek; dayOfWeek < 7; dayOfWeek++) {
                var dayCell = row.insertCell(dayOfWeek);
                dayCell.className = 'text-center align-middle fw-bold fst-italic';

                const formattedMonth = month.toString().padStart(2, '0');
                const formattedDayCounter = dayCounter.toString().padStart(2, '0');

                dayCell.innerHTML = '<a href="/management-time/weekly-detail/' + userId + '?currentDay=' + year + '-' + formattedMonth + '-' + formattedDayCounter + '" class="p-2 fs-6">' + dayCounter + '</a>';
                dayCounter++;
            }
            while (dayCounter <= daysInMonth) {
                row = table.insertRow();
                for (var k = 0; k < 7; k++) {
                    var dayCell = row.insertCell(k);
                    dayCell.className = 'text-center align-middle fw-bold fst-italic';
                    if (dayCounter <= daysInMonth) {
                        const formattedMonth = month.toString().padStart(2, '0');
                        const formattedDayCounter = dayCounter.toString().padStart(2, '0');
                        dayCell.innerHTML = '<a href="/management-time/weekly-detail/' + userId + '?currentDay=' + year + '-' + formattedMonth + '-' + formattedDayCounter + '" class="p-2 fs-6">' + dayCounter + '</a>';
                        dayCounter++;
                    } else {
                        dayCell.innerHTML = '';
                    }
                }
            }

            var tableContainer = document.createElement('div');
            tableContainer.className = 'col-md-3';

            tableContainer.appendChild(table);

            calendarContainer.appendChild(tableContainer);
        }
    }

    function getMonthName(month) {
        var monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
        return monthNames[month - 1];
    }
</script>
</body>
</html>