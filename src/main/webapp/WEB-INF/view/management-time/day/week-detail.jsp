<%@ page import="com.shsoftvina.erpshsoftvina.security.Principal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    session.setAttribute("pathMain", "/todo/");
%>
<c:set var="data" value="${dayResponse.data}"/>
<c:set var="oneThingCalendar" value="${data.oneThingCalendar}"/>
<c:set var="toDoList" value="${data.toDoList}"/>
<c:set var="showButtonResult" value='${dayResponse!=null ? "" : "disabled"}'/>
<c:set var="infoButtonResult" value='${dayResponse!=null ? "Update" : "Create"}'/>
<c:set var="userId" value="${Principal.getUserCurrent().getId()}"/>
<html>
<head>
    <title>Detail of Day</title>
    <style>
        .full-height {
            min-height: 80vh;
        }

        .table-container {
            overflow-x: auto;
            cursor: grab;
        }

        .oneThingCalendar th {
            max-width: 70px;
            line-height: 100%;
        }

        .table-container th {
            background-color: #f2f2f2;
            white-space: nowrap;
            min-width: 500px;
            text-align: center;
            border: 1px solid #000;
            padding-top: 5px;
            font-weight: bold;
            font-family: Poppins, sans-serif;
        }

        .table-container td {
            padding: 5px;
            white-space: nowrap;
            text-align: center;
            border: 1px solid #000;
            font-family: Poppins, sans-serif;
            height: 32.5px;
        }

        .table-detail {
            width: 100%; /* Đặt chiều rộng tùy ý */
        }

        .table-detail th {
            min-width: 340px;
            background-color: #f2f2f2;
            white-space: nowrap;
            text-align: center;
            border: 1px solid #000;
            font-weight: bold;
            font-family: Poppins, sans-serif;
            padding-top: 5px;
        }

        .table-detail td {
            padding: 5px;
            white-space: nowrap;
            text-align: center;
            border: 1px solid #000;
            font-family: Poppins, sans-serif;
            height: 32.5px;
        }
    </style>
</head>
<body>
<div class="row position-relative full-height">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Management Time: <span
                    class="fw-semibold text-success fst-italic">${dayResponse != null ? dayResponse.day : day}</span>
            </h4>
            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="/management-time/${userId}">Management Time</a></li>
                    <li class="breadcrumb-item active">Management Time Day</li>
                </ol>
            </div>
        </div>
    </div>
    <div style="width: 3rem; height: 3rem; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);"
         class="containerLoading d-flex align-items-center justify-content-center">
        <div>
            <div class="spinner-grow" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
    </div>
    <div class="row calendar-container d-none" data-date="${day}" data-id="${dayResponse.id}">
        <div class="card">
            <div class="row card-body">
                <div class="col-md-4">
                    <h4 class="fw-bolder">One Thing Calendar</h4>
                    <h5 class="fst-italic">Daily Important</h5>
                    <table class="table table-bordered oneThingCalendar text-center align-middle">
                        <thead>
                        <tr>
                            <th class="w-25">Objective</th>
                            <th>Key Results</th>
                            <th>Rate</th>
                            <th>Target</th>
                            <th class="text-wrap">Performance</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:set var="theSingleMostImportantThing"
                               value="${oneThingCalendar.theSingleMostImportantThing}"/>
                        <tr name="theSingleMostImportantThing">
                            <td class="text-start" rowspan="5">Repeat consistently every day</td>
                            <td><input class="form-control" type="text" value="${theSingleMostImportantThing.target}">
                            </td>
                            <td class="text-center">0%</td>
                            <td class="text-center" contenteditable="true">5</td>
                            <td class="text-center">0</td>
                        </tr>
                        <c:set var="lecture" value="${oneThingCalendar.lecture}"/>
                        <tr name="lecture">
                            <td><input class="form-control" type="text" value="${lecture.target}"></td>
                            <td class="text-center">0%</td>
                            <td class="text-center" contenteditable="true">5</td>
                            <td class="text-center">0</td>
                        </tr>
                        <c:set var="dailyEvaluation" value="${oneThingCalendar.dailyEvaluation}"/>
                        <tr name="dailyEvaluation">
                            <td><input class="form-control" type="text" value="${dailyEvaluation.target}"></td>
                            <td class="text-center">0%</td>
                            <td class="text-center" contenteditable="true">5</td>
                            <td class="text-center">0</td>
                        </tr>
                        <c:set var="work" value="${oneThingCalendar.work}"/>
                        <tr name="work">
                            <td><input class="form-control" type="text" value="${work.target}"></td>
                            <td class="text-center">0%</td>
                            <td class="text-center" contenteditable="true">5</td>
                            <td class="text-center">0</td>
                        </tr>
                        <c:set var="reading" value="${oneThingCalendar.reading}"/>
                        <tr name="reading">
                            <td><input class="form-control" type="text" value="${reading.target}"></td>
                            <td class="text-center">0%</td>
                            <td class="text-center" contenteditable="true">5</td>
                            <td class="text-center">0</td>
                        </tr>
                        </tbody>
                    </table>
                    <h4 class="fw-bolder">Month Target</h4>
                    <table class="table table-bordered oneThingCalendar text-center align-middle">
                        <thead>
                        <tr>
                            <th class="w-25">Objective</th>
                            <th>Key Results</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="monthly" varStatus="loop" items="${weekly.monthlyContents}">
                            <tr name="reading">
                                <c:if test="${loop.index == 0}">
                                    <td class="text-start" rowspan="3">Main target</td>
                                </c:if>
                                <td><input class="form-control" type="text" value="${monthly}"></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <h4 class="fw-bolder">Weekly Todolist</h4>
                    <table class="table table-bordered oneThingCalendar text-center align-middle">
                        <thead>
                        <tr>
                            <th class="w-25">Category</th>
                            <th>Target</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:set var="theSingleMostImportantThing" value="${weekly.weeklys.weeklyContents.theSingleMostImportantThing}"/>
                        <tr name="theSingleMostImportantThing">
                            <td class="text-start">Single Most Important Thing</td>
                            <td><input class="form-control" type="text" value="${theSingleMostImportantThing}">
                            </td>
                        </tr>
                        <c:set var="lecture" value="${weekly.weeklys.weeklyContents.lecture}"/>
                        <tr name="lecture">
                            <td class="text-start">Lecture</td>
                            <td><input class="form-control" type="text" value="${lecture}"></td>
                        </tr>
                        <c:set var="dailyEvaluation" value="${weekly.weeklys.weeklyContents.dailyEvaluation}"/>
                        <tr name="dailyEvaluation">
                            <td class="text-start">Daily Evaluation</td>
                            <td><input class="form-control" type="text" value="${dailyEvaluation}"></td>
                        </tr>
                        <c:set var="work" value="${weekly.weeklys.weeklyContents.work}"/>
                        <tr name="work">
                            <td class="text-start">Work</td>
                            <td><input class="form-control" type="text" value="${work}"></td>
                            </td>
                        </tr>
                        <c:set var="reading" value="${weekly.weeklys.weeklyContents.reading}"/>
                        <tr name="reading">
                            <td class="text-start">Reading</td>
                            <td><input class="form-control" type="text" value="${reading}"></td>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-8 d-inline-flex">
                    <div class="table-detail col-md-4">
                        <table>
                            <thead>
                            <tr>
                                <th colspan="2" class="fw-bolder"><h5>Detail</h5></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td></td>
                                <td class="fw-bolder">Categories</td>
                            </tr>
                            <tr>
                                <td rowspan="5" style="max-width: 5rem;white-space: normal" class="fw-bolder">Onething
                                    calendar
                                </td>
                                <td>The single most important thing</td>
                            </tr>
                            <tr>
                                <td>Lecture</td>
                            </tr>
                            <tr>
                                <td>Daily evaluation</td>
                            </tr>
                            <tr>
                                <td>Work</td>
                            </tr>
                            <tr>
                                <td>Reading</td>
                            </tr>
                            <tr>
                                <td rowspan="3" style="max-width: 5rem;white-space: normal" class="fw-bolder">To-Do
                                    List
                                </td>
                                <td style="height: 65px">Six to Twelve PM</td>
                            </tr>
                            <tr>
                                <td style="height: 65px">Twelve to Six PM</td>
                            </tr>
                            <tr>
                                <td style="height: 65px">Six to Twelve AM</td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 162.5px"><h5 class="fw-bolder">Daily Routine</h5></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 213px"><h5 class="fw-bolder">Gratitude Diary</h5></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 71px"><h5 class="fw-bolder">Affirmation</h5></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 71px"><h5 class="fw-bolder">Compliment for me today</h5>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 71px"><h5 class="fw-bolder">Today’s reflections and
                                    improvements</h5></td>
                            </tr>
                            <tr>
                                <td rowspan="24" style="max-width: 5rem;white-space: normal" class="fw-bolder">
                                    Timeline
                                </td>
                                <td>0:00</td>
                            </tr>
                            <c:forEach var="time" begin="1" end="23">
                                <tr>
                                    <td>${time}:00</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="table-container col-md-8">
                        <table>
                            <thead>
                            <tr>
                                <c:forEach var="day" items="${weekly.weeklys.listDayOfWeek}">
                                    <th colspan="2"><h5>${day.day}</h5></th>
                                </c:forEach>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td class="fw-bolder w-75">Target</td>
                                <td class="fw-bolder">Performance</td>
                            </tr>
                            <%--one-thing--%>
                            <c:set var="theSingleMostImportantThing"
                                   value="${oneThingCalendar.theSingleMostImportantThing}"/>
                            <tr name="theSingleMostImportantThing">
                                <td contenteditable="true">${theSingleMostImportantThing.target}</td>
                                <td><input class="form-check-input"
                                           type="checkbox" ${theSingleMostImportantThing.performance ? 'checked' : ''}>
                                </td>
                            </tr>
                            <c:set var="lecture" value="${oneThingCalendar.lecture}"/>
                            <tr name="lecture">
                                <td contenteditable="true">${lecture.target}</td>
                                <td><input class="form-check-input"
                                           type="checkbox" ${lecture.performance ? 'checked' : ''}></td>
                            </tr>
                            <c:set var="dailyEvaluation" value="${oneThingCalendar.dailyEvaluation}"/>
                            <tr name="dailyEvaluation">
                                <td contenteditable="true">${dailyEvaluation.target}</td>
                                <td><input class="form-check-input"
                                           type="checkbox" ${dailyEvaluation.performance ? 'checked' : ''}></td>
                            </tr>
                            <c:set var="work" value="${oneThingCalendar.work}"/>
                            <tr name="work">
                                <td contenteditable="true">${work.target}</td>
                                <td><input class="form-check-input"
                                           type="checkbox" ${work.performance ? 'checked' : ''}></td>
                            </tr>
                            <c:set var="reading" value="${oneThingCalendar.reading}"/>
                            <tr name="reading">
                                <td contenteditable="true">${reading.target}</td>
                                <td><input class="form-check-input"
                                           type="checkbox" ${reading.performance ? 'checked' : ''}></td>
                            </tr>
                            <%--to-do--%>
                            <tr name="daily">
                                <td contenteditable="true">${reading.target}</td>
                                <td><input class="form-check-input"
                                           type="checkbox" ${reading.performance ? 'checked' : ''}></td>
                            </tr>
                            <tr name="daily">
                                <td contenteditable="true">${reading.target}</td>
                                <td><input class="form-check-input"
                                           type="checkbox" ${reading.performance ? 'checked' : ''}></td>
                            </tr>
                            <tr name="daily">
                                <td contenteditable="true">${reading.target}</td>
                                <td><input class="form-check-input"
                                           type="checkbox" ${reading.performance ? 'checked' : ''}></td>
                            </tr>
                            <tr name="daily">
                                <td contenteditable="true">${reading.target}</td>
                                <td><input class="form-check-input"
                                           type="checkbox" ${reading.performance ? 'checked' : ''}></td>
                            </tr>
                            <tr name="daily">
                                <td contenteditable="true">${reading.target}</td>
                                <td><input class="form-check-input"
                                           type="checkbox" ${reading.performance ? 'checked' : ''}></td>
                            </tr>
                            <tr name="daily">
                                <td contenteditable="true">${reading.target}</td>
                                <td><input class="form-check-input"
                                           type="checkbox" ${reading.performance ? 'checked' : ''}></td>
                            </tr>
                            <%--                            daily--%>
                            <tr name="daily">
                                <td contenteditable="true">${reading.target}</td>
                                <td><input class="form-check-input"
                                           type="checkbox" ${reading.performance ? 'checked' : ''}></td>
                            </tr>
                            <tr name="daily">
                                <td contenteditable="true">${reading.target}</td>
                                <td><input class="form-check-input"
                                           type="checkbox" ${reading.performance ? 'checked' : ''}></td>
                            </tr>
                            <tr name="daily">
                                <td contenteditable="true">${reading.target}</td>
                                <td><input class="form-check-input"
                                           type="checkbox" ${reading.performance ? 'checked' : ''}></td>
                            </tr>
                            <tr name="daily">
                                <td contenteditable="true">${reading.target}</td>
                                <td><input class="form-check-input"
                                           type="checkbox" ${reading.performance ? 'checked' : ''}></td>
                            </tr>
                            <tr name="daily">
                                <td contenteditable="true">${reading.target}</td>
                                <td><input class="form-check-input"
                                           type="checkbox" ${reading.performance ? 'checked' : ''}></td>
                            </tr>


                            <c:forEach items="${data.gratitudeDiary}" var="entry" varStatus="loop">
                                <tr name="gratitudeDiary">
                                    <td colspan="2"><textarea
                                            class="form-control">${entry}</textarea></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${3-data.gratitudeDiary.size()>0}">
                                <c:forEach begin="1" end="${3-data.gratitudeDiary.size()}" varStatus="loop">
                                    <tr name="gratitudeDiary">
                                        <td colspan="2"><textarea
                                                class="form-control"></textarea></td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            <tr>
                                <td colspan="2">
                                    <textarea class="form-control affirmation">${data.affirmation}</textarea>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <textarea class="form-control affirmation">${data.affirmation}</textarea>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <textarea class="form-control affirmation">${data.affirmation}</textarea>
                                </td>
                            </tr>
                            <c:forEach var="time" begin="1" end="24">
                                <tr name="theSingleMostImportantThing">
                                    <td contenteditable="true">${theSingleMostImportantThing.target}</td>
                                    <td><input class="form-check-input"
                                               type="checkbox" ${theSingleMostImportantThing.performance ? 'checked' : ''}>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-md-12 text-center align-middle mt-3">
                    <button class="btn btn-primary mr-2" id="backButton" onclick="window.location=document.referrer">
                        Back
                    </button>
                    <button class="btn btn-success ml-2" id="updateButton">${infoButtonResult}</button>
                </div>
            </div>
        </div>
    </div> <!-- end row-->
</div>

<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="detailModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="margin-top: 30%;">
            <div class="modal-header">
                <h5 class="modal-title" id="detailModalLabel"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered text-center">
                    <thead>
                    <tr>
                        <th class="align-middle">Q</th>
                        <th class="align-middle">Time Slot</th>
                        <th class="align-middle">Target</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <p class="mr-4 message-noti-day-detail" style="color:green;"></p>
                <button type="button" class="btn btn-primary" id="showDetailSubmit">Save changes</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<style>
    .container-fluid .form-check-input {
        font-size: 1.2rem;
    }

    textarea.form-control {
        min-height: 60px
    }

    textarea.affirmation {
        min-height: 60px
    }

    .form-check-input {
        margin: 0;
    }

</style>
<script>
    const M_SIX_TO_TWELVE_PM = 'SIX_TO_TWELVE_PM';
    const M_TWELVE_TO_SIX_PM = 'TWELVE_TO_SIX_PM';
    const M_SIX_TO_TWELVE_AM = 'SIX_TO_TWELVE_AM';

    const CodeToDetail = {
        "sixToTwelvePm": "Six to Twelve PM",
        "twelveToSixPm": "Twelve to Six PM",
        "sixToTwelveAm": "Six to Twelve AM"
    }
    var rsSuccess = (text) => {
        Swal.fire({
            html: '<div class="mt-3"><lord-icon src="https://cdn.lordicon.com/lupuorrc.json" trigger="loop" colors="primary:#0ab39c,secondary:#405189" style="width:120px;height:120px"></lord-icon><div class="mt-4 pt-2 fs-15"><h4>Well done !</h4><p class="text-muted mx-4 mb-0">' + text + ' successfully</p></div></div>',
            showCancelButton: !0,
            showConfirmButton: !1,
            customClass: {
                cancelButton: 'btn btn-primary w-xs mb-1'
            },
            cancelButtonText: "Back",
            buttonsStyling: !1,
            showCloseButton: !0
        })
    }
    var rsUnSuccess = () => {
        Swal.fire({
            html: '<div class="mt-3"><lord-icon src="https://cdn.lordicon.com/tdrtiskw.json" trigger="loop" colors="primary:#f06548,secondary:#f7b84b" style="width:120px;height:120px"></lord-icon><div class="mt-4 pt-2 fs-15"><h4>Oops...! Something went Wrong !</h4><p class="text-muted mx-4 mb-0">Try Again</p></div></div>',
            showCancelButton: !0,
            showConfirmButton: !1,
            customClass: {
                cancelButton: 'btn btn-primary w-xs mb-1'
            },
            cancelButtonText: "Dismiss",
            buttonsStyling: !1,
            showCloseButton: !0
        })
    }
    let qresult = (name) => {
        let array = {
            sixToTwelvePm: "6~12pm",
            twelveToSixPm: "12~6pm",
            sixToTwelveAm: "6~12am",
        }
        return array[name]
    }
    let getCodeTime = (code) => {
        let arr = {
            sixToTwelvePm: M_SIX_TO_TWELVE_PM,
            twelveToSixPm: M_TWELVE_TO_SIX_PM,
            sixToTwelveAm: M_SIX_TO_TWELVE_AM,
        }
        return arr[code]
    }
    let interval = (name) => {
        let intervalResult = []
        if (name == "sixToTwelvePm") {
            for (var i = 6; i < 12; i++) {
                if (i === 11) {
                    intervalResult.push(i + "~" + (i + 1) + "pm");
                } else {
                    intervalResult.push(i + "~" + (i + 1) + "am");
                }
            }
        } else if (name == "twelveToSixPm") {
            for (var i = 0; i <= 5; i++) {
                if (i === 0) {
                    intervalResult.push(12 + "~" + (i + 1) + "pm");
                } else {
                    intervalResult.push(i + "~" + (i + 1) + "pm");
                }
            }
        } else {
            for (var i = 6; i < 12; i++) {
                if (i == 11) {
                    intervalResult.push(i + "~" + (i + 1) + "am");
                } else {
                    intervalResult.push(i + "~" + (i + 1) + "pm");
                }
            }
        }
        return intervalResult
    }


    document.addEventListener("DOMContentLoaded", function () {
        $(".containerLoading").addClass("d-none")
        $(".calendar-container").removeClass("d-none")

    })

    $("#showDetailSubmit").click(function () {
        let target = $(this)
        target.addClass("d-none")
        target.before(BtnPrimaryLoad)
        $(".container-fluid button").each(function () {
            $(this).prop("disabled", true)
        })
        var dayId = $("div.calendar-container").attr("data-id")
        var codeData = $("#detailModal").attr("data-code")
        var code = getCodeTime(codeData)
        var targetArr = []
        $("#detailModal tr input.inputTarget").each(function () {
            let target = $(this).val()
            targetArr.push(target)
        })
        var data = {
            dayId: dayId,
            code: code,
            data: targetArr
        }

        callAjaxByJsonWithData('/api/v1/management-time-detail/exist/' + dayId, 'GET', null, function (rs) {
            if (!(typeof rs === 'boolean')) {
                $("button").each(function () {
                    $(this).prop("disabled", false)
                })
                target.removeClass("d-none")
                BtnLoadRemove()
                rsUnSuccess()
                return
            }
            if (rs) { // update
                callAjaxByJsonWithData('/api/v1/management-time-detail', 'PUT', data, function (rs) {
                    $("button").each(function () {
                        $(this).prop("disabled", false)
                    })
                    $("#detailModal").modal("hide")
                    target.removeClass("d-none")
                    BtnLoadRemove()
                    rsSuccess("Update")
                });
            } else { // create
                callAjaxByJsonWithData('/api/v1/management-time-detail', 'POST', data, function (rs) {
                    $("button").each(function () {
                        $(this).prop("disabled", false)
                    })
                    $("#detailModal").modal("hide")
                    target.removeClass("d-none")
                    BtnLoadRemove()
                    rsSuccess("Update")
                });
            }
        }, function (error) {
            rsUnSuccess()
        });
    })
    $("button.showDetail").click(function () {
        $(this).addClass("d-none")
        $(this).after(BtnSmPrimaryLoad)
        $('.message-noti-day-detail').text('');
        var modal = $("#detailModal")
        var name = $(this).attr("data-name")
        var nameDisplay = CodeToDetail[name]
        $(".container-fluid button").each(function () {
            $(this).prop("disabled", true)
        })
        modal.attr("data-code", name)
        $("#detailModalLabel").text(nameDisplay)
        let arrayTime = interval(name)
        var code = getCodeTime(name)
        let html = '<tr>' +
            '<td rowspan="7" class="align-middle text-center">' + qresult(name) + '</td>' +
            '</tr>'
        let idResponse = $(".calendar-container").attr("data-id")
        callAjaxByJsonWithData('/api/v1/management-time-detail/' + idResponse + '/' + code, 'GET', null, function (rs) {
            if (rs.id != null) {
                if (rs.data != null) {
                    let data = rs.data;
                    if (arrayTime) {
                        arrayTime.forEach((e, index) => {
                            var dataOfArray = data[index];
                            if (data[index] == '' || data[index] == undefined) dataOfArray = '';
                            html +=
                                '<tr>' +
                                '<td class="align-middle">' + e + '</td>' +
                                '<td><input type="text" class="form-control inputTarget" value="' + dataOfArray + '" placeholder="Input target..."></td>' +
                                '</tr>'
                        })
                    }
                }
            } else {
                if (arrayTime) {
                    arrayTime.forEach((e) => {
                        html +=
                            '<tr>' +
                            '<td class="align-middle">' + e + '</td>' +
                            '<td><input type="text" class="form-control inputTarget" value="" placeholder="Input target..."></td>' +
                            '</tr>'
                    })
                }
            }
            BtnLoadRemove()
            $('button.showDetail').removeClass("d-none")
            $("#detailModal tbody").html(html)
            modal.modal("show")
            $("button").each(function () {
                $(this).prop("disabled", false)
            })
        })
    })

    $("#updateButton").click(function () {
        $(this).addClass("d-none")
        $(this).before(BtnSuccessLoad)
        var id = "${dayResponse.id}"
        var oneThingCalendar = {};
        $(".oneThingCalendar tr").each(function () {
            let name = $(this).attr("name")
            let target = $(this).find('input[type="text"]').val()
            let performance = $(this).find('input[type="checkbox"]').prop('checked')
            if (name && target != "") {
                oneThingCalendar[name] = {
                    target: target,
                    performance: performance
                }
            }
        })
        var sixToTwelvePm = []
        var twelveToSixPm = []
        var sixToTwelveAm = []

        $("table.sixToTwelvePm tr").each(function () {
            let target = $(this).find('input[type="text"]').val()
            let performance = $(this).find('input[type="checkbox"]').prop('checked')
            if (target && target != "") {
                let newObject = {
                    target: target,
                    performance: performance
                }
                sixToTwelvePm.push(newObject)
            }
        })

        $("table.twelveToSixPm tr").each(function () {
            let target = $(this).find('input[type="text"]').val()
            let performance = $(this).find('input[type="checkbox"]').prop('checked')
            if (target && target != "") {
                let newObject = {
                    target: target,
                    performance: performance
                }
                twelveToSixPm.push(newObject)
            }
        })

        $("table.sixToTwelveAm tr").each(function () {
            let target = $(this).find('input[type="text"]').val()
            let performance = $(this).find('input[type="checkbox"]').prop('checked')
            if (target && target != "") {
                let newObject = {
                    target: target,
                    performance: performance
                }
                sixToTwelveAm.push(newObject)
            }
        })

        var toDoList = {
            sixToTwelvePm: sixToTwelvePm,
            twelveToSixPm: twelveToSixPm,
            sixToTwelveAm: sixToTwelveAm,
        }

        var gratitudeDiary = []
        $('ul[name="gratitudeDiary"] textarea').each(function () {
            let text = $(this).val()
            if (text && text != "") {
                gratitudeDiary.push(text)
            }
        })
        var affirmation = $("textarea.affirmation").val()
        var dataInfor = {
            oneThingCalendar: oneThingCalendar,
            toDoList: toDoList,
            gratitudeDiary: gratitudeDiary,
            affirmation: affirmation
        }
        var apiUrlManagementTimeDayApi = "/api/v1/management-time/day"

        if ("${day}" != "" && $("div.calendar-container").attr("data-id") == "") {
            dataCreate = {
                day: "${day}",
                userId: "${userId}",
                data: dataInfor
            }
            callAjaxByJsonWithData(apiUrlManagementTimeDayApi, 'POST', dataCreate, function (rs) {
                if (rs != null) {
                    rsSuccess("Create")
                    $("#updateButton").text("Update")
                    $("button.showDetail").prop("disabled", false)
                    $("div.calendar-container").attr("data-id", rs.id)
                    $("#updateButton").removeClass("d-none")
                    BtnLoadRemove()
                    return
                }
                rsUnSuccess()
            })
        } else if ($("div.calendar-container").attr("data-id") != "") {
            var dataUpdate = {
                id: $("div.calendar-container").attr("data-id"),
                userId: userCurrent.id,
                data: dataInfor
            };
            callAjaxByJsonWithData(apiUrlManagementTimeDayApi, 'PUT', dataUpdate, function (rs) {
                if (rs != null) {
                    rsSuccess("Update")
                    $("#updateButton").removeClass("d-none")
                    BtnLoadRemove()
                    return
                }
                rsUnSuccess()
            })
        } else if ("${day}" == '') {
            console.log("Error")
        }
    })

    $(document).ready(function () {
        let isMouseDown = false;
        let startX;
        let startScrollLeft;

        $(".table-container").mousedown(function (e) {
            if (e.button === 0) {
                isMouseDown = true;
                startX = e.pageX - $(".table-container").offset().left;
                startScrollLeft = $(".table-container").scrollLeft();
            }
        });

        $(document).mouseup(function () {
            isMouseDown = false;
        });

        $(".table-container").on('mousemove', function (e) {
            if (isMouseDown) {
                const mouseX = e.pageX - $(".table-container").offset().left;
                const scrollX = startScrollLeft + (startX - mouseX);
                $(".table-container").scrollLeft(scrollX);
            }
        });
    });


    $(document).ready(function () {
        $(".table-container").on('wheel', function (e) {
            const scrollSpeed = 50;

            let currentScrollLeft = $(this).scrollLeft();

            let delta = e.originalEvent.deltaY || e.originalEvent.wheelDelta;
            let direction = delta > 0 ? 1 : -1;

            currentScrollLeft += direction * scrollSpeed;

            $(this).scrollLeft(currentScrollLeft);

            e.preventDefault();
        });
    });

</script>
</body>
</html>
