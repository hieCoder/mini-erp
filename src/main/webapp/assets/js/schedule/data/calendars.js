'use strict';

/* eslint-disable require-jsdoc, no-unused-vars */

var CalendarList = [];

function CalendarInfo() {
    this.id = null;
    this.name = null;
    this.checked = true;
    this.color = null;
    this.bgColor = null;
    this.borderColor = null;
    this.dragBgColor = null;
}

function addCalendar(calendar) {
    CalendarList.push(calendar);
}

function findCalendar(id) {
    var found;

    CalendarList.forEach(function(calendar) {
        if (calendar.id === id) {
            found = calendar;
        }
    });

    return found || CalendarList[0];
}

function hexToRGBA(hex) {
    var radix = 16;
    var r = parseInt(hex.slice(1, 3), radix),
        g = parseInt(hex.slice(3, 5), radix),
        b = parseInt(hex.slice(5, 7), radix),
        a = parseInt(hex.slice(7, 9), radix) / 255 || 1;
    var rgba = 'rgba(' + r + ', ' + g + ', ' + b + ', ' + a + ')';

    return rgba;
}

(function() {
    var calendar;

    calendar = new CalendarInfo();
    calendar.id = "OPENED";
    calendar.name = 'Opened';
    calendar.color = '#ffffff';
    calendar.bgColor = '#ffc107';
    calendar.dragBgColor = '#ffc107';
    calendar.borderColor = '#ffc107';
    addCalendar(calendar);

    calendar = new CalendarInfo();
    calendar.id = "POSTPONED";
    calendar.name = 'Postponed';
    calendar.color = '#ffffff';
    calendar.bgColor = '#dc3545';
    calendar.dragBgColor = '#dc3545';
    calendar.borderColor = '#dc3545';
    addCalendar(calendar);

    calendar = new CalendarInfo();
    calendar.id = "REGISTERED";
    calendar.name = 'Registered';
    calendar.color = '#ffffff';
    calendar.bgColor = '#6c757d';
    calendar.dragBgColor = '#6c757d';
    calendar.borderColor = '#6c757d';
    addCalendar(calendar);

    calendar = new CalendarInfo();
    calendar.id = "CLOSED";
    calendar.name = 'Closed';
    calendar.color = '#ffffff';
    calendar.bgColor = '#28a745';
    calendar.dragBgColor = '#28a745';
    calendar.borderColor = '#28a745';
    addCalendar(calendar);

    calendar = new CalendarInfo();
    calendar.id = "REOPENED";
    calendar.name = 'Reopened';
    calendar.color = '#ffffff';
    calendar.bgColor = '#ff0185';
    calendar.dragBgColor = '#ff0185';
    calendar.borderColor = '#ff0185';
    addCalendar(calendar);

    calendar = new CalendarInfo();
    calendar.id = "BIRTHDAY";
    calendar.name = 'Birthday';
    calendar.color = '#ff0185';
    calendar.bgColor = '#ff0185';
    calendar.dragBgColor = '#ff0185';
    calendar.borderColor = '#ff0185';
    addCalendar(calendar);

})();
