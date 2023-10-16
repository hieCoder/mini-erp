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
            <div class="col-md-6 text-right"> <!-- Thêm class text-right để căn giữa phải -->
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
    <div class="modal-dialog modal-lg" role="document">
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
    <div class="modal-dialog modal-lg" role="document">
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
                            <textarea class="form-control" id="contentWeeklyReport" rows="4" cols="50"></textarea>
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


<script>
    // Handle search
    document.addEventListener("DOMContentLoaded", function () {
        // Lấy thẻ input bằng id
        var searchInput = document.getElementById("search");

        // Kiểm tra giá trị của roleUser
        var roleUser = "${user.getRole().getValue()}";

        // Đặt giá trị placeholder tùy theo roleUser
        if (roleUser === "Owner") {
            searchInput.placeholder = "Search";
        } else {
            searchInput.placeholder = "Search Title";
        }

    });

    // Lắng nghe sự kiện khi người dùng nhấn nút "Add Weekly Report"
    document.addEventListener("DOMContentLoaded", function () {
        var addButtons = document.querySelectorAll(".create-weeklyReport-button");

        // Show modal Edit Contract
        addButtons.forEach(function (button) {
            button.addEventListener("click", function () {
                $("#addWeeklyReportModal").modal("show");
            });
        });
    });

    // Hiển thị dropdown khi người dùng sử dụng '#' trong trường content
    document.addEventListener("DOMContentLoaded", function () {
        var contentContainer = document.getElementById("contentContainer");
        var mentionDropdown = document.getElementById("mentionDropdown");

        contentContainer.addEventListener("input", function () {
            var content = contentContainer.innerText;

            if (content.includes("#")) {
                // Xử lý sự kiện gõ "#"
                // Gửi yêu cầu API để lấy danh sách title
                var userId = ${user.id};
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "/api/v1/tasks/hashtag/" + userId, true);
                xhr.onload = function () {
                    if (xhr.status === 200) {
                        var responseData = JSON.parse(xhr.responseText);
                        var titles = responseData.map(function (task) {
                            return task.title;
                        });

                        // Hiển thị dropdown với danh sách title
                        mentionDropdown.innerHTML = "Task:";
                        titles.forEach(function (title) {
                            var mentionItem = document.createElement("div");
                            mentionItem.textContent = title;

                            // Thêm lớp "dropdown-item" cho thẻ div
                            mentionItem.classList.add("dropdown-item");
                            mentionItem.classList.add("border");

                            mentionItem.addEventListener("click", function () {
                                // Xử lý khi người dùng chọn một title
                                var selectedTitle = mentionItem.textContent;
                                contentContainer.innerHTML = content.replace("#", '<a href="/task/taskId">#' + selectedTitle + '</a>' + " ");

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

    // Lắng nghe sự kiện khi người dùng nhấn nút "Submit" trong modal Add Weekly Report
    document.getElementById('addWeeklyReportButton').addEventListener('click', function () {

        // Lay du lieu trong the form
        var userId = this.value;
        var title = document.getElementById("title").value;
        var content = document.getElementById("contentContainer").textContent;

        var data = {
            title: title,
            content: content,
            userId: userId
        };

        // Khởi tạo đối tượng XMLHttpRequest
        var xhr = new XMLHttpRequest();
        var url = '/api/v1/weekly-reports';

        xhr.open('POST', url, true);
        xhr.setRequestHeader('Content-Type', 'application/json');
        // Định nghĩa hàm xử lý kết quả trả về từ máy chủ
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    // Xử lý kết quả ở đây
                    sessionStorage.setItem('result', 'addWeeklyReportSuccess');
                    location.reload();
                } else {
                    console.log('Add Weekly Report is False' + xhr.status);
                }
            }
        };
        xhr.send(JSON.stringify(data));
    });

    // Lắng nghe sự kiện khi người dùng nhấn link Title
    document.addEventListener("DOMContentLoaded", function () {
        var addButtons = document.querySelectorAll(".weeklyReportDetail-button");

        // Show modal Edit Contract
        addButtons.forEach(function (button) {
            button.addEventListener("click", function (event) {
                $("#WeeklyReportDetailModal").modal("show");
                var id = button.getAttribute("href");

                // Tạo một đối tượng XMLHttpRequest
                var xhr = new XMLHttpRequest();

                // Xác định phương thức và URL của API
                xhr.open("GET", "/api/v1/weekly-reports/" + id, true);

                // Đăng ký sự kiện "load" để xử lý khi API trả về dữ liệu
                xhr.onload = function () {
                    if (xhr.status === 200) {
                        // Parse dữ liệu JSON từ API
                        var responseData = JSON.parse(xhr.responseText);

                        // Gán dữ liệu từ API vào modal
                        document.getElementById("titleWeeklyReport").value = responseData.title;
                        document.getElementById("contentWeeklyReport").value = responseData.content;
                        document.getElementById("fullnameUser").value = responseData.fullnameUser;
                        document.getElementById("createDate").value = responseData.createdDate;
                    }
                };

                // Gửi yêu cầu API
                xhr.send();
                event.preventDefault();
            });
        });
    });

    // Lưu giá trị lựa chọn "Search" vào Local Storage khi thay đổi
    document.getElementById("search").addEventListener("input", function () {
        localStorage.setItem("selectedSearch", this.value);
    });

    // Khôi phục giá trị "Search" từ Local Storage khi trang được load
    window.addEventListener("load", function () {
        var selectedSearch = localStorage.getItem("selectedSearch");
        if (selectedSearch) {
            document.getElementById("search").value = selectedSearch;
        }
    });

    // Notification Delete User Success
    document.addEventListener('DOMContentLoaded', function () {
        const result = sessionStorage.getItem('result');
        if (result) {
            $('#resultMessage').text(result === 'addWeeklyReportSuccess' ? 'Add Weekly Report Success' : '');
            $('#resultModal').modal('show');
            sessionStorage.clear();
        }
    });
</script>

<%-- Hiển thị khung nội dung theo content trong modal Add Weekly Report--%>
<script>
    // Hàm để kiểm tra và mở rộng contentContainer khi người dùng thêm nội dung
    function expandContentContainer() {
        var contentContainer = document.getElementById("contentContainer");

        // Lấy chiều cao thực tế của nội dung bên trong và chiều cao hiện tại của contentContainer
        var contentHeight = contentContainer.scrollHeight;
        var containerHeight = contentContainer.clientHeight;

        // Nếu chiều cao thực tế của nội dung lớn hơn chiều cao hiện tại của contentContainer, thì mở rộng nó
        if (contentHeight > containerHeight) {
            contentContainer.style.height = contentHeight + "px";
        }
    }

    // Lắng nghe sự kiện khi người dùng thay đổi nội dung
    document.addEventListener("input", function () {
        expandContentContainer();
    });

    // Gọi hàm expandContentContainer khi trang được load để điều chỉnh ban đầu
    document.addEventListener("DOMContentLoaded", function () {
        expandContentContainer();
    });
</script>
</body>
</html>
