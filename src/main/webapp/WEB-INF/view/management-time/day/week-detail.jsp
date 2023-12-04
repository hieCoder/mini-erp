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
                                <td class="text-center dailyRoutineTarget" contenteditable="true">
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
                    <h4 class="fw-bolder">Category Color</h4>
                    <table class="table table-bordered border-primary categoryColor text-center align-middle">
                        <thead>
                        <tr>
                            <c:forEach items="${weekly.colors}" var="color" varStatus="loop">
                                <th scope="col" contenteditable="true" class="panel colorPicker"
                                    style="background-color: ${color.color != '' ? color.color : "#FFFFFF"}">
                                        ${color.category}
                                    <div class="pickr"></div>
                                    <p hidden="hidden"
                                       class="pickedColor">${color.color != '' ? color.color : "#FFFFFF"}</p>
                                </th>
                            </c:forEach>
                            <c:if test="${weekly.colors.size() < 4}">
                                <c:forEach begin="${weekly.colors.size()}" end="3">
                                    <th scope="col" contenteditable="true" class="panel colorPicker"
                                        style="background-color: #FFFFFF;">
                                        Default Category
                                        <div class="pickr"></div>
                                        <p hidden="hidden" class="pickedColor">#FFFFFF</p>
                                    </th>
                                </c:forEach>
                            </c:if>
                        </tr>

                        </thead>
                        <tbody>
                        <c:forEach begin="0" end="12" var="item" varStatus="loop">
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

                    <div class="table-container">
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
                                <tr name="timeLine">
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
                                                    <c:if test="${data[0] ne '' && value eq data[0]}">
                                                        <c:set var="backgroundColor0" value="${color.color}"/>
                                                        <c:set var="exitLoop0" value="true"/>
                                                    </c:if>
                                                    <c:if test="${data[1] ne '' && value eq data[1]}">
                                                        <c:set var="backgroundColor1" value="${color.color}"/>
                                                        <c:set var="exitLoop1" value="true"/>
                                                    </c:if>
                                                    <c:if test="${data[2] ne '' && value eq data[2]}">
                                                        <c:set var="backgroundColor2" value="${color.color}"/>
                                                        <c:set var="exitLoop2" value="true"/>
                                                    </c:if>
                                                    <c:if test="${data[3] ne '' && value eq data[3]}">
                                                        <c:set var="backgroundColor3" value="${color.color}"/>
                                                        <c:set var="exitLoop3" value="true"/>
                                                    </c:if>
                                                </c:if>
                                            </c:forEach>
                                        </c:forEach>

                                        <td style="background-color: ${backgroundColor0}" contenteditable="true"
                                            data-day="${day.day}"
                                            data-name="timeLine">${data[0]}</td>
                                        <td style="background-color: ${backgroundColor1}" contenteditable="true"
                                            data-day="${day.day}"
                                            data-name="timeLine">${data[1]}</td>
                                        <td style="background-color: ${backgroundColor2}" contenteditable="true"
                                            data-day="${day.day}"
                                            data-name="timeLine">${data[2]}</td>
                                        <td style="background-color: ${backgroundColor3}" contenteditable="true"
                                            data-day="${day.day}"
                                            data-name="timeLine">${data[3]}</td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
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
<script src="/assets/libs/@simonwep/pickr/pickr.min.js"></script>
<script src="/assets/custom/js/management-time/management-time.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        $(".containerLoading").addClass("d-none")
        $("div.calendar-container").removeClass("d-none")
    })

    $('td.dailyRoutineTarget').on('blur', function () {
        const target = $(this).text();
        if (target > 31 || target < 0) {
            $(this).text('0');
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
        const target = $(this).text();
        if (allValues.includes(target)) {
            $(this).text('');
            validateFail("Keyword should not be same");
        }
        allValues = [];
        $('td.inputColor').each(function () {
            const target = $(this).text().trim();
            if (target !== '') {
                allValues.push(target);
            }
        });
        console.log(allValues);
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

    $("#updateButton").click(function () {
        $(this).prop('disabled', true);
        $("div.containerLoading").removeClass("d-none")
        $("div.calendar-container").addClass("d-none")
        const currentYearMonth = getCurrentYearMonth();
        const data = {
            userId: '${user.id}',
            days: [],
            weekly: {},
            monthly: {},
            colors: []
        }

        const colors = [];
        $('th.colorPicker').each(function () {
            const category = $(this).contents().filter(function() {
                return this.nodeType === 3;
            }).first().text().trim();
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
                category : category,
                color : color,
                values : values
            })
        })
        data.colors = colors;
        const monthly = {
            month: currentYearMonth.year + '-' + (currentYearMonth.month < 10 ? '0' + currentYearMonth.month : currentYearMonth.month),
            content: [],
            dailyRoutine: []
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
            let weeklyData = [];
            $(this).find('td[data-name="timeLine"]').each(function (index) {
                const day = $(this).data('day');
                var value = $(this).text().trim();
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
                    weeklyData.push(value);
                    if ((index + 1) % 4 === 0) {
                        console.log(weeklyData);
                        dayObj.data.toDoDetail.push(weeklyData);
                        weeklyData = [];
                    }
                }
            })
        })
        data.days.push(...days);
        console.log(data);
        callAjaxByJsonWithData("/api/v1/management-time/weekly-detail", "POST", data, function (rs) {
            if (rs) {
                rsSuccessLoad("Add");
                $("div.containerLoading").addClass("d-none")
                $("div.calendar-container").removeClass("d-none")
            } else {
                rsUnSuccess();
                $("div.containerLoading").addClass("d-none")
                $("div.calendar-container").removeClass("d-none")
            }
        })
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
</script>
</body>
</html>
