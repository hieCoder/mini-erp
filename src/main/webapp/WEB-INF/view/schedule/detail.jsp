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
                    <h1 style="background-color: #fff"></h1>
                    <button class="btn btn-primary" onclick="getScheduleByDate()">Filter</button>
                </div>
            </div>
        </div>
        <div class="col-md-4 text-right">
            <p>Username</p>
        </div>
    </div>
</div>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
    Calendar calendar = Calendar.getInstance();
    // Lấy ngày đầu tiên của tháng hiện tại
    calendar.set(Calendar.DAY_OF_MONTH, 1);
    String startDateStr = sdf.format(calendar.getTime());
    // Lấy ngày hiện tại
    String endDateStr = sdf.format(new Date());
    Date startDate = null;
    Date endDate = null;
    long day;
    try {
        startDate = sdf.parse(startDateStr);
        endDate = sdf.parse(endDateStr);
        day = startDate.getTime();
    } catch (ParseException e) {
        throw new RuntimeException(e);
    }
%>
<div class="container mt-4" style="overflow-x: auto; max-width: 100%;">
    <table class="table table-bordered table-striped">
        <thead class="thead-dark">
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
        <tbody id="taskTotalElement">
        <c:forEach items="${requestScope.list}" var="s">
            <tr>
                <th scope="col">${s.title}</th>
                <c:set var="startDate" value="${s.startDate}"/>
                <c:set var="dueOrCloseDate" value="${s.dueOrCloseDate}"/>

                <script>
                    var selectedEndDate = new Date();
                    var selectedStartDate = new Date(selectedEndDate.getFullYear(), selectedEndDate.getMonth(), 1);

                    var startDate = new Date("${startDate}");
                    var dueOrCloseDate = new Date("${dueOrCloseDate}");
                    var status = "${s.statusTask.code}";
                    var id = "${s.id}";
                    var statusDuration = dueOrCloseDate - startDate;
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
                    while (selectedStartDate.getTime() < selectedEndDate.getTime()) {
                        if (selectedStartDate.getTime() === startDate.getTime()) {
                            document.write('<td colspan="' + daysDiff + '" class="rounded-pill text-center align-middle ' + color + '"><a href="/tasks/' + id + '" class="btn font-weight-bold">' + status + '</a></td>');
                            selectedStartDate = new Date(selectedStartDate.getTime() + 86400000 * daysDiff);
                        } else {
                            document.write('<td style="width: auto"></td>');
                            selectedStartDate = new Date(selectedStartDate.getTime() + 86400000);
                        }
                    }

                </script>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script>
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
        var choiceStartDate = localStorage.getItem("choiceStartDate") || "";
        var choiceEndDate = localStorage.getItem("choiceEndDate") || "";
        console.log(choiceStartDate)
        var dateStart = new Date(choiceStartDate);
        dateStart = new Date(dateStart.getFullYear(), dateStart.getMonth(), dateStart.getDate());
        var dateEnd = new Date(choiceEndDate);
        dateEnd = new Date(dateEnd.getFullYear(), dateEnd.getMonth(), dateEnd.getDate());
        console.log(dateStart)
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
                    responseData.forEach((task) => {
                        let row = taskTotalElement.insertRow();
                        let requestEndDate = dateEnd;
                        let requestStartDate = dateStart;
                        console.log(requestStartDate);
                        let startDate = new Date(task.startDate);
                        console.log(startDate);
                        let dueOrCloseDate = new Date(task.dueOrCloseDate);
                        let status = task.statusTask.name;
                        let statusDuration = dueOrCloseDate - startDate;
                        let daysDiff = (statusDuration / (1000 * 60 * 60 * 24)) + 1;
                        let color;
                        if (status.toUpperCase() === 'OPENED') {
                            color = 'bg-warning';
                        } else if (status.toUpperCase() === 'REOPENED') {
                            color = 'bg-primary';
                        } else if (status.toUpperCase() === 'POSTPONED') {
                            color = 'bg-danger';
                        } else if (status.toUpperCase() === 'CLOSED') {
                            color = 'bg-success';
                        } else {
                            color = 'bg-secondary';
                        }
                        row.innerHTML = '<th scope="col">' + task.title + '</th>';
                        while (requestStartDate.getTime() <= requestEndDate.getTime()) {
                            if (Math.abs(requestStartDate - startDate) < 1000) {
                                row.innerHTML += '<a href="/tasks/"' + task.id + '>' + '<td colspan="' + daysDiff + '" class="rounded-pill text-center align-middle ' + color + '">' + status + '</a></td>';
                                requestStartDate = new Date(requestStartDate.getTime() + 86400000 * daysDiff);
                            } else {
                                row.innerHTML += '<td style="width: auto"></td>';
                                requestStartDate = new Date(requestStartDate.getTime() + 86400000);
                            }
                        }
                    });
                    var taskTotalDate = document.getElementById("taskTotalDate");
                    taskTotalDate.innerHTML = '<th>Task/Date</th>';
                    while (dateStart.getTime() <= dateEnd.getTime()) {
                        taskTotalDate.innerHTML += '<th>' + formatDate(dateStart) + '</th>';
                        dateStart = new Date(dateStart.getTime() + 86400000);
                    }
                }
            }
        }
        xhr.open("GET", "/api/v1/schedules/2?" + "startDate=" + choiceStartDate + "&endDate=" + choiceEndDate, true);
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
