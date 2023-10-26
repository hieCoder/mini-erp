<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 10/25/2023
  Time: 12:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://uicdn.toast.com/calendar/latest/toastui-calendar.min.css" />
    <script src="https://uicdn.toast.com/calendar/latest/toastui-calendar.min.js"></script>
    <link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
    <script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
    <link rel="stylesheet" href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css">
    <script src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.js"></script>
</head>
<body>
<div class="container">
    <div class="tui-datepicker-input tui-datetime-input tui-has-focus">
        <input type="text" id="tui-date-picker-target" aria-label="Date-Time" />
        <span class="tui-ico-date"></span>
    </div>
    <div id="tui-date-picker-container" style="margin-top: -1px;"></div>
    <div id="calendar" style="height: 600px;"></div>
</div>

<script>
    const DatePicker = tui.DatePicker;
    const containerDate = document.getElementById('tui-date-picker-container');
    const target = document.getElementById('tui-date-picker-target');

    const instance = new DatePicker(containerDate, {
        input: {
            element: target
        },
    });

    instance.getDate();

    const Calendar = tui.Calendar;
    const container = document.getElementById('calendar');
    const options = {
        month: {
            dayNames: ['일', '월', '화', '수', '목', '금', '토'],
            visibleWeeksCount: 0,
            workweek: false,
            narrowWeekend: false,
            startDayOfWeek: 0,
            isAlways6Weeks: false,
            visibleEventCount: 6,
        },
        eventFilter: (event) => event.isVisible,
        isReadOnly: true,
        defaultView: 'month',
        usageStatistics: false,
        timezone: {
            zones: [
                {
                    timezoneName: 'Asia/Seoul',
                    displayLabel: 'Seoul',
                    tooltip: 'Seoul Time',
                },
                {
                    timezoneName: 'Asia/Saigon',
                    displayLabel: 'Saigon',
                    tooltip: 'Saigon Time',
                },
            ],
        },
        calendars: [
            {
                id: 'cal1',
                name: 'Personal',
                color: '#ffffff',
                backgroundColor: '#9e5fff',
                dragBackgroundColor: '#9e5fff',
                borderColor: '#9e5fff',
            },
            {
                id: 'cal2',
                name: 'Work',
                color: '#00a9ff',
                backgroundColor: '#00a9ff',
                dragBackgroundColor: '#00a9ff',
                borderColor: '#00a9ff',
            },
        ],
    };

    const calendar = new Calendar(container, options);

    calendar.createEvents([
        {
            id: 'event1',
            calendarId: 'cal2',
            title: 'Weekly meeting',
            start: '2023-10-23T09:00:00',
            end: '2023-10-25T10:00:00',
        },
        {
            id: 'event2',
            calendarId: 'cal1',
            title: 'Lunch appointment',
            start: '2023-10-23T12:00:00',
            end: '2023-10-27T13:00:00',
        },
        {
            id: 'event3',
            calendarId: 'cal2',
            title: 'Vacation',
            start: '2023-10-23',
            end: '2023-10-23',
            isAllday: true,
            category: 'allday',
        },
    ]);

    calendar.setOptions({
        useFormPopup: false,
        useDetailPopup: true,
    });

    calendar.setTheme({
        common: {
            gridSelection: {
                backgroundColor: 'rgba(81, 230, 92, 0.05)',
                border: '1px dotted #515ce6',
            },
        },
    });

    // Move to last year in month view
    // calendar.move(-12);

    // calendar.prev();
    // calendar.next();
    // calendar.today();
    // calendar.changeView('day');
    // calendar.setDate(new Date(2023, 9, 26));

    // calendar.openFormPopup({
    //     id: 'some-event-id',
    //     calendarId: 'cal1',
    //     title: 'Go to live concert',
    //     start: '2022-05-31T09:00:00',
    //     end: '2022-05-31T12:00:00',
    //     category: 'time',
    // });
</script>
</body>
</html>
