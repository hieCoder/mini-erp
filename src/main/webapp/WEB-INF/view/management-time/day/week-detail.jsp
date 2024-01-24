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
        #addDaily{
            position: absolute;
            top: 0;
            left: 51%;
            transform: translate(-50%, -50%);
            padding: 4px;
            border-radius: 50%;
            display: flex;
            align-items: center;
        }

        .w-100px {
            width: 100px;
        }

        .target-onething {
            max-width: 110px;
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

        #lectureCategory {
            background-color: #fcecec;
        }

        #dailyCategory {
            background-color: #e6f0e2;
        }

        #workCategory {
            background-color: #fff9e6;
        }

        #readingCategory {
            background-color: #e9e4f5;
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
    <div class="col-12 p-0" id="tab-session">
       <div class="col-6">
           <ul class="nav nav-tabs nav-tabs-custom nav-primary nav-justified bg-white fs-5" role="tablist">
               <li class="nav-item">
                   <a class="nav-link active" data-bs-toggle="tab" href="#calendar" role="tab" aria-selected="false">
                       <i class=" ri-calendar-todo-line align-middle me-1"></i>Planner
                   </a>
                   <div class="btn-group w-100 mt-2">
                       <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">TABS</button>
                       <div class="dropdown-menu">
                           <a class="dropdown-item nav-link" data-bs-toggle="tab"  role="tab" aria-selected="false">
                               2024 Goals
                           </a>
                           <a class="dropdown-item nav-link management-time-year">
                               2024 Calendar
                           </a>
                           <a class="dropdown-item nav-link management-time-month">
                               Monthly
                           </a>
                           <a class="dropdown-item nav-link management-time-week">
                               Weekly
                           </a>
                           <a class="dropdown-item nav-link" data-bs-toggle="tab" role="tab" aria-selected="false">
                               Daily Schedule
                           </a>
                           <a class="dropdown-item nav-link" id="session-review" data-bs-toggle="tab" href="#review" role="tab" aria-selected="false">
                               W&M Report
                           </a>
                           <a class="dropdown-item nav-link" data-bs-toggle="tab"  role="tab" aria-selected="false">
                               2024 Report
                           </a>
                       </div>
                   </div>

               </li>
               <li class="nav-item">
                   <a class="nav-link" id="session-checkBook" data-bs-toggle="tab" href="#check-book" role="tab" aria-selected="false">
                       <i class="ri-book-mark-line me-1 align-middle"></i>Check Book
                   </a>
               </li>
               <li class="nav-item">
                   <a class="nav-link" id="session-financial" data-bs-toggle="tab" href="#financial" role="tab" aria-selected="false">
                       <i class="ri-coins-line align-middle me-1"></i>Financial Ledger
                   </a>
               </li>
           </ul>
       </div>
    </div>
    <div class="tab-content">
        <div class="tab-pane active" id="calendar" role="tabpanel">
            <div class="row calendar-container d-none" data-date="${day}" data-id="${dayResponse.id}">
                <div class="card">
                    <div class="row card-body">
                        <div class="col-md-4">
                            <div class="d-flex align-items-center justify-content-between">
                                <div>
                                    <h4 class="fw-bolder">One Thing Calendar</h4>
                                    <h5 class="fst-italic">Performance Overview</h5>
                                </div>
                                <!-- Default Modals -->
                                <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#myModal"
                                        id="expenseManagement">Expense management
                                </button>
                            </div>
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
                                <%-- OneThing Calendar Session --%>
                                <c:set var="theSingleMostImportantThing" value="${weekly.weeklys.weeklys[0]}"/>
                                <tr style="background-color: ${weekly.monthlys[0].color[0]}" class="text-center">
                                    <td class="text-start" rowspan="5" style="background-color: #ffffff !important;">Onething calendar</td>
                                    <td><input class="form-control text-danger fw-bolder" type="text" value="Important matter" disabled></td>
                                    <td class="text-center rate-onething" style="width: 75px;"></td>
                                    <td class="text-center target-onething" contenteditable="true"  onkeydown="return isNumberKey(event)">
                                        ${weekly.monthlys[0].targetCategory[0] == null ? 0 : weekly.monthlys[0].targetCategory[0].target}
                                    </td>
                                    <td class="text-center performance-onething">
                                        <c:set var="sum" value="0" />
                                        <c:forEach var="item" items="${weekly.getPerformace}">
                                            <c:set var="target" value="${item.data[0].performance}" />
                                            <c:if test="${target eq true}">
                                                <c:set var="sum" value="${sum + 1}" />
                                            </c:if>
                                        </c:forEach>
                                        ${sum}
                                    </td>
                                </tr>
                                <c:set var="lecture" value="${weekly.weeklys.weeklys[1]}"/>
                                <tr style="background-color: ${weekly.monthlys[0].color[1] == null ? '#fcecec' : weekly.monthlys[0].color[1]}">
                                    <td><input class="form-control" type="text" value="${weekly.year.category[1]}" disabled></td>
                                    <td class="text-center rate-onething" style="width: 75px;"></td>
                                    <td class="text-center target-onething" contenteditable="true"  onkeydown="return isNumberKey(event)">
                                        ${weekly.monthlys[0].targetCategory[1] == null ? 0 : weekly.monthlys[0].targetCategory[1].target}
                                    </td>
                                    <td class="text-center performance-onething">
                                        <c:set var="sum" value="0" />
                                        <c:forEach var="item" items="${weekly.getPerformace}">
                                            <c:set var="target" value="${item.data[1].performance}" />
                                            <c:if test="${target eq true}">
                                                <c:set var="sum" value="${sum + 1}" />
                                            </c:if>
                                        </c:forEach>
                                        ${sum}
                                    </td>
                                </tr>
                                <c:set var="dailyEvaluation" value="${weekly.weeklys.weeklys[2]}"/>
                                <tr style="background-color:  ${weekly.monthlys[0].color[2] == null ? '#e6f0e2' : weekly.monthlys[0].color[2]}">
                                    <td><input class="form-control" type="text" value="${weekly.year.category[2]}" disabled></td>
                                    <td class="text-center rate-onething" style="width: 75px;"></td></td>
                                    <td class="text-center target-onething" contenteditable="true"  onkeydown="return isNumberKey(event)">
                                        ${weekly.monthlys[0].targetCategory[2] == null ? 0 : weekly.monthlys[0].targetCategory[2].target}
                                    </td>
                                    <td class="text-center performance-onething">
                                        <c:set var="sum" value="0" />
                                        <c:forEach var="item" items="${weekly.getPerformace}">
                                            <c:set var="target" value="${item.data[2].performance}" />
                                            <c:if test="${target eq true}">
                                                <c:set var="sum" value="${sum + 1}" />
                                            </c:if>
                                        </c:forEach>
                                        ${sum}
                                    </td>
                                </tr>
                                <c:set var="work" value="${weekly.weeklys.weeklys[3]}"/>
                                <tr style="background-color: ${weekly.monthlys[0].color[3] == null ? '#fff9e6' : weekly.monthlys[0].color[3]}">
                                    <td><input class="form-control" type="text" value="${weekly.year.category[3]}" disabled></td>
                                    <td class="text-center rate-onething" style="width: 75px;"></td></td>
                                    <td class="text-center target-onething" contenteditable="true"  onkeydown="return isNumberKey(event)">
                                        ${weekly.monthlys[0].targetCategory[3] == null ? 0 : weekly.monthlys[0].targetCategory[3].target}
                                    </td>
                                    <td class="text-center performance-onething">
                                        <c:set var="sum" value="0" />
                                        <c:forEach var="item" items="${weekly.getPerformace}">
                                            <c:set var="target" value="${item.data[3].performance}" />
                                            <c:if test="${target eq true}">
                                                <c:set var="sum" value="${sum + 1}" />
                                            </c:if>
                                        </c:forEach>
                                        ${sum}
                                    </td>
                                </tr>
                                <c:set var="reading" value="${weekly.weeklys.weeklys[4]}"/>
                                <tr style="background-color: ${weekly.monthlys[0].color[4] == null ? '#e9e4f5' : weekly.monthlys[0].color[4]}">
                                    <td><input class="form-control" type="text" value="${weekly.year.category[4]}" disabled></td>
                                    <td class="text-center rate-onething" style="width: 75px;"></td></td>
                                    <td class="text-center target-onething" contenteditable="true"  onkeydown="return isNumberKey(event)">
                                        ${weekly.monthlys[0].targetCategory[4] == null ? 0 : weekly.monthlys[0].targetCategory[4].target}
                                    </td>
                                    <td class="text-center performance-onething">
                                        <c:set var="sum" value="0" />
                                        <c:forEach var="item" items="${weekly.getPerformace}">
                                            <c:set var="target" value="${item.data[4].performance}" />
                                            <c:if test="${target eq true}">
                                                <c:set var="sum" value="${sum + 1}" />
                                            </c:if>
                                        </c:forEach>
                                        ${sum}
                                    </td>
                                </tr>

                                <%-- Daily Session --%>
                                <c:set var="dailyRoutine" value="${weekly.monthlys[0].dailyRoutine[0]}"/>
                                <tr name="theSingleMostImportantThing">
                                    <td class="text-start" rowspan="1" id="daily-objective">Daily Routine</td>
                                    <td><input class="form-control dailyRoutineInput checkDaily" type="text"
                                               value="${dailyRoutine.title == '' || dailyRoutine == null ? ' ' : dailyRoutine.title }">
                                    </td>
                                    <td class="text-center">
                                        <script>
                                            var performance = ${dailyRoutine != null && dailyRoutine.title != '' ? dailyRoutine.performance : 0};
                                            var target = ${dailyRoutine.target != 0 && dailyRoutine != null && dailyRoutine.title != '' ? dailyRoutine.target : 0};
                                            var result = target !== 0 ? (performance / target) * 100 : 0;
                                            var roundedResult = result !== 0 ? result.toFixed(2) + '%' : 0 + '%';
                                            document.write(roundedResult);
                                        </script>
                                    </td>
                                    <td class="text-center dailyRoutineTarget" contenteditable="true"
                                        onkeydown="return isNumberKey(event)">
                                        ${dailyRoutine.target != 0 && dailyRoutine != null && dailyRoutine.title != '' ? dailyRoutine.target : 0}
                                    </td>
                                    <td class="text-center">${dailyRoutine != null && dailyRoutine.title != '' ? dailyRoutine.performance : 0}</td>
                                </tr>
                                <c:forEach var="index" begin="1" end="10">
                                    <c:set var="dailyRoutine" value="${weekly.monthlys[0].dailyRoutine[index]}"/>
                                    <c:if test="${not empty dailyRoutine.title}">
                                        <tr name="theSingleMostImportantThing">
                                            <td><input class="form-control dailyRoutineInput checkDaily" type="text"
                                                       value="${dailyRoutine.title}"></td>
                                            <td class="text-center">
                                                <script>
                                                    var performance = ${dailyRoutine.title != '' ? dailyRoutine.performance : 0};
                                                    var target = ${dailyRoutine.target != 0 && dailyRoutine.title != '' ? dailyRoutine.target : 0};
                                                    var result = target !== 0 ? (performance / target) * 100 : 0;
                                                    var roundedResult = result !== 0 ? result.toFixed(2) + '%' : 0 + '%';
                                                    document.write(roundedResult);
                                                </script>
                                            </td>
                                            <td class="text-center dailyRoutineTarget" contenteditable="true"
                                                onkeydown="return isNumberKey(event)">
                                                    ${dailyRoutine.target != 0 && dailyRoutine.title != '' ? dailyRoutine.target : 0}
                                            </td>
                                            <td class="text-center">${dailyRoutine.title != '' ? dailyRoutine.performance : 0}</td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                <tr id="dailySession">
                                    <td colspan="4" style="position: relative">
                                        <button type="button" class="btn btn-success waves-effect waves-light"
                                                id="addDaily"><i class="bx bx-plus"></i></button>
                                    </td>
                                </tr>
                                </tbody>
                            </table>

                            <h4 class="fw-bolder">Year Goals</h4>
                            <table class="table table-bordered oneThingCalendar text-center align-middle">
                                <thead>
                                <tr>
                                    <th class="w-25">Objective</th>
                                    <th>Key Results</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="year" varStatus="loop" items="${weekly.year.target}">
                                    <tr>
                                        <c:if test="${loop.index == 0}">
                                            <td class="text-start" rowspan="3">Main target</td>
                                        </c:if>
                                        <td><input class="form-control yearTarget" type="text" value="${year}"></td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${weekly.year.target == null}">
                                    <c:forEach begin="1" end="${3}" varStatus="loop">
                                        <tr>
                                            <c:if test="${loop.index == 1}">
                                                <td class="text-start" rowspan="3">Main target</td>
                                            </c:if>
                                            <td><input class="form-control yearTarget" type="text"></td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                                </tbody>
                            </table>
                            <h4 class="fw-bolder">Monthly goal</h4>
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
                                        <td>
                                            <div class="input-group">
                                                <input class="form-control monthTarget" type="text" value="${monthly.content}">
                                                <button class="btn btn-info dropdown-toggle btn-status" data-value="${monthly.status}" type="button" data-bs-toggle="dropdown"
                                                        aria-expanded="false">Setting
                                                </button>
                                                <ul class="dropdown-menu dropdown-menu-end" style="min-width: unset">
                                                    <li>
                                                        <button type="button"
                                                                class="btn btn-outline-warning waves-effect waves-light pending"
                                                                style="margin: 0 5px; width: 102px;"><i
                                                                class="ri-arrow-right-line"></i> Pending</button>
                                                    </li>
                                                    <li>
                                                        <button type="button"
                                                                class="btn btn-outline-danger waves-effect waves-light mt-2 close"
                                                                style="margin: 0 5px; width: 102px;"><i class="ri-close-line"> Cancel</i>
                                                        </button>
                                                    </li>
                                                    <li>
                                                        <button type="button"
                                                                class="btn btn-outline-success waves-effect waves-light mt-2 complete"
                                                                style="margin: 0 5px; width: 102px;"><i class="ri-check-line"> Complete</i>
                                                        </button>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
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
                            <h4 class="fw-bolder">Weekly Goals</h4>
                            <table class="table table-bordered oneThingCalendar text-center align-middle">
                                <thead>
                                <tr>
                                    <th class="w-25">Category</th>
                                    <th>Goals</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:set var="theSingleMostImportantThing"
                                       value="${weekly.weeklys.weeklys[0]}"/>
                                <tr id="theSingCategory">
                                    <td class="text-start yearTitle text-danger fw-bolder" style="background-color: ${weekly.monthlys[0].color[0]};">Important matter</td>
                                    <td style="background-color: ${weekly.monthlys[0].color[0]}">
                                        <div class="input-group">
                                            <input class="form-control weekTarget" name="theSingleMostImportantThing"
                                                   type="text"
                                                   value="${theSingleMostImportantThing.content}">
                                            <button class="btn btn-info dropdown-toggle btn-status" data-value="${theSingleMostImportantThing.status}" type="button" data-bs-toggle="dropdown"
                                                    aria-expanded="false">Setting
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-end" style="min-width: unset">
                                                <li>
                                                    <button type="button"
                                                            class="btn btn-outline-warning waves-effect waves-light pending"
                                                            style="margin: 0 5px; width: 102px;"><i
                                                            class="ri-arrow-right-line"></i> Pending</button>
                                                </li>
                                                <li>
                                                    <button type="button"
                                                            class="btn btn-outline-danger waves-effect waves-light mt-2 close"
                                                            style="margin: 0 5px; width: 102px;"><i class="ri-close-line"> Cancel</i>
                                                    </button>
                                                </li>
                                                <li>
                                                    <button type="button"
                                                            class="btn btn-outline-success waves-effect waves-light mt-2 complete"
                                                            style="margin: 0 5px; width: 102px;"><i class="ri-check-line"> Complete</i>
                                                    </button>
                                                </li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                                <c:set var="lecture" value="${weekly.weeklys.weeklys[1]}"/>
                                <tr id="lectureCategory">
                                    <td class="text-start yearTitle" contenteditable="true" style="background-color: ${weekly.monthlys[0].color[1]}">${weekly.year.category[1]}</td>
                                    <td style="background-color: ${weekly.monthlys[0].color[1]}">
                                        <div class="input-group">
                                            <input class="form-control weekTarget" name="lecture" type="text"
                                                   value="${lecture.content}">
                                            <button class="btn btn-info dropdown-toggle btn-status" data-value="${lecture.status}" type="button" data-bs-toggle="dropdown"
                                                    aria-expanded="false">Setting
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-end" style="min-width: unset">
                                                <li>
                                                    <button type="button"
                                                            class="btn btn-outline-warning waves-effect waves-light pending"
                                                            style="margin: 0 5px; width: 102px;"><i
                                                            class="ri-arrow-right-line"></i> Pending</button>
                                                </li>
                                                <li>
                                                    <button type="button"
                                                            class="btn btn-outline-danger waves-effect waves-light mt-2 close"
                                                            style="margin: 0 5px; width: 102px;"><i class="ri-close-line"> Cancel</i>
                                                    </button>
                                                </li>
                                                <li>
                                                    <button type="button"
                                                            class="btn btn-outline-success waves-effect waves-light mt-2 complete"
                                                            style="margin: 0 5px; width: 102px;"><i class="ri-check-line"> Complete</i>
                                                    </button>
                                                </li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                                <c:set var="dailyEvaluation" value="${weekly.weeklys.weeklys[2]}"/>
                                <tr id="dailyCategory">
                                    <td class="text-start yearTitle" contenteditable="true" style="background-color: ${weekly.monthlys[0].color[2]}">${weekly.year.category[2]}</td>
                                    <td style="background-color: ${weekly.monthlys[0].color[2]}">
                                        <div class="input-group">
                                            <input class="form-control weekTarget" name="dailyEvaluation" type="text"
                                                   value="${dailyEvaluation.content}">
                                            <button class="btn btn-info dropdown-toggle btn-status" data-value="${dailyEvaluation.status}" type="button" data-bs-toggle="dropdown"
                                                    aria-expanded="false">Setting
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-end" style="min-width: unset">
                                                <li>
                                                    <button type="button"
                                                            class="btn btn-outline-warning waves-effect waves-light pending"
                                                            style="margin: 0 5px; width: 102px;"><i
                                                            class="ri-arrow-right-line"></i> Pending</button>
                                                </li>
                                                <li>
                                                    <button type="button"
                                                            class="btn btn-outline-danger waves-effect waves-light mt-2 close"
                                                            style="margin: 0 5px; width: 102px;"><i class="ri-close-line"> Cancel</i>
                                                    </button>
                                                </li>
                                                <li>
                                                    <button type="button"
                                                            class="btn btn-outline-success waves-effect waves-light mt-2 complete"
                                                            style="margin: 0 5px; width: 102px;"><i class="ri-check-line"> Complete</i>
                                                    </button>
                                                </li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                                <c:set var="work" value="${weekly.weeklys.weeklys[3]}"/>
                                <tr id="workCategory">
                                    <td class="text-start yearTitle" contenteditable="true" style="background-color: ${weekly.monthlys[0].color[3]}">${weekly.year.category[3]}</td>
                                    <td style="background-color: ${weekly.monthlys[0].color[3]}">
                                        <div class="input-group">
                                            <input class="form-control weekTarget" name="work" type="text"
                                                   value="${work.content}">
                                            <button class="btn btn-info dropdown-toggle btn-status" data-value="${work.status}" type="button" data-bs-toggle="dropdown"
                                                    aria-expanded="false">Setting
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-end" style="min-width: unset">
                                                <li>
                                                    <button type="button"
                                                            class="btn btn-outline-warning waves-effect waves-light pending"
                                                            style="margin: 0 5px; width: 102px;"><i
                                                            class="ri-arrow-right-line"></i> Pending</button>
                                                </li>
                                                <li>
                                                    <button type="button"
                                                            class="btn btn-outline-danger waves-effect waves-light mt-2 close"
                                                            style="margin: 0 5px; width: 102px;"><i class="ri-close-line"> Cancel</i>
                                                    </button>
                                                </li>
                                                <li>
                                                    <button type="button"
                                                            class="btn btn-outline-success waves-effect waves-light mt-2 complete"
                                                            style="margin: 0 5px; width: 102px;"><i class="ri-check-line"> Complete</i>
                                                    </button>
                                                </li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                                <c:set var="reading" value="${weekly.weeklys.weeklys[4]}"/>
                                <tr id="readingCategory">
                                    <td class="text-start yearTitle" contenteditable="true" style="background-color: ${weekly.monthlys[0].color[4]}">${weekly.year.category[4]}</td>
                                    <td style="background-color: ${weekly.monthlys[0].color[4]}">
                                        <div class="input-group">
                                            <input class="form-control weekTarget" name="reading" type="text"
                                                   value="${reading.content}">
                                            <button class="btn btn-info dropdown-toggle btn-status" type="button" data-bs-toggle="dropdown"
                                                    aria-expanded="false" data-value="${reading.status}">Setting
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-end" style="min-width: unset">
                                                <li>
                                                    <button type="button"
                                                            class="btn btn-outline-warning waves-effect waves-light pending"
                                                            style="margin: 0 5px; width: 102px;"><i
                                                            class="ri-arrow-right-line"></i> Pending</button>
                                                </li>
                                                <li>
                                                    <button type="button"
                                                            class="btn btn-outline-danger waves-effect waves-light mt-2 close"
                                                            style="margin: 0 5px; width: 102px;"><i class="ri-close-line"> Cancel</i>
                                                    </button>
                                                </li>
                                                <li>
                                                    <button type="button"
                                                            class="btn btn-outline-success waves-effect waves-light mt-2 complete"
                                                            style="margin: 0 5px; width: 102px;"><i class="ri-check-line"> Complete</i>
                                                    </button>
                                                </li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>

                            <div class="d-flex align-items-center justify-content-between">
                                <h4 class="fw-bolder">A quote I shouldn't forget</h4>
                                <button type="button" class="btn btn-info mb-2" data-bs-toggle="modal"
                                        data-bs-target="#exampleModalgrid">Dream Board</button>
                                <div class="modal fade" id="exampleModalgrid" tabindex="-1"
                                     aria-labelledby="exampleModalgridLabel" aria-modal="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalgridLabel">Choose image</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                        aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body text-center">
                                                <input class="form-control" type="file" id="quoteImage"
                                                       accept="image/jpeg, image/png, image/gif" onchange="previewImage()">
                                                <div id="imagePreview" class="border mt-2 d-none"></div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close
                                                </button>
                                                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">OK
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
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
                                        <input class="form-control quotes checkQuote" type="text"
                                               value="${weekly.quotes.content[1]}">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input class="form-control quotes checkQuote" type="text"
                                               value="${weekly.quotes.content[2]}">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input class="form-control quotes checkQuote" type="text"
                                               value="${weekly.quotes.content[3]}">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input class="form-control quotes checkQuote" type="text"
                                               value="${weekly.quotes.content[4]}">
                                    </td>
                                </tr>
                                <tr id="quoteSession">
                                    <td>
                                        <button type="button" class="btn btn-success waves-effect waves-light w-100"
                                                id="addQuote">ADD</button>
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
                                            <p class="m-0 color-category">${color.category}</p>
                                            <div class="pickr"></div>
                                            <p hidden="hidden"
                                               class="pickedColor">${color.color != '' ? color.color : "#FFFFFF"}</p>
                                        </th>
                                    </c:forEach>
                                    <c:if test="${weekly.colors.size() < 4}">
                                        <c:forEach begin="${weekly.colors.size()}" end="3">
                                            <th scope="col" class="panel colorPicker"
                                                style="background-color: #FFFFFF;">
                                                <p class="m-0 color-category">Default Category</p>
                                                <div class="pickr"></div>
                                                <p hidden="hidden" class="pickedColor">#FFFFFF</p>
                                            </th>
                                        </c:forEach>
                                    </c:if>
                                </tr>

                                </thead>
                                <tbody>
                                <c:forEach begin="0" end="8" var="item" varStatus="loop">
                                    <tr class="tr-color-category">
                                        <c:forEach items="${weekly.colors}" var="color">
                                            <td contenteditable="true" class="key-color">${color.values[loop.index]}</td>
                                        </c:forEach>
                                        <c:if test="${weekly.colors.size() < 4}">
                                            <c:forEach begin="${weekly.colors.size()}" end="3">
                                                <td contenteditable="true" class="key-color"></td>
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
                                        <th colspan="3" class="fw-bolder"><h5>Detail</h5></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td></td>
                                        <td colspan="2" class="fw-bolder">Categories</td>
                                    </tr>
                                    <tr class="theSingleMostImportantThing">
                                        <td rowspan="5" style="max-width: 5rem;white-space: normal" class="fw-bolder">Onething
                                            calendar
                                        </td>
                                        <td colspan="2"
                                            style="border-top: 0; border-left: 0; border-bottom: 0;  background-color: ${weekly.monthlys[0].color[0]}">
                                            <span class="mx-auto fw-bolder text-danger">Important matter</span>
                                        </td>
                                    </tr>
                                    <tr class="lecture">
                                        <td colspan="2"
                                            style="border-left: 0; border-bottom: 0; background-color: ${weekly.monthlys[0].color[1]}">
                                            <span class="mx-auto">${weekly.year.category[1]}</span>
                                        </td>
                                    </tr>
                                    <tr class="dailyEvaluation">
                                        <td colspan="2"
                                            style="border-left: 0; border-bottom: 0; background-color: ${weekly.monthlys[0].color[2]}">
                                            <span class="mx-auto">${weekly.year.category[2]}</span>
                                        </td>
                                    </tr>
                                    <tr class="work">
                                        <td colspan="2"
                                            style="border-left: 0; border-bottom: 0; background-color: ${weekly.monthlys[0].color[3]}">
                                            <span class="mx-auto">${weekly.year.category[3]}</span>
                                        </td>
                                    </tr>
                                    <tr class="reading">
                                        <td colspan="2"
                                            style="border-left: 0; border-bottom: 0; background-color: ${weekly.monthlys[0].color[4]}">
                                            <span class="mx-auto">${weekly.year.category[4]}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 162.5px" id="daily-routine"><h5 class="fw-bolder">Daily
                                            Routine</h5></td>
                                    </tr>
                                    <tr>
                                        <td rowspan="3" style="max-width: 5rem;white-space: normal" class="fw-bolder">To-Do
                                            List
                                        </td>
                                        <td colspan="3" style="height: 65px">Six to Twelve PM</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="height: 65px">Twelve to Six PM</td>
                                    </tr>
                                    <tr>
                                        <td  colspan="2" style="height: 65px">Six to Twelve AM</td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 213px"><h5 class="fw-bolder">Gratitude Diary</h5></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 71px"><h5 class="fw-bolder">Affirmation</h5></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 71px"><h5 class="fw-bolder">Compliment for me today</h5>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 71px"><h5 class="fw-bolder">Today’s reflections and
                                            improvements</h5></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td colspan="2" class="fw-bolder">Process</td>
                                    </tr>
                                    <tr>
                                        <td rowspan="24" style="max-width: 5rem;white-space: normal" class="fw-bolder">
                                            Timeline
                                        </td>
                                        <td colspan="2" class="fw-bolder">0:00</td>
                                    </tr>
                                    <c:forEach var="time" begin="1" end="23">
                                        <tr>
                                            <c:choose>
                                                <c:when test="${time % 6 == 0}">
                                                    <td colspan="2" class="fw-bolder">${time}:00</td>
                                                </c:when>
                                                <c:otherwise>
                                                    <td colspan="2">${time}:00</td>
                                                </c:otherwise>
                                            </c:choose>
                                        </tr>
                                    </c:forEach>
                                    <tr>
                                        <td rowspan="4" style="height: 71px" class="fw-bolder">Time Usage <br> Report</td>
                                        <td class="title-report-category"></td>
                                        <td class="w-100px total-category text-lg-start"></td>
                                    </tr>
                                    <tr>
                                        <td class="title-report-category" style="background-color: #e6f0e2"></td>
                                        <td class="w-100px total-category text-lg-start"></td>
                                    </tr>
                                    <tr>
                                        <td class="title-report-category" style="background-color: #fff9e6"></td>
                                        <td class="w-100px total-category text-lg-start"></td>
                                    </tr>
                                    <tr>
                                        <td class="title-report-category" style="background-color: #e9e4f5"></td>
                                        <td class="w-100px total-category text-lg-start"></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="table-container" style="max-height: 3000px">
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
                                            <td class="fw-bolder" colspan="3">Goals</td>
                                            <td class="fw-bolder">Performance</td>
                                        </c:forEach>
                                    </tr>

                                    <%--one-thing--%>
                                    <tr class="theSingleMostImportantThing">
                                        <c:forEach var="day" items="${weekly.days}">
                                            <c:set var="theSingleMostImportantThing"
                                                   value="${day.data.oneThingCalendar[0]}"/>
                                            <td class="editable-cell target-color-theSingle isModifyTheSing" colspan="3"
                                                contenteditable="true"
                                                data-name="theSingleMostImportantThing"
                                                data-day="${day.day}" style="background-color: ${weekly.monthlys[0].color[0]}">${theSingleMostImportantThing.target}</td>
                                            <td class="performance-color-theSingle isModifyTheSing" style="background-color: ${weekly.monthlys[0].color[0]}"><input
                                                    class="form-check-input"
                                                    type="checkbox" ${theSingleMostImportantThing.performance ? 'checked' : ''}>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr class="lecture">
                                        <c:forEach var="day" items="${weekly.days}">
                                            <c:set var="lecture" value="${day.data.oneThingCalendar[1]}"/>
                                            <td class="editable-cell target-color-lecture isModifyLecture" colspan="3"
                                                contenteditable="true" data-name="lecture"
                                                data-day="${day.day}" style="background-color: ${weekly.monthlys[0].color[1]}">${lecture.target}</td>
                                            <td class="performance-color-lecture isModifyLecture" style="background-color: ${weekly.monthlys[0].color[1]}"><input
                                                    class="form-check-input"
                                                    type="checkbox" ${lecture.performance ? 'checked' : ''}></td>
                                        </c:forEach>
                                    </tr>
                                    <tr class="dailyEvaluation">
                                        <c:forEach var="day" items="${weekly.days}">
                                            <c:set var="dailyEvaluation" value="${day.data.oneThingCalendar[2]}"/>
                                            <td class="editable-cell target-color-dailyEvaluation isModifyDaily" colspan="3"
                                                contenteditable="true"
                                                data-name="dailyEvaluation"
                                                data-day="${day.day}" style="background-color: ${weekly.monthlys[0].color[2]}">${dailyEvaluation.target}</td>
                                            <td class="performance-color-dailyEvaluation isModifyDaily" style="background-color: ${weekly.monthlys[0].color[2]}"><input
                                                    class="form-check-input"
                                                    type="checkbox" ${dailyEvaluation.performance ? 'checked' : ''}></td>
                                        </c:forEach>
                                    </tr>
                                    <tr class="work">
                                        <c:forEach var="day" items="${weekly.days}">
                                            <c:set var="work" value="${day.data.oneThingCalendar[3]}"/>
                                            <td class="editable-cell target-color-work isModifyWork" colspan="3"
                                                contenteditable="true" data-name="work"
                                                data-day="${day.day}" style="background-color: ${weekly.monthlys[0].color[3]}">${work.target}</td>
                                            <td class="performance-color-work isModifyWork" style="background-color: ${weekly.monthlys[0].color[3]}"><input class="form-check-input"
                                                                                                                                                            type="checkbox" ${work.performance ? 'checked' : ''}>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                    <tr class="reading">
                                        <c:forEach var="day" items="${weekly.days}">
                                            <c:set var="reading" value="${day.data.oneThingCalendar[4]}"/>
                                            <td class="editable-cell target-color-reading isModifyReading" colspan="3"
                                                contenteditable="true" data-name="reading"
                                                data-day="${day.day}" style="background-color: ${weekly.monthlys[0].color[4]}">${reading.target}</td>
                                            <td class="performance-color-reading isModifyReading" style="background-color: ${weekly.monthlys[0].color[4]}"><input
                                                    class="form-check-input"
                                                    type="checkbox" ${reading.performance ? 'checked' : ''}></td>
                                        </c:forEach>
                                    </tr>

                                    <%--daily routine--%>
                                    <c:forEach var="dailyRoutine" varStatus="loop" begin="0" end="4">
                                        <tr name="daily" class="checkDailyRoutine">
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
                                                <td class="editable-cell " colspan="3">${dailyRoutine.title}</td>
                                                <td><input class="form-check-input dailyRoutine"
                                                           type="checkbox" ${day.data.dailyRoutine[loop.index] ? 'checked' : ''}
                                                           data-day="${day.day}"></td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>

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
                                                <td class="actual-timeLine" style="background-color: ${backgroundColor2}" contenteditable="true"
                                                    data-day="${day.day}"
                                                    data-name="timeLine">${data[0].actual}</td>
                                                <td class="actual-timeLine" style="background-color: ${backgroundColor3}" contenteditable="true"
                                                    data-day="${day.day}"
                                                    data-name="timeLine">${data[1].actual}</td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>

                                    <%--Time Usage Report--%>
                                    <c:forEach begin="0" end="3" varStatus="loop">
                                        <tr class="tr-timeReport">
                                            <c:forEach var="day" items="${weekly.days}">
                                                <td class="total-time-day" colspan="2" data-day="${day.day}"></td>
                                                <td class="performance-of-day" colspan="2"></td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-md-12 text-center align-middle mt-3">
                            <button class="btn btn-primary mr-2" onclick="history.back()">
                                Back
                            </button>
                            <button class="btn btn-success ml-2 btn-save">Save</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="tab-pane" id="check-book" role="tabpanel" style="min-height: 700px">
            <div class="row calendar-container d-none">
                <div class="card">
                    <div class="card-header border-0">
                        <div class="d-flex align-items-center">
                            <h5 class="card-title mb-0 flex-grow-1">All books</h5>
                        </div>
                    </div>
                    <div class="card-body border border-dashed border-end-0 border-start-0">
                        <div class="row g-3">
                            <div class="col-xxl-9 col-sm-12">
                                <div class="search-box">
                                    <input id="search-input" type="text" class="form-control search bg-light border-light"
                                           placeholder="Search by title, username">
                                    <i class="ri-search-line search-icon"></i>
                                </div>
                            </div>
                            <!--end col-->
                            <div class="col-xxl-1 col-sm-4">
                                <button id="filter-btn" type="button" class="btn btn-primary btn-load">
                                <span class="d-flex align-items-center">
                                    <span class="spinner-border flex-shrink-0 d-none"></span>
                                    <span class="flex-grow-1 ms-2">
                                        <i class="ri-equalizer-fill me-1 align-bottom"></i>Filters
                                    </span>
                                </span>
                                </button>
                            </div>
                            <div class="col-xxl-2 col-sm-4 d-flex align-items-center justify-content-end">
                                <div style="margin-right: 5px;">Show entries:</div>
                                <div class="page-count-item-container d-flex align-items-center align-items-center">
                                    <select id="page-count-select" class="form-select" aria-label=".form-select-lg example">
                                        <option value="10">10</option>
                                        <option value="15">15</option>
                                        <option value="20">20</option>
                                    </select>
                                    <span class="btn-load ml-10">
                                    <span class="spinner-border flex-shrink-0 d-none"></span>
                                </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive table-card">
                            <table id="datatable-book" class="table align-middle table-nowrap mb-0 w-100"
                                   style="margin: 0px!important;">
                                <thead>
                                <tr>
                                    <th>Book</th>
                                    <th>Title</th>
                                    <th>Author</th>
                                    <th>Created by</th>
                                    <th>Created date</th>
                                    <th>Time Spent Reading <span class="text-danger">(Hour)</span></th>
                                    <th>Note</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                        <div class="d-flex justify-content-center">
                            <div class="pagination-wrap hstack gap-2">
                                <ul id="pagination" class="pagination mb-0"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="tab-pane" id="review" role="tabpanel" style="min-height: 700px">
            <div class="row calendar-container d-none">
                <div class="card">
                    <div class="row card-body">
                        <div class="d-flex border p-0" style="background-color: rgba(233, 30, 105, 0.81); margin: 0 12px">
                            <div class="col-2 ms-2">
                                <div class="card ribbon-box border shadow-none overflow-hidden mt-2 mb-2" style="width: 16rem; margin-right: 80px">
                                    <div class="card-body text-muted">
                                        <div class="ribbon ribbon-info ribbon-shape trending-ribbon">
                                            <span class="trending-ribbon-text">Focus</span> <i class="ri-flashlight-fill text-white align-bottom float-end ms-1"></i>
                                        </div>
                                        <h5 class="fs-14 text-end mb-3">Goals of <span id="monthTarget">${weekly.monthlys[0].month}</span></h5>
                                        <div class="m-0" id="monthlyTarget">
                                            <p class="editable m-0">${weekly.monthlys[0].monthlyContents[0].content}</p>
                                            <p class="editable m-0">${weekly.monthlys[0].monthlyContents[1].content}</p>
                                            <p class="editable m-0">${weekly.monthlys[0].monthlyContents[2].content}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-8 mt-4">
                               <div class="d-flex flex-column align-items-center">
                                   <div class="d-flex align-items-center">
                                       <h1 class="text-center text-white month-current"></h1>
                                   </div>
                               </div>
                           </div>
                            <div class="col-2 ms-2 d-flex align-items-center">
                                <button type="button" id="btn-chart-time-used" class="btn btn-info btn-label waves-effect waves-light" data-bs-toggle="modal" data-bs-target="#modalChart">
                                    <i class="ri-pie-chart-2-line label-icon align-middle fs-16 me-2"></i> Time Usage: 4C
                                </button>
                                <div id="modalChart" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="card-title mb-0 flex-grow-1">Chart Time Usage Of Category</h4>
                                                <div class="flex-shrink-0">
                                                    <div class="dropdown card-header-dropdown">
                                                        <a class="text-reset dropdown-btn" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                            <span class="text-muted fs-16"><i class="mdi mdi-dots-vertical align-middle"></i></span>
                                                        </a>
                                                        <div class="dropdown-menu dropdown-menu-end">
                                                            <a class="dropdown-item" href="#">Week</a>
                                                            <a class="dropdown-item" href="#">Month</a>
                                                            <a class="dropdown-item" href="#">Year</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-body">
                                                <div class="card-body">
                                                    <div id="simple_pie_chart" data-colors='["${weekly.monthlys[0].color[1]}", "${weekly.monthlys[0].color[2]}", "${weekly.monthlys[0].color[3]}", "${weekly.monthlys[0].color[4]}"]' class="apex-charts" dir="ltr"></div>
                                                </div><!-- end card-body -->
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">OK</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 d-flex mt-2">
                            <div class="table-detail" style="width: unset;">
                                <table>
                                    <thead>
                                    </thead>
                                    <tbody>
                                    <tr style="height: 65px">
                                        <td id="daily-onething-routine" rowspan="6" style="height: 311px; background-color: #FFEAA7">
                                            <h5 class="fw-bolder text-white">Daily Onething <br>&<br> Daily routine</h5>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td class="reivew-daily-onething"></td>
                                    </tr>
                                    <tr style="background-color: #fcecec">
                                        <td class="reivew-daily-onething"></td>
                                    </tr>
                                    <tr style="background-color: #e6f0e2">
                                        <td class="reivew-daily-onething"></td>
                                    </tr>
                                    <tr style="background-color: #fff9e6">
                                        <td class="reivew-daily-onething"></td>
                                    </tr>
                                    <tr style="background-color: #e9e4f5">
                                        <td class="reivew-daily-onething"></td>
                                    </tr>
                                    <c:choose>
                                        <c:when test="${empty weekly.monthlys[0].dailyRoutine}">
                                            <tr class="review-dailyRoutine">
                                                <td></td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${weekly.monthlys[0].dailyRoutine}" var="dailyRoutine" varStatus="loop">
                                                <tr class="review-dailyRoutine">
                                                    <td>${dailyRoutine.title}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>

                                    <tr style="height: 50px; background-color: #fcecec">
                                        <td rowspan="4" style="background-color: #FFBB64;">
                                            <h5 class="fw-bolder text-white">Weekly <br> & <br> MonthLy Goals</h5>
                                        </td>
                                        <td class="review-weekly-goals"></td>
                                    </tr>
                                    <tr style="height: 51px; background-color: #e6f0e2">
                                        <td class="review-weekly-goals"></td>
                                    </tr>
                                    <tr style="height: 50px; background-color: #fff9e6">
                                        <td class="review-weekly-goals"></td>
                                    </tr>
                                    <tr style="height: 51px; background-color: #e9e4f5">
                                        <td class="review-weekly-goals"></td>
                                    </tr>
                                    <tr style="height: 45px; background-color: #fcecec">
                                        <td rowspan="4" style="background-color: #E6A4B4;">
                                            <h5 class="fw-bolder text-white">Amount of <br>time</h5>
                                        </td>
                                        <td class="review-weekly-amount-time"></td>
                                    </tr>
                                    <tr style="height: 45px; background-color: #e6f0e2">
                                        <td class="review-weekly-amount-time"></td>
                                    </tr>
                                    <tr style="height: 45px; background-color: #fff9e6">
                                        <td class="review-weekly-amount-time"></td>
                                    </tr>
                                    <tr style="height: 45px; background-color: #e9e4f5">
                                        <td class="review-weekly-amount-time"></td>
                                    </tr>
                                    <tr style="background-color: #FF9BD2">
                                        <td rowspan="4" style="height: 378px">
                                            <h5 class="fw-bolder text-white">Weekly <br>&<br> Monthly Review</h5>
                                        </td>
                                    </tr>
                                    <tr style="height: 45px">
                                        <td class="review-weekly-amount-time fw-bolder text-uppercase">Gratitude Diary</td>
                                    </tr>
                                    <tr style="height: 45px">
                                        <td class="review-weekly-amount-time fw-bolder text-uppercase">Compliment</td>
                                    </tr>
                                    <tr style="height: 45px">
                                        <td class="review-weekly-amount-time fw-bolder text-uppercase">Reflection/Improvement</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="table-container">
                                <table id="table-dailyOnethingRoutine">
                                    <thead>
                                    <tr style="height: 44px">
                                        <c:forEach begin="0" end="3" varStatus="loop">
                                            <th class="fw-bolder" colspan="7">WEEK <span>${loop.index + 1}</span></th>
                                        </c:forEach>
                                        <th class="fw-bolder" colspan="7">EXTRA DAYS</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr id="days-of-month" style="height: 45px" data-value="${weekly.monthlys[0].month}">
                                    </tr>
                                    <c:forEach begin="0" end="3" varStatus="loop">
                                        <tr class="tr-review-weekly" style="height: 50.5px">
                                            <c:forEach begin="0" end="4" varStatus="loop">
                                                <td colspan="7" class="weekly-goals fw-bolder"></td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>
                                    <c:forEach begin="0" end="3" varStatus="loop">
                                        <tr class="tr-weekly-amountTime" style="height: 45px">
                                            <c:forEach begin="0" end="4" varStatus="loop">
                                                <td colspan="4" class="weekly-amountTime">0/168 hours</td>
                                                <td colspan="3.5" class="performance-time-used-amountTime"></td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>
                                    <c:forEach begin="0" end="2" varStatus="outerLoop">
                                        <tr style="height: 126px" class="tr-weekly-sentence${outerLoop.index}">
                                            <c:forEach begin="0" end="4" varStatus="innerLoop">
                                                <td colspan="7">
                                                    <textarea class="form-control weekly-sentence" style="height: 100%" placeholder="Enter here..."></textarea>
                                                </td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div>
                                <table class="table table-bordered text-center mb-0" style="border: 1px solid black; width: 240px">
                                    <thead>
                                    <tr>
                                        <th colspan="3" style="border: 1px solid black" class="month-current text-danger fw-bolder text-uppercase"></th>
                                    </tr>
                                    <tr>
                                        <th style="border: 1px solid black">Rate</th>
                                        <th style="border: 1px solid black">Target</th>
                                        <th class="text-wrap" style="border: 1px solid black">Performance</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%-- Review OneThing Calendar Session --%>
                                    <tr class="text-center" style="background-color: ${weekly.monthlys[0].color[0]}">
                                        <td class="text-center review-rate-ongthing">0%</td>
                                        <td class="text-center review-target-ongthing">
                                            ${weekly.monthlys[0].targetCategory[0] == null ? 0 : weekly.monthlys[0].targetCategory[0].target}
                                        </td>
                                        <td class="text-center review-performance-onething">
                                            0
                                        </td>
                                    </tr>
                                    <tr class="text-center" style="background-color: ${weekly.monthlys[0].color[1] == null ? '#fcecec' : weekly.monthlys[0].color[1]}">
                                        <td class="text-center review-rate-ongthing">0%</td>
                                        <td class="text-center review-target-ongthing">
                                            ${weekly.monthlys[0].targetCategory[1] == null ? 0 : weekly.monthlys[0].targetCategory[1].target}
                                        </td>
                                        <td class="text-center review-performance-onething">
                                            0
                                        </td>
                                    </tr>
                                    <tr class="text-center" style="background-color: ${weekly.monthlys[0].color[2] == null ? '#e6f0e2' : weekly.monthlys[0].color[2]}">
                                        <td class="text-center review-rate-ongthing">0%</td>
                                        <td class="text-center review-target-ongthing">
                                            ${weekly.monthlys[0].targetCategory[2] == null ? 0 : weekly.monthlys[0].targetCategory[2].target}
                                        </td>
                                        <td class="text-center review-performance-onething">
                                            0
                                        </td>
                                    </tr>
                                    <tr class="text-center" style="background-color: ${weekly.monthlys[0].color[3] == null ? '#fff9e6' : weekly.monthlys[0].color[3]}">
                                        <td class="text-center review-rate-ongthing">0%</td>
                                        <td class="text-center review-target-ongthing">
                                            ${weekly.monthlys[0].targetCategory[3] == null ? 0 : weekly.monthlys[0].targetCategory[3].target}
                                        </td>
                                        <td class="text-center review-performance-onething">
                                            0
                                        </td>
                                    </tr>
                                    <tr class="text-center" style="background-color: ${weekly.monthlys[0].color[4] == null ? '#e9e4f5' : weekly.monthlys[0].color[4]}">
                                        <td class="text-center review-rate-ongthing">0%</td>
                                        <td class="text-center review-target-ongthing">
                                            ${weekly.monthlys[0].targetCategory[4] == null ? 0 : weekly.monthlys[0].targetCategory[4].target}
                                        </td>
                                        <td class="text-center review-performance-onething">
                                            0
                                        </td>
                                    </tr>

                                    <%-- Review Daily Session --%>
                                    <c:set var="dailyRoutine" value="${weekly.monthlys[0].dailyRoutine[0]}"/>
                                    <tr name="theSingleMostImportantThing">
                                        <td class="text-center">
                                            <script>
                                                var performance = ${dailyRoutine != null && dailyRoutine.title != '' ? dailyRoutine.performance : 0};
                                                var target = ${dailyRoutine.target != 0 && dailyRoutine != null && dailyRoutine.title != '' ? dailyRoutine.target : 0};
                                                var result = target !== 0 ? (performance / target) * 100 : 0;
                                                var roundedResult = result !== 0 ? result.toFixed(2) + '%' : 0 + '%';
                                                document.write(roundedResult);
                                            </script>
                                        </td>
                                        <td class="text-center dailyRoutineTarget"
                                            onkeydown="return isNumberKey(event)">
                                            ${dailyRoutine.target != 0 && dailyRoutine != null && dailyRoutine.title != '' ? dailyRoutine.target : 0}
                                        </td>
                                        <td class="text-center">${dailyRoutine != null && dailyRoutine.title != '' ? dailyRoutine.performance : 0}</td>
                                    </tr>
                                    <c:forEach var="index" begin="1" end="10">
                                        <c:set var="dailyRoutine" value="${weekly.monthlys[0].dailyRoutine[index]}"/>
                                        <c:if test="${not empty dailyRoutine.title}">
                                            <tr name="theSingleMostImportantThing">
                                                <td class="text-center">
                                                    <script>
                                                        var performance = ${dailyRoutine.title != '' ? dailyRoutine.performance : 0};
                                                        var target = ${dailyRoutine.target != 0 && dailyRoutine.title != '' ? dailyRoutine.target : 0};
                                                        var result = target !== 0 ? (performance / target) * 100 : 0;
                                                        var roundedResult = result !== 0 ? result.toFixed(2) + '%' : 0 + '%';
                                                        document.write(roundedResult);
                                                    </script>
                                                </td>
                                                <td class="text-center dailyRoutineTarget"
                                                    onkeydown="return isNumberKey(event)">
                                                        ${dailyRoutine.target != 0 && dailyRoutine.title != '' ? dailyRoutine.target : 0}
                                                </td>
                                                <td class="text-center">${dailyRoutine.title != '' ? dailyRoutine.performance : 0}</td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <table class="table text-center mb-0" style="border: 1px solid black">
                                    <thead>
                                    </thead>
                                    <tbody>
                                    <%-- OneThing Calendar Session --%>
                                    <tr class="text-center" >
                                        <td style="height: 67px" class="text-center fw-bolder monthly-goals d-flex align-items-center justify-content-between">
                                            <span class="d-inline-block">${weekly.monthlys[0].monthlyContents[0].content}</span>
                                            <c:if test="${weekly.monthlys[0].monthlyContents[0].status.equals('COMPLETE')}">
                                                <button class="btn btn-success" style="width: 53px">
                                                    <i class="ri-check-line"></i>
                                                </button>
                                            </c:if>
                                            <c:if test="${weekly.monthlys[0].monthlyContents[0].status.equals('PENDING')}">
                                                <button class="btn btn-warning" style="width: 53px">
                                                    <i class="ri-arrow-right-line"></i>
                                                </button>

                                            </c:if>
                                            <c:if test="${weekly.monthlys[0].monthlyContents[0].status.equals('CANCEL')}">
                                                <button class="btn btn-danger" style="width: 53px">
                                                    <i class="ri-close-line"></i>
                                                </button>
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr class="text-center" >
                                        <td style="height: 67px" class="text-center fw-bolder monthly-goals d-flex align-items-center justify-content-between">
                                            <span class="d-inline-block">${weekly.monthlys[0].monthlyContents[1].content}</span>
                                            <c:if test="${weekly.monthlys[0].monthlyContents[1].status.equals('COMPLETE')}">
                                                <button class="btn btn-success" style="width: 53px">
                                                    <i class="ri-check-line"></i>
                                                </button>
                                            </c:if>
                                            <c:if test="${weekly.monthlys[0].monthlyContents[1].status.equals('PENDING')}">
                                                <button class="btn btn-warning" style="width: 53px">
                                                    <i class="ri-arrow-right-line"></i>
                                                </button>

                                            </c:if>
                                            <c:if test="${weekly.monthlys[0].monthlyContents[1].status.equals('CANCEL')}">
                                                <button class="btn btn-danger" style="width: 53px">
                                                    <i class="ri-close-line"></i>
                                                </button>
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr class="text-center" >
                                        <td style="height: 65px" class="text-center fw-bolder monthly-goals d-flex align-items-center justify-content-between">
                                            <span class="d-inline-block">${weekly.monthlys[0].monthlyContents[2].content}</span>
                                            <c:if test="${weekly.monthlys[0].monthlyContents[2].status.equals('COMPLETE')}">
                                                <button class="btn btn-success" style="width: 53px">
                                                    <i class="ri-check-line"></i>
                                                </button>
                                            </c:if>
                                            <c:if test="${weekly.monthlys[0].monthlyContents[2].status.equals('PENDING')}">
                                                <button class="btn btn-warning" style="width: 53px">
                                                    <i class="ri-arrow-right-line"></i>
                                                </button>
                                            </c:if>
                                            <c:if test="${weekly.monthlys[0].monthlyContents[2].status.equals('CANCEL')}">
                                                <button class="btn btn-danger" style="width: 53px">
                                                    <i class="ri-close-line"></i>
                                                </button>
                                            </c:if>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <table class="table table-bordered text-center mb-0" style="border: 1px solid black">
                                    <thead>
                                    </thead>
                                    <tbody>
                                    <%-- OneThing Calendar Session --%>
                                    <tr class="text-center" style="height: 45px">
                                        <td class="text-center time-used-monthly" style="width: 75px;"></td>
                                        <td class="text-center performance-amountTime-monthly" style="width: 75px;"></td>
                                    </tr>
                                    <tr class="text-center" style="height: 45px">
                                        <td class="text-center time-used-monthly" style="width: 75px;"></td>
                                        <td class="text-center performance-amountTime-monthly" style="width: 75px;"></td>
                                    </tr>
                                    <tr class="text-center" style="height: 45px">
                                        <td class="text-center time-used-monthly" style="width: 75px;"></td>
                                        <td class="text-center performance-amountTime-monthly" style="width: 75px;"></td>
                                    </tr>
                                    <tr class="text-center" style="height: 45px">
                                        <td class="text-center time-used-monthly" style="width: 75px;"></td>
                                        <td class="text-center performance-amountTime-monthly" style="width: 75px;"></td>
                                    </tr>
                                    </tbody>
                                </table>
                                <table class="table table-bordered text-center mb-0" style="border: 1px solid black">
                                    <thead>
                                    </thead>
                                    <tbody>
                                    <%-- OneThing Calendar Session --%>
                                    <tr class="text-center">
                                        <td>
                                            <textarea id="monthly-gratitudeDiary" class="form-control" style="height: 100px" placeholder="Enter here...">${weekly.monthlys[0].gratitudeDiary}</textarea>
                                        </td>
                                    </tr>
                                    <tr class="text-center">
                                        <td>
                                            <textarea id="monthly-compliment" class="form-control" style="height: 101px" placeholder="Enter here...">${weekly.monthlys[0].compliment}</textarea>
                                        </td>
                                    </tr>
                                    <tr class="text-center">
                                        <td>
                                            <textarea class="form-control" id="monthly-reflectionAndImprovement" style="height: 101px" placeholder="Enter here...">${weekly.monthlys[0].reflectionAndImprovement}</textarea>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-md-12 text-center align-middle mt-3">
                            <button class="btn btn-primary mr-2" onclick="history.back()">
                                Back
                            </button>
                            <button class="btn btn-success ml-2 btn-save">Save</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
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

<div id="myModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true"
     style="display: none;">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="myModalLabel">Expense management</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered border-secondary table-nowrap" style="width: 400px;">
                    <thead>
                    <tr>
                        <th scope="col">Total spending</th>
                        <th scope="col">Spending goals</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="bg-light" id="totalSpending">0</td>
                        <td contenteditable="true" oninput="validateNumberInput(event)" id="spendingGoals">0</td>
                    </tr>
                    </tbody>
                </table>

                <div class="table-responsive">
                    <table class="table table-bordered border-secondary text-center">
                        <thead>
                        <tr id="days"></tr>
                        </thead>
                        <tbody>
                        <tr id="spending"></tr>
                        <tr id="valueSpending"></tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="saveSpending">Save Changes</button>
            </div>
        </div>
    </div>
</div>

<!-- Default Modals -->
<button type="button" class="btn btn-primary d-none" data-bs-toggle="modal" data-bs-target="#imageQuote"
        id="showImageQuoteBtn">Standard Modal
</button>
<div id="imageQuote" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true"
     style="display: none; z-index: 9999">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center border mt-2">
                <img src='${weekly.quotes.image}' alt="Modal Image" id="srcImageQuote"
                     style="max-width: 700px; max-height: 700px;">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
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
<script src="/assets/libs/apexcharts/apexcharts.min.js"></script>
<%--<script src="/assets/js/pages/apexcharts-pie.init.js"></script>--%>

<script>
    function getChartColorsArray(e) {
        if (null !== document.getElementById(e)) return e = document.getElementById(e).getAttribute("data-colors"), (e = JSON.parse(e)).map(function (e) {
            var t = e.replace(" ", "");
            return -1 === t.indexOf(",") ? getComputedStyle(document.documentElement).getPropertyValue(t) || t : 2 == (e = e.split(",")).length ? "rgba(" + getComputedStyle(document.documentElement).getPropertyValue(e[0]) + "," + e[1] + ")" : t
        })
    }

    function formatDate(date) {
        const year = date.getFullYear();
        const month = (date.getMonth() + 1).toString().padStart(2, '0');
        const day = date.getDate().toString().padStart(2, '0');
        return year + '-' + month + '-' + day;
    }

    function getFirstSundayLastSaturday(year, month) {
        const firstSunday = new Date(year, month, 1);
        const lastDay = new Date(year, month + 1, 0);

        return {
            firstSunday,
            lastDay
        };
    }

    function getAllSundays(year, month) {
        var sundays = [];
        var date = new Date(year, month, 1);
        date.setDate(1);

        while (date.getDay() !== 0) {
            date.setDate(date.getDate() - 1);
        }

        do {
            sundays.push(new Date(date));
            date.setDate(date.getDate() + 7);
        } while (date.getMonth() === month);

        sundays = sundays.map(function (sunday) {
            sunday.setDate(sunday.getDate() + 1);
            return sunday.toISOString().split('T')[0];
        });

        return sundays;
    }

    // Handle Tab reivew
    document.addEventListener("DOMContentLoaded", function () {
        const monthTarget = document.getElementById('monthTarget');
        const date = new Date(monthTarget.textContent + "-01");
        const monthName = date.toLocaleString('en-US', { month: 'long' });
        monthTarget.textContent = monthName;
        document.querySelectorAll('.month-current').forEach(function (e) {
             e.textContent = monthName;
        })

        const daysOfMonth = document.getElementById('days-of-month');
        const month = daysOfMonth.getAttribute('data-value');
        const monthDate = new Date(month);
        const numberOfDays = new Date(monthDate.getFullYear(), monthDate.getMonth() + 1, 0).getDate();
        const firstDayOfWeek = new Date(monthDate.getFullYear(), monthDate.getMonth(), 1).getDay();
        const lastDayOfWeek = new Date(monthDate.getFullYear(), monthDate.getMonth(), numberOfDays).getDay();

        let currentWeekDay = firstDayOfWeek;

        for (let i = 1; i < firstDayOfWeek; i++) {
            const td = document.createElement('td');
            td.classList.add('fw-bolder');
            daysOfMonth.appendChild(td);
        }

        for (let i = 1; i <= numberOfDays; i++) {
            const td = document.createElement('td');
            td.classList.add('fw-bolder');

            const day = i < 10 ? '0' + i : i;
            const monthString = (monthDate.getMonth() + 1) < 10 ? '0' + (monthDate.getMonth() + 1) : (monthDate.getMonth() + 1);
            const dateString = monthDate.getFullYear() + '-' + monthString + '-' + day;

            td.textContent = dateString;
            daysOfMonth.appendChild(td);

            td.setAttribute('data-week', dateString);

            if (currentWeekDay === 7) {
                td.classList.add('text-danger');
                currentWeekDay = 1;
            } else {
                currentWeekDay++;
            }
        }

        if (lastDayOfWeek < 6) {
            const nextMonth = new Date(monthDate.getFullYear(), monthDate.getMonth() + 1, 1);
            const remainingDays = 6 - lastDayOfWeek;

            if (remainingDays < 6) {
                for (let i = 1; i <= remainingDays; i++) {
                    const td = document.createElement('td');
                    td.classList.add('fw-bolder');

                    const day = i < 10 ? '0' + i : i;
                    const nextMonthString = (nextMonth.getMonth() + 1) < 10 ? '0' + (nextMonth.getMonth() + 1) : (nextMonth.getMonth() + 1);
                    const nextMonthDateString = nextMonth.getFullYear() + '-' + nextMonthString + '-' + day;

                    td.textContent = nextMonthDateString;
                    td.setAttribute('data-week', nextMonthDateString);
                    daysOfMonth.appendChild(td);
                }
            }
        }

        const totalDailyRoutine = document.querySelectorAll('.review-dailyRoutine').length;
        const tableDailyOnethingRoutine = document.getElementById('table-dailyOnethingRoutine');
        if (tableDailyOnethingRoutine) {
            for (let i = 0; i < 5 + totalDailyRoutine; i++) {
                const tr = document.createElement('tr');
                tr.style.height = '44.5px';
                tr.classList.add('category-review');
                for (let j = 0; j < daysOfMonth.children.length; j++) {
                    const td = document.createElement('td');
                    td.classList.add('fw-bolder');

                    const weekValue = daysOfMonth.children[j].getAttribute('data-week');
                    td.setAttribute('data-week', weekValue);
                    tr.appendChild(td);
                }
                daysOfMonth.insertAdjacentElement('afterend', tr);
            }
        }

        var queryString = window.location.search;
        var urlParams = new URLSearchParams(queryString);
        var currentDayParam = urlParams.get('currentDay');
        var currentDate = new Date(currentDayParam);
        var sundaysInMonth = getAllSundays(currentDate.getFullYear(), currentDate.getMonth());
        const weekGoals = document.querySelectorAll('.weekly-goals');
        const weeklyAmountTime = document.querySelectorAll('.weekly-amountTime');
        const weeklySentence = document.querySelectorAll('.weekly-sentence');

        weekGoals.forEach(function (e, index) {
            const weekIndex = index % sundaysInMonth.length;
            e.setAttribute('data-week', sundaysInMonth[weekIndex]);
        });

        weeklyAmountTime.forEach(function (e, index) {
            const weekIndex = index % sundaysInMonth.length;
            e.setAttribute('data-week', sundaysInMonth[weekIndex]);
        });

        weeklySentence.forEach(function (e, index) {
            const weekIndex = index % sundaysInMonth.length;
            e.setAttribute('data-week', sundaysInMonth[weekIndex]);
        });

        // Function handle Click tab reivew
        function handleClick(e) {
            const result = getFirstSundayLastSaturday(monthDate.getFullYear(), monthDate.getMonth());
            const formattedFirstDay = formatDate(result.firstSunday);
            const formattedLastDay = formatDate(result.lastDay);
            let xhr = new XMLHttpRequest();
            xhr.open("GET", "/api/v1/management-time/calendar/" + "${requestScope.user.id}" + "?startDate=" + formattedFirstDay + "&endDate=" + formattedLastDay, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        const parseData = JSON.parse(xhr.responseText);
                        console.log(parseData)
                        const days = parseData.days;
                        const weeklys = parseData.weeklys;

                        const dayInRow = document.querySelectorAll('.category-review');
                        dayInRow.forEach(function (dayRow, index) {
                            if (index < 5) {
                                dayRow.querySelectorAll('td').forEach(function (onlyDay) {
                                    const dataDay = onlyDay.getAttribute('data-week');
                                    days.forEach(day => {
                                        const dayDate = day.day;
                                        const dayData = day.data;
                                        if (dataDay ==  dayDate) {
                                           if (dayData[index] != null && dayData[index] != '') {
                                               if (dayData[index].performance == true && dayData[index].performance != null) onlyDay.textContent = 'X';
                                           }
                                        }
                                    });
                                })
                            } else if (index >= 5) {
                                dayRow.querySelectorAll('td').forEach(function (onlyDay) {
                                    const dataDay = onlyDay.getAttribute('data-week');
                                    days.forEach(day => {
                                        const dayDate = day.day;
                                        const dataDailyRoutine = day.dailyRoutine;
                                        if (dataDay ==  dayDate) {
                                            if (dataDailyRoutine != null) {
                                                if (dataDailyRoutine[Math.abs(5 - index)] == true) onlyDay.textContent = 'X';
                                            }
                                        }
                                    });
                                })
                            }
                        })

                        const weeklyGoalsRow = document.querySelectorAll('.tr-review-weekly');
                        weeklyGoalsRow.forEach(function (weekRow, index) {
                            weekRow.querySelectorAll('td').forEach(function (onlyWeek) {
                                const startDate = onlyWeek.getAttribute('data-week');
                                weeklys.forEach(week => {
                                    const startDateDB = week.startDate;
                                    if (startDate == startDateDB) {
                                        if (week.weeklys != null) {
                                            const weeklyTarget = week.weeklys[index].content;
                                            const statusWeek = week.weeklys[index].status;
                                            if (weeklyTarget != null && weeklyTarget != '') {
                                                var btnStatus = ``;
                                                if (statusWeek == 'COMPLETE') {
                                                    btnStatus = `<button class="btn btn-success float-end" style="width: 53px"><i class="ri-check-line"></i></button>`
                                                } else if (statusWeek == 'PENDING') {
                                                    btnStatus = `<button class="btn btn-warning float-end" style="width: 53px"><i class="ri-arrow-right-line"></i></button>`
                                                } else if (statusWeek == 'CANCEL') {
                                                    btnStatus = `<button class="btn btn-danger float-end" style="width: 53px"><i class="ri-close-line"></i></button>`
                                                } else if (statusWeek == '') {
                                                    btnStatus = `<button class="btn btn-info float-end">null</button>`
                                                }
                                                const html = `<span>` + weeklyTarget + `</span>`+ btnStatus;
                                                $(onlyWeek).append(html);
                                            }
                                        }
                                    }
                                });
                            })
                        })

                        const weeklyAmountTime = document.querySelectorAll('.tr-weekly-amountTime');
                        weeklyAmountTime.forEach(function (weekRow, index) {
                            weekRow.querySelectorAll('td').forEach(function (onlyWeek) {
                                const startDate = onlyWeek.getAttribute('data-week');
                                weeklys.forEach(week => {
                                    const startDateDB = week.startDate;
                                    if (startDate == startDateDB) {
                                       if (week.weeklys != null) {
                                           const timeusedWeekly = week.weeklys[index + 1].timeUsed;
                                           if (timeusedWeekly != null && timeusedWeekly != '') {
                                               onlyWeek.innerHTML = `<span>` + timeusedWeekly + `</span>` + `/168 hours`;
                                           }
                                       }
                                    }
                                });
                            })
                        })

                        const gratitudeDiaryTr = document.querySelectorAll('.tr-weekly-sentence0');
                        gratitudeDiaryTr.forEach(function (weekRow, index) {
                            weekRow.querySelectorAll('textarea').forEach(function (onlyWeek) {
                                const startDate = onlyWeek.getAttribute('data-week');
                                weeklys.forEach(week => {
                                    const startDateDB = week.startDate;
                                    if (startDate == startDateDB) {
                                        onlyWeek.value = week.gratitudeDiary;
                                    }
                                });
                            })
                        })

                        const complimentTr = document.querySelectorAll('.tr-weekly-sentence1');
                        complimentTr.forEach(function (weekRow, index) {
                            weekRow.querySelectorAll('textarea').forEach(function (onlyWeek) {
                                const startDate = onlyWeek.getAttribute('data-week');
                                weeklys.forEach(week => {
                                    const startDateDB = week.startDate;
                                    if (startDate == startDateDB) {
                                        onlyWeek.value = week.compliment;
                                    }
                                });
                            })
                        })

                        const reflectionAndImproveTr = document.querySelectorAll('.tr-weekly-sentence2');
                        reflectionAndImproveTr.forEach(function (weekRow, index) {
                            weekRow.querySelectorAll('textarea').forEach(function (onlyWeek) {
                                const startDate = onlyWeek.getAttribute('data-week');
                                weeklys.forEach(week => {
                                    const startDateDB = week.startDate;
                                    if (startDate == startDateDB) {
                                        onlyWeek.value = week.reflectionAndImprovement;
                                    }
                                });
                            })
                        })

                        document.querySelectorAll('.weekly-goals').forEach(function (e) {
                            if (e.textContent.trim() == 'COMPLETE') e.classList.add('text-success')
                            else if (e.textContent.trim() == 'PENDING') e.classList.add('text-warning')
                            else if (e.textContent.trim() == 'CANCEL') e.classList.add('text-danger')
                        })

                        document.querySelectorAll('.monthly-goals').forEach(function (e) {
                            if (e.textContent.trim() == 'COMPLETE') e.classList.add('text-success')
                            else if (e.textContent.trim() == 'PENDING') e.classList.add('text-warning')
                            else if (e.textContent.trim() == 'CANCEL') e.classList.add('text-danger')
                        })

                        const weeklyAmountTimeUsed = document.querySelectorAll('.weekly-amountTime');
                        document.querySelectorAll('.performance-time-used-amountTime').forEach(function (e, index) {
                            const elSpan = weeklyAmountTimeUsed[index].querySelector('span');
                            if (elSpan != null) {
                                const timeUsedWeekly = parseFloat(elSpan.textContent);
                                e.textContent = (timeUsedWeekly * 100 / 168).toFixed(2) + '%';
                            } else  e.textContent ='0%';
                        })

                        const currentUrl = window.location.href;
                        const currentDayParam = getParameterByName('currentDay', currentUrl);
                        const currentDate = new Date(currentDayParam);
                        const currentMonth = currentDate.getMonth() + 1;
                        const lastDayOfMonth = new Date(currentDate.getFullYear(), currentMonth, 0).getDate();
                        const hoursInMonth = lastDayOfMonth * 24;
                        const timeUsedMonthly = document.querySelectorAll('.time-used-monthly');
                        const performanceAmountTimeMonthly = document.querySelectorAll('.performance-amountTime-monthly');
                        const arrayTimeUsedCategory = [];
                        document.querySelectorAll('.tr-weekly-amountTime').forEach(function (e, index) {
                            var totalTimeUsedWeekly = 0;
                            e.querySelectorAll('span').forEach(function (eSpan) {
                                totalTimeUsedWeekly += parseFloat(eSpan.textContent);
                            })
                            timeUsedMonthly[index].textContent = totalTimeUsedWeekly + '/' + hoursInMonth + ' hours';
                            performanceAmountTimeMonthly[index].textContent = (totalTimeUsedWeekly * 100 / hoursInMonth).toFixed(2) + '%';
                            arrayTimeUsedCategory.push(totalTimeUsedWeekly)
                        })
                        const btnChart = document.getElementById('btn-chart-time-used');
                        btnChart.addEventListener('click', function (e) {
                            const arrCategory = [];
                            document.querySelectorAll('.review-weekly-goals').forEach(function (e) {
                                arrCategory.push(e.textContent);
                            })
                            var upadatedonutchart, chartPieBasicColors = getChartColorsArray("simple_pie_chart"),
                                chartDonutBasicColors = (chartPieBasicColors && (options = {
                                    series: arrayTimeUsedCategory,
                                    chart: {height: 300, type: "pie"},
                                    labels: arrCategory,
                                    legend: {position: "bottom"},
                                    dataLabels: {dropShadow: {enabled: !1}},
                                    colors: chartPieBasicColors
                                }, (chart = new ApexCharts(document.querySelector("#simple_pie_chart"), options)).render()), getChartColorsArray("simple_dount_chart")),
                                chartDonutupdatingColors = (chartDonutBasicColors && (options = {
                                    series: [44, 55, 41, 17, 15],
                                    chart: {height: 300, type: "donut"},
                                    legend: {position: "bottom"},
                                    dataLabels: {dropShadow: {enabled: !1}},
                                    colors: chartDonutBasicColors
                                }, (chart = new ApexCharts(document.querySelector("#simple_dount_chart"), options)).render()), getChartColorsArray("updating_donut_chart"));
                        })
                        
                       const checkExtraDay = document.getElementById('days-of-month').querySelector('td').textContent;
                        console.log(checkExtraDay)
                    } else {
                        window.location.href = "/management-time/";
                    }
                }
            }
            xhr.send();
            document.getElementById('session-review').removeEventListener('click', handleClick);
        }

        // Call function handleClick
        document.getElementById('session-review').addEventListener('click', handleClick);

        const dailyOnethingRoutine = document.getElementById('daily-onething-routine');
        document.querySelectorAll('.review-dailyRoutine').forEach(function () {
            dailyOnethingRoutine.setAttribute('rowspan', parseInt(dailyOnethingRoutine.getAttribute('rowspan')) + 1);
            dailyOnethingRoutine.style.height = (parseInt(dailyOnethingRoutine.style.height) + 45) + 'px';
        });

    })
    
    // Url api get all book
    function getUrlApiBooks(search, page, pageSize) {
        return '/api/v1/books?search=' + search + '&page=' + page + '&pageSize=' + pageSize;
    }

    // Url pi get book by paramater
    function getCountListApiUrl(search) {
        return '/api/v1/books/count?search=' + search;
    }

    var objPaging = {
        search: '',
        page: 1,
        pageSize: $('#page-count-select').val()
    }

    var table = null;

    // Render data for datatable
    $(document).ready(function () {
        if (isDeleveloper()) {
            $('#add-book-btn').remove();
            document.getElementById('isDeveloper').textContent = '';
        } else {
            $('#add-book-btn').removeClass('d-none');
        }

        table = $('#datatable-book').DataTable({
            ajax: {
                url: getUrlApiBooks(objPaging.search, 1, objPaging.pageSize),
                method: 'GET',
                dataSrc: function (json) {
                    if (json.length != 0) {
                        loadPaging();
                        $('#pagination').addClass('mt-4');
                    } else {
                        removePagingIfExsit();
                        $('#pagination').removeClass('mt-4');
                    }
                    return json;
                }
            },
            columns: [
                {
                    data: 'image',
                    render: function (data, type, row) {
                        return `<img src="` + data + `" height="40"/>`;
                    }

                },
                {
                    data: 'title',
                    render: function (data, type, row) {
                        return `<a class="fw-medium link-primary text-decoration-underline" href="/books/` + row.id + `">` + data + `</a>`;
                    }
                },
                {data: 'author'},
                {data: 'createdBy'},
                {data: 'createdDate'},
                {data: 'timeSpentReading'},
                {data: 'note'}
            ],
            searching: false,
            paging: false,
            lengthChange: false,
            ordering: false,
            info: false
        });
    });

    // Handle user use function search
    $(document).on('click', '#filter-btn', function () {
        objPaging.search = $('#search-input').val();
        objPaging.page = 1;

        var btn = $(this);
        btn.find('.spinner-border').removeClass('d-none');

        table.ajax.url(getUrlApiBooks(objPaging.search,
            objPaging.page, objPaging.pageSize)).load(function () {
            btn.find('.spinner-border').addClass('d-none');
        });
    });

    // Handle user change page count
    $(document).on('change', '#page-count-select', function () {
        var selectedValue = $(this).val();
        objPaging.page = 1;
        objPaging.pageSize = selectedValue;

        var selectContainerE = $(this).closest('.page-count-item-container');
        selectContainerE.find('.spinner-border').removeClass('d-none');
        table.ajax.url(getUrlApiBooks(objPaging.search,
            objPaging.page, objPaging.pageSize)).load(function () {
            selectContainerE.find('.spinner-border').addClass('d-none');
        });
    });

    // Remove table if it exsit
    function removePagingIfExsit() {
        if (window.pagObj) {
            window.pagObj.twbsPagination('destroy');
        }
    }

    // Function when user next page list book
    function loadPaging() {
        callAjaxByJsonWithData(getCountListApiUrl(objPaging.search), 'GET', null, function (totalItem) {

            removePagingIfExsit();

            //paging
            var totalPages = 0;
            if (totalItem <= objPaging.pageSize) totalPages = 1;
            else totalPages = Math.ceil(totalItem / objPaging.pageSize);
            var currentPage = objPaging.page;

            $(function () {
                window.pagObj = $('#pagination').twbsPagination({
                    totalPages: totalPages,
                    startPage: currentPage,
                    onPageClick: function (event, page) {
                        if (currentPage != page) {
                            objPaging.page = page;
                            table.ajax.url(getUrlApiBooks(objPaging.search,
                                objPaging.page, objPaging.pageSize)).load();
                            currentPage = page;
                        }
                    }
                });
            });
        });
    }

    // Handle change content Category Color
    caculatorTimeUsage();
    function caculatorTimeUsage() {
        const trColorCategory = document.querySelectorAll('.tr-color-category');
        const columColor1 = [], columColor2 = [], columColor3 = [], columColor4 = [];
        trColorCategory.forEach(function (e) {
            columColor1.push(e.querySelectorAll('td')[0].textContent);
            columColor2.push(e.querySelectorAll('td')[1].textContent);
            columColor3.push(e.querySelectorAll('td')[2].textContent);
            columColor4.push(e.querySelectorAll('td')[3].textContent);
        })

        const performanceOfDay = document.querySelectorAll('.performance-of-day');
        document.querySelectorAll('.total-time-day').forEach(function (eTotal, index) {
            var count1 = 0, count2 = 0, count3 = 0, count4 = 0;
            document.querySelectorAll('.actual-timeLine').forEach(function (e) {
                for (var i = 0; i < 7; i++) {
                    if (index == i) {
                        if (e.getAttribute('data-day') == eTotal.getAttribute('data-day')) {
                            if (columColor1.includes(e.textContent) && e.textContent != '') {
                                count1++;
                            }
                        }
                        eTotal.textContent = count1 * 0.5 + '/24 hours';
                        performanceOfDay[index].textContent = ((count1 * 0.5) * 100 /24).toFixed(2) + '%';
                    }
                }
                for (var i = 7; i < 14; i++) {
                    if (index == i) {
                        if (e.getAttribute('data-day') == eTotal.getAttribute('data-day')) {
                            if (columColor2.includes(e.textContent) && e.textContent != '') {
                                count2++;
                            }
                        }
                        eTotal.textContent = count2 * 0.5 + '/24 hours';
                        performanceOfDay[index].textContent = ((count2 * 0.5) * 100 /24).toFixed(2) + '%';
                    }
                }
                for (var i = 14; i < 21; i++) {
                    if (index == i) {
                        if (e.getAttribute('data-day') == eTotal.getAttribute('data-day')) {
                            if (columColor3.includes(e.textContent) && e.textContent != '') {
                                count3++;
                            }
                        }
                        eTotal.textContent = count3 * 0.5 + '/24 hours';
                        performanceOfDay[index].textContent = ((count3 * 0.5) * 100 /24).toFixed(2) + '%';
                    }
                }
                for (var i = 21; i < 28; i++) {
                    if (index == i) {
                        if (e.getAttribute('data-day') == eTotal.getAttribute('data-day')) {
                            if (columColor4.includes(e.textContent) && e.textContent != '') {
                                count4++;
                            }
                        }
                        eTotal.textContent = count4 * 0.5 + '/24 hours';
                        performanceOfDay[index].textContent = ((count4 * 0.5) * 100 /24).toFixed(2) + '%';
                    }
                }
            })
        })

        const totalTimeCategory = document.querySelectorAll('.total-category');
        document.querySelectorAll('.tr-timeReport').forEach(function (eTr, index) {
            var total = 0;
            eTr.querySelectorAll('td').forEach(function (eTd, index) {
                if (index == 0) total += parseFloat(eTd.textContent);
            })
            totalTimeCategory[index].innerHTML = 'Total time: ' + '<span class="text-danger time-used-category fw-bolder">' + total + '</span>' +' hours';
        })
    }

    // Handle change content Category Color
    document.addEventListener("DOMContentLoaded", function () {
        const elColorCategory = document.querySelectorAll('.color-category');
        const titleReportCategory = document.querySelectorAll('.title-report-category');
        const reviewWeeklyGoals = document.querySelectorAll('.review-weekly-goals');
        const reivewWeeklyAmountTime = document.querySelectorAll('.review-weekly-amount-time');
        const reivewDailyOnething = document.querySelectorAll('.reivew-daily-onething');
        const yearTitle = document.querySelectorAll('.yearTitle');

        yearTitle.forEach(function (e, index) {
            if (index != 0) {
                if (e.textContent != '') {
                    elColorCategory[index - 1].textContent = e.textContent;
                    titleReportCategory[index - 1].textContent = e.textContent;
                    titleReportCategory[index - 1].style.backgroundColor = yearTitle[index].style.backgroundColor;
                    reviewWeeklyGoals[index - 1].textContent = e.textContent;
                    reviewWeeklyGoals[index - 1].style.backgroundColor = yearTitle[index].style.backgroundColor;
                    reivewWeeklyAmountTime[index - 1].textContent = e.textContent;
                    reivewWeeklyAmountTime[index - 1].style.backgroundColor = yearTitle[index].style.backgroundColor;
                }
            }
            reivewDailyOnething[0].classList.add('text-danger', 'fw-bolder')
            reivewDailyOnething[index].textContent = e.textContent;
            reivewDailyOnething[index].style.backgroundColor = yearTitle[index].style.backgroundColor;
        })
    })

    // Handle performance onething calendar
    document.addEventListener("DOMContentLoaded", function () {
        const tartgetOnething = document.querySelectorAll('.target-onething');
        const rateOnething = document.querySelectorAll('.rate-onething');
        const reviewRateOnthing = document.querySelectorAll('.review-rate-ongthing');
        const reviewPerformanceOnthing = document.querySelectorAll('.review-performance-onething');

        document.querySelectorAll('.performance-onething').forEach(function (e, index) {
            reviewPerformanceOnthing[index].textContent = e.textContent;
            if (tartgetOnething[index].textContent != 0) {
                rateOnething[index].textContent = parseFloat((parseInt(e.textContent.trim()) * 100) / parseInt(tartgetOnething[index].textContent.trim())).toFixed(2) + ' %';
                reviewRateOnthing[index].textContent = rateOnething[index].textContent;
            } else  rateOnething[index].textContent = '0 %'
        })

    })

    // Function change color and content Status
    function addStatus(btn, value) {
        switch (value) {
            case 'PENDING':
                $(btn).removeClass('btn-info btn-danger btn-success');
                $(btn).addClass('btn-warning');
                btn.setAttribute('data-value', 'PENDING');
                $(btn).text('');
                $(btn).append(`<i class="ri-arrow-right-line"></i>`);
                break;
            case 'CANCEL':
                $(btn).removeClass('btn-info btn-warning btn-success');
                $(btn).addClass('btn-danger');
                $(btn).text('');
                btn.setAttribute('data-value', 'CANCEL');
                $(btn).append(`<i class="ri-close-line"></i>`);
                break;
            case 'COMPLETE':
                $(btn).removeClass('btn-info btn-warning btn-danger');
                $(btn).addClass('btn-success');
                btn.setAttribute('data-value', 'COMPLETE');
                $(btn).text('');
                $(btn).append(`<i class="ri-check-line">`);
                break;
        }
    }

    // Handle Change status by button setting
    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll('.btn-status').forEach(function (e) {
            const statusValue = e.getAttribute('data-value');
            addStatus(e, statusValue);
        })
        document.querySelectorAll('.pending').forEach(function (e) {
            e.addEventListener('click', function () {
                const btnPending = e.parentNode.parentNode.previousElementSibling;
                addStatus(btnPending, 'PENDING');
            })
        })
        document.querySelectorAll('.close').forEach(function (e) {
            e.addEventListener('click', function () {
                const btnClose = e.parentNode.parentNode.previousElementSibling;
                addStatus(btnClose, 'CANCEL');
            })
        })
        document.querySelectorAll('.complete').forEach(function (e) {
            e.addEventListener('click', function () {
                const btnComplete = e.parentNode.parentNode.previousElementSibling;
                addStatus(btnComplete, 'COMPLETE');
            })
        })
    })

    // Function show Dream Board when user shoose image
    function previewImage() {
        var input = document.getElementById('quoteImage');
        var preview = document.getElementById('imagePreview');

        if (input.files && input.files[0]) {
            $(preview).removeClass('d-none');
            var reader = new FileReader();

            reader.onload = function (e) {
                var image = document.createElement('img');
                image.src = e.target.result;
                image.style.maxWidth = '100%';
                image.style.maxHeight = '200px';

                preview.innerHTML = '';
                preview.appendChild(image);
            };

            reader.readAsDataURL(input.files[0]);
        } else {
            $(preview).addClass('d-none');
            $(preview).find('img').remove();
        }
    }

    function getParameterByName(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }

    // Handle expenseManagement when user click button Expense management
    document.getElementById('expenseManagement').addEventListener('click', function (e) {
        var currentUrl = window.location.href;
        var currentDayParam = getParameterByName('currentDay', currentUrl);
        if (currentDayParam) {
            var currentDate = new Date(currentDayParam);
            var month = (currentDate.getMonth() + 1).toString().padStart(2, '0');
            var year = currentDate.getFullYear();
            var firstDayOfMonth = new Date(year, month - 1, 1);
            var lastDayOfMonth = new Date(year, month + 1, 0);
            var allDaysInMonth = [];
            for (var day = firstDayOfMonth.getDate(); day <= lastDayOfMonth.getDate(); day++) {
                var formattedDay = year + '-' + month + '-' + day.toString().padStart(2, '0');
                allDaysInMonth.push(formattedDay);
            }
            callAjaxByJsonWithData('/api/v1/management-time/weekly-detail/spending/' + '${user.id}' + '?monthCode=' + year + '-' + month, 'GET', null, function (rs) {
                const data = rs;
                var spendingGoals = data.spendingGoals;
                if (spendingGoals == '' || spendingGoals == null) spendingGoals = '0'
                document.getElementById('spendingGoals').textContent = spendingGoals;
                allDaysInMonth.forEach(function (day) {
                    const newDay = '<th scope="col" colspan="2" class="spendingDays" data-day="' + day + '">' + day + '</th>';
                    const spending = '<td class="fw-bolder">Spending</td><td class="fw-bolder">Daily Budget</td>';
                    const valueSpending = '<td data-day="' + day + '" class="valueSpending" contenteditable="true" oninput="validateNumberInput(event)">0</td><td class="dailyBudget bg-light">0</td>';
                    $('#days').append(newDay);
                    $('#spending').append(spending);
                    $('#valueSpending').append(valueSpending);
                })
                document.getElementById('saveSpending').setAttribute('data-month', year + '-' + month);

                data.spending.forEach(function (e, i) {
                    var element = $('.valueSpending[data-day="' + e.day + '"]');
                    element.text(e.spending);
                });

                const elTotalSpending = document.getElementById('totalSpending');
                const elSpendingGoals = document.getElementById('spendingGoals');
                var totalSpending = parseFloat(elTotalSpending.textContent);
                var spendingGoals = parseFloat(elSpendingGoals.textContent);
                var dailyBudget = document.querySelectorAll('.dailyBudget');
                document.querySelectorAll('.valueSpending').forEach(function (e, index) {
                    if (e.textContent != null && e.textContent != '') {
                        totalSpending += parseFloat(e.textContent);
                        spendingGoals -= parseFloat(e.textContent);
                        dailyBudget[index].textContent = spendingGoals;
                    }
                })
                elTotalSpending.textContent = totalSpending;
            })
        }
    })

    // Show modal expenseManagement when user save expenseManagement success
    document.addEventListener("DOMContentLoaded", function () {
        const result = localStorage.getItem('result');
        if (result == 'saveExpenseSuccess') {
            document.getElementById('expenseManagement').click();
            localStorage.clear();
        }
    })

    // Handle height px of Daily Routine
    document.addEventListener("DOMContentLoaded", function () {
        const dailySession = document.getElementById('daily-routine');
        var heightDaily = parseFloat(dailySession.style.height);
        var count = 0;
        document.querySelectorAll('.checkDailyRoutine').forEach(function (e) {
            var tdDaily = e.getElementsByTagName('td');
            var lastElement = tdDaily[tdDaily.length - 2];
            if (lastElement.textContent == '') {
                count++;
                if (count != 5) {
                    $(e).addClass('d-none');
                    heightDaily = heightDaily - 32.5;
                }
            }
        });
        if (count == 4 || count == 5) $(dailySession).addClass('p-0');
        dailySession.style.height = heightDaily + 'px';
    })

    // Handle when user click add more Daily Routine
    document.addEventListener("DOMContentLoaded", function () {
        const checkDaily = document.querySelectorAll('.checkDaily');
        const dailyObjective = document.getElementById('daily-objective');
        var countValue = 0;
        checkDaily.forEach(function (e) {
            if (e.getAttribute('value') == '') {
                const trElment = e.parentNode;
                trElment.remove();
            } else if (e.getAttribute('value') != '') countValue++;
        })
        dailyObjective.setAttribute('rowspan', countValue + 1);
        const btnAddDaily = document.getElementById('addDaily');
        if (countValue == 5) {
            btnAddDaily.innerHTML = `<i class="bx bx-minus"></i>`
            $('#addDaily').removeClass('btn-success');
            $('#addDaily').addClass('btn-danger');
        }
        btnAddDaily.addEventListener('click', function () {
            const rowspanDaily = parseInt(dailyObjective.getAttribute('rowspan'))
            if (btnAddDaily.classList.contains('btn-success')) {
                const newDaily = '<tr name="theSingleMostImportantThing"> <td><input class="form-control dailyRoutineInput" type="text"></td> <td class="text-center">0% </td> <td class="text-center dailyRoutineTarget" contenteditable="true" onkeydown="return isNumberKey(event)" onclick="checkDaily()"> 0 </td> <td class="text-center">0</td> </tr>';
                dailyObjective.setAttribute('rowspan', rowspanDaily + 1);
                $(newDaily).insertBefore('#dailySession');
                countValue++;

                if (countValue == 5) {
                    btnAddDaily.innerHTML = `<i class="bx bx-minus"></i>`
                    $('#addDaily').removeClass('btn-success');
                    $('#addDaily').addClass('btn-danger');
                }
            } else if (btnAddDaily.classList.contains('btn-danger')) {
                var pToDelete = $("#dailySession").prev("tr");
                if (pToDelete.length > 0) pToDelete.remove();
                dailyObjective.setAttribute('rowspan', rowspanDaily - 1);
                countValue--;
                if (countValue == 1) {
                    btnAddDaily.innerHTML = `<i class="bx bx-plus"></i>`
                    $('#addDaily').removeClass('btn-danger');
                    $('#addDaily').addClass('btn-success');
                }
            }
        })
    })

    // Handle when user click add more Quote
    document.addEventListener("DOMContentLoaded", function () {
        const checkQuote = document.querySelectorAll('.checkQuote');
        var countValue = 0;
        checkQuote.forEach(function (e) {
            if (e.getAttribute('value') == '') {
                const trElment = e.parentNode;
                trElment.remove();
            } else if (e.getAttribute('value') != '') countValue++;
        })
        const btnAddQuote = document.getElementById('addQuote');
        if (countValue == 4) {
            btnAddQuote.textContent = 'Remove';
            $('#addQuote').removeClass('btn-success');
            $('#addQuote').addClass('btn-danger');
        }
        btnAddQuote.addEventListener('click', function () {
            if (btnAddQuote.textContent == 'ADD') {
                const newQuote = '<tr><td><input class="form-control quotes" type="text"></td></tr>';
                $(newQuote).insertBefore('#quoteSession');
                countValue++;

                if (countValue == 4) {
                    btnAddQuote.textContent = 'Remove';
                    $('#addQuote').removeClass('btn-success');
                    $('#addQuote').addClass('btn-danger');
                }
            } else if (btnAddQuote.textContent == 'Remove') {
                var pToDelete = $("#quoteSession").prev("tr");
                if (pToDelete.length > 0) pToDelete.remove();
                countValue--;
                if (countValue == 0) {
                    btnAddQuote.textContent = 'ADD';
                    $('#addQuote').removeClass('btn-danger');
                    $('#addQuote').addClass('btn-success');
                }
            }
        })
    })

    // Function only allows users to enter numbers
    function validateNumberInput(event) {
        var inputText = event.target.textContent;
        var numericValue = inputText.replace(/[^\d.]/g, '');
        var decimalCount = (numericValue.match(/\./g) || []).length;
        if (decimalCount > 1) {
            numericValue = numericValue.substring(0, numericValue.lastIndexOf('.'));
        }

        event.target.textContent = numericValue;
        placeCaretAtEnd(event.target);
    }

    // Function move the cursor to the end of the input cell after deleting the literal character
    function placeCaretAtEnd(el) {
        var range = document.createRange();
        var sel = window.getSelection();
        range.selectNodeContents(el);
        range.collapse(false);
        sel.removeAllRanges();
        sel.addRange(range);
        el.focus();
    }

    // Function Check if there is notification content and display the notification
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

    // Check notification content
    document.addEventListener("DOMContentLoaded", function () {
        var rows = document.querySelectorAll('tr[name="timeLine"]');
        rows.forEach(function (row) {
            checkRow(row);
        });
    });

    // Delete input quote if there is no content
    document.addEventListener("DOMContentLoaded", function () {
        var quotes = document.querySelectorAll('.notiQuote');
        quotes.forEach(function (quote) {
            if (quote.querySelector('p').textContent == '') $(quote).remove();
        });
    });

    // Handle add content and icon notification when user right click
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

    // Handle when content notification is null -> hide icon
    document.addEventListener("DOMContentLoaded", function () {
        var plant = document.querySelectorAll('.setting');
        plant.forEach(function (elementPlant) {
            const note = elementPlant.querySelector('.note');
            const contentNotiPlan = note.getAttribute('data-value');
            if (contentNotiPlan == '' || contentNotiPlan == null) elementPlant.querySelectorAll('img')[1].classList.add('d-none');
            else elementPlant.querySelectorAll('img')[1].classList.remove('d-none');
        })
    })

    // Show modal notification
    function showModal(element) {
        const isAllowedNoti = element.innerText;

        function saveNotiHandler() {
            var contentNotiPlant = document.getElementById('contentNotiPlan').value;
            element.setAttribute('data-value', contentNotiPlant);
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

    // Handle show image quote + message success when user save all success
    document.addEventListener("DOMContentLoaded", function () {
        $(".containerLoading").addClass("d-none")
        $("div.calendar-container").removeClass("d-none")

        const result = localStorage.getItem('result');
        const image = '${weekly.quotes.image}';
        switch (true) {
            case (result == 'addSuccess'):
                Swal.fire(
                    {
                        html: '<div class="mt-1 text-center"><div class="d-flex align-items-center justify-content-center"><i class="ri-calendar-check-line text-success fs-3 mb-2 me-1"></i><h4 class="text-success">Well done !</h4></div><p class="text-muted mx-4 mb-0">' + 'Success' + ' successfully</p></div></div>' +
                            '<img src="' + image + '" alt="A tall image" class="custom-image-class border" style="max-height: 700px; max-width: 700px">',
                        imageAlt: 'A tall image',
                        confirmButtonClass: 'btn btn-primary w-xs mt-2',
                        buttonsStyling: false,
                        showCloseButton: true,
                        width: 800
                    }
                )
                if (image == '') document.querySelector('img.custom-image-class.border').classList.add('d-none');
                document.getElementById('imageQuote').style.display = 'none';
                localStorage.clear();
                break;
            case !(result == 'addSuccess'):
                if (document.getElementById('srcImageQuote').getAttribute('src') != '') document.getElementById('showImageQuoteBtn').click();
                break;
            default:
                break;
        }
    })

    // Loading when wait api load done
    window.addEventListener('beforeunload', function (event) {
        $(".containerLoading").removeClass("d-none");
        $("div.calendar-container").addClass("d-none")
        $(".col-12.p-0").addClass("d-none");
    });

    // Only daily routines <= 30
    function checkDaily() {
        $('td.target-onething').on('blur', function () {
            const target = $(this).text();
            if (target > 31 || target < 0) {
                validateFail("Onething target shouldn't exceed 30 or below 0");
                return false;
            }
        });

        $('td.dailyRoutineTarget').on('blur', function () {
            const target = $(this).text();
            if (target > 31 || target < 0) {
                validateFail("Daily target shouldn't exceed 30 or below 0");
                return false;
            }
        });
    }

    checkDaily();
    const inputString = '${weekly.colors}';
    const valuesRegex = /\bvalues=\[(.*?)\]/g;
    const matches = inputString.match(valuesRegex);
    let allValues = matches ? matches.map(match => {
        const innerValues = match.replace('values=[', '').replace(']', '');
        return innerValues.split(',').map(value => value.trim());
    }).flat() : [];

    $('td.key-color').on('blur', function () {
        allValues = [];
        $('td.key-color').each(function () {
            const target = $(this).text().trim();
            if (target !== '') {
                allValues.push(target);
            }
        });
    });

    // Handle when user click check box Performance
    $(document).ready(function () {
        checkInitialValue();

        $('td.editable-cell').on('input', function () {
            checkInitialValue();
        });
    });

    // Function check box Performance
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

        if (charCode === 8) {
            return true;
        }
        if ((charCode >= 48 && charCode <= 57) || (charCode >= 96 && charCode <= 105)) {
            return true;
        } else {
            evt.preventDefault();
            return false;
        }
    }

    // Handle user click save all
    $('.btn-save').on('click', function() {
        if (hasDuplicates(allValues)) {
            validateFail("Keyword should not be same");
        } else {
            caculatorTimeUsage();
            $(this).prop('disabled', true);
            $('#tab-session').addClass('d-none');
            $("div.containerLoading").removeClass("d-none");
            $("div.calendar-container").addClass("d-none");
            const currentYearMonth = getCurrentYearMonth();
            const data = {
                userId: '${user.id}',
                days: [],
                weekly: {},
                weeklysReview: [],
                monthly: {},
                colors: [],
                quotes: {},
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
                targetCategory: [],
            };
            const weekly = {
                startDay: getPreviousSunday(currentYearMonth.currentDayParam),
                weeklys: []
            };
            $('.monthTarget').each(function () {
                const statusMonth = $(this).closest('div').find('button');
                var valueStatus = statusMonth.data('value');
                if (valueStatus == undefined) valueStatus = '';
                let obj = {
                    content: $(this).val(),
                    status: valueStatus
                }
                monthly.content.push(obj);
            });
            $('input.dailyRoutineInput').each(function () {
                let obj = {
                    title: $(this).val(),
                    target: $(this).closest('tr').find('.dailyRoutineTarget').text()
                }
                monthly.dailyRoutine.push(obj)
            })
            const targetOnething = document.querySelectorAll('.target-onething');
            const performanceOnthing = document.querySelectorAll('.performance-onething');
            targetOnething.forEach(function (e, index) {
                let obj = {
                    target: e.textContent.trim() == '' ? '0' : e.textContent.trim(),
                    performance: performanceOnthing[index].textContent.trim() == '' ? '0' : performanceOnthing[index].textContent.trim()
                }
                monthly.targetCategory.push(obj);
            })
            monthly.gratitudeDiary = document.getElementById('monthly-gratitudeDiary').value;
            monthly.compliment = document.getElementById('monthly-compliment').value;
            monthly.reflectionAndImprovement = document.getElementById('monthly-reflectionAndImprovement').value;
            data.monthly = monthly;

            const timeUsedCategory = document.querySelectorAll('.time-used-category');
            $("input.form-control.weekTarget").each(function (index) {
                const statusWeekly = $(this).closest('div').find('button');
                var timeUsed = '';
                var valueStatus = statusWeekly.data('value');
                if (valueStatus == null || valueStatus == undefined) valueStatus = '';
                if (index != 0) timeUsed = timeUsedCategory[index - 1].textContent;
                let obj = {
                    content: $(this).val(),
                    status: valueStatus,
                    timeUsed: timeUsed
                }
                weekly.weeklys.push(obj);
            })
            data.weekly = weekly;

            const tr0 = document.querySelector('.tr-weekly-sentence0').querySelectorAll('textarea');
            const tr1 = document.querySelector('.tr-weekly-sentence1').querySelectorAll('textarea');
            const tr2 = document.querySelector('.tr-weekly-sentence2').querySelectorAll('textarea');;
            tr0.forEach(function (e, index) {
                let obj = {
                    startDay: e.getAttribute('data-week'),
                    gratitudeDiary: e.value,
                    compliment: tr1[index].value,
                    reflectionAndImprovement: tr2[index].value
                }
                data.weeklysReview.push(obj)
            })

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
                if (value !== "" && value != 'Allow notifications') {
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
            data.quotes.quotes = quotes;

            var queryString = window.location.search;
            var urlParams = new URLSearchParams(queryString);
            var currentDayParam = urlParams.get('currentDay');
            var currentDate = new Date(currentDayParam);
            var year = currentDate.getFullYear().toString();

            data.year = {
                year: year,
                target: [],
                category: []
            };

            var yearTarget = document.querySelectorAll('.yearTarget');
            yearTarget.forEach(function (target) {
                data.year.target.push(target.value);
            })
            document.querySelectorAll('.yearTitle').forEach(function (e) {
                data.year.category.push(e.textContent);
            })
            data.days.push(...days);

            const imageQuote = document.getElementById('quoteImage').files[0];
            const formData = new FormData();
            formData.append('files', imageQuote);
            const weeklyData = data.weekly.startDay;
            const weeklyReviewData = data.weeklysReview;
            for (let i = 0; i < weeklyReviewData.length; i++) {
                const currentItem = weeklyReviewData[i];
                if (currentItem.startDay === weeklyData) {
                    data.weekly.gratitudeDiary = currentItem.gratitudeDiary;
                    data.weekly.compliment = currentItem.compliment;
                    data.weekly.reflectionAndImprovement = currentItem.reflectionAndImprovement;
                    data.weeklysReview.splice(i, 1);
                    i--;
                }
            }
            console.log(data)
            callAjaxByDataFormWithDataForm("/api/v1/upload?typeFile=" + M_QUOTE, "POST", formData, function (rs) {
                data.quotes.image = rs[0];
                callAjaxByJsonWithData("/api/v1/management-time/weekly-detail", "POST", data, function (rs) {
                    if (rs) {
                        $("div.containerLoading").addClass("d-none")
                        $("div.calendar-container").removeClass("d-none")
                        localStorage.setItem('result', 'addSuccess');
                        window.location.reload();
                    } else {
                        rsUnSuccess();
                        $("div.containerLoading").addClass("d-none")
                        $("div.calendar-container").removeClass("d-none")
                    }
                })
            })
        }
    });

    // Handle user click save Expense management
    document.getElementById('saveSpending').addEventListener('click', function () {
        $("div.containerLoading").removeClass("d-none");
        document.getElementById('myModal').style.display = 'none';
        const monthSpending = {};
        monthSpending.spendingGoals = parseFloat(document.getElementById('spendingGoals').textContent)

        const spendingDays = document.querySelectorAll('.spendingDays');
        const daysArray = [];
        document.querySelectorAll('.valueSpending').forEach(function (e, index) {
            if (e.textContent != null && e.textContent != '' && e.textContent != '0') {
                const obj = {
                    day: spendingDays[index].getAttribute('data-day'),
                    spending: parseFloat(e.textContent)
                };
                daysArray.push(obj);
            }
        })
        monthSpending.days = daysArray;
        monthSpending.month = this.getAttribute('data-month');
        monthSpending.userId = '${user.id}';
        callAjaxByJsonWithData('/api/v1/management-time/weekly-detail/spending', 'POST', monthSpending, function () {
            localStorage.setItem('result', 'saveExpenseSuccess');
            location.reload();
        })
    })

    // Handle scrollbars through days of the week
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
