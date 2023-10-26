<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 10/25/2023
  Time: 12:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<html lang="en">

<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <title>TOAST UI Calendar Template For Popup DEMO</title>
    <link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css">
    <link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css">
    <link rel="stylesheet" type="text/css" href="/assets/css/schedule/dist/tui-calendar.css">
    <link rel="stylesheet" type="text/css" href="/assets/css/schedule/default.css">
    <link rel="stylesheet" type="text/css" href="/assets/css/schedule/icons.css">
</head>

<body>
<div class="container" style="margin-top: 6%">
    <div class="code-html">
        <div id="menu" class="mb-3 font-weight-bold">
          <span id="menu-navi">
                <button type="button" class="btn btn-default btn-sm move-today font-weight-bold" data-action="move-today">Today</button>
                <button type="button" class="btn btn-default btn-sm move-day font-weight-bold " data-action="move-prev">
                  <i class="calendar-icon ic-arrow-line-left font-weight-bold d-flex flex-column align-items-center" data-action="move-prev"></i>
                </button>
                <button type="button" class="btn btn-default btn-sm move-day " data-action="move-next">
                  <i class="calendar-icon ic-arrow-line-right font-weight-bold d-flex flex-column align-items-center" data-action="move-next"></i>
                </button>
          </span>
            <span id="renderRange" class="render-range"></span>
        </div>

        <div id="calendar"></div>
    </div>
</div>

<script src="https://uicdn.toast.com/tui.code-snippet/v1.5.2/tui-code-snippet.min.js"></script>
<script src="https://uicdn.toast.com/tui.time-picker/v2.0.3/tui-time-picker.min.js"></script>
<script src="https://uicdn.toast.com/tui.date-picker/v4.0.3/tui-date-picker.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.20.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/chance/1.0.13/chance.min.js"></script>
<script src="/assets/css/schedule/dist/tui-calendar.js"></script>
<script src="/assets/js/schedule/data/calendars.js"></script>
<script src="/assets/js/schedule/data/schedules.js"></script>
<script type="text/javascript" class="code-js">
    var templates = {
        popupIsAllDay: function() {
            return 'All Day';
        },
        // popupStateFree: function() {
        //     return 'Free';
        // },
        // popupStateBusy: function() {
        //     return 'Busy';
        // },
        // titlePlaceholder: function() {
        //     return 'Subject';
        // },
        // locationPlaceholder: function() {
        //     return 'Location';
        // },
        startDatePlaceholder: function() {
            return 'Start date';
        },
        endDatePlaceholder: function() {
            return 'End date';
        },
        // popupSave: function() {
        //     return 'Save';
        // },
        // popupUpdate: function() {
        //     return 'Update';
        // },
        popupDetailDate: function(isAllDay, start, end) {
            var isSameDate = moment(start).isSame(end);
            var endFormat = (isSameDate ? '' : 'YYYY.MM.DD ') + 'hh:mm a';

            if (isAllDay) {
                return moment(start).format('YYYY.MM.DD') + (isSameDate ? '' : ' - ' + moment(end).format('YYYY.MM.DD'));
            }

            return (moment(start).format('YYYY.MM.DD hh:mm a') + ' - ' + moment(end).format(endFormat));
        },
        // popupDetailLocation: function(schedule) {
        //     return 'Location : ' + schedule.location;
        // },
        // popupDetailUser: function(schedule) {
        //     return 'User : ' + (schedule.attendees || []).join(', ');
        // },
        // popupDetailState: function(schedule) {
        //     return 'State : ' + schedule.state || 'Busy';
        // },
        // popupDetailRepeat: function(schedule) {
        //     return 'Repeat : ' + schedule.recurrenceRule;
        // },
        // popupDetailBody: function(schedule) {
        //     return 'Body : ' + schedule.body;
        // },
        // popupEdit: function() {
        //     return 'Edit';
        // },
        // popupDelete: function() {
        //     return 'Delete';
        // }
    };

    var cal = new tui.Calendar('#calendar', {
        defaultView: 'month',
        template: templates,
        useCreationPopup: false,
        useDetailPopup: true
    });
</script>
<script src="/assets/js/schedule/default.js"></script>
</body>
</html>
