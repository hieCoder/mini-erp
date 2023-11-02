var start_date = document.getElementById("event-start-date"), timepicker1 = document.getElementById("timepicker1"),
    timepicker2 = document.getElementById("timepicker2"), date_range = null, T_check = null;
const baseUrlEvent = "/api/v1/events";
const codeDisabled = ["BIRTHDAY", "OPENED", "REOPENED", "REGISTERED","POSTPONED", "CLOSED"]
const typeEnum = {
    "bg-danger text-light": "HOLIDAY",
    "bg-success text-light": "SEMINAR",
    "bg-secondary text-light": "TEAM_BUILDING",
    "bg-primary text-light": "MEETING",
    "bg-info text-light": "TRAINING",
    "bg-warning text-light": "PARTY",
    "bg-dark text-light": "OTHER",
};

const birthdayIcon = '<img src="https://cdn-icons-png.flaticon.com/512/2985/2985632.png" class="cakeIcon" alt="Cake" title="Cake" width="44" height="44">'
function returnType(name){
    return typeEnum[name]
}

function originalStringDateToDate(input){
    const parts = input.match(/(\d{2})\/(\d{2})\/(\d{4}) (\d{2}):(\d{2}):(\d{2})/);

    if (parts === null) {
        throw new Error("Invalid date format. Expected 'dd/mm/yyyy hh:mm:ss'.");
    }

    // Note: Months are 0-based in JavaScript, so we subtract 1 from the month.
    const year = parseInt(parts[3], 10);
    const month = parseInt(parts[2], 10) - 1;
    const day = parseInt(parts[1], 10);
    const hours = parseInt(parts[4], 10);
    const minutes = parseInt(parts[5], 10);
    const seconds = parseInt(parts[6], 10);

    return new Date(year, month, day, hours, minutes, seconds);
}
function alertInput(text){
    let html =
        '<div class="col-12 mb-1">'+
        '<div class="alert alert-danger alert-dismissible alert-outline fade show mb-xl-0" role="alert">'+
        '<strong> '+text+' </strong>'+ '</div>'+
    '</div>'
    return html
}

function checkEmptyString(text){
    if (text.trim() === "" || !text) {
        return true;
    }
}

function deleteEvent(y, v, g) {
    let id = v._def.publicId
    callAjaxByJsonWithData(baseUrlEvent + "/" + id, "DELETE", null, function (rs){
        if(rs > 0){
            if (v) {
                for (var t = 0; t < y.length; t++) y[t].id == v.id && (y.splice(t, 1), t--);
                upcomingEvent(y), v.remove(), v = null, g.hide()
            }
        } else{
            refreshPage()
        }
    }, function (error){
        console.log("Error")
        console.log(error)
    })
}

function updateEvent(event, calendar, v, g) {
    let type = returnType(event.className)
    let title = event.title
    let content = event.description
    let startDate = event.start
    let endDate = event.end
    let id = event.id
    let data = {
        id: id,
        type: type,
        title: title,
        content: content,
        startDate: startDate,
        endDate: endDate,
    }
    if(startDate.toString() === "Invalid Date"){
        let html = alertInput("Start Time Invalid")
        if($("#event-start-date").val() == ""){
            $("#event-start-date").parent().parent().after(html)
        } else{
            $("#event-time").after(html)
        }
        return false
    }
    if(endDate.toString() === "Invalid Date"){
        let html = alertInput("End Time Invalid")
        $("#event-time").after(html)
        return false
    }
    if(startDate >= endDate){
        let html = alertInput("Start Time and End Time Invalid")
        $("#event-time").after(html)
        return false
    }

    callAjaxByJsonWithData(baseUrlEvent, "PUT", data, function (rs){
        if(rs > 0){
                v.setProp("id", event.id)
                v.setProp("title", event.title)
                v.setProp("classNames", event.className)
                v.setStart(event.start)
                v.setEnd(event.allDay)
                v.setAllDay("")
                v.setExtendedProp("description", event.description)
                v.setExtendedProp("location", event.location)
            calendar.render()
            g.hide()
        } else{
            refreshPage()
        }
    }, function (error){
        console.log("Error")
        console.log(error)
    })
}

function refreshPage() {
    location.reload();
}

function addEventFunc(event, g, E){
    removeAlert()
    let type = returnType(event.className)
    let title = event.title
    let content = event.description
    let startDate = event.start
    let endDate = event.end
    if(startDate.toString() == "Invalid Date"){
        let html = alertInput("Start Time Invalid")
        if($("#event-start-date").val() == ""){
            $("#event-start-date").parent().parent().after(html)
        } else{
            $("#event-time").after(html)
        }
        return false
    }
    if(endDate.toString() == "Invalid Date"){
        let html = alertInput("End Time Invalid")
        $("#event-time").after(html)
        return false
    }
    if(startDate >= endDate){
        let html = alertInput("Start Time and End Time Invalid")
        $("#event-time").after(html)
        return false
    }
    let data = {
        type: type,
        title: title,
        content: content,
        startDate: startDate,
        endDate: endDate,
    }
    callAjaxByJsonWithData(baseUrlEvent,"POST", data, function (rs){
        if(rs){
            CALENDAR_RESULT.push(event)
            g.hide()
            upcomingEvent(CALENDAR_RESULT)
            event.id = rs.toString()
            E.addEvent(event)
        }
    }, function (error){
        console.log("Have Error")
        console.log(error)
    })
}
var statusCodePrevent = ["CLOSED", "REGISTERED", "POSTPONED"]
var currentApiDate = ""
let userId = "1"
let CALENDAR_RESULT = []
function formatDate(date) {
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    return year + '-' + month + '-' + day;
}

function formatDateYYMM(date) {
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    return year + '-' + month
}

function getStatusColor(code){
    var colorClass = '';
    switch (code) {
        case 'REGISTERED':
            colorClass = 'bg-soft-secondary';
            break;
        case 'OPENED':
            colorClass = 'bg-soft-warning';
            break;
        case 'POSTPONED':
            colorClass = 'bg-soft-danger';
            break;
        case 'REOPENED':
            colorClass = 'bg-soft-info';
            break;
        case 'CLOSED':
            colorClass = 'bg-soft-success';
            break;
        case 'BIRTHDAY':
            colorClass = 'bg-soft-primary';
            break;
        default:
            colorClass = '';
            break;
    }
    return colorClass;
}

function flatPickrInit() {
    var e = {enableTime: !0, noCalendar: !0};
    flatpickr(start_date, {
        enableTime: !1, mode: "range", minDate: "today", onChange: function (e, t, n) {
            1 < t.split("to").length ? document.getElementById("event-time").setAttribute("hidden", !0) : (document.getElementById("timepicker1").parentNode.classList.remove("d-none"), document.getElementById("timepicker1").classList.replace("d-none", "d-block"), document.getElementById("timepicker2").parentNode.classList.remove("d-none"), document.getElementById("timepicker2").classList.replace("d-none", "d-block"), document.getElementById("event-time").removeAttribute("hidden"))
        }
    });
    flatpickr(timepicker1, e), flatpickr(timepicker2, e)
}

function flatpicekrValueClear() {
    start_date.flatpickr().clear(), timepicker1.flatpickr().clear(), timepicker2.flatpickr().clear()
}

function eventClicked() {
    document.getElementById("form-event").classList.add("view-event"), document.getElementById("event-title").classList.replace("d-block", "d-none"), document.getElementById("event-category").classList.replace("d-block", "d-none"), document.getElementById("event-start-date").parentNode.classList.add("d-none"), document.getElementById("event-start-date").classList.replace("d-block", "d-none"), document.getElementById("event-time").setAttribute("hidden", !0), document.getElementById("timepicker1").parentNode.classList.add("d-none"), document.getElementById("timepicker1").classList.replace("d-block", "d-none"), document.getElementById("timepicker2").parentNode.classList.add("d-none"), document.getElementById("timepicker2").classList.replace("d-block", "d-none"), document.getElementById("event-location").classList.replace("d-block", "d-none"), document.getElementById("event-description").classList.replace("d-block", "d-none"), document.getElementById("event-start-date-tag").classList.replace("d-none", "d-block"), document.getElementById("event-timepicker1-tag").classList.replace("d-none", "d-block"), document.getElementById("event-timepicker2-tag").classList.replace("d-none", "d-block"), document.getElementById("event-location-tag").classList.replace("d-none", "d-block"), document.getElementById("event-description-tag").classList.replace("d-none", "d-block"), document.getElementById("btn-save-event").setAttribute("hidden", !0)
}

function editEvent(e) {
    var t = e.getAttribute("data-id");
    "new-event" == t ? (document.getElementById("modal-title").innerHTML = "", document.getElementById("modal-title").innerHTML = "Add Event", document.getElementById("btn-save-event").innerHTML = "Add Event", eventTyped()) : "edit-event" == t ? (e.innerHTML = "Cancel", e.setAttribute("data-id", "cancel-event"), document.getElementById("btn-save-event").innerHTML = "Update Event", e.removeAttribute("hidden"), eventTyped()) : (e.innerHTML = "Edit", e.setAttribute("data-id", "edit-event"), eventClicked())
}

function eventTyped() {
    document.getElementById("form-event").classList.remove("view-event"), document.getElementById("event-title").classList.replace("d-none", "d-block"), document.getElementById("event-category").classList.replace("d-none", "d-block"), document.getElementById("event-start-date").parentNode.classList.remove("d-none"), document.getElementById("event-start-date").classList.replace("d-none", "d-block"), document.getElementById("timepicker1").parentNode.classList.remove("d-none"), document.getElementById("timepicker1").classList.replace("d-none", "d-block"), document.getElementById("timepicker2").parentNode.classList.remove("d-none"), document.getElementById("timepicker2").classList.replace("d-none", "d-block"), document.getElementById("event-location").classList.replace("d-none", "d-block"), document.getElementById("event-description").classList.replace("d-none", "d-block"), document.getElementById("event-start-date-tag").classList.replace("d-block", "d-none"), document.getElementById("event-timepicker1-tag").classList.replace("d-block", "d-none"), document.getElementById("event-timepicker2-tag").classList.replace("d-block", "d-none"), document.getElementById("event-location-tag").classList.replace("d-block", "d-none"), document.getElementById("event-description-tag").classList.replace("d-block", "d-none"), document.getElementById("btn-save-event").removeAttribute("hidden")
}

function upcomingEvent(e) {
    e.sort(function (e, t) {
        return new Date(e.start) - new Date(t.start)
    }),
        document.getElementById("upcoming-event-list").innerHTML = null,
        Array.from(e).forEach(function (e) {
        var t = e.title,
            n = (l = e.end ? (endUpdatedDay = new Date(e.end)).setDate(endUpdatedDay.getDate() - 1) : l) || void 0;
        n = "Invalid Date" == n || null == n ? null : (a = new Date(n).toLocaleDateString("en", {
            year: "numeric",
            month: "numeric",
            day: "numeric"
        }), new Date(a).toLocaleDateString("en-GB", {
            day: "numeric",
            month: "short",
            year: "numeric"
        }).split(" ").join(" "));
        (e.start ? str_dt(e.start) : null) === (l ? str_dt(l) : null) && (n = null);
        var a = e.start,
            d = (a = "Invalid Date" === a || void 0 === a ? null : (d = new Date(a).toLocaleDateString("en", {
                year: "numeric",
                month: "numeric",
                day: "numeric"
            }), new Date(d).toLocaleDateString("en-GB", {
                day: "numeric",
                month: "short",
                year: "numeric"
            }).split(" ").join(" ")), n ? " to " + n : ""), n = e.className.split("-"), i = e.description || "",
            e = tConvert(getTime(e.start)),
            l = (e == (l = tConvert(getTime(l))) && (e = "Full day event", l = null), l ? " to " + l : "");
        u_event = "<div class='card mb-3'>                        <div class='card-body'>                            <div class='d-flex mb-3'>                                <div class='flex-grow-1'><i class='mdi mdi-checkbox-blank-circle me-2 text-" + n[2] + "'></i><span class='fw-medium'>" + a + d + " </span></div>                                <div class='flex-shrink-0'><small class='badge badge-soft-primary ms-auto'>" + e + l + "</small></div>                            </div>                            <h6 class='card-title fs-16'> " + t + "</h6>                            <p class='text-muted text-truncate-two-lines mb-0'> " + i + "</p>                        </div>                    </div>", document.getElementById("upcoming-event-list").innerHTML += u_event
    })
}

function getTime(e) {
    if (null != (e = new Date(e)).getHours()) return e.getHours() + ":" + (e.getMinutes() ? e.getMinutes() : 0)
}

function tConvert(e) {
    var e = e.split(":"), t = e[0], e = e[1], n = 12 <= t ? "PM" : "AM";
    return (t = (t %= 12) || 12) + ":" + (e = e < 10 ? "0" + e : e) + " " + n
}

var str_dt = function (e) {
    var e = new Date(e),
        t = "" + ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"][e.getMonth()],
        n = "" + e.getDate(), e = e.getFullYear();
    return t.length < 2 && (t = "0" + t), [(n = n.length < 2 ? "0" + n : n) + " " + t, e].join(",")
};

document.addEventListener("DOMContentLoaded", function () {
    flatPickrInit();
    // let arrId = window.location.href.split("/")
    // userId = arrId[idArr.length-1]
    var g = new bootstrap.Modal(document.getElementById("event-modal"), {keyboard: !1}),

        d = (document.getElementById("event-modal"), document.getElementById("modal-title")),

        i = document.getElementById("form-event"), v = null, p = document.getElementsByClassName("needs-validation"),

        e = new Date,
        t = e.getDate(),
        n = e.getMonth(),
        e = e.getFullYear(),
        a = FullCalendar.Calendar,
        l = document.getElementById("external-events"),
        e = (new a(l, {

        }),
            document.getElementById("calendar"));

    function o(e) {
        document.getElementById("form-event").reset(), document.getElementById("btn-delete-event").setAttribute("hidden", !0), g.show(), i.classList.remove("was-validated"), i.reset(), v = null, d.innerText = "Add Event", newEventData = e, document.getElementById("edit-event-btn").setAttribute("data-id", "new-event"), document.getElementById("edit-event-btn").click(), document.getElementById("edit-event-btn").setAttribute("hidden", !0)
    }

    function r() {
        return 768 <= window.innerWidth && window.innerWidth < 1200 ? "timeGridWeek" : window.innerWidth <= 768 ? "listMonth" : "dayGridMonth"
    }

    var c = new Choices("#event-category", {searchEnabled: !1})
    var configE = {
        timeZone: "local",
        editable: false,
        droppable: !0,
        selectable: !0,
        navLinks: !0,
        initialView: r(),
        themeSystem: "bootstrap",
        fixedWeekCount: false,
        headerToolbar: {
            left: "prev,next today",
            center: "title",
            right: "dayGridMonth,timeGridWeek,timeGridDay,listMonth"
        },
        windowResize: function (e) {
            var t = r();
            E.changeView(t)
        },
        eventResize: function (t) {
            var e = CALENDAR_RESULT.findIndex(function (e) {
                return e.id == t.event.id
            });
            CALENDAR_RESULT[e] && (CALENDAR_RESULT[e].title = t.event.title, CALENDAR_RESULT[e].start = t.event.start, CALENDAR_RESULT[e].end = t.event.end || null, CALENDAR_RESULT[e].allDay = t.event.allDay, CALENDAR_RESULT[e].className = t.event.classNames[0], CALENDAR_RESULT[e].description = t.event._def.extendedProps.description || "", CALENDAR_RESULT[e].location = t.event._def.extendedProps.location || ""), upcomingEvent(CALENDAR_RESULT)
        },
        eventClick: function (e) {
            $("img.cakeIcon").remove()
            removeAlert()
            let codeEvent = e.event._def.extendedProps.code
                    document.getElementById("edit-event-btn").removeAttribute("hidden"),
                    document.getElementById("btn-save-event").setAttribute("hidden", !0),
                    document.getElementById("edit-event-btn").setAttribute("data-id", "edit-event")
                    document.getElementById("edit-event-btn").innerHTML = "Edit"
                    eventClicked(),
                    flatPickrInit(),
                    flatpicekrValueClear(),
                    i.reset(),
                    v = e.event,
                    document.getElementById("modal-title").innerHTML = "",
                    document.getElementById("event-location-tag").innerHTML = void 0 === v.extendedProps.location ? "No Location" : v.extendedProps.location,
                    document.getElementById("event-description-tag").innerHTML = void 0 === v.extendedProps.description ? "No Description" : v.extendedProps.description,
                    document.getElementById("event-title").value = v.title,
                    document.getElementById("event-location").value = void 0 === v.extendedProps.location ? "No Location" : v.extendedProps.location,
                    document.getElementById("event-description").value = void 0 === v.extendedProps.description ? "No Description" : v.extendedProps.description,
                    document.getElementById("eventid").value = v.id, v.classNames[0] && (c.destroy(),
                    (c = new Choices("#event-category", {searchEnabled: !1})).setChoiceByValue(v.classNames[0]));
                    if(codeDisabled.includes(codeEvent)){
                        $("#edit-event-btn").addClass("d-none")
                        $("#btn-delete-event").addClass("d-none")
                    } else{
                        $("#edit-event-btn").removeClass("d-none")
                        $("#btn-delete-event").removeClass("d-none")
                    }
                    if(codeEvent === "BIRTHDAY"){
                        $("#event-modal .modal-title").before(birthdayIcon)
                    }
                    g.show()
            function t(e) {
                var t = "" + ((e = new Date(e)).getMonth() + 1), n = "" + e.getDate();
                return [e.getFullYear(), t = t.length < 2 ? "0" + t : t, n = n.length < 2 ? "0" + n : n].join("-")
            }
            var e = v.start, n = v.end, a = null == n ? str_dt(e) : str_dt(e) + " to " + str_dt(n),
                e = null == n ? t(e) : t(e) + " to " + t(n), n = (flatpickr(start_date, {
                    defaultDate: e,
                    altInput: !0,
                    altFormat: "j F Y",
                    dateFormat: "Y-m-d",
                    mode: "range",
                    onChange: function (e, t, n) {
                        1 < t.split("to").length ? document.getElementById("event-time").setAttribute("hidden", !0) : (document.getElementById("timepicker1").parentNode.classList.remove("d-none"), document.getElementById("timepicker1").classList.replace("d-none", "d-block"), document.getElementById("timepicker2").parentNode.classList.remove("d-none"), document.getElementById("timepicker2").classList.replace("d-none", "d-block"), document.getElementById("event-time").removeAttribute("hidden"))
                    }
                }), document.getElementById("event-start-date-tag").innerHTML = a, getTime(v.start)), e = getTime(v.end);
            n == e ? (document.getElementById("event-time").setAttribute("hidden", !0), flatpickr(document.getElementById("timepicker1"), {
                enableTime: !0,
                noCalendar: !0,
                dateFormat: "H:i"
            }), flatpickr(document.getElementById("timepicker2"), {
                enableTime: !0,
                noCalendar: !0,
                dateFormat: "H:i"
            })) : (document.getElementById("event-time").removeAttribute("hidden"), flatpickr(document.getElementById("timepicker1"), {
                enableTime: !0,
                noCalendar: !0,
                dateFormat: "H:i",
                defaultDate: n
            }), flatpickr(document.getElementById("timepicker2"), {
                enableTime: !0,
                noCalendar: !0,
                dateFormat: "H:i",
                defaultDate: e
            }), document.getElementById("event-timepicker1-tag").innerHTML = tConvert(n), document.getElementById("event-timepicker2-tag").innerHTML = tConvert(e)), newEventData = null, d.innerText = v.title, document.getElementById("btn-delete-event").removeAttribute("hidden")
        },
        dateClick: function (e) {
            $("img.cakeIcon").remove()
            removeAlert()
            o(e)
        },
        events: null,
        // eventReceive: function (e) {
        //     e = {
        //         id: parseInt(e.event.id),
        //         title: e.event.title,
        //         start: e.event.start,
        //         allDay: e.event.allDay,
        //         className: e.event.classNames[0]
        //     };
        //     y.push(e), upcomingEvent(y)
        // },
        datesSet: function(info) {
            return formatDateYYMM(info.view.currentStart)
        }
    }
    var   E = new FullCalendar.Calendar(e, configE)
    currentApiDate = formatDateYYMM(E.getDate())

    // async function fetchDataFromApisAndCallFunction() {
    //     try {
    //         const [data1, data2] = await Promise.all([
    //             callAjaxByJsonWithData("/api/v1/schedules/" + userId +"?monthly="+currentApiDate,"GET",null,function (rs) {
    //                 let CALENDAR_API = []
    //                 if(rs) {
    //                     rs.list.forEach(item=>{
    //                         if(statusCodePrevent.includes(item.statusTask.code)){
    //                             return
    //                         }
    //                         CALENDAR_API.push({
    //                             id: item.id,
    //                             code: item.statusTask.code,
    //                             title: item.title,
    //                             start: new Date(item.startDate),
    //                             end: new Date(item.dueOrCloseDate),
    //                             allDay: !0,
    //                             className: getStatusColor(item.statusTask.code),
    //                         })
    //                     })
    //                     resolve(CALENDAR_API)
    //                 }
    //             }, function (error){
    //                 console.log("Error")
    //                 console.log(error)
    //             })
    //             ,
    //             callAjaxByJsonWithData(baseUrlEvent + "?month="+currentApiDate,"GET",null,function (rs) {
    //                 let EVENT_API = []
    //                 if(rs && rs.length >0){
    //                     rs.forEach(item=>{
    //                         EVENT_API.push({
    //                             id: item.id,
    //                             code: item.type.code,
    //                             title: item.title,
    //                             start: new Date(item.startDate),
    //                             end: new Date(item.dueOrCloseDate),
    //                             allDay: !0,
    //                             className: getStatusColor(item.type.code),
    //                         })
    //                     })
    //                 }
    //                 resolve(EVENT_API)
    //             }, function (error){
    //                 console.log("Error")
    //                 console.log(error)
    //             })
    //         ]);
    //         // Xử lý kết quả từ cả hai API
    //         console.log('Data from API 1:', data1);
    //         console.log('Data from API 2:', data2);
    //         renderCalendar(data1, data2);
    //     } catch (error) {
    //         console.error('An error occurred:', error);
    //     }
    // }
    // function renderCalendar(data1, data2) {
    //     console.log('Data from API 1 in yourFunction:', data1);
    //     console.log('Data from API 2 in yourFunction:', data2);
    // }
    // fetchDataFromApisAndCallFunction().then(r => console.log(r))
    async function fetchCalendarData(userId, currentApiDate) {
        return new Promise((resolve, reject) => {
            callAjaxByJsonWithData(
                "/api/v1/schedules/" + userId + "?monthly=" + currentApiDate,
                "GET",
                null,
                (rs) => {
                    let CALENDAR_API = [];
                    if (rs) {
                        rs.list.forEach((item) => {
                            if (statusCodePrevent.includes(item.statusTask.code)) {
                                return;
                            }
                            CALENDAR_API.push({
                                id: item.id,
                                code: item.statusTask.code,
                                title: item.title,
                                start: new Date(item.startDate),
                                end: new Date(item.dueOrCloseDate),
                                allDay: true,
                                className: getStatusColor(item.statusTask.code),
                            });
                        });
                        resolve(CALENDAR_API);
                    }
                },
                (error) => {
                    console.log("Error");
                    console.log(error);
                    reject(error);
                }
            );
        });
    }

    async function fetchEventApiData(currentApiDate) {
        return new Promise((resolve, reject) => {
            callAjaxByJsonWithData(
                baseUrlEvent + "?month=" + currentApiDate,
                "GET",
                null,
                (rs) => {
                    let EVENT_API = [];
                    if (rs && rs.length > 0) {
                        rs.forEach((item) => {
                            EVENT_API.push({
                                id: item.id,
                                code: item.type.code,
                                title: item.title,
                                start: originalStringDateToDate(item.startDate),
                                end: originalStringDateToDate(item.endDate),
                                allDay: true,
                                className: getStatusColor(item.type.code),
                            });
                        });
                    }
                    resolve(EVENT_API);
                },
                (error) => {
                    console.log("Error");
                    console.log(error);
                    reject(error);
                }
            );
        });
    }

    async function fetchData() {
        try {
            const [calendarData, eventApiData] = await Promise.all([
                fetchCalendarData(userId, currentApiDate),
                fetchEventApiData(currentApiDate),
            ]);
            console.log("Data from Calendar API:", calendarData.concat(eventApiData));
            CALENDAR_RESULT = calendarData.concat(eventApiData)
            upcomingEvent(CALENDAR_RESULT)
            E.addEventSource(CALENDAR_RESULT);
            E.render()
            i.addEventListener("submit", function (e) {
                e.preventDefault();
                var t,
                    n,
                    e = document.getElementById("event-title").value,
                    a = document.getElementById("event-category").value,
                    d = document.getElementById("event-start-date").value.split("to"),
                    i = new Date(d[0].trim()),
                    l = d[1] ? new Date(d[1].trim()) : "", o = null, r = document.getElementById("event-location").value,
                    c = document.getElementById("event-description").value, s = document.getElementById("eventid").value,
                    m = !1,
                    u = (1 < d.length ? ((o = new Date(d[1])).setDate(o.getDate() + 1),
                        d = new Date(d[0]), m = !0) : (t = d, u = document.getElementById("timepicker1").value.trim(),
                        n = document.getElementById("timepicker2").value.trim(),
                        d = new Date(d + "T" + u), o = new Date(t + "T" + n)), CALENDAR_RESULT.length + 1);
                !1 === p[0].checkValidity() ?  p[0].classList.add("was-validated") :
                    (v
                        ? (
                            t = CALENDAR_RESULT.findIndex(function (e) {
                                return e.id == v.id
                            }),
                            CALENDAR_RESULT[t] && (CALENDAR_RESULT[t].title = e,
                                CALENDAR_RESULT[t].start = d,
                                CALENDAR_RESULT[t].end = l!="" ? l : o,
                                CALENDAR_RESULT[t].allDay = m,
                                CALENDAR_RESULT[t].className = a,
                                CALENDAR_RESULT[t].description = c,
                                CALENDAR_RESULT[t].location = r),
                                updateEvent(CALENDAR_RESULT[t], E, v, g)
                        )
                        : (n = {
                            id: u,
                            title: e,
                            start: d,
                            end: o,
                            allDay: m,
                            className: a,
                            description: c,
                            location: r
                        }, addEventFunc(n, g, E)))
            })
            document.getElementById("btn-delete-event").addEventListener("click", function (e) {
                deleteEvent(CALENDAR_RESULT, v, g)
            })
            let $elm = document.getElementsByClassName('fc-today-button')[0];
            $elm.addEventListener('click', function() {
                let month = formatDateYYMM(E.getDate())
                callApiData(userId, month, getFilter())
            });
        } catch (error) {
            console.error("An error occurred:", error);
        }
    }

    fetchData();

    $(document).on("change","table.filterStatus input", function(){
        let newArr = []
        let $element = $(this)
        console.log($element.val())
        if($element.val() === "ALL" && $element.prop("checked")){
            $("input.checkFilter").prop("checked", true)
        } else if($element.val() === "ALL" && !$element.prop("checked")){
            $("input.checkFilter").prop("checked", false)
            newArr = getFilter()
        } else {
            newArr = getFilter()
        }
        let apiDate = formatDateYYMM(E.getDate())
        callApiData(1,apiDate, newArr)
    })

    function getFilter(){
        let newArr = []
        $("table.filterStatus input").each(function(index, item ){
            if(!$(item).prop("checked") && $("input.allFilter").prop("checked")){
                $("input.allFilter").prop("checked", false)
                getFilter()
            }
            if(!$(item).prop("checked") && !$("input.allFilter").prop("checked")){
                newArr.push($(item).val())
            }
        })
        return newArr
    }

    $(document).on("click",".fc-header-toolbar button",function (){
        let month = formatDateYYMM(E.getDate())
        if(currentApiDate != month){
            callApiData(userId, month, getFilter())
        }
    })

    function callApiData(userId,apiDate,newArr){
        console.log(newArr)
        CALENDAR_RESULT =[]
        callAjaxByJsonWithData("/api/v1/schedules/" + userId +"?monthly="+apiDate,"GET",null,function (rs) {
            if(rs){
                currentApiDate = apiDate
                rs.list.forEach(item=>{
                    if(newArr.includes(item.statusTask.code)){
                        return
                    }
                    CALENDAR_RESULT.push({
                        id: item.id,
                        code: item.statusTask.code,
                        title: item.title,
                        start: new Date(item.startDate),
                        end: new Date(item.dueOrCloseDate),
                        allDay: !0,
                        className: getStatusColor(item.statusTask.code),
                    })
                })
                E.getEventSources().forEach(eventSource => {
                    eventSource.remove();
                });
                upcomingEvent(CALENDAR_RESULT)
                E.addEventSource(CALENDAR_RESULT);
                E.render()
            }
        })
    }
});


