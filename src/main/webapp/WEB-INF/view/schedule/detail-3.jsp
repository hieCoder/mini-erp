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
<style>
    .tui-full-calendar-weekday-grid-header .tui-full-calendar-weekday-grid-more-schedules{
        color: #fb0072;
        font-size: 13px;
        font-style: italic;
    }
</style>
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
        popupDetailDate: function(allDay ,start, end) {
            var isSameDate = moment(start._date).isSame(moment(end._date));
            var startFormat = moment(start._date).format('YYYY.MM.DD')
            var endFormat = moment(end._date).format('YYYY.MM.DD')
            if (isSameDate) {
                return moment(start).format('YYYY.MM.DD')
            }
            return startFormat + ' ~ ' + endFormat
        },
    };
    var cal = new tui.Calendar('#calendar', {
        defaultView: 'month',
        template: templates,
        useCreationPopup: false,
        useDetailPopup: true,
        isReadOnly: true,
    });
</script>
<script src="/assets/js/schedule/default.js"></script>
</body>
</html>
