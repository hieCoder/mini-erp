<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 10/10/2023
  Time: 10:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="" method="get">
    <div class="container">
        <div class="row">
            <!-- Phần 1: Hình ảnh avatar và tên người dùng -->
            <div class="col-md-4">
                <div class="text-center">
                    <img src="/upload/user/cat.jpg" class="img-fluid" alt="User Avatar" width="200">
                    <input type="file" class="form-control mt-2" placeholder="Chèn ảnh mới">
                    <h5 class="mt-2">${user.getFullname()}</h5>
                </div>
            </div>

            <!-- Phần 2: Form thông tin người dùng -->
            <div class="col-md-8">
                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" class="form-control" id="address" value="${user.getAddress()}">
                </div>
                <div class="form-group">
                    <label for="dob">Date of Birth</label>
                    <input type="date" class="form-control" id="dob" value="${user.getDateOfBirth()}">
                </div>
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" class="form-control" id="phone" value="${user.getPhone()}">
                </div>
                <div class="form-group">
                    <label for="emergencyPhone">Emergency Phone</label>
                    <input type="tel" class="form-control" id="emergencyPhone" value="${user.getEmergencyPhone()}">
                </div>
                <div class="form-group">
                    <label for="resume">Resume</label>
                    <a href="${user.getResume()}" download target="_blank" id="resumeLink">Download Resume</a>
                    <input type="file" class="form-control mt-2" id="resume">
                    <small class="text-muted ml-2">Choose New Resume</small>
                </div>
                <div class="form-group">
                    <label for="timeSheetsCode">TimeSheets code</label>
                    <input type="text" class="form-control" id="timeSheetsCode" value="${user.getTimesheetsCode()}">
                </div>
                <div class="form-group">
                    <label for="type">Type</label>
                    <select class="form-control" id="type">
                        <option value="OFFICIAL"
                                <c:if test="${user.type.code.equals('OFFICIAL')}">selected</c:if>
                        >Official</option>
                        <option value="PROBATION"
                                <c:if test="${user.type.code.equals('PROBATION')}">selected</c:if>
                        >Probation</option>
                        <option value="PARTTIME"
                                <c:if test="${user.type.code.equals('PARTTIME')}">selected</c:if>
                        >Parttime</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="department">Department</label>
                    <select class="form-control" id="department">
                        <option value="ADMINISTRATION" <c:if test="${user.department.code.equals('ADMINISTRATION')}">selected</c:if>>
                            Administration
                        </option>
                        <option value="MANAGEMENT" <c:if test="${user.department.code.equals('MANAGEMENT')}">selected</c:if>>
                            Management
                        </option>
                        <option value="UI_UX" <c:if test="${user.department.code.equals('UI_UX')}">selected</c:if>>
                            UI/UX
                        </option>
                        <option value="DEV1" <c:if test="${user.department.code.equals('DEV1')}">selected</c:if>>
                            Dev1
                        </option>
                        <option value="DEV2" <c:if test="${user.department.code.equals('DEV2')}">selected</c:if>>
                            Dev2
                        </option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="userId">User ID</label>
                    <input type="email" class="form-control" id="userId" value="${user.getEmail()}">
                </div>
                <div class="form-group">
                    <label for="atm">ATM</label>
                    <input type="text" class="form-control" id="atm" value="${user.getAtm()}">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" id="password">
                </div>
                <div class="form-group">
                    <label for="role">Role</label>
                    <select class="form-control" id="role">
                        <option value="OWNER" <c:if test="${user.role.code.equals('OWNER')}">selected</c:if>>
                            Owner
                        </option>
                        <option value="MANAGER" <c:if test="${user.role.code.equals('MANAGER')}">selected</c:if>>
                            Manager
                        </option>
                        <option value="DEVELOPER" <c:if test="${user.role.code.equals('DEVELOPER')}">selected</c:if>>
                            Developer
                        </option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="position">Position</label>
                    <select class="form-control" id="position">
                        <option value="INTERN" <c:if test="${user.position.code.equals('INTERN')}">selected</c:if>>
                            Inter
                        </option>
                        <option value="JUNIOR"  <c:if test="${user.position.code.equals('JUNIOR')}">selected</c:if>>
                            Junior
                        </option>
                        <option value="SENIOR"  <c:if test="${user.position.code.equals('SENIOR')}">selected</c:if>>
                            Senior
                        </option>
                        <option value="MANAGER"  <c:if test="${user.position.code.equals('MANAGER')}">selected</c:if>>
                            Manager
                        </option>
                        <option value="SENIOR_MANAGER"  <c:if test="${user.position.code.equals('SENIOR_MANAGER')}">selected</c:if>>
                            Senior Manager
                        </option>
                        <option value="OWNER"  <c:if test="${user.position.code.equals('OWNER')}">selected</c:if>>
                            Owner
                        </option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="contract">Contract: </label>
                    <button id="contract" type="button" class="btn btn-warning font-weight-bold" data-toggle="modal" data-target="#contractModal">
                        VIEW
                    </button>
                </div>
                <div class="form-group">
                    <label for="working-day">Working Day</label>
                    <div class="input-group" id="working-day">
                        <select class="form-control" id="working-year">
                            <option value="">-- Select Year --</option>
                            <c:forEach items="${workingDay}" var="data">
                                <option value="${data.year}">${data.year}</option>
                            </c:forEach>
                        </select>
                        <select class="form-control" id="working-month" style="display: none;">
                            <option value="">-- Select Month --</option>
                            <c:choose>
                                <c:when test="${not empty workingDay and not empty workingDay[0].month}">
                                    <c:forEach items="${workingDay}" var="data">
                                        <option value="${data.month}">${data.month}</option>
                                    </c:forEach>
                                </c:when>
                            </c:choose>
                            <option value="1">January</option>
                            <option value="2">February</option>
                            <!-- Thêm các option cho các tháng khác nếu cần -->
                        </select>
                        <input type="text" class="form-control" id="totailWorkingDay" readonly placeholder="Result">
                        <div class="input-group-prepend">
                            <button class="btn btn-primary" type="button" id="checkTotalWorkingDay">Check Total WorkingDay</button>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <button class="btn btn-primary">Save</button>
                    <button type="button" class="btn btn-danger ml-2" data-toggle="modal" data-target="#deleteModal">
                        Delete
                    </button>
                    <a class="btn btn-secondary ml-2" href="/users">Cancel</a>
                </div>
            </div>
        </div>
    </div>
</form>

<!-- Modal Delete -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                Are you sure to delete this user?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-danger">Delete</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Contract History -->
<div class="modal fade" id="contractModal" tabindex="-1" role="dialog" aria-labelledby="contractModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Contract History</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Basic Salary</th>
                        <th>Allowance</th>
                        <th>Insurance Type</th>
                        <th>Insurance Money</th>
                        <th>Contract</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- Dữ liệu của bảng sẽ được thêm ở đây -->
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary">Add</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>


<!-- Thêm script để gọi API và cập nhật select month -->
<script>
    // Lắng nghe sự kiện khi người dùng thay đổi năm
    document.getElementById("working-year").addEventListener("change", function () {
        var yearValue = this.value;
        var monthInput = document.getElementById("working-month");

        if (yearValue !== "") {
            // Gọi API để lấy dữ liệu month
            fetch(`/api/v1/timesheets/workingday/{userID}?year=${yearValue}`)
                .then(response => response.json())
                .then(data => {
                    // Xóa tất cả các option hiện tại trong select month
                    while (monthInput.options.length > 0) {
                        monthInput.remove(0);
                    }

                    // Thêm các option mới dựa trên dữ liệu từ API
                    data.forEach(item => {
                        var option = document.createElement("option");
                        option.value = item.month;
                        option.text = item.month;
                        monthInput.add(option);
                    });

                    // Hiển thị select month
                    monthInput.style.display = "block";
                })
                .catch(error => console.error(error));
        } else {
            // Nếu không chọn năm, ẩn select month
            monthInput.style.display = "none";
        }
    });

    // Lắng nghe sự kiện khi người dùng nhấn nút "Check Total WorkingDay"
    document.getElementById("checkTotalWorkingDay").addEventListener("click", function () {
        var year = document.getElementById("working-year").value;
        var month = document.getElementById("working-month").value;

        // Thực hiện tính toán dựa trên year và month ở đây, và hiển thị kết quả trong ô "Result"
    });
</script>

</body>
</html>

