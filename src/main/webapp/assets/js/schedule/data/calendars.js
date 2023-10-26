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
    calendar.bgColor = '#9e5fff';
    calendar.dragBgColor = '#9e5fff';
    calendar.borderColor = '#9e5fff';
    addCalendar(calendar);

    calendar = new CalendarInfo();
    calendar.id = "POSTPONED";
    calendar.name = 'Postponed';
    calendar.color = '#ffffff';
    calendar.bgColor = '#ff5583';
    calendar.dragBgColor = '#ff5583';
    calendar.borderColor = '#ff5583';
    addCalendar(calendar);

    calendar = new CalendarInfo();
    calendar.id = "REGISTERED";
    calendar.name = 'Registered';
    calendar.color = '#ffffff';
    calendar.bgColor = '#03bd9e';
    calendar.dragBgColor = '#03bd9e';
    calendar.borderColor = '#03bd9e';
    addCalendar(calendar);

    calendar = new CalendarInfo();
    calendar.id = "CLOSED";
    calendar.name = 'Closed';
    calendar.color = '#ffffff';
    calendar.bgColor = '#bbdc00';
    calendar.dragBgColor = '#bbdc00';
    calendar.borderColor = '#bbdc00';
    addCalendar(calendar);

    calendar = new CalendarInfo();
    calendar.id = "REOPENED";
    calendar.name = 'Reopened';
    calendar.color = '#ffffff';
    calendar.bgColor = '#9d9d9d';
    calendar.dragBgColor = '#9d9d9d';
    calendar.borderColor = '#9d9d9d';
    addCalendar(calendar);

    calendar = new CalendarInfo();
    calendar.id = "BIRTHDAYS";
    calendar.name = 'Birthdays';
    calendar.color = '#ffffff';
    calendar.bgColor = '#ffbb3b';
    calendar.dragBgColor = '#ffbb3b';
    calendar.borderColor = '#ffbb3b';
    addCalendar(calendar);

})();
