// document.addEventListener("DOMContentLoaded", function () {
//     var currentDate = new Date();
//     var currentMonth = currentDate.getMonth();
//     var currentYear = currentDate.getFullYear();
//     var calendarElement = document.getElementById("calendar");
//     var calendar;
//
//     function formatMonthYear(date) {
//         var month = date.getMonth() + 1;
//         var year = date.getFullYear();
//         return `${month}-${year}`;
//     }
//
//     function fetchEventData(monthYear) {
//         var events = [{
//             id: 136,
//             title: "07:53-17:13",
//             start: new Date(currentYear, currentMonth, 3),
//             allDay: true,
//             className: "bg-soft-primary"
//         },
//             {
//                 id: 136,
//                 title: "07:53-17:13",
//                 start: new Date(currentYear, currentMonth, 4),
//                 allDay: true,
//                 className: "bg-soft-primary"
//             },
//             {
//                 id: 136,
//                 title: "07:53-17:13",
//                 start: new Date(currentYear, currentMonth, 5),
//                 allDay: true,
//                 className: "bg-soft-primary"
//             },
//             {
//                 id: 136,
//                 title: "07:53-17:13",
//                 start: new Date(currentYear, currentMonth, 6),
//                 allDay: true,
//                 className: "bg-soft-primary"
//             }];
//
//         calendar.setOption('events', events);
//     }
//
//     function handleCalendarViewChange(info) {
//         var newDate = info.view.currentStart;
//         var monthYearString = formatMonthYear(newDate);
//
//         var staffCurent = document.querySelector('.staff-name.text-decoration-underline');
//         var dataId ='';
//         if(staffCurent != null){
//             dataId = staffCurent.getAttribute('data-id');
//         }
//         console.log("Switched to:", monthYearString, dataId);
//         fetchEventData(monthYearString);
//     }
//
//     calendar = new FullCalendar.Calendar(calendarElement, {
//         timeZone: "local",
//         editable: false,
//         droppable: true,
//         selectable: true,
//         navLinks: true,
//         themeSystem: "bootstrap",
//         headerToolbar: {
//             left: "prev,next",
//             center: "title",
//             right: false
//         },
//         events: [],
//         datesSet: handleCalendarViewChange
//     });
//
//     calendar.render();
// });