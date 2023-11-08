<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Books</title>
</head>
<body>
<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Book</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Time management</a></li>
                    <li class="breadcrumb-item active">Book</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<%--<!-- end page title -->--%>

<div class="row">
    <div class="col-lg-12">
        <div class="alert alert-success d-none"></div>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header border-0">
                <div class="d-flex align-items-center">
                    <h5 class="card-title mb-0 flex-grow-1">All books</h5>
                    <div class="flex-shrink-0">
                        <button data-bs-toggle="modal" data-bs-target="#addBookModal" id="add-book-btn" class="btn btn-success d-none"><i class="ri-add-line align-bottom me-1"></i> Add book</button>
                    </div>
                </div>
            </div>
            <div class="card-body border border-dashed border-end-0 border-start-0">
                <form>
                    <div class="row g-3">
                        <div class="col-xxl-9 col-sm-12">
                            <div class="search-box">
                                <input id="search-input" type="text" class="form-control search bg-light border-light" placeholder="Search by title, username">
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
                        <!--end col-->
                        <div class="col-xxl-2 col-sm-4 d-flex align-items-center justify-content-end">
                            <div style="margin-right: 5px;">Show entries: </div>
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
                        <!--end col-->
                    </div>
                    <!--end row-->
                </form>
            </div>
            <!--end card-body-->
            <div class="card-body">
                <div class="table-responsive table-card">
                    <table id="datatable-book" class="table align-middle table-nowrap mb-0 w-100" style="margin: 0px!important;">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Book</th>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Created by</th>
                            <th>Created date</th>
                            <th>Action</th>
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
            <!--end card-body-->
        </div>
        <!--end card-->
    </div>
    <!--end col-->
</div>
<!--end row-->

<!-- Modal Add Book -->
<div class="modal fade zoomIn" id="addBookModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content border-0">
            <div class="modal-header p-3 bg-soft-info">
                <h5 class="modal-title" id="exampleModalLabel">Add book</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="close-modal"></button>
            </div>
            <form id="addBookForm">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-lg-12">
                            <div>
                                <label for="title-add" class="form-label">Title</label>
                                <input type="text" id="title-add" name="title" class="form-control" placeholder="Title"/>
                                <small class="form-message"></small>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div>
                                <label for="author-add" class="form-label">Author</label>
                                <input type="text" id="author-add" name="author" class="form-control" placeholder="Author"/>
                                <small class="form-message"></small>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div>
                                <label for="link-add" class="form-label">Link</label>
                                <input type="text" id="link-add" name="link" class="form-control" placeholder="Link"/>
                                <small class="form-message"></small>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div>
                                <label for="image-add" class="form-label">Image</label>
                                <input type="file" id="image-add" name="image" class="form-control file-image" accept="image/*" placeholder="Image"/>
                                <img src="" alt="Preview Image" style="max-width: 200px;" id="image-preview-add" class="image-preview d-none">
                                <small class="form-message"></small>
                            </div>
                        </div>
                    </div>
                    <!--end row-->
                </div>
                <div class="modal-footer">
                    <div class="hstack gap-2 justify-content-end">
                        <button type="submit" class="btn btn-success btn-load">
                            <span class="d-flex align-items-center">
                                <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                <span class="flex-grow-1">Add</span>
                            </span>
                        </button>
                        <button type="button" class="btn btn-light" id="close-modal" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<!--end modal-->

<!-- Modal Edit Book -->
<div class="modal fade zoomIn" id="editBookModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content border-0">
            <div class="modal-header p-3 bg-soft-info">
                <h5 class="modal-title" id="exampleModalLabel">Edit book</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="close-modal"></button>
            </div>
            <form id="editBookForm">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-lg-12">
                            <div>
                                <label for="title-add" class="form-label">Title</label>
                                <input type="text" id="title-edit" name="title" class="form-control" placeholder="Title"/>
                                <small class="form-message"></small>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div>
                                <label for="author-add" class="form-label">Author</label>
                                <input type="text" id="author-edit" name="author" class="form-control" placeholder="Author"/>
                                <small class="form-message"></small>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div>
                                <label for="link-add" class="form-label">Link</label>
                                <input type="text" id="link-edit" name="link" class="form-control" placeholder="Link"/>
                                <small class="form-message"></small>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div>
                                <label for="image-add" class="form-label">Image</label>
                                <input type="file" id="image-edit" name="image" class="form-control file-image" accept="image/*" placeholder="Image"/>
                                <img src="" alt="Preview Image" style="max-width: 200px;" id="image-preview-edit" class="image-preview d-none">
                                <small class="form-message"></small>
                            </div>
                        </div>
                    </div>
                    <!--end row-->
                </div>
                <div class="modal-footer">
                    <div class="hstack gap-2 justify-content-end">
                        <button type="submit" class="btn btn-success btn-load">
                            <span class="d-flex align-items-center">
                                <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                <span class="flex-grow-1">Add</span>
                            </span>
                        </button>
                        <button type="button" class="btn btn-light" id="close-modal" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<!--end modal-->

<script>

    function getUrlApiBooks(search, page, pageSize) {
        return '/api/v1/books?search='+search+'&page='+page+'&pageSize='+pageSize;
    }

    function getCountListApiUrl(search) {
        return '/api/v1/books/count?search='+search;
    }

    var objPaging = {
        search:'',
        page: 1,
        pageSize: $('#page-count-select').val()
    }

    var table = null;

    $(document).ready(function (){

        if(isDeleveloper()){
            $('#add-book-btn').remove();
        } else{
            $('#add-book-btn').removeClass('d-none');
        }

        table = $('#datatable-book').DataTable({
            ajax: {
                url: getUrlApiBooks(objPaging.search, 1, objPaging.pageSize),
                method: 'GET',
                dataSrc: function (json) {
                    if(json.length != 0) {
                        loadPaging();
                        $('#pagination').addClass('mt-4');
                    }
                    else {
                        removePagingIfExsit();
                        $('#pagination').removeClass('mt-4');
                    }
                    return json;
                }
            },
            columns: [
                {data: 'id'},
                {
                    data: 'image',
                    render: function(data, type, row) {
                        return `<img src="`+data+`" height="40"/>`;
                    }
                },
                {
                    data: 'title',
                    render: function(data, type, row) {
                        return `<a class="fw-medium link-primary text-decoration-underline" href="/books/`+row.id+`">`+data+`</a>`;
                    }
                },
                {data: 'author'},
                {data: 'createdBy'},
                {data: 'createdDate'},
                {
                    render: function (data, type, row) {
                        return `<div class="d-flex gap-2">
                                    <div class="edit">
                                        <button data-id="`+row.id+ `" class="btn btn-sm btn-success edit-book-btn">Edit</button>
                                    </div>
                                    <div class="remove">
                                        <button data-id="`+row.id+`" class="btn btn-sm btn-danger remove-book-btn">Remove</button>
                                    </div>
                        </div>`;
                    }
                }
            ],
            ordering: false,
            searching: false,
            lengthChange: false,
            paging: false,
            info: false
        });
    });

    $(document).on('click', '#filter-btn', function() {
        objPaging.search = $('#search-input').val();
        objPaging.page = 1;

        var btn = $(this);
        btn.find('.spinner-border').removeClass('d-none');

        table.ajax.url(getUrlApiBooks(objPaging.search,
            objPaging.page, objPaging.pageSize)).load(function () {
            btn.find('.spinner-border').addClass('d-none');
        });
    });

    $(document).on('change', '#page-count-select', function() {
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

    function removePagingIfExsit(){
        if (window.pagObj) {
            window.pagObj.twbsPagination('destroy');
        }
    }

    function loadPaging(){
        callAjaxByJsonWithData(getCountListApiUrl(objPaging.search), 'GET', null, function (totalItem) {

            removePagingIfExsit();

            //paging
            var totalPages = 0;
            if(totalItem <= objPaging.pageSize) totalPages = 1;
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

    $(document).on('change', '.file-image', function() {
        const selectedFile = this.files[0];
        if (selectedFile) {
            const reader = new FileReader();
            const imagePreview = $(this).siblings('.image-preview');

            reader.onload = function(e) {
                imagePreview.attr('src', e.target.result);
                imagePreview.removeClass('d-none');
            };

            reader.readAsDataURL(selectedFile);
        }
    });

    $(document).on('shown.bs.modal', '#addBookModal', function() {

        $('#title-add').val('');
        $('#author-add').val('');
        $('#link-add').val('');
        $('#image-add').val('');
        var imagepreview = $('#image-preview-add');
        imagepreview.attr('src', '');
        imagepreview.addClass('d-none');

        Validator({
            form:'#addBookForm',
            errorSelector: '.form-message',
            rules:[
                Validator.isRequired('#title-add'),
                Validator.isRequired('#author-add'),
                Validator.isRequired('#link-add'),
                Validator.isRequired('#image-add'),
            ],
            onSubmit: function (formData) {

                formData.append('fullnameUser', userCurrent.fullname);

                $('#addBookForm .spinner-border').removeClass('d-none');
                callAjaxByDataFormWithDataForm('/api/v1/books', 'POST', formData, function (rs) {

                    table.ajax.url(getUrlApiBooks(objPaging.search,
                        objPaging.page, objPaging.pageSize)).load(function () {
                        $('#addBookForm .spinner-border').addClass('d-none');
                        $("#addBookModal").modal("hide");
                        showAlert(SUCCESS_ALERT, 'Add success');
                    });
                });
            }
        });
    });

    $(document).on('click', '.edit-book-btn', function () {
        var id = $(this).data('id');
        var swal = showAlertLoading();
        callAjaxByJsonWithData("/api/v1/books/" + id, "GET", null, function (rs) {
            var book = rs.book;
            $('#title-edit').val(book.title);
            $('#author-edit').val(book.author);
            $('#link-edit').val(book.link);
            $('#image-edit').val('');
            var imagepreview = $('#image-preview-edit');
            imagepreview.attr('src', book.image);
            imagepreview.removeClass('d-none');

            swal.close();
            $('#editBookModal').modal('show');
        });

        Validator({
            form:'#editBookForm',
            errorSelector: '.form-message',
            rules:[
                Validator.isRequired('#title-edit'),
                Validator.isRequired('#author-edit'),
                Validator.isRequired('#link-edit')
            ],
            onSubmit: function (formData) {
                formData.append('id', id);

                $('#editBookForm .spinner-border').removeClass('d-none');
                callAjaxByDataFormWithDataForm('/api/v1/books/updation', 'POST', formData, function (rs) {

                    table.ajax.url(getUrlApiBooks(objPaging.search,
                        objPaging.page, objPaging.pageSize)).load(function () {
                        $('#editBookForm .spinner-border').addClass('d-none');
                        $("#editBookModal").modal("hide");
                        showAlert(SUCCESS_ALERT, 'Update success');
                    });
                });
            }
        });
    });
</script>

<%--<!-- Modal Delete Book -->--%>
<%--<div class="modal fade" id="deleteBookModal" tabindex="-1" role="dialog" aria-labelledby="deleteBookModalLabel"--%>
<%--     aria-hidden="true">--%>
<%--    <div class="modal-dialog modal-dialog-centered" role="document">--%>
<%--        <div class="modal-content">--%>
<%--            <div class="modal-body">--%>
<%--                Are you sure to delete this book ?--%>
<%--            </div>--%>
<%--            <div class="modal-footer container-button-delete-user">--%>
<%--                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>--%>
<%--                <button type="button" class="btn btn-danger confirm-del-button">Delete</button>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<!-- Modal Notification  -->--%>
<%--<div class="modal fade" id="resultModal" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel"--%>
<%--     aria-hidden="true">--%>
<%--    <div class="modal-dialog modal-dialog-centered" role="document">--%>
<%--        <div class="modal-content">--%>
<%--            <div class="modal-header">--%>
<%--                <h4 class="modal-title" id="resultModalLabel">Result</h4>--%>
<%--                <button type="button" class="close" data-dismiss="modal" aria-label="Close">--%>
<%--                    <span aria-hidden="true">&times;</span>--%>
<%--                </button>--%>
<%--            </div>--%>
<%--            <div class="modal-body" id="resultMessage">--%>
<%--                <!-- Message Success -->--%>
<%--            </div>--%>
<%--            <div class="modal-footer">--%>
<%--                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<script>--%>

<%--    // Handle when user click button 'Add Book'--%>
<%--    document.addEventListener('DOMContentLoaded', function () {--%>
<%--        var addButton = document.querySelectorAll('.add-book-button');--%>

<%--        addButton.forEach(function (button) {--%>
<%--            button.addEventListener('click', function () {--%>
<%--                $('#addBookModal').modal('show');--%>
<%--            });--%>
<%--        });--%>

<%--        var submitButton = document.getElementById('addBookButton');--%>
<%--        submitButton.addEventListener('click', function () {--%>
<%--            var titleE = document.getElementById('title');--%>
<%--            var authorE = document.getElementById('author');--%>
<%--            var linkE = document.getElementById('link');--%>
<%--            var image = document.getElementById('image');--%>

<%--            var valueTitle = titleE.value;--%>
<%--            var valueAuthor = authorE.value;--%>
<%--            var valueLink = linkE.value;--%>

<%--            var isValidate = true;--%>

<%--            var errorMessageSpan = titleE.nextElementSibling;--%>
<%--            if (valueTitle === "") {--%>
<%--                errorMessageSpan.textContent = "This field is not filled";--%>
<%--                isValidate = false;--%>
<%--            } else {--%>
<%--                errorMessageSpan.textContent = '';--%>
<%--            }--%>

<%--            errorMessageSpan = authorE.nextElementSibling;--%>
<%--            if (valueAuthor === "") {--%>
<%--                errorMessageSpan.textContent = "This field is not filled";--%>
<%--                isValidate = false;--%>
<%--            } else {--%>
<%--                errorMessageSpan.textContent = '';--%>
<%--            }--%>

<%--            errorMessageSpan = linkE.nextElementSibling;--%>
<%--            if (valueLink === "") {--%>
<%--                errorMessageSpan.textContent = "This field is not filled";--%>
<%--                isValidate = false;--%>
<%--            } else {--%>
<%--                errorMessageSpan.textContent = '';--%>
<%--            }--%>

<%--            errorMessageSpan = image.nextElementSibling;--%>
<%--            if (image.files.length === 0) {--%>
<%--                errorMessageSpan.textContent = "This field is not filled";--%>
<%--                isValidate = false;--%>
<%--            } else {--%>
<%--                errorMessageSpan.textContent = '';--%>
<%--            }--%>

<%--            if (isValidate) {--%>
<%--                var formData = new FormData--%>
<%--                formData.append('title', valueTitle);--%>
<%--                formData.append('author', valueAuthor);--%>
<%--                formData.append('link', valueLink);--%>
<%--                formData.append('fullnameUser', userCurrent.fullname);--%>

<%--                if (image.files.length > 0) {--%>
<%--                    formData.append('image', image.files[0]);--%>
<%--                }--%>

<%--                callAjaxByDataFormWithDataForm('/api/v1/books', 'POST', formData, function (rs) {--%>
<%--                    sessionStorage.setItem('result', 'addBookSuccess');--%>
<%--                    location.reload();--%>
<%--                })--%>
<%--            };--%>
<%--        });--%>
<%--    });--%>

<%--    // Handle when user click button 'Delete Book'--%>
<%--    document.addEventListener('DOMContentLoaded', function () {--%>
<%--        var delButtons = document.querySelectorAll(".del-book-button");--%>
<%--        var confirmDelButton = document.querySelector(".confirm-del-button");--%>
<%--        var bookId;--%>

<%--        // Xử lý khi nút Delete được nhấn--%>
<%--        delButtons.forEach(function (button) {--%>
<%--            button.addEventListener("click", function () {--%>
<%--                bookId = button.value;--%>
<%--                confirmDelButton.addEventListener('click', function () {--%>
<%--                    if (bookId) {--%>
<%--                        callAjaxByJsonWithData('/api/v1/books/' + bookId, 'DELETE', null, function (rs) {--%>
<%--                            sessionStorage.setItem('result', 'delBookSuccess');--%>
<%--                            location.reload();--%>
<%--                        })--%>
<%--                    }--%>
<%--                })--%>
<%--            });--%>
<%--        });--%>
<%--    });--%>

<%--    // Handle when user click button 'Edit Book'--%>
<%--    document.addEventListener('DOMContentLoaded', function () {--%>
<%--        var editButton = document.querySelectorAll('.edit-book-button');--%>
<%--        var bookId;--%>

<%--        editButton.forEach(function (button) {--%>
<%--            button.addEventListener('click', function () {--%>
<%--                bookId = button.value;--%>
<%--                $('#editBookModal').modal('show');--%>

<%--                callAjaxByJsonWithData('/api/v1/books/' + bookId, 'GET', null, function (rs) {--%>
<%--                    var responseData = rs;--%>

<%--                    // Đổ dữ liệu từ API vào các trường của modal--%>
<%--                    document.getElementById('editTitle').value = responseData.book.title;--%>
<%--                    document.getElementById('editAuthor').value = responseData.book.author;--%>
<%--                    document.getElementById('editLink').value = responseData.book.link;--%>
<%--                    $('.img-edit-book').attr('src', responseData.book.image);--%>

<%--                    var submitButton = document.getElementById('editBookButton');--%>
<%--                    submitButton.addEventListener('click', function () {--%>
<%--                        var title = document.getElementById('editTitle').value;--%>
<%--                        var author = document.getElementById('editAuthor').value;--%>
<%--                        var link = document.getElementById('editLink').value;--%>
<%--                        var image = document.getElementById('editImage');--%>

<%--                        var formData = new FormData--%>
<%--                        formData.append('id', bookId);--%>
<%--                        formData.append('title', title);--%>
<%--                        formData.append('author', author);--%>
<%--                        formData.append('link', link);--%>

<%--                        if (image.files.length != 0) {--%>
<%--                            formData.append('image', image.files[0]);--%>
<%--                        }--%>

<%--                        callAjaxByDataFormWithDataForm('/api/v1/books/update', 'POST', formData, function (rs) {--%>
<%--                            sessionStorage.setItem('result', 'updateBookSuccess');--%>
<%--                            location.reload();--%>
<%--                        })--%>
<%--                    });--%>
<%--                });--%>
<%--            });--%>
<%--        });--%>
<%--    });--%>

<%--    // Notification--%>
<%--    document.addEventListener('DOMContentLoaded', function () {--%>
<%--        const result = sessionStorage.getItem('result');--%>
<%--        if (result) {--%>
<%--            let message;--%>
<%--            switch (result) {--%>
<%--                case 'addBookSuccess':--%>
<%--                    message = 'Add Book Success';--%>
<%--                    break;--%>
<%--                case 'updateBookSuccess':--%>
<%--                    message = 'Update Book Success';--%>
<%--                    break;--%>
<%--                case 'delBookSuccess':--%>
<%--                    message = 'Delete Book Success';--%>
<%--                    break;--%>
<%--                default:--%>
<%--                    message = 'Unknown Result';--%>
<%--            }--%>
<%--            $('#resultMessage').text(message);--%>
<%--            $('#resultModal').modal('show');--%>
<%--            sessionStorage.clear();--%>
<%--        }--%>
<%--    });--%>

<%--    document.addEventListener('DOMContentLoaded', function () {--%>
<%--        var addButton = document.querySelector('.add-book-button');--%>
<%--        var actionColumn = document.querySelectorAll('th')[6];--%>
<%--        var actionValue = document.querySelectorAll('.action');--%>

<%--        if (userCurrent.role === 'DEVELOPER') {--%>
<%--            addButton.remove();--%>
<%--            actionColumn.remove();--%>
<%--            actionValue.forEach(function (element) {--%>
<%--                element.remove();--%>
<%--            });--%>
<%--        }--%>
<%--    });--%>

<%--    // Get value Search save to Local Storage--%>
<%--    document.getElementById("search").addEventListener("input", function () {--%>
<%--        localStorage.setItem("searchBook", this.value);--%>
<%--    });--%>

<%--    // Restore "Search" value from Local Storage--%>
<%--    window.addEventListener("load", function () {--%>
<%--        var selectedSearch = localStorage.getItem("searchBook");--%>
<%--        if (selectedSearch) {--%>
<%--            document.getElementById("search").value = selectedSearch;--%>
<%--        }--%>
<%--    });--%>

<%--</script>--%>

</body>
</html>
