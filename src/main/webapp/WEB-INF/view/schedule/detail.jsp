<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.util.Calendar" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Schedule Detail</title>
    <link rel="stylesheet" href="../../../assets/css/schedule/style.css">
</head>
<body>
<div class="container text-center mt-5">
    <h1>Schedule Detail</h1>
</div>

<div class="container mt-4">
    <div class="row">
        <div class="col-md-8">
            <div class="form-row">
                <div class="col">
                    <label for="datePickerStart">Choose time start:</label>
                    <input type="date" id="datePickerStart" class="form-control">
                </div>
                <div class="col">
                    <label for="datePickerEnd">Choose time end:</label>
                    <input type="date" id="datePickerEnd" class="form-control">
                </div>
                <div class="col">
                    <p class="margin-filter"></p>
                    <button class="btn btn-primary" onclick="getScheduleByDate()">Filter</button>
                </div>
            </div>
        </div>
        <div class="col-md-4 text-right">
            <p class="margin-filter"></p>
            <p>Username: <b>${schedule.user.fullname}</b></p>
        </div>
    </div>
</div>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
    Calendar calendar = Calendar.getInstance();
    // Lấy ngày đầu tiên của tháng hiện tại
    calendar.set(Calendar.DAY_OF_MONTH, 1);
    String startDateStr = sdf.format(calendar.getTime());
    calendar.add(Calendar.MONTH, 1);
    calendar.add(Calendar.DATE, -1);
    String endDateStr = sdf.format(calendar.getTime());
    Date startDate = null;
    Date endDate = null;
    long day,daydiff;
    try {
        startDate = sdf.parse(startDateStr);
        endDate = sdf.parse(endDateStr);
        day = startDate.getTime();
        daydiff =((endDate.getTime()-startDate.getTime()) / (1000 * 60 * 60 * 24)) + 1;
    } catch (ParseException e) {
        throw new RuntimeException(e);
    }
%>
<div class="container mt-4" style="overflow-x: auto; max-width: 100%;">
    <table class="table table-bordered table-striped">
        <thead class="thead-dark text-center">
        <tr id="taskTotalDate">
            <th>Task/Date</th>
            <%
                for (; day <= endDate.getTime(); day += 86400000) {
                    Date currentDate = new Date(day);
            %>
            <th><%=new SimpleDateFormat("yyyy/MM/dd").format(currentDate)%>
            </th>
            <%
                }
            %>
        </tr>
        </thead>
        <tbody id="taskTotalElement" class="width-auto text-center">
        <c:choose>
            <c:when test="${not empty requestScope.schedule.list}">
                <c:forEach items="${requestScope.schedule.list}" var="s">
                    <tr>
                        <th scope="col" class="bg-dark align-middle">${s.title}</th>
                        <c:set var="startDate" value="${s.startDate}"/>
                        <c:set var="dueOrCloseDate" value="${s.dueOrCloseDate}"/>

                        <script>
                            var currentDay = new Date();
                            var selectedStartDate = new Date(currentDay.getFullYear(), currentDay.getMonth(), 1);
                            var selectedEndDate = new Date(currentDay.getFullYear(), currentDay.getMonth() + 1, 0);
                            console.log(selectedStartDate);

                            var startDate = new Date("${startDate}");
                            startDate = new Date(startDate.getFullYear(), startDate.getMonth(), startDate.getDate());
                            var subStringDueOrCloseDate = "${dueOrCloseDate}";
                            subStringDueOrCloseDate = subStringDueOrCloseDate.replace("~ ", "");
                            var dueOrCloseDate = new Date(subStringDueOrCloseDate);
                            dueOrCloseDate = new Date(dueOrCloseDate.getFullYear(), dueOrCloseDate.getMonth(), dueOrCloseDate.getDate());
                            var status = "${s.statusTask.code}";
                            var id = "${s.id}";
                            var statusDuration;
                            console.log(startDate);
                            if (startDate < selectedStartDate) {
                                console.log("A")
                                statusDuration = dueOrCloseDate - selectedStartDate;
                            } else {
                                statusDuration = dueOrCloseDate - startDate;
                            }
                            var daysDiff = (statusDuration / (1000 * 60 * 60 * 24)) + 1;
                            var color;
                            if (status === 'OPENED') {
                                color = 'bg-warning';
                            } else if (status === 'REOPENED') {
                                color = 'bg-primary';
                            } else if (status === 'POSTPONED') {
                                color = 'bg-danger';
                            } else if (status === 'CLOSED') {
                                color = 'bg-success';
                            } else {
                                color = 'bg-secondary';
                            }
                            var checkStartDateIsBefore = true;
                            while (selectedStartDate.getTime() <= selectedEndDate.getTime()) {
                                if (selectedStartDate.getTime() > startDate.getTime() && checkStartDateIsBefore) {
                                    document.write('<td colspan="' + daysDiff + '" class="rounded-pill text-center align-middle ' + color + '"><a href="/tasks/' + id + '" class="btn font-weight-bold">' + status + '</a></td>');
                                    selectedStartDate = new Date(selectedStartDate.getTime() + 86400000 * daysDiff);
                                    checkStartDateIsBefore = false;
                                } else if (selectedStartDate.getTime() === startDate.getTime()) {
                                    document.write('<td colspan="' + daysDiff + '" class="rounded-pill text-center align-middle ' + color + '"><a href="/tasks/' + id + '" class="btn font-weight-bold">' + status + '</a></td>');
                                    selectedStartDate = new Date(selectedStartDate.getTime() + 86400000 * daysDiff);
                                    checkStartDateIsBefore = false;
                                } else {
                                    document.write('<td></td>');
                                    selectedStartDate = new Date(selectedStartDate.getTime() + 86400000);
                                }
                            }
                        </script>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <th scope="col" class="bg-dark align-middle"></th>
                    <td class="text-center font-weight-bold" colspan="<%= daydiff %>">NO RESULT IN THIS DURATION</td>
                    <script>
                        var selectedEndDate = new Date();
                    </script>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</div>
<script>
    var defaultDate = new Date();
    var year = defaultDate.getFullYear();
    var month = defaultDate.getMonth() + 1;
    var lastDay = new Date(year, month, 0).getDate();
    var formattedDateStart = year + '-' + (month < 10 ? '0' : '') + month + '-01';
    var formattedDateEnd = year + '-' + (month < 10 ? '0' : '') + month + '-' + lastDay;

    document.getElementById("datePickerStart").value = formattedDateStart;
    document.getElementById("datePickerEnd").value = formattedDateEnd;

    document.getElementById("datePickerStart").addEventListener("input", function () {
        localStorage.setItem("choiceStartDate", this.value);
    });

    document.getElementById("datePickerEnd").addEventListener("input", function () {
        localStorage.setItem("choiceEndDate", this.value);
    });
    window.addEventListener("beforeunload", function () {
        localStorage.removeItem("choiceStartDate");
        localStorage.removeItem("choiceEndDate");
        document.getElementById("datePickerStart").value = "";
        document.getElementById("datePickerEnd").value = "";
    });

    function getScheduleByDate() {
        let userId = "${schedule.user.id}";
        var choiceStartDate = localStorage.getItem("choiceStartDate") || "";
        var choiceEndDate = localStorage.getItem("choiceEndDate") || "";
        var dateStart = new Date(choiceStartDate);
        dateStart = new Date(dateStart.getFullYear(), dateStart.getMonth(), dateStart.getDate());
        var dateEnd = new Date(choiceEndDate);
        dateEnd = new Date(dateEnd.getFullYear(), dateEnd.getMonth(), dateEnd.getDate());
        if (choiceStartDate === "") {
            dateStart = new Date(selectedEndDate.getFullYear(), selectedEndDate.getMonth(), 1);
        }
        if (choiceEndDate === "") {
            dateEnd = selectedEndDate;
        }
        var loading = document.getElementById("loading");
        loading.style.display = "block";

        var xhr = new XMLHttpRequest();

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    loading.style.display = "none";
                    var responseData = JSON.parse(xhr.responseText);
                    var taskTotalElement = document.getElementById("taskTotalElement");
                    taskTotalElement.innerHTML = "";
                    if (dateStart > dateEnd || responseData.list.length === 0) {
                        let row = taskTotalElement.insertRow();
                        let statusDuration = dateEnd - dateStart;
                        let daysDiff = (statusDuration / (1000 * 60 * 60 * 24)) + 1;
                        row.innerHTML = '<th scope="col" class="bg-dark"></th>' + '<td colspan="' + daysDiff + '" class="text-center font-weight-bold">NO RESULT IN THIS DURATION</td>';
                    } else {
                        responseData.list.forEach((task) => {
                            let row = taskTotalElement.insertRow();
                            let requestEndDate = dateEnd;
                            let requestStartDate = dateStart;
                            let startDate = new Date(task.startDate);
                            startDate = new Date(startDate.getFullYear(), startDate.getMonth(), startDate.getDate());
                            let subStringDueOrCloseDate = task.dueOrCloseDate;
                            subStringDueOrCloseDate = subStringDueOrCloseDate.replace("~ ", "");
                            let dueOrCloseDate = new Date(subStringDueOrCloseDate);
                            dueOrCloseDate = new Date(dueOrCloseDate.getFullYear(), dueOrCloseDate.getMonth(), dueOrCloseDate.getDate());
                            let status = task.statusTask.code;
                            let statusDuration;
                            if (startDate < requestStartDate) {
                                console.log("A")
                                statusDuration = dueOrCloseDate - requestStartDate;
                            } else {
                                statusDuration = dueOrCloseDate - startDate;
                            }
                            let daysDiff = (statusDuration / (1000 * 60 * 60 * 24)) + 1;
                            let color;
                            if (status === 'OPENED') {
                                color = 'bg-warning';
                            } else if (status === 'REOPENED') {
                                color = 'bg-primary';
                            } else if (status === 'POSTPONED') {
                                color = 'bg-danger';
                            } else if (status === 'CLOSED') {
                                color = 'bg-success';
                            } else {
                                color = 'bg-secondary';
                            }
                            let checkStartDateIsBefore = true;
                            row.innerHTML = '<th scope="col" class="bg-dark">' + task.title + '</th>';
                            while (requestStartDate.getTime() <= requestEndDate.getTime()) {
                                if (checkStartDateIsBefore && requestStartDate.getTime() > startDate.getTime()) {
                                    row.innerHTML += '<td colspan="' + daysDiff + '" class="rounded-pill text-center align-middle ' + color + '"><a href="/tasks/' + task.id + '" class="btn font-weight-bold">' + status + '</a></td>';
                                    requestStartDate = new Date(requestStartDate.getTime() + 86400000 * daysDiff);
                                    checkStartDateIsBefore = false;
                                } else
                                if (Math.abs(requestStartDate - startDate) < 1000) {
                                    row.innerHTML += '<td colspan="' + daysDiff + '" class="rounded-pill text-center align-middle ' + color + '"><a href="/tasks/' + task.id + '" class="btn font-weight-bold">' + status + '</a></td>';
                                    requestStartDate = new Date(requestStartDate.getTime() + 86400000 * daysDiff);
                                    checkStartDateIsBefore = false;
                                } else {
                                    row.innerHTML += '<td></td>';
                                    requestStartDate = new Date(requestStartDate.getTime() + 86400000);
                                }
                            }
                        });
                    }
                    var taskTotalDate = document.getElementById("taskTotalDate");
                    if (dateStart > dateEnd) {
                        taskTotalDate.innerHTML = '<th>Task/Date</th>' + '<th>INVALID DATE</th>';
                    } else {
                        taskTotalDate.innerHTML = '<th>Task/Date</th>';
                        while (dateStart.getTime() <= dateEnd.getTime()) {
                            taskTotalDate.innerHTML += '<th>' + formatDate(dateStart) + '</th>';
                            dateStart = new Date(dateStart.getTime() + 86400000);
                        }
                    }
                }
            }
        }
        xhr.open("GET", "/api/v1/schedules/" + userId + "?startDate=" + choiceStartDate + "&endDate=" + choiceEndDate, true);
        xhr.send();
    }

    function formatDate(date) {
        var options = {year: 'numeric', month: '2-digit', day: '2-digit'};
        return new Intl.DateTimeFormat('en-US', options).format(date);
    }
</script>
<div id="loading" class="loading-spin">Loading...</div>
</body>
</html>
