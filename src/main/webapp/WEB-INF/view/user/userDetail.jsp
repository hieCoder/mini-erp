<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>User detail</title>
    <style>
        .form-group-password {
            position: relative;
        }

        #change-password-button {
            position: absolute;
            right: 0;
            top: 0;
        }
    </style>
</head>
<body>
<div class="container">
    <form id="formUpdateUser">
        <div class="row">
            <!-- Phần 1: Hình ảnh avatar và tên người dùng -->
            <div class="col-md-4">
                <div class="text-center">
                    <div id="avatar-container" style="position: relative;">
                        <img id="avatar-user" src="${user.getAvatar()}" class="img-fluid" alt="User Avatar" width="200">
                        <input name="avatar" type="file" class="form-control mt-2" id="avatar" accept="image/*">
                        <small class="text-muted ml-2">Choose New Avatar</small>
                        <h4 class="mt-2">${user.getFullname()}</h4>
                        <div id="delete-avatar-button"
                             style="position: absolute; top: 0; right: 0; color: black; padding: 5px; cursor: pointer; display: none;">
                            X
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <!-- Phần 2: Form thông tin người dùng -->
                <h3 class="font-weight-bold">Basic User Information</h3>
                <div class="col-md-12">
                    <div class="p-3 border">
                        <div class="form-group">
                            <label for="address">Address:</label>
                            <input type="text" name="address" class="form-control" id="address"
                                   value="${user.getAddress()}">
                            <small class="form-message"></small>
                        </div>
                        <div class="form-group">
                            <label for="fullname">Username:</label>
                            <input type="text" class="form-control" name="fullname" id="fullname"
                                   value="${user.getFullname()}">
                            <small class="form-message"></small>
                        </div>
                        <div class="form-group">
                            <label for="gender">Gender:</label>
                            <select name="gender" class="form-control" id="gender">
                                <option value="MALE"
                                        <c:if test="${user.gender.code.equals('MALE')}">selected</c:if>
                                >Male
                                </option>
                                <option value="FEMALE"
                                        <c:if test="${user.gender.code.equals('FEMALE')}">selected</c:if>
                                >Female
                                </option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="dateOfBirth">Date of birth:</label>
                            <input type="date" class="form-control" id="dateOfBirth" value="${user.dateOfBirth}">
                            <small class="form-message"></small>
                        </div>
                        <div class="form-group">
                            <label for="phone">Phone number:</label>
                            <input type="number" class="form-control" name="phone" id="phone"
                                   value="${user.getPhone()}">
                            <small class="form-message"></small>
                        </div>
                        <div class="form-group">
                            <label for="emergencyPhone">Emergency phone:</label>
                            <input type="number" class="form-control" name="emergencyPhone" id="emergencyPhone"
                                   value="${user.getEmergencyPhone()}">
                            <small class="form-message"></small>
                        </div>
                        <div class="form-group">
                            <label for="resume">Resume file:</label>
                            <button id="viewFileResume" type="button" class="btn btn-info font-weight-bold">
                                View Files Resume
                            </button>
                            <input type="file" class="form-control mt-2" name="newResumeFiles" id="resume" multiple>
                            <small class="text-muted ml-2">Choose new resume</small>
<%--                            <div id="selectedFiles" style="display: none">--%>
<%--                                <label for="resume" class="mt-2">File da chon</label>--%>
<%--                                <div class="border">--%>
<%--                                    <div class="row" id="listFiles"></div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
                        </div>
                        <div class="form-group">
                            <label for="timeSheetsCode">TimeSheets code:</label>
                            <input type="text" class="form-control" name="timesheetsCode" id="timeSheetsCode"
                                   value="${user.getTimesheetsCode()}">
                        </div>
                    </div>
                </div>
                <h3 class="mt-2 font-weight-bold hide">Detail User Information</h3>
                <div class="col-md-12">
                    <div class="p-3 border hide">
                        <div class="form-group hide">
                            <label for="type">Type:</label>
                            <select name="type" class="form-control" id="type">
                                <option value="OFFICIAL"
                                        <c:if test="${user.type.code.equals('OFFICIAL')}">selected</c:if>
                                >Official
                                </option>
                                <option value="PROBATION"
                                        <c:if test="${user.type.code.equals('PROBATION')}">selected</c:if>
                                >Probation
                                </option>
                                <option value="PARTTIME"
                                        <c:if test="${user.type.code.equals('PARTTIME')}">selected</c:if>
                                >Parttime
                                </option>
                            </select>
                        </div>
                        <div class="form-group hide">
                            <label for="department">Department:</label>
                            <select name="department" class="form-control" id="department">
                                <option value="ADMINISTRATION"
                                        <c:if test="${user.department.code.equals('ADMINISTRATION')}">selected</c:if>>
                                    Administration
                                </option>
                                <option value="MANAGEMENT"
                                        <c:if test="${user.department.code.equals('MANAGEMENT')}">selected</c:if>>
                                    Management
                                </option>
                                <option value="UI_UX"
                                        <c:if test="${user.department.code.equals('UI_UX')}">selected</c:if>>
                                    UI/UX
                                </option>
                                <option value="DEV1"
                                        <c:if test="${user.department.code.equals('DEV1')}">selected</c:if>>
                                    Dev1
                                </option>
                                <option value="DEV2"
                                        <c:if test="${user.department.code.equals('DEV2')}">selected</c:if>>
                                    Dev2
                                </option>
                            </select>
                        </div>
                        <div class="form-group hide">
                            <label for="userId">User ID:</label>
                            <input name="email" type="email" class="form-control" id="userId"
                                   value="${user.getEmail()}">
                        </div>
                        <div class="form-group-password hide">
                            <label for="password">Password: </label>
                            <a id="change-password-button" class="text-primary text-decoration-none"
                               style="cursor: pointer;">Change
                                password</a>
                            <div id="password-form" style="display: none;">
                                <input name="password" type="password" class="form-control" id="password" value=""
                                       placeholder="New Password">
                                <span id="messageNewPassword" class="text-danger"></span>
                            </div>
                        </div>
                        <div class="form-group hide">
                            <label for="atm">ATM:</label>
                            <input name="atm" type="text" class="form-control" id="atm" value="${user.getAtm()}">
                        </div>
                        <div class="form-group hide">
                            <label for="role">Role:</label>
                            <select name="role" class="form-control" id="role">
                                <option value="OWNER" <c:if test="${user.role.code.equals('OWNER')}">selected</c:if>>
                                    Owner
                                </option>
                                <option value="MANAGER"
                                        <c:if test="${user.role.code.equals('MANAGER')}">selected</c:if>>
                                    Manager
                                </option>
                                <option value="DEVELOPER"
                                        <c:if test="${user.role.code.equals('DEVELOPER')}">selected</c:if>>
                                    Developer
                                </option>
                            </select>
                        </div>
                        <div class="form-group hide">
                            <label for="position">Position:</label>
                            <select name="position" class="form-control" id="position">
                                <option value="INTERN"
                                        <c:if test="${user.position.code.equals('INTERN')}">selected</c:if>>
                                    Intern
                                </option>
                                <option value="JUNIOR"
                                        <c:if test="${user.position.code.equals('JUNIOR')}">selected</c:if>>
                                    Junior
                                </option>
                                <option value="SENIOR"
                                        <c:if test="${user.position.code.equals('SENIOR')}">selected</c:if>>
                                    Senior
                                </option>
                                <option value="MANAGER"
                                        <c:if test="${user.position.code.equals('MANAGER')}">selected</c:if>>
                                    Manager
                                </option>
                                <option value="SENIOR_MANAGER"
                                        <c:if test="${user.position.code.equals('SENIOR_MANAGER')}">selected</c:if>>
                                    Senior manager
                                </option>
                                <option value="OWNER"
                                        <c:if test="${user.position.code.equals('OWNER')}">selected</c:if>>
                                    Owner
                                </option>
                            </select>
                        </div>
                        <div class="form-group hide">
                            <label for="contract">Contract:</label>
                            <button id="contract" type="button" class="btn btn-warning font-weight-bold"
                                    data-toggle="modal"
                                    data-target="#contractModal">
                                View
                            </button>
                        </div>
                        <div class="form-group hide">
                            <label for="working-day">Working day:</label>
                            <div class="input-group" id="working-day">
                                <select class="form-control" id="working-year">
                                    <option value="">-- Select year --</option>
                                </select>
                                <select class="form-control" id="working-month" style="display: none;">
                                    <option>-- Select month --</option>
                                </select>
                                <input type="text" class="form-control" id="totalWorkingDay" readonly
                                       placeholder="Result">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group col-md-12 mt-3 container-button">
                    <button value="${user.getId()}" type="submit" class="btn btn-primary" id="updateUserButton">Save
                    </button>
                    <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteUserModal"
                            id="delUser">Delete
                    </button>
                    <a class="btn btn-secondary cancle-button">Cancel</a>
                </div>
            </div>
        </div>
    </form>
</div>

<!-- Modal List File Resume  -->
<div class="modal fade" id="filesResume" tabindex="-1" role="dialog" aria-labelledby="resumeModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable" role="document">
        <div class="modal-content" style="width: 150%">
            <div class="modal-header">
                <h4 class="modal-title">Files Resume</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <c:forEach var="resume" items="${resumes}">
                        <div class="col-md-2 mt-2 text-center delete-fileResume" style="position: relative">
                        <span class="custom-icon">
                           <i class="fa-regular fa-file" style="font-size: 75px; color: #4A86E8"></i>
                        </span>
                            <br>
                            <div class="resume-link">
                                <a href="/upload/user/${resume}" class="cut-file-name fileName-Resume">${resume}</a>
                            </div>
                            <div class="delete-fileResume-button"
                                 style="position: absolute;top: -20px;right: 30px;color: black;padding: 5px;cursor: pointer;display: block;">
                                X
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal List Contract  -->
<div class="modal fade" id="contractModal" tabindex="-1" role="dialog" aria-labelledby="contractModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable" role="document">
        <div class="modal-content" style="margin-top: 65px; width: 150%">
            <div class="modal-header">
                <h4 class="modal-title">List Contract</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>Basic Salary</th>
                        <th width="200">Allowance</th>
                        <th>Insurance Type</th>
                        <th>Insurance Money</th>
                        <th>Contract</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="contract" items="${contracts}">
                        <tr>
                            <td>${contract.basicSalary}</td>
                            <td class="format-allowance">${contract.allowance}</td>
                            <td>${contract.insuranceType.name}</td>
                            <td>${contract.insuranceMoney}</td>
                            <td><a href="${contract.getContract()}" download target="_blank"
                                   class="contractLink cut-file-name">Contract
                                Files</a></td>
                            <td>
                                <button value="${contract.id}" type="button"
                                        class="btn btn-primary edit-contract-button mt-1">Edit
                                </button>
                                <button value="${contract.id}" type="button"
                                        class="btn btn-danger delete-contract-button mt-1">Delete
                                </button>
                                <button value="${contract.id}" type="button"
                                        class="btn btn-warning history-contract-button mt-1">History Update
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-primary px-4 add-contract-button">Add</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal History Update Contract  -->
<div class="modal fade" id="contractHistoryModal" tabindex="-1" role="dialog"
     aria-labelledby="contractHistoryModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable" role="document">
        <div class="modal-content" style="margin-top: 65px; width: 150%">
            <div class="modal-header">
                <h4 class="modal-title">Contract History</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered" id="table-history-contract">
                    <thead>
                    <tr>
                        <th>Basic Salary</th>
                        <th>Allowance</th>
                        <th>Insurance Type</th>
                        <th>Insurance Money</th>
                        <th>Contract</th>
                        <th>Create Date</th>
                    </tr>
                    </thead>
                </table>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal ADD Contract  -->
<div class="modal fade" id="addContractModal" tabindex="-1" role="dialog" aria-labelledby="addContractModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable" role="document">
        <div class="modal-content" style="max-height: 80%">
            <div class="modal-header">
                <h4 class="modal-title text-center">Add Contract</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="formAddContract">
                    <div class="form-group">
                        <label for="editBasicSalary">Basic Salary:</label>
                        <input type="number" class="form-control" id="addBasicSalary" name="basicSalary">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group">
                        <label id="valAllowance">Allowance:</label>
                        <div id="additionalFields" class="p-3 border">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label for="telephone">Telephone:</label>
                                        <input type="number" class="form-control" id="telephone">
                                        <small class="form-message"></small>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label for="meal">Meal:</label>
                                        <input type="number" class="form-control" id="meal">
                                        <small class="form-message"></small>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label for="gasoline">Gasoline:</label>
                                        <input type="number" class="form-control" id="gasoline">
                                        <small class="form-message"></small>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label for="uniform">Uniform:</label>
                                        <input type="number" class="form-control" id="uniform">
                                        <small class="form-message"></small>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label for="attendance">Attendance:</label>
                                        <input type="number" class="form-control" id="attendance">
                                        <small class="form-message"></small>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label for="other">Other:</label>
                                        <input type="number" class="form-control" id="other">
                                        <small class="form-message"></small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="editInsuranceType">Insurance Type:</label>
                        <select class="form-control" id="addInsuranceType" name="insuranceType">
                            <option value="HEALTH_INSURANCE">Health insurance</option>
                            <option value="SOCIAL_INSURANCE">Social insurance</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editInsuranceMoney">Insurance Money:</label>
                        <input type="number" class="form-control" id="addInsuranceMoney" name="insuranceMoney">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group">
                        <label for="newContract">Contract</label>
                        <input type="file" class="form-control mt-2" id="newContract" name="contract">
                    </div>
                    <div class="form-group container-button-add-contract">
                        <button value="${user.getId()}" type="submit" class="btn btn-primary" id="addContractButton">
                            Confirm
                        </button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal Contract Edit -->
<div class="modal fade" id="editContractModal" tabindex="-1" role="dialog" aria-labelledby="editContractModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content" style="margin-top: 75px !important;">
            <div class="modal-header">
                <h4 class="modal-title text-center">Edit Contract</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editContractForm">
                    <div class="form-group">
                        <label for="editBasicSalary">Basic Salary:</label>
                        <input type="number" class="form-control" id="editBasicSalary" name="basicSalary">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group">
                        <label>Allowance:</label>
                        <button id="showEditFields" type="button" class="btn btn-secondary">Edit Allowance</button>
                        <div id="editFields" style="display: none">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label for="telephone">Telephone:</label>
                                        <input type="number" class="form-control" id="editTelephone">
                                        <small class="form-message"></small>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label for="meal">Meal:</label>
                                        <input type="number" class="form-control" id="editMeal">
                                        <small class="form-message"></small>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label for="gasoline">Gasoline:</label>
                                        <input type="number" class="form-control" id="editGasoline">
                                        <small class="form-message"></small>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label for="uniform">Uniform:</label>
                                        <input type="number" class="form-control" id="editUniform">
                                        <small class="form-message"></small>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label for="attendance">Attendance:</label>
                                        <input type="number" class="form-control" id="editAttendance">
                                        <small class="form-message"></small>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label for="other">Other:</label>
                                        <input type="number" class="form-control" id="editOther">
                                        <small class="form-message"></small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="editInsuranceType">Insurance Type:</label>
                        <select class="form-control" id="editInsuranceType" name="insuranceType">
                            <option value="HEALTH_INSURANCE">Health insurance</option>
                            <option value="SOCIAL_INSURANCE">Social insurance</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editInsuranceMoney">Insurance Money:</label>
                        <input type="number" class="form-control" id="editInsuranceMoney" name="insuranceMoney">
                        <small class="form-message"></small>
                    </div>
                    <div class="form-group">
                        <label for="contractUser">Contract Files: </label>
                        <input type="file" class="form-control mt-2" id="contractUser" name="contract">
                        <small class="text-muted ml-2">Choose New Contract</small>
                    </div>
                    <div class="form-group container-button-edit-contract">
                        <button type="submit" class="btn btn-primary" id="confirmContractButton">Confirm</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal Delete Contract-->
<div class="modal fade" id="deleteContractModal" tabindex="-1" role="dialog" aria-labelledby="deleteContractModalLabel"
     aria-hidden="true" style="z-index: 999999;">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                Are you sure to delete this contract?
            </div>
            <div class="modal-footer container-button-delete-contract">
                <button type="button" class="btn btn-info confirm-delete-button">Confirm</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Delete User -->
<div class="modal fade" id="deleteUserModal" tabindex="-1" role="dialog" aria-labelledby="deleteUserModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                Are you sure to delete this user?
            </div>
            <div class="modal-footer container-button-delete-user">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button value="${user.getId()}" type="button" class="btn btn-danger" id="deleteUser">Delete</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Notification Success -->
<div class="modal fade" id="resultModal" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel"
     aria-hidden="true">
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

<%-------------------------------------------- CODE JAVASCRIPT--------------------------------------------%>

<%--Handle User--%>
<script>
    // Handle button view Of resume
    document.addEventListener("DOMContentLoaded", function () {
        cutShortLink();
        // Show modal view files resume
        var viewResumeButton = document.getElementById('viewFileResume');
        viewResumeButton.addEventListener('click', function () {
            $('#filesResume').modal('show');
            var viewFilesResumeButton = document.querySelectorAll('.delete-fileResume-button');
            viewFilesResumeButton.forEach(function (button) {
                button.addEventListener('click', function () {
                    this.closest('.delete-fileResume').remove();
                });
            });
        });
    });

    // document.getElementById('resume').addEventListener('change', function() {
    //     document.getElementById('selectedFiles').style.display = 'block';
    //     var selectedFiles = document.getElementById('resume').files;
    //     var filesList = document.getElementById('listFiles');
    //     for (var i = 0; i < selectedFiles.length; i++) {
    //         var fileName = selectedFiles[i].name;
    //         var listItem = document.createElement('div');
    //         listItem.classList.add('col-md-3', 'm-3');
    //         listItem.textContent = fileName;
    //         filesList.appendChild(listItem);
    //         cutShortLink();
    //     }
    // });

    // Format filename
    function formatName(ClassName) {
        for (var i = 0; i < ClassName.length; i++) {
            var link = ClassName[i];
            var href = link.getAttribute("href");
            var fileName = href.substring(href.indexOf("-") + 1);
            if (fileName.length > 15) {
                var extension = fileName.substring(fileName.lastIndexOf("."));
                fileName = fileName.substring(0, 12) + "..." + extension;
            }

            link.textContent = fileName;
        }
    };

    var fileChanged = false;

    // Show image of user choose
    document.getElementById("avatar").addEventListener("change", function (e) {
        var file = e.target.files[0];

        if (file) {
            var reader = new FileReader();

            // Set up the image source for preview
            reader.onload = function (e) {
                document.getElementById("avatar-user").src = e.target.result;
                fileChanged = true;
                document.getElementById("delete-avatar-button").style.display = "block";
            };

            reader.readAsDataURL(file);
        }
    });

    // When user delete avatar curren then change = avatar-defalut
    document.getElementById("delete-avatar-button").addEventListener("click", function () {
        if (fileChanged) {
            document.getElementById("avatar-user").src = userCurrent.avatar;
            fileChanged = false;
            document.getElementById("delete-avatar-button").style.display = "none";
            document.getElementById("avatar").value = "";
        }
    });

    var isNewPassword = false;
    var linkCancle = '/users';
    if (userCurrent.role == U_DEVELOPER) linkCancle = '/home';
    $('.cancle-button').attr('href', linkCancle);

    // Handle user click on "Change Password"
    document.getElementById("change-password-button").addEventListener("click", function () {
        var inputPassword = document.getElementById("password-form");
        if (inputPassword.style.display == "none") {
            inputPassword.style.display = "block";
            isNewPassword = true;
        } else {
            inputPassword.style.display = "none";
            isNewPassword = false;
        }
    });

    Validator({
        form: '#formUpdateUser',
        errorSelector: '.form-message',
        rules: [
            Validator.isRequired('#address'),
            Validator.isRequired('#fullname'),
            Validator.isRequired('#dateOfBirth'),
            Validator.isDayBeforeToday('#dateOfBirth'),
            Validator.isRequired('#phone'),
            Validator.isPhoneVN('#phone'),
            Validator.isRequired('#emergencyPhone')
        ],
        onSubmit: function (formData) {

            $('.container-button').after(createLoadingHtml());


            formData.append('id', '${user.id}');

            // ADD dateOfBirth after format
            var dobString = document.getElementById('dateOfBirth').value;
            var jsDate = new Date(dobString);
            var dateOfBirth = new Date(jsDate.getTime());
            formData.append('dateOfBirth', dateOfBirth);

            // ADD all file resume
            var filesResume = document.querySelectorAll('.fileName-Resume');
            var filenamesResume = [];
            filesResume.forEach(function (element) {
                var href = element.getAttribute('href');
                var parts = href.split('/');
                var fileName = parts[parts.length - 1];
                filenamesResume.push(fileName);
            });

            var result = filenamesResume.join(",");
            formData.append('remainResumeFiles', result);

            if (isNewPassword) {
                var newPassword = document.getElementById('password').value;
                var regex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{6,}$/;
                var message = regex.test(newPassword) ? undefined : 'Password must have at least 6 characters and include letters, numbers and special characters';
                if (newPassword != '') {
                    if (message == undefined) {
                        callAjaxByDataFormWithDataForm('/api/v1/users/updation', 'POST', formData, function (rs) {
                            sessionStorage.setItem('result', 'updateSuccess');
                            location.href = "/users/" + '${user.getId()}';
                        }, 'formUpdateUser');
                    } else {
                        document.getElementById('messageNewPassword').textContent = message;
                        resetForm('formUpdateUser');
                    }
                } else {
                    document.getElementById('messageNewPassword').textContent = message;
                    resetForm('formUpdateUser');
                }
            } else {
                formData.delete('password');
                callAjaxByDataFormWithDataForm('/api/v1/users/updation', 'POST', formData, function (rs) {
                    sessionStorage.setItem('result', 'updateSuccess');
                    location.href = "/users/" + '${user.getId()}';
                }, 'formUpdateUser');
            }
        }
    });

    // Handle when user click button "Confirm Delete User"
    document.addEventListener("DOMContentLoaded", function () {

        var deleteUserButtons = document.getElementById('deleteUser');
        var userId = deleteUserButtons.value;

        // Show File Name Contract
        var contractLinks = document.getElementsByClassName("contractLink");
        formatName(contractLinks);

        // Handler button Delete in modal Delete
        deleteUserButtons.addEventListener("click", function () {
            if (userId) {
                $('.container-button-delete-user').after(createLoadingHtml());

                callAjaxByJsonWithData('/api/v1/users/' + userId, 'DELETE', null, function (rs) {
                    sessionStorage.setItem('result', 'deleteSuccess');
                    window.location.href = "/users";
                });
            }
        });
    });

    // Notification Success
    document.addEventListener('DOMContentLoaded', function () {
        const result = sessionStorage.getItem('result');
        if (result) {
            let message;
            switch (result) {
                case 'updateSuccess':
                    message = 'Update User Success';
                    break;
                case 'addContractSuccess':
                    message = 'Add Contract Success';
                    break;
                case 'editContractSuccess':
                    message = 'Edit Contract Success';
                    break;
                case 'deleteContractSuccess':
                    message = 'Delete Contract Success';
                    break;
                default:
                    message = 'Unknown Result';
            }
            $('#resultMessage').text(message);
            $('#resultModal').modal('show');
            sessionStorage.clear();
        }
    });
</script>

<%--Handle WorkingDay--%>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        if (!isDeleveloper()) {
            // Lấy tham chiếu đến các phần tử HTML
            var yearSelect = document.getElementById('working-year');
            var monthSelect = document.getElementById('working-month');
            var totalWorkingDayInput = document.getElementById('totalWorkingDay');

            var data;
            callAjaxByJsonWithData('/api/v1/timesheets/workingday/' + '${user.getId()}', 'GET', null, function (rs) {
                data = rs;
                yearSelect.innerHTML = '<option value="">-- Select Year --</option>';
                data.forEach(function (entry) {
                    var option = document.createElement('option');
                    option.value = entry.year;
                    option.textContent = entry.year;
                    yearSelect.appendChild(option);
                });
            });

            // Thêm sự kiện nghe cho việc thay đổi lựa chọn năm
            yearSelect.addEventListener('change', function () {
                $('#working-day').after(createLoadingHtml());
                callAjaxByJsonWithData('/api/v1/timesheets/workingday/' + '${user.getId()}' + "?year=" + yearSelect.value, 'GET', null, function (rs) {
                    var dataMonth = rs;
                    // Xóa các option cũ trong dropdown year
                    monthSelect.innerHTML = '<option value="">-- Select Month --</option>';

                    // Thêm các option mới từ dữ liệu API
                    dataMonth.forEach(function (entry) {
                        var option = document.createElement('option');
                        option.value = entry.month;
                        option.textContent = entry.month;
                        monthSelect.appendChild(option);
                    });
                    monthSelect.addEventListener('change', function () {
                        var selectedMonth = monthSelect.value;
                        var selectedData = dataMonth.find(function (entry) {
                            return entry.month === parseInt(selectedMonth);
                        });
                        totalWorkingDayInput.value = "TotalWorkDay: " + selectedData.workdays + " Days";
                    });
                    $('div.custom-spinner').parent().remove();
                });

                if (yearSelect.value != "") {
                    var selectedYear = yearSelect.value;
                    var selectedData = data.find(function (entry) {
                        return entry.year === parseInt(selectedYear);
                    });
                    totalWorkingDayInput.value = "TotalWorkDay: " + selectedData.workdays + " Days";
                    monthSelect.style.display = 'block';
                } else {
                    totalWorkingDayInput.value = null;
                    monthSelect.style.display = 'none';
                }
            });
        }
    });
</script>

<%--Handle Contract--%>
<script>
    // Function formatAllowance
    function allowanceFormat(data) {
        var data = JSON.parse(data);
        var keyValueString = '';
        for (var key in data) {
            if (data.hasOwnProperty(key)) {
                keyValueString += '<strong>' + key + '</strong>' + ' : ' + data[key] + 'đ' + '<br><br>';
            }
        }
        keyValueString = keyValueString.slice(0, -2);

        return keyValueString;
    }

    // Handle when user click button "Edit Allowance"
    document.getElementById("showEditFields").addEventListener("click", function () {
        var editFields = document.getElementById("editFields");
        if (editFields.style.display === "none" || editFields.style.display === "") {
            editFields.style.display = "block";
        } else {
            editFields.style.display = "none";
        }
    });

    // Handle when user click button "Add Contract"
    document.addEventListener("DOMContentLoaded", function () {
        var addButtons = document.querySelectorAll(".add-contract-button");

        // Show modal Edit Contract
        addButtons.forEach(function (button) {
            button.addEventListener("click", function () {
                $("#addContractModal").modal("show");
            });
        });
    });

    Validator({
        form: '#formAddContract',
        errorSelector: '.form-message',
        rules: [
            Validator.isRequired('#addBasicSalary'),
            Validator.isRequired('#addInsuranceMoney'),
            Validator.isRequired('#telephone'),
            Validator.isRequired('#meal'),
            Validator.isRequired('#gasoline'),
            Validator.isRequired('#uniform'),
            Validator.isRequired('#attendance'),
            Validator.isRequired('#other')
        ],
        onSubmit: function (formData) {

            $('.container-button-add-contract').after(createLoadingHtml());

            var telPhone = document.getElementById('telephone').value;
            var meal = document.getElementById('meal').value;
            var gasoline = document.getElementById('gasoline').value;
            var uniform = document.getElementById('uniform').value;
            var attendance = document.getElementById('attendance').value;
            var other = document.getElementById('other').value;

            formData.append('userId', '${user.id}');
            formData.append('allowance', JSON.stringify({
                "Telephone": telPhone,
                "Meal": meal,
                "Gasoline": gasoline,
                "Uniform": uniform,
                "Attendance": attendance,
                "Other": other
            }));
            callAjaxByDataFormWithDataForm('/api/v1/contracts', 'POST', formData, function (rs) {
                sessionStorage.setItem('result', 'addContractSuccess');
                localStorage.setItem("showModal", "true");
                location.reload();
            }, 'formAddContract');
        }
    });

    // Handle when user click 'History Update' button
    document.addEventListener("DOMContentLoaded", function () {
        var tdElements = document.getElementsByClassName('format-allowance');
        for (var i = 0; i < tdElements.length; i++) {
            var tdElement = tdElements[i];
            var jsonText = tdElement.textContent;

            tdElement.innerHTML = allowanceFormat(jsonText);
        }
        var historyButtons = document.querySelectorAll('.history-contract-button');
        var contractIdHistory;

        historyButtons.forEach(function (button) {
            button.addEventListener('click', function () {
                contractIdHistory = button.value;
                $('#contractHistoryModal').modal('show');

                if ($.fn.DataTable.isDataTable('#table-history-contract')) {
                    $('#table-history-contract').DataTable().destroy();
                }

                if (contractIdHistory) {
                    table = $('#table-history-contract').DataTable({
                        ajax: {
                            url: '/api/v1/contracts/' + contractIdHistory,
                            contentType: 'application/json',
                            method: 'GET',
                            dataSrc: 'historyContract'
                        },
                        columns: [
                            {data: 'basicSalary'},
                            {
                                data: 'allowance',
                                render: function (data, type, row) {
                                    return allowanceFormat(data);
                                }
                            },
                            {data: 'insuranceType.name'},
                            {data: 'insuranceMoney'},
                            {
                                data: 'contract',
                                render: function (data, type, row) {
                                    if (data != null) {
                                        return '<a class="cut-file-name" href="' + data + '">' + data + '</a>';
                                    }
                                    return '';
                                }
                            },
                            {data: 'createdDate'}
                        ],
                        ordering: false,
                        searching: false,
                        lengthChange: false,
                        paging: false,
                        info: false,
                        initComplete: function () {
                            cutShortLink();
                        }
                    });
                }
            });
        });
    });

    // Handle when user click button "Edit Contract"
    document.addEventListener("DOMContentLoaded", function () {
        var editButtons = document.querySelectorAll(".edit-contract-button");
        var contractIdEdit;

        // Show modal Edit Contract
        editButtons.forEach(function (button) {
            button.addEventListener("click", function () {
                contractIdEdit = button.value;
                $("#editContractModal").modal("show");

                if (contractIdEdit) {

                    callAjaxByJsonWithData('/api/v1/contracts/' + contractIdEdit, 'GET', null, function (rs) {
                        var responseData = rs

                        // Đổ dữ liệu từ API vào các trường của modal
                        document.getElementById("editBasicSalary").value = responseData.basicSalary;
                        // document.getElementById("editAllowance").value = responseData.allowance;
                        var allowance = JSON.parse(responseData.allowance);
                        document.getElementById('editTelephone').value = allowance.Telephone;
                        document.getElementById('editMeal').value = allowance.Meal;
                        document.getElementById('editGasoline').value = allowance.Gasoline;
                        document.getElementById('editUniform').value = allowance.Uniform;
                        document.getElementById('editAttendance').value = allowance.Attendance;
                        document.getElementById('editOther').value = allowance.Other;

                        var selectElement = document.getElementById("editInsuranceType");
                        var editInsuranceType = responseData.insuranceType.name;
                        for (var i = 0; i < selectElement.options.length; i++) {
                            if (selectElement.options[i].text === editInsuranceType) {
                                // Option đã tồn tại, di chuyển option đó lên đầu
                                selectElement.insertBefore(selectElement.options[i], selectElement.options[0]);
                                break;
                            }
                        }
                        selectElement.selectedIndex = 0;

                        document.getElementById("editInsuranceMoney").value = responseData.insuranceMoney;
                    });
                }
            });
        });
    });

    // Handle when user click button "Confirm Edit Contract"
    document.addEventListener('DOMContentLoaded', function () {
        var confirmButton = document.getElementById("confirmContractButton");
        var contractId = document.querySelectorAll(".edit-contract-button");
        var contractIdValue;

        contractId.forEach(function (button) {
            button.addEventListener("click", function () {
                contractIdValue = button.value;
            });
        });

        Validator({
            form: '#editContractForm',
            errorSelector: '.form-message',
            rules: [
                Validator.isRequired('#editBasicSalary'),
                Validator.isRequired('#editInsuranceMoney')
            ],
            onSubmit: function (formData) {

                $('.container-button-edit-contract').after(createLoadingHtml());

                var telPhone = document.getElementById('editTelephone').value;
                var meal = document.getElementById('editMeal').value;
                var gasoline = document.getElementById('editGasoline').value;
                var uniform = document.getElementById('editUniform').value;
                var attendance = document.getElementById('editAttendance').value;
                var other = document.getElementById('editOther').value;

                formData.append('allowance', JSON.stringify({
                    "Telephone": telPhone,
                    "Meal": meal,
                    "Gasoline": gasoline,
                    "Uniform": uniform,
                    "Attendance": attendance,
                    "Other": other
                }));


                formData.append('userId', '${user.id}');
                formData.append('parentId', contractIdValue);
                callAjaxByDataFormWithDataForm('/api/v1/contracts', 'POST', formData, function (rs) {

                }, 'formAddContract');

                formData.delete('parentId');
                formData.delete('userId');
                formData.append('id', contractIdValue);
                callAjaxByDataFormWithDataForm('/api/v1/contracts/updation', 'POST', formData, function (rs) {
                    sessionStorage.setItem('result', 'editContractSuccess');
                    localStorage.setItem("showModal", "true");
                    location.reload();
                }, 'editContractForm');
            }
        });
    });

    // Handle when user click button "Confirm Delete Contract"
    document.addEventListener("DOMContentLoaded", function () {
        var deleteButtons = document.querySelectorAll(".delete-contract-button");
        var confirmButton = document.querySelector(".confirm-delete-button");
        var contractIdToDelete;

        // Xử lý khi nút Delete được nhấn
        deleteButtons.forEach(function (button) {
            button.addEventListener("click", function () {
                contractIdToDelete = button.value;

                // Đặt trạng thái hiển thị modal trong Local Storage thành true
                localStorage.setItem("showModal", "true");
                $("#deleteContractModal").modal("show");
            });
        });

        // Xử lý khi nút Confirm được nhấn trong modal
        confirmButton.addEventListener("click", function () {
            if (contractIdToDelete) {
                $('.container-button-delete-contract').after(createLoadingHtml());
                callAjaxByJsonWithData('/api/v1/contracts/' + contractIdToDelete, 'DELETE', null, function (rs) {
                    sessionStorage.setItem('result', 'deleteContractSuccess');
                    localStorage.setItem("showModal", "true");
                    location.reload();
                });
            }
        });
    });
    window.onload = function () {
        // Show Modal when page reload
        if (localStorage.getItem("showModal") === "true") {
            $("#contractModal").modal("show");
            // Đặt trạng thái hiển thị modal trong Local Storage thành false để tránh hiển thị lần tiếp theo
            localStorage.setItem("showModal", "false");
        }
    };

</script>

<%--Handle Role--%>
<script>
    document.addEventListener("DOMContentLoaded", function () {

        if (isDeleveloper()) {
            $('.hide').remove();
            $('#delUser').remove();
        } else {
            $('.hide').css('display', 'block');
        }
    });
</script>
</body>
</html>