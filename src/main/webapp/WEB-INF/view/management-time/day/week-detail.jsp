<%@ page import="com.shsoftvina.erpshsoftvina.security.Principal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    session.setAttribute("pathMain", "/todo/");
%>
<c:set var="data" value="${dayResponse.data}"/>
<c:set var="oneThingCalendar" value="${data.oneThingCalendar}"/>
<c:set var="toDoList" value="${data.toDoList}"/>
<c:set var="showButtonResult" value='${dayResponse!=null ? "" : "disabled"}'/>
<c:set var="infoButtonResult" value='${dayResponse!=null ? "Update" : "Create"}'/>
<c:set var="userRole" value="${Principal.getUserCurrent().getRole()}"/>
<html>
<head>
    <title>Detail of Day</title>
    <link rel="stylesheet" href="../../../../assets/custom/css/management-time/style.css">
    <link rel="stylesheet" href="/assets/libs/@simonwep/pickr/themes/classic.min.css"/>
    <link rel="stylesheet" href="/assets/libs/@simonwep/pickr/themes/monolith.min.css"/>
    <link rel="stylesheet" href="/assets/libs/@simonwep/pickr/themes/nano.min.css"/>
    <link href="/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css"/>
    <style>
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
            position: relative;
            white-space: nowrap;
            text-align: center;
            min-width: 100px;
            border: 1px solid #000;
            font-family: Poppins, sans-serif;
            height: 32.5px;
        }

        .table-detail {
            width: 100%;
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

        .categoryColor th {
            max-width: 20px;
            text-wrap: normal;
        }

        .categoryColor td {
            max-width: 20px;
            text-wrap: normal;
        }

        .note {
            position: absolute;
            background-color: #fff;
            border: 1px solid #ccc;
            width: 160px;
            cursor: pointer;
            padding: 5px;
            left: 60%;
            top: 15px;
            z-index: 1;
        }

        .note:hover {
            background: #cfd1d4;
        }
    </style>
</head>
<body>
<div class="row position-relative full-height">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Calendar of ${user.fullname} <span
                    class="fw-semibold text-success fst-italic">${dayResponse != null ? dayResponse.day : day}</span>
            </h4>
            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="/home">Dashboard</a></li>
                    <c:if test="${userRole != 'DEVELOPER'}">
                        <li class="breadcrumb-item"><a href="/management-time">Management Time</a></li>
                    </c:if>
                    <li class="breadcrumb-item"><a href="/management-time/${user.id}">Management Time</a></li>
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
                        <c:forEach var="month" varStatus="loop" begin="0" end="4">
                            <c:set var="dailyRoutine" value="${weekly.monthlys[0].dailyRoutine[loop.index]}"/>
                            <tr name="theSingleMostImportantThing">
                                <c:if test="${loop.index == 0}">
                                    <td class="text-start" rowspan="5">Repeat consistently every day</td>
                                </c:if>
                                <td><input class="form-control dailyRoutineInput" type="text"
                                           value="${dailyRoutine.title}">
                                </td>
                                <td class="text-center">
                                    <c:if test="${not empty dailyRoutine.target and not empty dailyRoutine.performance}">
                                        <c:choose>
                                            <c:when test="${dailyRoutine.target == 0}">
                                                0%
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatNumber
                                                        value="${((dailyRoutine.performance / dailyRoutine.target) * 100)}"
                                                        pattern="#.##"/>%
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </td>
                                <td class="text-center dailyRoutineTarget" contenteditable="true"
                                    onkeydown="return isNumberKey(event)">
                                    <c:choose>
                                        <c:when test="${dailyRoutine.target == null}">
                                            0
                                        </c:when>
                                        <c:otherwise>
                                            ${dailyRoutine.target}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">${dailyRoutine.performance}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <h4 class="fw-bolder">Year Target</h4>
                    <table class="table table-bordered oneThingCalendar text-center align-middle">
                        <thead>
                        <tr>
                            <th class="w-25">Objective</th>
                            <th>Key Results</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="text-start" rowspan="3">Main target</td>
                            <td><input class="form-control yearTarget" type="text"></td>
                        </tr>
                        <tr>
                            <td><input class="form-control yearTarget" type="text"></td>
                        </tr>
                        <tr>
                            <td><input class="form-control yearTarget" type="text"></td>
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
                        <c:forEach var="monthly" varStatus="loop" items="${weekly.monthlys[0].monthlyContents}">
                            <tr>
                                <c:if test="${loop.index == 0}">
                                    <td class="text-start" rowspan="3">Main target</td>
                                </c:if>
                                <td><input class="form-control monthTarget" type="text" value="${monthly}"></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${weekly.monthlys[0].monthlyContents == null}">
                            <c:forEach begin="1" end="${3}" varStatus="loop">
                                <tr>
                                    <c:if test="${loop.index == 1}">
                                        <td class="text-start" rowspan="3">Main target</td>
                                    </c:if>
                                    <td><input class="form-control monthTarget" type="text"></td>
                                </tr>
                            </c:forEach>
                        </c:if>
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
                        <c:set var="theSingleMostImportantThing"
                               value="${weekly.weeklys.weeklys[0]}"/>
                        <tr>
                            <td class="text-start weekTitle"
                                contenteditable="true">${theSingleMostImportantThing.title}</td>
                            <td><input class="form-control weekTarget" name="theSingleMostImportantThing" type="text"
                                       value="${theSingleMostImportantThing.content}">
                            </td>
                        </tr>
                        <c:set var="lecture" value="${weekly.weeklys.weeklys[1]}"/>
                        <tr>
                            <td class="text-start weekTitle" contenteditable="true">${lecture.title}</td>
                            <td><input class="form-control weekTarget" name="lecture" type="text"
                                       value="${lecture.content}">
                            </td>
                        </tr>
                        <c:set var="dailyEvaluation" value="${weekly.weeklys.weeklys[2]}"/>
                        <tr>
                            <td class="text-start weekTitle" contenteditable="true">${dailyEvaluation.title}</td>
                            <td><input class="form-control weekTarget" name="dailyEvaluation" type="text"
                                       value="${dailyEvaluation.content}"></td>
                        </tr>
                        <c:set var="work" value="${weekly.weeklys.weeklys[3]}"/>
                        <tr>
                            <td class="text-start weekTitle" contenteditable="true">${work.title}</td>
                            <td><input class="form-control weekTarget" name="work" type="text" value="${work.content}">
                            </td>
                            </td>
                        </tr>
                        <c:set var="reading" value="${weekly.weeklys.weeklys[4]}"/>
                        <tr>
                            <td class="text-start weekTitle" contenteditable="true">${reading.title}</td>
                            <td><input class="form-control weekTarget" name="reading" type="text"
                                       value="${reading.content}">
                            </td>
                            </td>
                        </tr>
                        </tbody>
                    </table>

                    <h4 class="fw-bolder">A quote I shouldn't forget</h4>
                    <button type="button" class="btn btn-info d-none" id="btn-alarm" data-bs-toggle="modal"
                            data-bs-target=".bs-example-modal-xl">Extra large Modal
                    </button>
                    <table class="table table-bordered oneThingCalendar text-center align-middle">
                        <thead>
                        <tr>
                            <th>Quotes</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>
                                <input class="form-control quotes" type="text" value="${weekly.quotes.content[0]}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input class="form-control quotes" type="text" value="${weekly.quotes.content[1]}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input class="form-control quotes" type="text" value="${weekly.quotes.content[2]}">
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <input class="form-control quotes" type="text" value="${weekly.quotes.content[3]}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input class="form-control quotes" type="text" value="${weekly.quotes.content[4]}">
                            </td>
                        </tr>
                        </tbody>
                    </table>

                    <h4 class="fw-bolder">Category Color</h4>
                    <table class="table table-bordered border-primary categoryColor text-center align-middle">
                        <thead>
                        <tr>
                            <c:forEach items="${weekly.colors}" var="color" varStatus="loop">
                                <th scope="col" class="panel colorPicker"
                                    style="background-color: ${color.color != '' ? color.color : "#FFFFFF"}">
                                    <p class="m-0" contenteditable="true">${color.category}</p>
                                    <div class="pickr"></div>
                                    <p hidden="hidden"
                                       class="pickedColor">${color.color != '' ? color.color : "#FFFFFF"}</p>
                                </th>
                            </c:forEach>
                            <c:if test="${weekly.colors.size() < 4}">
                                <c:forEach begin="${weekly.colors.size()}" end="3">
                                    <th scope="col" class="panel colorPicker"
                                        style="background-color: #FFFFFF;">
                                        <p class="m-0" contenteditable="true">Default Category</p>
                                        <div class="pickr"></div>
                                        <p hidden="hidden" class="pickedColor">#FFFFFF</p>
                                    </th>
                                </c:forEach>
                            </c:if>
                        </tr>

                        </thead>
                        <tbody>
                        <c:forEach begin="0" end="8" var="item" varStatus="loop">
                            <tr>
                                <c:forEach items="${weekly.colors}" var="color">
                                    <td contenteditable="true" class="inputColor">${color.values[loop.index]}</td>
                                </c:forEach>
                                <c:if test="${weekly.colors.size() < 4}">
                                    <c:forEach begin="${weekly.colors.size()}" end="3">
                                        <td contenteditable="true" class="inputColor"></td>
                                    </c:forEach>
                                </c:if>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-8 d-flex">
                    <div class="table-detail">
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
                            <tr class="theSingleMostImportantThing">
                                <td rowspan="5" style="max-width: 5rem;white-space: normal" class="fw-bolder">Onething
                                    calendar
                                </td>
                                <td>${weekly.weeklys.weeklys[0].title}</td>
                            </tr>
                            <tr class="lecture">
                                <td>${weekly.weeklys.weeklys[1].title}</td>
                            </tr>
                            <tr class="dailyEvaluation">
                                <td>${weekly.weeklys.weeklys[2].title}</td>
                            </tr>
                            <tr class="work">
                                <td>${weekly.weeklys.weeklys[3].title}</td>
                            </tr>
                            <tr class="reading">
                                <td>${weekly.weeklys.weeklys[4].title}</td>
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
                                <td></td>
                                <td class="fw-bolder">Process</td>
                            </tr>
                            <tr>
                                <td rowspan="24" style="max-width: 5rem;white-space: normal" class="fw-bolder">
                                    Timeline
                                </td>
                                <td class="fw-bolder">0:00</td>
                            </tr>
                            <c:forEach var="time" begin="1" end="23">
                                <tr>
                                    <c:choose>
                                        <c:when test="${time % 6 == 0}">
                                            <td class="fw-bolder">${time}:00</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>${time}:00</td>
                                        </c:otherwise>
                                    </c:choose>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="table-container" style="max-height: 1870px">
                        <table>
                            <thead>
                            <tr>
                                <c:forEach var="day" items="${weekly.days}">
                                    <th colspan="4" class="fw-bolder"><h5>${day.day}</h5></th>
                                </c:forEach>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <c:forEach var="day" items="${weekly.days}">
                                    <td class="fw-bolder" colspan="3">Target</td>
                                    <td class="fw-bolder">Performance</td>
                                </c:forEach>
                            </tr>
                            <%--one-thing--%>
                            <tr class="theSingleMostImportantThing">
                                <c:forEach var="day" items="${weekly.days}">
                                    <c:set var="theSingleMostImportantThing"
                                           value="${day.data.oneThingCalendar[0]}"/>
                                    <td class="editable-cell" colspan="3" contenteditable="true"
                                        data-name="theSingleMostImportantThing"
                                        data-day="${day.day}">${theSingleMostImportantThing.target}</td>
                                    <td><input class="form-check-input"
                                               type="checkbox" ${theSingleMostImportantThing.performance ? 'checked' : ''}>
                                    </td>
                                </c:forEach>
                            </tr>
                            <tr class="lecture">
                                <c:forEach var="day" items="${weekly.days}">
                                    <c:set var="lecture" value="${day.data.oneThingCalendar[1]}"/>
                                    <td class="editable-cell" colspan="3" contenteditable="true" data-name="lecture"
                                        data-day="${day.day}">${lecture.target}</td>
                                    <td><input class="form-check-input"
                                               type="checkbox" ${lecture.performance ? 'checked' : ''}></td>
                                </c:forEach>
                            </tr>
                            <tr class="dailyEvaluation">
                                <c:forEach var="day" items="${weekly.days}">
                                    <c:set var="dailyEvaluation" value="${day.data.oneThingCalendar[2]}"/>
                                    <td class="editable-cell" colspan="3" contenteditable="true"
                                        data-name="dailyEvaluation"
                                        data-day="${day.day}">${dailyEvaluation.target}</td>
                                    <td><input class="form-check-input"
                                               type="checkbox" ${dailyEvaluation.performance ? 'checked' : ''}></td>
                                </c:forEach>
                            </tr>
                            <tr class="work">
                                <c:forEach var="day" items="${weekly.days}">
                                    <c:set var="work" value="${day.data.oneThingCalendar[3]}"/>
                                    <td class="editable-cell" colspan="3" contenteditable="true" data-name="work"
                                        data-day="${day.day}">${work.target}</td>
                                    <td><input class="form-check-input"
                                               type="checkbox" ${work.performance ? 'checked' : ''}></td>
                                </c:forEach>
                            </tr>
                            <tr class="reading">
                                <c:forEach var="day" items="${weekly.days}">
                                    <c:set var="reading" value="${day.data.oneThingCalendar[4]}"/>
                                    <td class="editable-cell" colspan="3" contenteditable="true" data-name="reading"
                                        data-day="${day.day}">${reading.target}</td>
                                    <td><input class="form-check-input"
                                               type="checkbox" ${reading.performance ? 'checked' : ''}></td>
                                </c:forEach>
                            </tr>

                            <%--to-do--%>
                            <tr name="daily">
                                <c:forEach var="day" items="${weekly.days}">
                                    <c:set value="${day.data.toDoList.sixToTwelvePm[0]}" var="sixToTwelvePm"/>
                                    <td class="editable-cell" colspan="3" contenteditable="true" data-day="${day.day}"
                                        data-name="sixToTwelvePm">${sixToTwelvePm.target}</td>
                                    <td><input class="form-check-input"
                                               type="checkbox" ${sixToTwelvePm.performance ? 'checked' : ''}></td>
                                </c:forEach>
                            </tr>
                            <tr name="daily">
                                <c:forEach var="day" items="${weekly.days}">
                                    <c:set value="${day.data.toDoList.sixToTwelvePm[1]}" var="sixToTwelvePm"/>
                                    <td class="editable-cell" colspan="3" contenteditable="true" data-day="${day.day}"
                                        data-name="sixToTwelvePm">${sixToTwelvePm.target}</td>
                                    <td><input class="form-check-input"
                                               type="checkbox" ${sixToTwelvePm.performance ? 'checked' : ''}></td>
                                </c:forEach>
                            </tr>
                            <tr name="daily">
                                <c:forEach var="day" items="${weekly.days}">
                                    <c:set value="${day.data.toDoList.twelveToSixPm[0]}" var="twelveToSixPm"/>
                                    <td class="editable-cell" colspan="3" contenteditable="true" data-day="${day.day}"
                                        data-name="twelveToSixPm">${twelveToSixPm.target}</td>
                                    <td><input class="form-check-input"
                                               type="checkbox" ${twelveToSixPm.performance ? 'checked' : ''}></td>
                                </c:forEach>
                            </tr>
                            <tr name="daily">
                                <c:forEach var="day" items="${weekly.days}">
                                    <c:set value="${day.data.toDoList.twelveToSixPm[1]}" var="twelveToSixPm"/>
                                    <td class="editable-cell" colspan="3" contenteditable="true" data-day="${day.day}"
                                        data-name="twelveToSixPm">${twelveToSixPm.target}</td>
                                    <td><input class="form-check-input"
                                               type="checkbox" ${twelveToSixPm.performance ? 'checked' : ''}></td>
                                </c:forEach>
                            </tr>
                            <tr name="daily">
                                <c:forEach var="day" items="${weekly.days}">
                                    <c:set value="${day.data.toDoList.sixToTwelveAm[0]}" var="sixToTwelveAm"/>
                                    <td class="editable-cell" colspan="3" contenteditable="true" data-day="${day.day}"
                                        data-name="sixToTwelveAm">${sixToTwelveAm.target}</td>
                                    <td><input class="form-check-input"
                                               type="checkbox" ${sixToTwelveAm.performance ? 'checked' : ''}></td>
                                </c:forEach>
                            </tr>
                            <tr name="daily">
                                <c:forEach var="day" items="${weekly.days}">
                                    <c:set value="${day.data.toDoList.sixToTwelveAm[1]}" var="sixToTwelveAm"/>
                                    <td class="editable-cell" colspan="3" contenteditable="true" data-day="${day.day}"
                                        data-name="sixToTwelveAm">${sixToTwelveAm.target}</td>
                                    <td><input class="form-check-input"
                                               type="checkbox" ${sixToTwelveAm.performance ? 'checked' : ''}></td>
                                </c:forEach>
                            </tr>

                            <%--daily routine--%>
                            <c:forEach var="dailyRoutine" varStatus="loop" begin="0" end="4">
                                <tr name="daily">
                                    <c:forEach var="day" items="${weekly.days}">
                                        <c:set var="dayMonth" value="${fn:substring(day.day, 0, 7)}"/>
                                        <c:choose>
                                            <c:when test="${dayMonth eq weekly.monthlys[0].month}">
                                                <c:set var="dailyRoutine"
                                                       value="${weekly.monthlys[0].dailyRoutine[loop.index]}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="dailyRoutine"
                                                       value="${weekly.monthlys[1].dailyRoutine[loop.index]}"/>
                                            </c:otherwise>
                                        </c:choose>
                                        <td class="editable-cell" colspan="3">${dailyRoutine.title}</td>
                                        <td><input class="form-check-input dailyRoutine"
                                                   type="checkbox" ${day.data.dailyRoutine[loop.index] ? 'checked' : ''}
                                                   data-day="${day.day}"></td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>

                            <%--Gratitude Diary--%>
                            <c:forEach begin="0" end="2" var="entry" varStatus="loop">
                                <tr name="gratitudeDiary">
                                    <c:forEach var="day" items="${weekly.days}">
                                        <c:set var="gratitudeDiary" value="${day.data.gratitudeDiary[loop.index]}"/>
                                        <td colspan="4"><textarea
                                                class="form-control" data-name="gratitudeDiary"
                                                data-day="${day.day}">${gratitudeDiary}</textarea></td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>

                            <%--Affirmation--%>
                            <tr>
                                <c:forEach var="day" items="${weekly.days}">
                                    <c:set var="affirmation" value="${day.data.affirmation}"/>
                                    <td colspan="4">
                                        <textarea class="form-control" data-name="affirmation"
                                                  data-day="${day.day}">${affirmation}</textarea>
                                    </td>
                                </c:forEach>
                            </tr>
                            <%--Compliment--%>
                            <tr>
                                <c:forEach var="day" items="${weekly.days}">
                                    <c:set var="complimentForMeToday" value="${day.data.complimentForMeToday}"/>
                                    <td colspan="4">
                                        <textarea class="form-control" data-name="complimentForMeToday"
                                                  data-day="${day.day}">${complimentForMeToday}</textarea>
                                    </td>
                                </c:forEach>
                            </tr>
                            <%--Reflection--%>
                            <tr>
                                <c:forEach var="day" items="${weekly.days}">
                                    <c:set var="todaysReflectionsAndImprovements"
                                           value="${day.data.todaysReflectionsAndImprovements}"/>
                                    <td colspan="4">
                                        <textarea class="form-control" data-name="todaysReflectionsAndImprovements"
                                                  data-day="${day.day}">${todaysReflectionsAndImprovements}</textarea>
                                    </td>
                                </c:forEach>
                            </tr>
                            <tr>
                                <c:forEach var="day" items="${weekly.days}">
                                    <td class="fw-bolder" colspan="2">Plan</td>
                                    <td class="fw-bolder" colspan="2">Actual</td>
                                </c:forEach>
                            </tr>
                            <%--Timeline--%>
                            <c:forEach var="time" varStatus="loop" begin="0" end="23">
                                <tr name="timeLine" data-value="${time}">
                                    <c:forEach var="day" items="${weekly.days}">
                                        <c:set var="data" value="${day.data.toDoDetail[loop.index]}"/>
                                        <c:set var="backgroundColor0" value=""/>
                                        <c:set var="backgroundColor1" value=""/>
                                        <c:set var="backgroundColor2" value=""/>
                                        <c:set var="backgroundColor3" value=""/>
                                        <c:set var="exitLoop0" value="false"/>
                                        <c:set var="exitLoop1" value="false"/>
                                        <c:set var="exitLoop2" value="false"/>
                                        <c:set var="exitLoop3" value="false"/>
                                        <c:forEach var="color" items="${weekly.colors}">
                                            <c:forEach var="value" items="${color.values}">
                                                <c:if test="${exitLoop0 eq false || exitLoop1 eq false || exitLoop2 eq false || exitLoop3 eq false}">
                                                    <c:if test="${data[0].contentPlan ne '' && value eq data[0].contentPlan}">
                                                        <c:set var="backgroundColor0" value="${color.color}"/>
                                                        <c:set var="exitLoop0" value="true"/>
                                                    </c:if>
                                                    <c:if test="${data[1].contentPlan ne '' && value eq data[1].contentPlan}">
                                                        <c:set var="backgroundColor1" value="${color.color}"/>
                                                        <c:set var="exitLoop1" value="true"/>
                                                    </c:if>
                                                    <c:if test="${data[0].actual ne '' && value eq data[0].actual}">
                                                        <c:set var="backgroundColor2" value="${color.color}"/>
                                                        <c:set var="exitLoop2" value="true"/>
                                                    </c:if>
                                                    <c:if test="${data[1].actual ne '' && value eq data[1].actual}">
                                                        <c:set var="backgroundColor3" value="${color.color}"/>
                                                        <c:set var="exitLoop3" value="true"/>
                                                    </c:if>
                                                </c:if>
                                            </c:forEach>
                                        </c:forEach>

                                        <td style="background-color: ${backgroundColor0}" contenteditable="true"
                                            class="setting"
                                            data-day="${day.day}"
                                            data-name="timeLine">${data[0].contentPlan}
                                            <div class="d-flex d-none note rounded-pill btn-light align-items-center"
                                                 data-value="${data[0].contentNotiPlan}" data-day="${day.day}"
                                                 contenteditable="false"
                                                 onclick="showModal(this)">
                                                <img src="https://cdn-icons-png.flaticon.com/512/4764/4764539.png"
                                                     width="24" height="24" class="me-1">Allow notifications
                                            </div>
                                            <img src="https://cdn-icons-png.flaticon.com/512/4764/4764539.png"
                                                 class="float-end d-none" width="15" height="15">
                                        </td>
                                        <td style="background-color: ${backgroundColor1}" contenteditable="true"
                                            class="setting"
                                            data-day="${day.day}"
                                            data-name="timeLine">${data[1].contentPlan}
                                            <div class="d-flex d-none note rounded-pill btn-light align-items-center"
                                                 data-value="${data[1].contentNotiPlan}" data-day="${day.day}"
                                                 contenteditable="false"
                                                 onclick="showModal(this)">
                                                <img src="https://cdn-icons-png.flaticon.com/512/4764/4764539.png"
                                                     width="24" height="24" class="me-1">Allow notifications
                                            </div>
                                            <img src="https://cdn-icons-png.flaticon.com/512/4764/4764539.png"
                                                 class="float-end d-none" width="15" height="15">
                                        </td>
                                        <td style="background-color: ${backgroundColor2}" contenteditable="true"
                                            data-day="${day.day}"
                                            data-name="timeLine">${data[0].actual}</td>
                                        <td style="background-color: ${backgroundColor3}" contenteditable="true"
                                            data-day="${day.day}"
                                            data-name="timeLine">${data[1].actual}</td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-md-4 text-center align-middle mt-3">
                    <h3>Income this month</h3>
                    <!-- Tables Border Colors -->
                    <table class="table table-bordered border-secondary table-nowrap">
                        <thead>
                        <tr>
                            <th scope="col">ITEM</th>
                            <th scope="col">AMT</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="INCOME"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="INCOME"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="INCOME"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="INCOME"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="INCOME"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="INCOME"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="INCOME"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="INCOME"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td colspan="2">Total: $4,521</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-4 text-center align-middle mt-3">
                    <h3>Fixed costs</h3>
                    <!-- Tables Border Colors -->
                    <table class="table table-bordered border-secondary table-nowrap">
                        <thead>
                        <tr>
                            <th scope="col">ITEM</th>
                            <th scope="col">AMT</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="FIXED"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="FIXED"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="FIXED"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="FIXED"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="FIXED"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="FIXED"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="FIXED"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="FIXED"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td colspan="2">Total: $4,521</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-4 text-center align-middle mt-3">
                    <h3>Fluctuating costs</h3>
                    <!-- Tables Border Colors -->
                    <table class="table table-bordered border-secondary table-nowrap">
                        <thead>
                        <tr>
                            <th scope="col">ITEM</th>
                            <th scope="col">AMT</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="FLUCTUATING"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="FLUCTUATING"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="FLUCTUATING"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="FLUCTUATING"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="FLUCTUATING"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="FLUCTUATING"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="FLUCTUATING"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td contenteditable="true" class="item"></td>
                            <td contenteditable="true" class="amt" data-name="FLUCTUATING"
                                oninput="validateNumberInput(event)"></td>
                        </tr>
                        <tr>
                            <td colspan="2">Total: $4,521</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-12 text-center align-middle mt-3">
                    <button class="btn btn-primary mr-2" id="backButton" onclick="history.back()">
                        Back
                    </button>
                    <button class="btn btn-success ml-2" id="updateButton">Save</button>
                </div>
            </div>
        </div>
    </div> <!-- end row-->
</div>

<!-- Modal Content Allowed Notification -->
<div class="modal fade" id="contentNoti" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body text-center p-5">
                <h5>Content Notification:</h5>
                <textarea class="form-control" id="contentNotiPlan" placeholder="Enter here..."></textarea>

                <div class="mt-4">
                    <div class="hstack gap-2 justify-content-center">
                        <a href="javascript:void(0);" class="btn btn-link link-success fw-medium"
                           data-bs-dismiss="modal" id="cancelSaveNoti"><i class="ri-close-line me-1 align-middle"></i>
                            Close</a>
                        <a href="javascript:void(0);" class="btn btn-success" id="saveNoti">Save</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
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

<div class="modal fade bs-example-modal-xl" tabindex="-1" aria-labelledby="myExtraLargeModalLabel"
     style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title text-danger" id="myExtraLargeModalLabel">Important warning</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <h6 class="fs-16 my-3">Schedules</h6>
                <div class="d-flex">
                    <div class="flex-shrink-0">
                        <i class="mdi mdi-clock-edit-outline text-warning fs-5"></i>
                    </div>
                    <div class="flex-grow-1 ms-2">
                        <p class="text-muted mb-0" id="noti1"></p>
                    </div>
                </div>
                <div class="d-flex">
                    <div class="flex-shrink-0">
                        <i class="mdi mdi-clock-edit-outline text-warning fs-5"></i>
                    </div>
                    <div class="flex-grow-1 ms-2">
                        <p class="text-muted mb-0" id="noti2"></p>
                    </div>
                </div>
                <h6 class="fs-16 my-3">Quotes You shouldn't forget</h6>
                <div class="d-flex mt-2 notiQuote">
                    <div class="flex-shrink-0">
                        <i class="mdi mdi-comment-quote-outline text-primary fs-5"></i>
                    </div>
                    <div class="flex-grow-1 ms-2">
                        <p class="text-muted mb-0">${weekly.quotes.content[0]}</p>
                    </div>
                </div>
                <div class="d-flex mt-2 notiQuote">
                    <div class="flex-shrink-0">
                        <i class="mdi mdi-comment-quote-outline text-primary fs-5"></i>
                    </div>
                    <div class="flex-grow-1 ms-2">
                        <p class="text-muted mb-0">${weekly.quotes.content[1]}</p>
                    </div>
                </div>
                <div class="d-flex mt-2 notiQuote">
                    <div class="flex-shrink-0">
                        <i class="mdi mdi-comment-quote-outline text-primary fs-5"></i>
                    </div>
                    <div class="flex-grow-1 ms-2">
                        <p class="text-muted mb-0">${weekly.quotes.content[2]}</p>
                    </div>
                </div>
                <div class="d-flex mt-2 notiQuote">
                    <div class="flex-shrink-0">
                        <i class="mdi mdi-comment-quote-outline text-primary fs-5"></i>
                    </div>
                    <div class="flex-grow-1 ms-2">
                        <p class="text-muted mb-0">${weekly.quotes.content[3]}</p>
                    </div>
                </div>
                <div class="d-flex mt-2 notiQuote">
                    <div class="flex-shrink-0">
                        <i class="mdi mdi-comment-quote-outline text-primary fs-5"></i>
                    </div>
                    <div class="flex-grow-1 ms-2">
                        <p class="text-muted mb-0">${weekly.quotes.content[4]}</p>
                    </div>
                </div>
            </div>
            <div class="modal-footer ms-2">
                <div class="ml-auto">
                    <a href="javascript:void(0);" class="btn w-sm btn-primary fw-medium" data-bs-dismiss="modal">
                        OK
                    </a>
                </div>
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
<script src="/assets/libs/@simonwep/pickr/pickr.min.js"></script>
<script src="/assets/custom/js/management-time/management-time.js"></script>
<script src="/assets/libs/sweetalert2/sweetalert2.min.js"></script>
<script>
    function validateNumberInput(event) {
        var inputText = event.target.textContent;

        var numericValue = inputText.replace(/[^\d]/g, '');

        event.target.textContent = numericValue;
        placeCaretAtEnd(event.target);
    }

    function placeCaretAtEnd(el) {
        var range = document.createRange();
        var sel = window.getSelection();
        range.selectNodeContents(el);
        range.collapse(false);
        sel.removeAllRanges();
        sel.addRange(range);
        el.focus();
    }

    function checkRow(row) {
        var date = new Date();
        var day = row.querySelectorAll('td[data-name="timeLine"] .note');
        var dateSystem = date.toISOString().split('T')[0];
        var hoursSystem = date.getHours();
        var hoursValue = row.getAttribute('data-value');

        var noti1 = null;
        var noti2 = null;

        day.forEach(function (div) {
            var dataDay = div.getAttribute('data-day');
            if (dataDay == dateSystem) {
                if (hoursValue == hoursSystem) {
                    var divValue = div.getAttribute('data-value');

                    if (noti1 === null) {
                        noti1 = divValue;
                    } else if (noti2 === null) {
                        noti2 = divValue;
                    }
                }
            }
        });

        if (noti1 !== null) {
            if (noti1 != '') document.getElementById('noti1').innerText = 'Notice at ' + hoursValue + ':00' + ' you have an activity: ' + '"' + noti1 + '"';
            else document.getElementById('noti1').innerText = 'At ' + hoursValue + ':00 you have no notifications.';
        }

        if (noti2 !== null) {
            if (noti2 != '') document.getElementById('noti2').innerText = 'Notice at ' + hoursValue + ':30' + ' you have an activity: ' + '"' + noti2 + '"';
            else document.getElementById('noti2').innerText = 'At ' + hoursValue + ':30 you have no notifications.';
        }

        if ((noti1 != '' && noti1 != null) || (noti2 != '' && noti2 != null)) {

            document.getElementById('btn-alarm').click();
        }
    }

    document.addEventListener("DOMContentLoaded", function () {
        var rows = document.querySelectorAll('tr[name="timeLine"]');
        rows.forEach(function (row) {
            checkRow(row);
        });
    });

    document.addEventListener("DOMContentLoaded", function () {
        var quotes = document.querySelectorAll('.notiQuote');
        quotes.forEach(function (quote) {
            if (quote.querySelector('p').textContent == '') $(quote).remove();
        });
    });

    function setWithExpiry(key, value, ttl) {
        const now = new Date();
        const item = {
            value: value,
            expiry: now.getTime() + ttl,
        };
        localStorage.setItem(key, JSON.stringify(item));
    }

    function getWithExpiry(key) {
        const itemString = localStorage.getItem(key);
        if (!itemString) {
            return null;
        }
        const item = JSON.parse(itemString);
        const now = new Date();
        if (now.getTime() > item.expiry) {
            localStorage.removeItem(key);
            return null;
        }
        return item.value;
    }

    document.addEventListener("DOMContentLoaded", function () {
        var plant = document.querySelectorAll('.setting');
        plant.forEach(function (elementPlant) {
            const note = elementPlant.querySelector('.note');
            const imgNoti = note.querySelector('img');
            elementPlant.addEventListener('contextmenu', function (event) {
                if (elementPlant.innerText != '') {
                    const contentNotiPlan = note.getAttribute('data-value');
                    if (contentNotiPlan != '') {
                        const imgHTML = imgNoti.outerHTML;
                        note.innerHTML = imgHTML + 'Remove Allowed';
                    }
                    const isAllowed = note.innerText.trim();
                    if (note) {
                        $(note).removeClass('d-none');
                        if (isAllowed == 'Allow notifications') {
                            note.addEventListener('click', function (e) {
                                $(note).addClass('d-none');
                                elementPlant.querySelectorAll('img')[1].classList.remove('d-none');
                                note.innerHTML = '';
                                note.appendChild(imgNoti);
                                note.appendChild(document.createTextNode('Remove Allowed'));
                            })
                        } else if (isAllowed == 'Remove Allowed') {
                            note.addEventListener('click', function (e) {
                                const imgIconPlan = elementPlant.querySelectorAll('img')[1];
                                imgIconPlan.classList.add('d-none');
                                note.innerHTML = '';
                                note.appendChild(imgNoti);
                                note.appendChild(document.createTextNode('Allow notifications'));
                                note.setAttribute('data-value', '');
                                $(note).addClass('d-none');
                            })
                        }
                    }

                    event.preventDefault();
                    document.addEventListener('click', function hideNoteOnClickOutside(e) {
                        if (!note.contains(e.target) && e.target !== note) {
                            $(note).addClass('d-none');
                            document.removeEventListener('click', hideNoteOnClickOutside);
                        }
                    });
                } else event.preventDefault();
            });
        })
    })

    document.addEventListener("DOMContentLoaded", function () {
        var plant = document.querySelectorAll('.setting');
        plant.forEach(function (elementPlant) {
            const note = elementPlant.querySelector('.note');
            const contentNotiPlan = note.getAttribute('data-value');
            if (contentNotiPlan == '' || contentNotiPlan == null) elementPlant.querySelectorAll('img')[1].classList.add('d-none');
            else elementPlant.querySelectorAll('img')[1].classList.remove('d-none');
        })
    })

    function showModal(element) {
        const isAllowedNoti = element.innerText;

        function saveNotiHandler() {
            var contentNotiPlant = document.getElementById('contentNotiPlan').value;
            element.setAttribute('data-value', contentNotiPlant);
            console.log(contentNotiPlant);
            $('#contentNoti').modal('hide');
            document.getElementById('contentNotiPlan').value = '';
            document.getElementById('saveNoti').removeEventListener('click', saveNotiHandler);
        }

        if (isAllowedNoti == 'Allow notifications') {
            $('#contentNoti').modal('show');
            document.getElementById('cancelSaveNoti').addEventListener('click', function () {
                const imgNoti = element.querySelector('img').outerHTML;
                element.innerHTML = imgNoti + 'Allow notifications';
                element.nextElementSibling.classList.add('d-none');
            });
            document.getElementById('saveNoti').removeEventListener('click', saveNotiHandler);
            document.getElementById('saveNoti').addEventListener('click', saveNotiHandler);
        }


    }

    document.addEventListener("DOMContentLoaded", function () {
        $(".containerLoading").addClass("d-none")
        $("div.calendar-container").removeClass("d-none")

        const result = localStorage.getItem('result');
        if (result == 'addSuccess') {
            rsSuccessLoad("Add");
            localStorage.clear();
        }
    })

    window.addEventListener('beforeunload', function (event) {
        $(".containerLoading").removeClass("d-none");
        $("div.calendar-container").addClass("d-none")
    });

    $('td.dailyRoutineTarget').on('blur', function () {
        const target = $(this).text();
        if (target > 31 || target < 0) {
            validateFail("Daily target shouldn't exceed 30 or below 0");
            return false;
        }
    });

    const inputString = '${weekly.colors}';
    const valuesRegex = /\bvalues=\[(.*?)\]/g;
    const matches = inputString.match(valuesRegex);
    let allValues = matches ? matches.map(match => {
        const innerValues = match.replace('values=[', '').replace(']', '');
        return innerValues.split(',').map(value => value.trim());
    }).flat() : [];

    $('td.inputColor').on('blur', function () {
        allValues = [];
        $('td.inputColor').each(function () {
            const target = $(this).text().trim();
            if (target !== '') {
                allValues.push(target);
            }
        });
    });

    $(document).ready(function () {
        checkInitialValue();

        $('td.editable-cell').on('input', function () {
            checkInitialValue();
        });
    });

    function checkInitialValue() {
        $('.editable-cell').each(function () {
            var cellValue = $(this).text().trim();
            var checkbox = $(this).next().find('.form-check-input');
            if (cellValue === '' || cellValue === null) {
                checkbox.prop('disabled', true);
            } else {
                checkbox.prop('disabled', false);
            }
        });
    }

    function isNumberKey(evt) {
        var charCode = (evt.which) ? evt.which : evt.keyCode;

        if ((charCode >= 48 && charCode <= 57) || (charCode >= 96 && charCode <= 105)) {
            return true;
        } else {
            evt.preventDefault();
            return false;
        }
    }

    $("#updateButton").click(function () {
        if (hasDuplicates(allValues)) {
            validateFail("Keyword should not be same");
        } else {
            $(this).prop('disabled', true);
            $("div.containerLoading").removeClass("d-none")
            $("div.calendar-container").addClass("d-none")
            const currentYearMonth = getCurrentYearMonth();
            const data = {
                userId: '${user.id}',
                days: [],
                weekly: {},
                monthly: {},
                colors: [],
                quotes: [],
                year: {}
            }

            const colors = [];
            $('th.colorPicker').each(function () {
                const category = $(this).find('p:first').text().trim();
                const color = $(this).find('.pickedColor').text().trim();
                const values = [];
                const columnIndex = $(this).index();
                $('table.categoryColor tbody tr').each(function () {
                    const value = $(this).find('td:eq(' + columnIndex + ')').text().trim();
                    if (value !== '') {
                        values.push(value);
                    }
                })
                colors.push({
                    category: category,
                    color: color,
                    values: values
                })
            })
            data.colors = colors;
            const monthly = {
                month: currentYearMonth.year + '-' + (currentYearMonth.month < 10 ? '0' + currentYearMonth.month : currentYearMonth.month),
                content: [],
                dailyRoutine: [],
                costs: []
            };
            const weekly = {
                startDay: getPreviousSunday(currentYearMonth.currentDayParam),
                weeklys: []
            };
            $('.monthTarget').each(function () {
                monthly.content.push($(this).val())
            });
            $('input.dailyRoutineInput').each(function () {
                let obj = {
                    title: $(this).val(),
                    target: $(this).closest('tr').find('.dailyRoutineTarget').text()
                }
                monthly.dailyRoutine.push(obj)
            })
            data.monthly = monthly;

            $("input.form-control.weekTarget").each(function () {
                let obj = {
                    title: $(this).closest('tr').find('.weekTitle').text(),
                    content: $(this).val()
                }
                weekly.weeklys.push(obj)
            })
            data.weekly = weekly
            const days = [];
            $('textarea').each(function () {
                const day = $(this).data('day');
                const value = $(this).val();

                let dayObj = days.find(d => d.day === day);
                if (value !== "") {
                    if (day != null) {
                        if (!dayObj) {
                            dayObj = {
                                day: day,
                                data: {
                                    oneThingCalendar: [],
                                    gratitudeDiary: getTextAreaValuesByDayAndClass(day, 'gratitudeDiary'),
                                    complimentForMeToday: getTextAreaValuesByDayAndClass(day, 'complimentForMeToday'),
                                    todaysReflectionsAndImprovements: getTextAreaValuesByDayAndClass(day, 'todaysReflectionsAndImprovements'),
                                    affirmation: getTextAreaValuesByDayAndClass(day, 'affirmation'),
                                    toDoDetail: [],
                                    dailyRoutine: getDailyRoutineList(day, 'dailyRoutine'),
                                    toDoList: {
                                        sixToTwelvePm: [],
                                        twelveToSixPm: [],
                                        sixToTwelveAm: []
                                    }
                                }
                            };
                            days.push(dayObj);
                        }
                    }
                }
            })
            $('input[type="checkbox"].dailyRoutine').each(function () {
                const day = $(this).data('day');
                const isChecked = $(this).prop('checked');

                let dayObj = days.find(d => d.day === day);
                if (isChecked !== false) {
                    if (day != null) {
                        if (!dayObj) {
                            dayObj = {
                                day: day,
                                data: {
                                    oneThingCalendar: [],
                                    gratitudeDiary: getTextAreaValuesByDayAndClass(day, 'gratitudeDiary'),
                                    complimentForMeToday: getTextAreaValuesByDayAndClass(day, 'complimentForMeToday'),
                                    todaysReflectionsAndImprovements: getTextAreaValuesByDayAndClass(day, 'todaysReflectionsAndImprovements'),
                                    affirmation: getTextAreaValuesByDayAndClass(day, 'affirmation'),
                                    toDoDetail: [],
                                    dailyRoutine: getDailyRoutineList(day, 'dailyRoutine'),
                                    toDoList: {
                                        sixToTwelvePm: [],
                                        twelveToSixPm: [],
                                        sixToTwelveAm: []
                                    }
                                }
                            };
                            days.push(dayObj);
                        }
                    }
                }
            })
            $('td[contenteditable="true"]').each(function () {
                const day = $(this).data('day');
                const name = $(this).data('name');
                const value = $(this).text().trim();
                const isChecked = $(this).next().find('input[type="checkbox"]').prop('checked');

                let dayObj = days.find(d => d.day === day);
                if (value !== "") {
                    if (day != null) {
                        if (!dayObj) {
                            dayObj = {
                                day: day,
                                data: {
                                    oneThingCalendar: [],
                                    gratitudeDiary: getTextAreaValuesByDayAndClass(day, 'gratitudeDiary'),
                                    complimentForMeToday: getTextAreaValuesByDayAndClass(day, 'complimentForMeToday'),
                                    todaysReflectionsAndImprovements: getTextAreaValuesByDayAndClass(day, 'todaysReflectionsAndImprovements'),
                                    affirmation: getTextAreaValuesByDayAndClass(day, 'affirmation'),
                                    toDoDetail: [],
                                    dailyRoutine: getDailyRoutineList(day, 'dailyRoutine'),
                                    toDoList: {
                                        sixToTwelvePm: [],
                                        twelveToSixPm: [],
                                        sixToTwelveAm: []
                                    }
                                }
                            };
                            days.push(dayObj);
                        }
                    }
                }
                if (dayObj) {
                    if (name === 'sixToTwelvePm' || name === 'twelveToSixPm' || name === 'sixToTwelveAm') {
                        dayObj.data.toDoList[name].push({
                            target: value,
                            performance: isChecked
                        });
                    } else if (name !== 'timeLine') {
                        dayObj.data.oneThingCalendar.push({
                            target: value,
                            performance: isChecked
                        });
                    }
                }
            })

            $('tr[name="timeLine"]').each(function () {
                $(this).find('td[data-name="timeLine"]').each(function (index) {
                    const day = $(this).data('day');
                    var value = $(this).contents().filter(function () {
                        return this.nodeType === 3;
                    }).text().trim();
                    var contentPlan = $(this).find('div').first().data('value');
                    let dayObj = days.find(d => d.day === day);
                    if (value !== "") {
                        if (day != null) {
                            if (!dayObj) {
                                dayObj = {
                                    day: day,
                                    data: {
                                        oneThingCalendar: [],
                                        gratitudeDiary: getTextAreaValuesByDayAndClass(day, 'gratitudeDiary'),
                                        complimentForMeToday: getTextAreaValuesByDayAndClass(day, 'complimentForMeToday'),
                                        todaysReflectionsAndImprovements: getTextAreaValuesByDayAndClass(day, 'todaysReflectionsAndImprovements'),
                                        affirmation: getTextAreaValuesByDayAndClass(day, 'affirmation'),
                                        toDoDetail: [],
                                        dailyRoutine: getDailyRoutineList(day, 'dailyRoutine'),
                                        toDoList: {
                                            sixToTwelvePm: [],
                                            twelveToSixPm: [],
                                            sixToTwelveAm: []
                                        }
                                    }
                                };
                                days.push(dayObj);
                            }
                        }
                    }
                    if (dayObj) {
                        if ((index + 1) % 4 === 1) {
                            dayObj.data.toDoDetail.push([
                                {contentPlan: value, contentNotiPlan: contentPlan, actual: ''},
                                {contentPlan: '', contentNotiPlan: '', actual: ''}
                            ]);
                        } else if ((index + 1) % 4 === 2) {
                            dayObj.data.toDoDetail[dayObj.data.toDoDetail.length - 1][1].contentPlan = value;
                            dayObj.data.toDoDetail[dayObj.data.toDoDetail.length - 1][1].contentNotiPlan = contentPlan;
                        } else if ((index + 1) % 4 === 3) {
                            dayObj.data.toDoDetail[dayObj.data.toDoDetail.length - 1][0].actual = value;
                        } else if ((index + 1) % 4 === 0) {
                            dayObj.data.toDoDetail[dayObj.data.toDoDetail.length - 1][1].actual = value;
                        }
                    }
                });
            });

            const quotes = [];
            document.querySelectorAll('.quotes').forEach(function (quote) {
                quotes.push(quote.value);
            });

            var items = document.querySelectorAll('.item');
            var amts = document.querySelectorAll('.amt');
            items.forEach(function (item, index) {
                var objConsts = {
                    item: item.textContent,
                    amt: amts[index].textContent,
                    type: amts[index].getAttribute('data-name')
                }
                if (objConsts.item != '' && objConsts.amt != '') {
                    data.monthly.costs.push(objConsts);
                }
            })

            var queryString = window.location.search;
            var urlParams = new URLSearchParams(queryString);
            var currentDayParam = urlParams.get('currentDay');
            var currentDate = new Date(currentDayParam);
            var year = currentDate.getFullYear().toString();

            data.year = {
                year: year,
                target: []
            };

            var yearTarget = document.querySelectorAll('.yearTarget');
            yearTarget.forEach(function (target) {
                data.year.target.push(target.value);
            })

            data.days.push(...days);
            data.quotes.push(...quotes);
            console.log(data)
            // callAjaxByJsonWithData("/api/v1/management-time/weekly-detail", "POST", data, function (rs) {
            //     if (rs) {
            //         $("div.containerLoading").addClass("d-none")
            //         $("div.calendar-container").removeClass("d-none")
            //         localStorage.setItem('result', 'addSuccess');
            //         window.location.reload();
            //     } else {
            //         rsUnSuccess();
            //         $("div.containerLoading").addClass("d-none")
            //         $("div.calendar-container").removeClass("d-none")
            //     }
            // })
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

    function getTextAreaValuesByDayAndClass(day, className) {
        const selector = 'textarea[data-day="' + day + '"][data-name="' + className + '"]';
        const textareas = $(selector);

        if (textareas.length >= 2) {
            const values = textareas.map(function () {
                return $(this).val();
            }).get();
            return values;
        } else if (textareas.length > 0) {
            return textareas.first().val() || "";
        } else {
            return "";
        }
    }

    function getDailyRoutineList(day, className) {
        var dailyRoutineList = [];

        var selector = 'input.' + className + '[data-day="' + day + '"]';

        $(selector).each(function () {
            var isChecked = $(this).prop('checked');
            dailyRoutineList.push(isChecked);
        });
        return dailyRoutineList;
    }

    function getCurrentYearMonth() {
        let currentURL = window.location.href;
        const url = new URL(currentURL);
        let urlSearchParams = new URLSearchParams(url.search);
        let currentDayParam = urlSearchParams.get("currentDay");
        let currentDate = new Date(currentDayParam);
        let month = currentDate.getMonth() + 1;
        let year = currentDate.getFullYear();
        return {
            month,
            year,
            currentDayParam
        };
    }

    function getPreviousSunday(currentDate) {
        const dateObject = new Date(currentDate);

        let currentDayOfWeek = dateObject.getDay();

        let daysToSubtract = currentDayOfWeek === 0 ? 0 : currentDayOfWeek;

        const sundayDate = new Date(dateObject);
        sundayDate.setDate(dateObject.getDate() - daysToSubtract);

        return sundayDate.toISOString().split('T')[0];
    }

    function hasDuplicates(array) {
        const obj = {};
        for (let i = 0; i < array.length; i++) {
            if (array[i] !== '') {
                if (obj[array[i]]) {
                    return true;
                }
                obj[array[i]] = true;
            }
        }
        return false;
    }
</script>
</body>
</html>
