<%@ page import="com.shsoftvina.erpshsoftvina.security.Principal" %>
<%@ page import="com.shsoftvina.erpshsoftvina.enums.user.RoleEnum" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    session.setAttribute("pathMain", "/notifications/");
    session.setAttribute("apiURL", "/api/v1");
%>
<c:set var="userRole" value="${Principal.getUserCurrent().getRole()}"/>git
<html>
<head>
    <title>Notifications List</title>
    <link rel="stylesheet" href="/assets/css/notification/style.css">
</head>
<body>
<!-- quill css -->
<link href="assets/libs/quill/quill.core.css" rel="stylesheet" type="text/css" />
<!-- bubble css for bubble editor-->
<link href="assets/libs/quill/quill.bubble.css" rel="stylesheet" type="text/css" />
<!-- snow css for snow editor-->
<link href="assets/libs/quill/quill.snow.css" rel="stylesheet" type="text/css" />
<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header">
                <h4 class="card-title mb-0">Notification List</h4>
            </div><!-- end card header -->
            <div class="card-body">
                <div id="customerList">
                    <div class="row g-4 mb-3">
                        <div class="col-sm-auto d-flex justify-content-end align-items-center">
                                <div style="display: inline-block" class="dataTables_length"><label class="m-0">Show
                                    <select id="pageSizeSelect"
                                            name="example_length"
                                            aria-controls="example"
                                            class="form-select form-select-sm">
                                        <option <c:if test='${pageSize  == 10}'>selected</c:if>>10</option>
                                        <option <c:if test='${pageSize  == 15}'>selected</c:if>>15</option>
                                        <option <c:if test='${pageSize  == 20}'>selected</c:if>>20</option>
                                    </select> entries</label></div>
                        <c:if test="${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER)}">
                                <button type="button" class="btn btn-success addNotification" style="margin-left: 8px"><i class="ri-add-line align-bottom me-1"></i> Add</button>
                                <button type="button" class="btn btn-danger showListInactive" style="margin-left: 8px"><i class=" ri-delete-bin-line align-bottom me-1"></i> Inactive List</button>
                                <button class="btn btn-soft-danger" onclick="deleteMultiple()" style="margin-left: 8px"><i class="ri-delete-bin-2-line"></i></button>
                        </c:if>
                        </div>
                        <div class="col-sm d-flex justify-content-end align-items-center">
                                <div class="search-box ms-2">
                                    <input id="searchInput" type="text" class="form-control search" placeholder="Search Title or Author">
                                    <i class="ri-search-line search-icon"></i>
                                </div>
                                <button class="btn btn-sm btn-primary" id="searchButton" style="margin-left: 8px">Search</button>
                        </div>
                    </div>

                    <div class="table-responsive table-card mt-3 mb-1">
                        <table class="table align-middle table-nowrap" id="customerTable">
                            <thead class="table-light">
                            <tr>
                                <th scope="col" style="width: 50px;">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="checkAll" value="option">
                                    </div>
                                </th>
                                <th data-sort="customer_name">No. </th>
                                <th data-sort="email">Title</th>
                                <th data-sort="phone">Author</th>
                                <th data-sort="date">Created Date</th>
                            <c:if test="${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER)}">
                                <th data-sort="action">Action</th>
                            </c:if>
                            </tr>
                            </thead>
                            <tbody id="notificationList" class="list form-check-all">
                                <c:forEach items="${listNotification}" varStatus="loop" var="notification">
                                    <tr class="">
                                        <th scope="row">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" name="chk_child" value="option2">
                                            </div>
                                        </th>
                                        <td class="number">${(loop.index + 1) + (currentPage-1)*pageSize }</td>
                                        <td class="fw-bold title">
                                            <a target="_blank" href="<c:url value='/notifications/${notification.id}'/>">${notification.title}</a>
                                        </td>
                                        <td class="author">${notification.user.fullname}</td>
                                        <td class="createdDate">${notification.createdDate}</td>
                                        <c:if test="${userRole.equals(RoleEnum.OWNER) || userRole.equals(RoleEnum.MANAGER)}">
                                        <td>
                                            <div class="d-flex gap-2" data-id="${notification.id}">
                                                <div class="viewNotification">
                                                    <button class="btn btn-sm btn-info edit-item-btn">View</button>
                                                </div>
                                                <div class="editNotification">
                                                    <button class="btn btn-sm btn-success edit-item-btn">Edit</button>
                                                </div>
                                                <div class="removeNotification">
                                                    <button class="btn btn-sm btn-danger remove-item-btn">Remove</button>
                                                </div>
                                            </div>
                                        </td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="noresult" style="display: none">
                            <div class="text-center">
                                <lord-icon src="https://cdn.lordicon.com/msoeawqm.json" trigger="loop" colors="primary:#121331,secondary:#08a88a" style="width:75px;height:75px"></lord-icon>
                                <h5 class="mt-2">Sorry! No Result Found</h5>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex justify-content-center align-items-center paginationElement">
                        <div class="pagination-wrap hstack gap-2">
                            <div class="dataTables_paginate paging_simple_numbers" <c:if test="${totalPages <= 1}">class="invisible"</c:if> >
                                <ul class="pagination listjs-pagination mb-0" id="paginationList">
                                    <li class="paginate_button page-item previous linkStart">
                                        <span class="btn page-link fw-bold"
                                              data-page="1">Last</span>
                                    </li>
                                    <li class="paginate_button page-item previous linkStart">
                                        <span class="btn page-link fw-bold"
                                              data-page="-1">Previous</span>
                                    </li>
                                    <c:forEach var="page" begin="1" end="${totalPages}">
                                        <li class="paginate_button page-item <c:if test="${currentPage == page}"> active</c:if>"><span class="btn page-link fw-bold"
                                                                                                                                       data-page="${page}">${page}</span></li>
                                    </c:forEach>
                                    <li class="paginate_button page-item next linkEnd">
                                                        <span class="btn page-link fw-bold"
                                                              data-page="+1"> Next </span>
                                    </li>
                                    <li class="paginate_button page-item next linkEnd">
                                                        <span class="btn page-link fw-bold"
                                                              data-page="${totalPages}"> Last </span>
                                    </li>
                                </ul>
                            </div>

                        </div>
                    </div>
                </div>
            </div><!-- end card -->
        </div>
        <!-- end col -->
    </div>
    <!-- end col -->
</div>

<div id="listInactive" class="modal fade zoomIn" tabindex="-1" aria-labelledby="zoomInModalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="zoomInModalLabel">List Inactive Notifications</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table id="inactiveNotificationTable" class="table align-middle table-nowrap">
                    <thead class="table-light">
                    <tr>
                        <th scope="col">No.</th>
                        <th scope="col">Title</th>
                        <th scope="col">Author</th>
                        <th scope="col">Created Date</th>
                    </tr>
                    </thead>
                    <tbody id="inactiveNotificationList">
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>

<div id="viewNotification" class="modal modal-lg fade zoomIn" tabindex="-1" aria-labelledby="zoomInModalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">View Notification</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>

<div id="formNotication" data-bs-keyboard="false" data-bs-backdrop="static" class="modal fade zoomIn bs-example-modal-xl" tabindex="-1" aria-labelledby="myExtraLargeModalLabel" style="display: none;" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="myExtraLargeModalLabel">Create Notification Form</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- start page title -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="mb-3">
                                    <label class="form-label" for="titleCreate">Notification Title</label>
                                    <input type="text" class="form-control" id="titleCreate" placeholder="Input notification title">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Notification Content</label>
                                    <div class="snow-editor" id="contentCreate">

                                    </div>
                                </div>
                            </div>
                            <!-- end card body -->
                        </div>
                        <!-- end card -->

                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Attached files</h5>
                            </div>
                            <div class="card-body">
                                <div>
                                    <p class="text-muted">Add Attached files here.</p>

                                    <div class="dropzone">
                                        <div class="fallback">
                                            <input name="file" type="file" multiple="multiple">
                                        </div>
                                        <div class="dz-message needsclick">
                                            <div class="mb-3">
                                                <i class="display-4 text-muted ri-upload-cloud-2-fill"></i>
                                            </div>

                                            <h5>Drop files here or click to upload.</h5>
                                        </div>
                                    </div>

                                    <ul class="list-unstyled mb-0" id="dropzone-preview">
                                        <li class="mt-2" id="dropzone-preview-list">
                                            <!-- This is used as the file preview template -->
                                            <div class="border rounded">
                                                <div class="d-flex p-2">
                                                    <div class="flex-shrink-0 me-3">
                                                        <div class="avatar-sm bg-light rounded">
                                                            <img src="#" alt="Project-Image" data-dz-thumbnail class="img-fluid rounded d-block" />
                                                        </div>
                                                    </div>
                                                    <div class="flex-grow-1">
                                                        <div class="pt-1">
                                                            <h5 class="fs-14 mb-1" data-dz-name>&nbsp;</h5>
                                                            <p class="fs-13 text-muted mb-0" data-dz-size></p>
                                                            <strong class="error text-danger" data-dz-errormessage></strong>
                                                        </div>
                                                    </div>
                                                    <div class="flex-shrink-0 ms-3">
                                                        <button data-dz-remove class="btn btn-sm btn-danger">Delete</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                    <!-- end dropzon-preview -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <a href="javascript:void(0);" class="btn btn-link link-success fw-medium" data-bs-dismiss="modal"><i class="ri-close-line me-1 align-middle"></i> Close</a>
                <button type="button" class="btn btn-primary createBtn">Create</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<script>
        function displayPagination() {
        var currentUrl = window.location.search;
        var params = new URLSearchParams(currentUrl);
        var currentPage = !params.get('page') ? 1 : parseInt(params.get('page'));
        if (currentPage == 1) {
            $("li.linkStart").addClass("d-none")
        } else {
            $("li.linkStart").removeClass("d-none")
        }
        var lastPageElement = $("#paginationList > li").eq(-3)
        let lastPage = $(lastPageElement).children().attr("data-page")
        if (currentPage == lastPage) {
            $("li.linkEnd").addClass("d-none")
        } else {
            $("li.linkEnd").removeClass("d-none")
        }
    }

    document.addEventListener("DOMContentLoaded", function () {
        displayPagination()
        const baseUrl = "/api/v1/notifications";

        $("button.addNotification").click(function () {

            $("#formNotication").modal("show")

        })

        $(document).on("click", "li.viewNotification", function (e) {
            let main = $(this)
            let idNotification = main.parent().attr("data-id")
            console.log(idNotification)
            $("#viewNotification").modal("show")
        })
        $(document).on("click", "li.paginate_button", function (e) {
            var currentUrl = window.location.search;
            var params = new URLSearchParams(currentUrl);
            var currentPage = !params.get('page') ? 1 : parseInt(params.get('page'));
            var target = event.target;
            if (target.tagName === "SPAN") {
                var page = target.getAttribute("data-page");
                if (page === "-1") {
                    page = currentPage - 1
                    if (page < 1) {
                        return;
                    }
                } else if (page === "+1") {
                    page = currentPage + 1;
                }
                if (currentPage == page || page > ${totalPages}) {
                    return;
                }
                if (currentUrl.includes("page=")) {
                    currentUrl = currentUrl.replace(/(page=)[^\&]+/, "page=" + page);
                } else {
                    if (currentUrl.includes("?")) {
                        currentUrl += "&page=" + page;
                    } else {
                        currentUrl += "?page=" + page;
                    }
                }
            }
            document.querySelector(".page-item.active").classList.remove("active");
            var listActive = document.querySelectorAll('[data-page="' + page + '"]')
            if (page == 1) {
                listActive[1].parentElement.classList.add("active");
            } else {
                listActive[0].parentElement.classList.add("active");
            }
            var apiUrl = baseUrl + currentUrl
            var tbodyElement = document.getElementById("notificationList");
            tbodyElement.classList.add("hidden")
            callAjaxByJsonWithData(apiUrl, "GET", null,
                function (rs) {
                    if(rs){
                        history.pushState(null, null, currentUrl);
                        let xhtml =""
                        var currentURL = window.location.href;
                        var urlParams = new URLSearchParams(currentURL);
                        var pageSize = urlParams.get("pageSize") ? urlParams.get("pageSize") : 10
                        rs.forEach(function (notification, index) {
                            let pageInt = (parseInt(page) - 1) * pageSize
                            xhtml += '<tr class="">' +
                                '<th scope="row">'+
                                    '<div class="form-check">'+
                                        '<input class="form-check-input" type="checkbox" name="chk_child" value="option2">'+
                                    '</div>'+
                                '</th>'+
                                '<td>' + (index + pageInt + 1) + '</td>' +
                                '<td class="fw-bold"><a target="_blank" href="/notifications/' + notification.id + '">' + notification.title + '</a></td>' +
                                '<td>' + notification.user.fullname + '</td>' +
                                '<td>' + notification.createdDate + '</td>' +
                                '<td>' +
                                '    <div class="d-flex gap-2" data-id="'+ notification.id +  '">' +
                                        '<div class="viewNotification">'+
                                            '<button class="btn btn-sm btn-info edit-item-btn">View</button>'+
                                       ' </div>'+
                                        '<div class="editNotification">'+
                                            '<button class="btn btn-sm btn-success edit-item-btn">Edit</button>'+
                                        '</div>'+
                                        '<div class="removeNotification">'+
                                            '<button class="btn btn-sm btn-danger remove-item-btn">Remove</button>'+
                                        '</div>'+
                                '    </div>' +
                                '</td>'+
                                '</tr>'
                        })
                        tbodyElement.innerHTML = xhtml
                        tbodyElement.classList.remove("hidden")
                        displayPagination()
                    } else{
                        console.log("Data API Error")
                    }
                },
                function (error){
                    console.log("Call API Error")
                    console.log(error)
            })
        })
        const pageSizeSelect = document.getElementById("pageSizeSelect");

        pageSizeSelect.addEventListener("change", () => {
            const selectedValue = pageSizeSelect.value;
            updateUrl(selectedValue);
        });

        const updateUrl = (selectedValue) => {
            let currentUrl = window.location.href;
            if (currentUrl.includes("pageSize=")) {
                currentUrl = currentUrl.replace(/(pageSize=)[^\&]+/, "pageSize=" + selectedValue);
            } else {
                if (currentUrl.includes("?")) {
                    currentUrl += "&pageSize=" + selectedValue
                } else {
                    currentUrl += "?pageSize=" + selectedValue
                }
            }
            window.location.href = currentUrl
        };

        function searchNotification() {
            var keyword = searchInput.value;
            var currentUrl = window.location.href;

            if (currentUrl.includes("?")) {
                if (currentUrl.includes("search=")) {
                    var regex = /(\?|&)search=([^&]*)/;
                    var newUrl = currentUrl.replace(regex, "$1search=" + encodeURIComponent(keyword));
                    window.location.href = newUrl;
                } else {
                    var newUrl = currentUrl + "&search=" + encodeURIComponent(keyword);
                    window.location.href = newUrl;
                }
            } else {
                var newUrl = currentUrl + "?search=" + encodeURIComponent(keyword);
                window.location.href = newUrl;
            }
        }


        var searchInput = document.getElementById("searchInput");
        var searchButton = document.getElementById("searchButton");
        searchInput.addEventListener("keydown", handleSearchEvent);
        searchButton.addEventListener("click", handleSearchEvent);

        function showSearchValue(){
            var url = new URL(window.location.href);
            var params = url.searchParams;
            var paramValue = params.get("search");
            if(paramValue){
                document.getElementById("searchInput").value = paramValue
            }
        }
        showSearchValue()
        function handleSearchEvent(event) {
            if (event.key === "Enter" || event.type === "click") {
                searchNotification();
            }
        }

        $("button.showListInactive").click(function () {
            let button = $(this)
            button.addClass("d-none")
            button.prop("disabled", true)
            button.before(BtnDangerLoad)
            callAjaxByJsonWithData(baseUrl + "/inactive", "GET", null, function (rs) {
                if (rs) {
                    let xhtml = ""
                    if (rs.length > 0) {
                        rs.forEach(function (notification, index) {
                            xhtml += '<tr>' +
                                '<td>' + (index + 1) + '</td>' +
                                '<td class="fw-bold"><a target="_blank" href="/notifications/' + notification.id + '">' + notification.title + '</a></td>' +
                                '<td>' + notification.user.fullname + '</td>' +
                                '<td>' + notification.createdDate + '</td>' +
                                '</tr>';
                        })
                        $("#inactiveNotificationList").html(xhtml)
                    } else {
                        xhtml = '<tr>' +
                            '<td class="text-center" colspan="4">' +
                            '<div class="alert alert-warning" role="alert"> <strong> The list is empty  </strong></div>' +
                            '</td>' +
                            '</tr>'
                        $("#inactiveNotificationList").html(xhtml)
                    }
                    $("#listInactive").modal("show")
                    button.removeClass("d-none")
                    $("button.showListInactive").prop("disabled", false)
                } else {
                    console.log("Data Error")
                    $("button.showListInactive").prop("disabled", false)
                }
                BtnLoadRemove()
            }, function (error){
                console.log("Call API Error")
                console.log(error)
            })
        });
    })
        let checkSearch = (number) => {
            var url = new URL(window.location.href);
            var params = url.searchParams;
            var paramValue = params.get("search");
            if((number === 0 && paramValue) || number === 0){
                $(".noresult").css("display", "block")
                $("ul.pagination ").addClass("d-none")
            } else{
                $(".noresult").css("display", "none")
                $("ul.pagination ").removeClass("d-none")
            }
        }
        checkSearch(${listNotification.size()});
</script>
<!-- quill js -->
<script src="/assets/libs/quill/quill.min.js"></script>
<!-- dropzone js -->
<script src="/assets/libs/dropzone/dropzone-min.js"></script>
<!-- init js -->
<script src="/assets/js/pages/form-editor.init.js"></script>
<script>
    let listTypeFileArr = "${listTypeFile}".split(",")
    let listTypeFile = ""
    listTypeFileArr.forEach((item, index)=>{
        listTypeFile += "." + item
        if(index<listTypeFileArr.length){
            listTypeFile += ","
        }
    })
    let maxFileSize = "${maxFileSize}"
    let uploadFileLimit = "${uploadFileLimit}"
    var dropzonePreviewNode = document.querySelector("#dropzone-preview-list");
    dropzonePreviewNode.id = "";
    var previewTemplate = dropzonePreviewNode.parentNode.innerHTML;
    dropzonePreviewNode.parentNode.removeChild(dropzonePreviewNode);
    var dropzone = new Dropzone(".dropzone", {
        url: 'https://httpbin.org/post',
        method: "post",
        previewTemplate: previewTemplate,
        previewsContainer: "#dropzone-preview",
        acceptedFiles: listTypeFile,
        maxFilesize: parseInt(maxFileSize),
        maxFiles: parseInt(uploadFileLimit) ,
        autoProcessQueue: false,
    });

    $(document).on("click","button.createBtn", function (){
        let title = $("#titleCreate").val()
        let content = $(".ql-editor").html().toString()
        var formData = new FormData();
        formData.append("title", title);
        formData.append("content", content);
        if(dropzone.files.length>0){
            for (let i = 0; i < dropzone.files.length; i++) {
                let file = dropzone.files[i]
                if(file.accepted){
                    formData.append("files", file);
                }
           }
        }
        callAjaxByDataFormWithDataForm2("${apiURL}${pathMain}","POST",function (rs){
            console.log(rs)
        },function (error){
            console.log(error)
        })
    })
</script>
</body>
</html>
