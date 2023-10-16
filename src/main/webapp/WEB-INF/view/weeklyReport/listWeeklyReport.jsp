<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 10/14/2023
  Time: 8:03 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>

    <style>
        /* CSS để tạo dropdown */
        .mention-container {
            border: 1px solid #ccc;
            padding: 10px;
            position: relative;
        }

        .mention-dropdown {
            position: absolute;
            background-color: white;
            border: 1px solid #ccc;
            max-height: 150px;
            overflow-y: auto;
            cursor: pointer;
            display: none;
        }

    </style>
</head>
<body>
<form id="form" action="/weeklyReports" method="GET">
    <div class="container">
        <h1 class="mt-4">LIST WEEKLY REPORT</h1>
        <div class="row mt-4">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="search">Search</label>
                    <div class="input-group">
                        <input id="search" name="search" type="text" class="form-control" placeholder="Search">
                        <div class="input-group-append">
                            <button class="btn btn-primary" type="submit">Search</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 text-right">
                <button type="button" class="btn btn-primary px-4 create-weeklyReport-button">Add Weekly Report</button>
            </div>
        </div>
        <table class="table mt-4 table-bordered">
            <thead>
            <tr>
                <th>NO.</th>
                <th>Report ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>Created Date</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="weeklyReport" items="${weeklyReports.getListWeeklyReport()}" varStatus="loop">
                <tr>
                    <th scope="row">${(weeklyReports.pageNumber - 1) * weeklyReports.pageSize + loop.index + 1}</th>
                    <td>${weeklyReport.getId()}</td>
                    <td><a href="${weeklyReport.getId()}" class="weeklyReportDetail-button">${weeklyReport.getTitle()}</a></td>
                    <td>${weeklyReport.getFullnameUser()}</td>
                    <td>${weeklyReport.getCreatedDate()}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <!-- Pagination -->
        <div class="row justify-content-center">
            <ul class="pagination">
                <li class="page-item">
                    <c:if test="${weeklyReports.hasPrevious}">
                        <button class="page-link" type="submit" name="page" value="1"><<</button>
                    </c:if>
                </li>
                <li class="page-item">
                    <c:if test="${weeklyReports.hasPrevious}">
                        <button class="page-link" type="submit" name="page" value="${weeklyReports.pageNumber - 1}"><
                        </button>
                    </c:if>
                </li>
                <c:forEach var="page" begin="1" end="${weeklyReports.totalPages}">
                    <c:choose>
                        <c:when test="${page == weeklyReports.pageNumber}">
                            <li class="page-item active"><a class="page-link" href="#">${page}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item">
                                <button class="page-link" type="submit" name="page" value="${page}">${page}</button>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <li class="page-item">
                    <c:if test="${weeklyReports.hasNext}">
                        <button class="page-link" type="submit" name="page" value="${weeklyReports.pageNumber + 1}">>
                        </button>
                    </c:if>
                </li>
                <li class="page-item">
                    <c:if test="${weeklyReports.hasNext}">
                        <button class="page-link" type="submit" name="page" value="${weeklyReports.totalPages}">>>
                        </button>
                    </c:if>
                </li>
            </ul>
        </div>
    </div>
</form>

<!-- Modal Add Weekly Report -->
<div class="modal fade" id="addWeeklyReportModal" tabindex="-1" role="dialog" aria-labelledby="addWeeklyReportModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title text-center">Add Weekly Report</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="" method="post">
                    <div class="form-group row">
                        <label for="fullname" class="col-sm-2 col-form-label">Username</label>
                        <div class="col-sm-10">
                            <input type="text" readonly class="form-control-plaintext" id="fullname" value="${user.fullname}">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="title" class="col-sm-2 col-form-label">Title</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="title" placeholder="Enter here">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label  class="col-sm-2 col-form-label">Content</label>
                        <div class="col-sm-10">
                            <div id="contentContainer" contenteditable="true" class="form-control mention-container">
                                <!-- Content will be edited here -->
                            </div>
                        </div>
                    </div>
                    <div id="mentionDropdown" class="mention-dropdown">
                        <!-- Mention suggestions will be displayed here -->
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button value="${user.id}" type="button" class="btn btn-primary" id="addWeeklyReportButton">Submit
                </button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Weekly Report Detail -->
<div class="modal fade" id="WeeklyReportDetailModal" tabindex="-1" role="dialog" aria-labelledby="WeeklyReportDetailModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title text-center">Weekly Report Detail</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="" method="post">
                    <div class="form-group row">
                        <label for="fullnameUser" class="col-sm-2 col-form-label">Username</label>
                        <div class="col-sm-10">
                            <input type="text" readonly class="form-control-plaintext" id="fullnameUser">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="titleWeeklyReport" class="col-sm-2 col-form-label">Title</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="titleWeeklyReport" readonly>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="contentWeeklyReport" class="col-sm-2 col-form-label">Content</label>
                        <div class="col-sm-10">
                            <div class="form-control" id="contentWeeklyReport" readonly></div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="createDate" class="col-sm-2 col-form-label">Create Date</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="createDate" readonly>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Notification Success -->
<div class="modal fade" id="resultModal" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="resultModalLabel">Result</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="resultMessage">
                <!-- Message Success -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<%-------------------------------- Code Javascript -------------------------------------%>
<script>
    // Handle search
    document.addEventListener("DOMContentLoaded", function () {
        // Get input search
        var searchInput = document.getElementById("search");

        // Check Role Of User
        var roleUser = "${user.getRole().getValue()}";

        // setup placeholder of input search flow Role User
        if (roleUser === "Owner") {
            searchInput.placeholder = "Search by Title or Author";
        } else {
            searchInput.placeholder = "Search by Title";
        }

    });

    // Handle when user click button "Add Weekly Report"
    document.addEventListener("DOMContentLoaded", function () {
        var addButtons = document.querySelectorAll(".create-weeklyReport-button");

        // Show modal Edit Contract
        addButtons.forEach(function (button) {
            button.addEventListener("click", function () {
                $("#addWeeklyReportModal").modal("show");
            });
        });

        // Show dropdown titles task when user used key '#' in content weeklyReport
        // Get content and Get dropdown of tasks
        var contentContainer = document.getElementById("contentContainer");
        var mentionDropdown = document.getElementById("mentionDropdown");

        // Handle when user used key "#" in content
        contentContainer.addEventListener("input", function () {
            var content = contentContainer.innerText;

            if (content.includes("#")) {
                // Get titles form API
                var userId = ${user.id};
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "/api/v1/tasks/hashtag/" + userId, true);
                xhr.onload = function () {
                    if (xhr.status === 200) {
                        // Get Id and Title of Tasks From response Data API
                        var responseData = JSON.parse(xhr.responseText);
                        var taskId = responseData.map(function (task) {
                            return task.id;
                        });
                        var titles = responseData.map(function (task) {
                            return task.title;
                        });

                        // Show dropdown titles tasks
                        mentionDropdown.innerHTML = "Task:";
                        titles.forEach(function (title) {
                            var mentionItem = document.createElement("div");
                            mentionItem.classList.add("dropdown-item");
                            mentionItem.classList.add("border");
                            mentionItem.textContent = title;

                            // Handle when user choose one of the titles
                            mentionItem.addEventListener("click", function () {
                                var selectedTitle = mentionItem.textContent;
                                var selectedTaskId = taskId[titles.indexOf(selectedTitle)];
                                contentContainer.innerHTML = content.replace("#", '<a href="/tasks/' + selectedTaskId + '">#' + selectedTitle + '</a>' + " ");

                                mentionDropdown.style.display = "none";
                            });
                            mentionDropdown.appendChild(mentionItem);
                        });
                        mentionDropdown.style.display = "block";
                    }
                };
                xhr.send();
            } else {
                mentionDropdown.style.display = "none";
            }
        });
    });

    // Handle when user click button "Submit" in modal Add Weekly Report
    document.getElementById('addWeeklyReportButton').addEventListener('click', function () {

        // Get Data in form
        var userId = this.value;
        var title = document.getElementById("title").value;
        var content = document.getElementById("contentContainer").textContent;

        var data = {
            title: title,
            content: content,
            userId: userId
        };

        var xhr = new XMLHttpRequest();
        var url = '/api/v1/weekly-reports';

        xhr.open('POST', url, true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    sessionStorage.setItem('result', 'addWeeklyReportSuccess');
                    location.reload();
                } else {
                    console.log('Add Weekly Report is False' + xhr.status);
                }
            }
        };
        xhr.send(JSON.stringify(data));
    });

    // Handle when user click on link Title
    document.addEventListener("DOMContentLoaded", function () {
        var addButtons = document.querySelectorAll(".weeklyReportDetail-button");

        // Show modal Edit Contract
        addButtons.forEach(function (button) {
            button.addEventListener("click", function (event) {
                $("#WeeklyReportDetailModal").modal("show");

                var id = button.getAttribute("href");
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "/api/v1/weekly-reports/" + id, true);
                xhr.onload = function () {
                    if (xhr.status === 200) {
                        var responseData = JSON.parse(xhr.responseText);
                        var content = responseData.content;
                        var modifiedContent = replaceHashtagsWithLinks(content);

                        // Assign response Data weekly report to fields
                        document.getElementById("titleWeeklyReport").value = responseData.title;
                        document.getElementById("contentWeeklyReport").innerHTML = modifiedContent;
                        document.getElementById("fullnameUser").value = responseData.fullnameUser;
                        document.getElementById("createDate").value = responseData.createdDate;
                    }
                };
                xhr.send();
                event.preventDefault();
            });
        });

        // assign tag a to "#**"
        function replaceHashtagsWithLinks(text) {
            return text.replace(/#([a-zA-Z0-9]+)/g, '<a href="/tasks/taskId">#$1</a>');
        }
    });

    // Notification Add weekly Report Success
    document.addEventListener('DOMContentLoaded', function () {
        const result = sessionStorage.getItem('result');
        if (result) {
            $('#resultMessage').text(result === 'addWeeklyReportSuccess' ? 'Add Weekly Report Success' : '');
            $('#resultModal').modal('show');
            sessionStorage.clear();
        }
    });
</script>

<%-- Format content in modal Add Weekly Report--%>
<script>
    function expandContentContainer() {
        var contentContainer = document.getElementById("contentContainer");
        var contentHeight = contentContainer.scrollHeight;
        var containerHeight = contentContainer.clientHeight;

        if (contentHeight > containerHeight) {
            contentContainer.style.height = contentHeight + "px";
        }
    }

    // Get event when user change content
    document.addEventListener("input", function () {
        expandContentContainer();
    });

</script>
</body>
</html>
