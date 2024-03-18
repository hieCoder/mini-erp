<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Book detail</title>
</head>
<body>

<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-sm-flex align-items-center justify-content-between">
            <h4 class="mb-sm-0">Book detail</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Time management</a></li>
                    <li class="breadcrumb-item active">Book detail</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<%--<!-- end page title -->--%>

<div class="row">
    <div class="col-lg-12">
        <div class="card" style="padding: 50px 50px 50px 0">
            <div class="row">
                <div class="col-md-3">
                    <div class="text-center ps-4">
                        <img class="img-fluid image-book" alt="User Avatar" width="200">
                        <h4 class="mt-2 font-weight-bold title-book"></h4>
                        <p class="text-muted"><span class="author-book"></span></p>
                        <a class="cursor-pointer link-book" target="_blank">Link To Book</a>
                    </div>
                    <div class="ps-4 mt-4">
                            <label class="form-label">Time Spent Reading <span class="text-danger">(Hour)</span></label>
                            <input type="number" class="form-control" placeholder="Enter here..." id="time-spent-reading">
                    </div>
                    <div class="ps-4 mt-2">
                        <label class="form-label">MeMo</label>
                        <textarea  class="form-control" placeholder="Enter here..." id="note"></textarea>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="d-flex align-items-center">
                                <h1 class="font-weight-bold">Write a book report</h1>
                                <i id="book-guide" class="ri-question-line fs-2 ms-2 cursor-pointer" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="right"
                                   data-bs-content="....." style="color: #11a4dd"></i>
                            </div>
                            <form id="feelingBookForm">
                                <div class="form-group mt-3">
                                    <textarea class="form-control data" name="bookReport" id="bookReport" placeholder="Enter here..." style="height: 120px"></textarea>
                                </div>
                                <div class="form-group mt-3">
                                    <button id="submit-feeling" type="submit" class="btn btn-primary btn-load d-none" disabled>
                                        <span class="d-flex align-items-center">
                                            <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                            <span class="flex-grow-1">Submit</span>
                                        </span>
                                    </button>
                                    <button id="update-feeling" type="submit" class="btn btn-primary btn-load d-none">
                                        <span class="d-flex align-items-center">
                                            <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                            <span class="flex-grow-1">Update</span>
                                        </span>
                                    </button>
                                    <a id="delete-feeling"  class="btn btn-danger d-none" data-bs-toggle="modal" href="#deleteFeelingModal">Delete</a>
                                    <a href="/books"><button type="button" class="btn btn-secondary">Back</button></a>
                                </div>
                            </form>
                        </div>
                        <div class="col-md-12">
                            <h1 class="font-weight-bold mt-5">Other book reports</h1>
                            <div class="list-feeling mt-4">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--end col-->
</div>
<!--end row-->

<div class="modal fade flip" id="deleteFeelingModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body p-5 text-center">
                <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop" colors="primary:#405189,secondary:#f06548" style="width:90px;height:90px"></lord-icon>
                <div class="mt-4 text-center">
                    <h4>You are sure ?</h4>
                    <p class="text-muted fs-14 mb-4">Delete this feeling?</p>
                    <div class="hstack gap-2 justify-content-center remove">
                        <button class="btn btn-danger btn-load" id="delete-feeling-confirm" data-id="">
                            <span class="d-flex align-items-center">
                                <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                <span class="flex-grow-1">Yes, Delete It</span>
                            </span>
                        </button>
                        <button class="btn btn-link btn-ghost-success fw-medium text-decoration-none" data-bs-dismiss="modal"><i class="ri-close-line me-1 align-middle"></i> Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--end delete modal -->

<div class="modal fade flip" id="deleteCommentModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-body p-5 text-center">
                <lord-icon src="https://cdn.lordicon.com/gsqxdxog.json" trigger="loop" colors="primary:#405189,secondary:#f06548" style="width:90px;height:90px"></lord-icon>
                <div class="mt-4 text-center">
                    <h4>You are sure ?</h4>
                    <p class="text-muted fs-14 mb-4">Delete this comment?</p>
                    <div class="hstack gap-2 justify-content-center remove">
                        <button class="btn btn-danger btn-load" id="delete-comment" data-id="">
                            <span class="d-flex align-items-center">
                                <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>
                                <span class="flex-grow-1">Yes, Delete It</span>
                            </span>
                        </button>
                        <button class="btn btn-link btn-ghost-success fw-medium text-decoration-none" data-bs-dismiss="modal"><i class="ri-close-line me-1 align-middle"></i> Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--end delete modal -->

<script src="/assets/custom/js/book/book-detail.js"></script>
<script>
    var bookId = '${bookId}';

    document.addEventListener("DOMContentLoaded", function () {
        var bookGuide = document.getElementById('book-guide');
        bookGuide.addEventListener('shown.bs.popover', function () {
            document.querySelectorAll('.popover-body').forEach(function (popoverBody) {
                popoverBody.innerHTML = '<div class="row align-items-center border-top">' +
                    '<div class="col-auto pe-0"><i class="ri-message-2-line fs-4"></i></div>' +
                    '<div class="col ps-2 fs-5">Feel about the book?</div>' +
                    '</div>' +
                    '<div class="row align-items-center border-top">' +
                    '<div class="col-auto pe-0"><i class="ri-pencil-ruler-line fs-4"></i></div>' +
                    '<div class="col ps-2 fs-5">Lessons learned from the book?</div>' +
                    '</div>' +
                    '<div class="row align-items-center border-top">' +
                    '<div class="col-auto pe-0"><i class="ri-double-quotes-l fs-4"></i></div>' +
                    '<div class="col ps-2 fs-5">Quotes from the book?</div>' +
                    '</div>' +
                    '<div class="row align-items-center border-top border-bottom">' +
                    '<div class="col-auto pe-0"><i class="ri-user-location-line fs-4"></i></div>' +
                    '<div class="col ps-2 fs-5">What is the activity you like to do after reading the book?</div>' +
                    '</div>';
            });
        });
    })

    $(document).ready(function () {
       callAjaxByJsonWithData('/api/v1/books/'+bookId, 'GET', null, function (rs) {
           var book = rs;
           $('.image-book').attr('src', book.image);
           $('.title-book').text(book.title);
           $('.author-book').text(book.author);
           $('.link-book').attr('href', book.link);
       });

        callAjaxByJsonWithData('/api/v1/feeling-of-book/' + bookId + '/' + userCurrent.id, 'GET', null, function (rs) {
            $('#bookReport').val(rs.bookReport);
            $('#time-spent-reading').val(rs.timeSpentReading);
            $('#note').val(rs.note);

            $('#submit-feeling').addClass('d-none');
            $('#update-feeling').removeClass('d-none');
            $('#delete-feeling').attr('data-id', rs.id);
            $('#delete-feeling').removeClass('d-none');
        }, function (rs) {
            $('#submit-feeling').removeClass('d-none');
            $('#update-feeling').addClass('d-none');
        });

        const feeling = document.querySelectorAll('.data');
        const submitButton = document.getElementById('submit-feeling');
        feeling.forEach(function (e) {
            e.addEventListener('input', function () {
                let allowSubmit = false;
                feeling.forEach(function (content) {
                    if (content.value != '') {
                        allowSubmit = true;
                    }
                })
                if (allowSubmit == true) submitButton.disabled = false;
                else if (allowSubmit == false) submitButton.disabled = true;
            })
        })

        Validator({
            form: '#feelingBookForm',
            errorSelector: '.form-message',
            rules: [
            ],
            onSubmit: function (formData) {
                formData.append('userId', userCurrent.id);
                formData.append('bookId', bookId);
                formData.append('timeSpentReading', $('#time-spent-reading').val());
                formData.append('note', $('#note').val())

                $('#feelingBookForm .spinner-border').removeClass('d-none');
                $('.btn').attr('disabled', true);
                callAjaxByJsonWithData('/api/v1/feeling-of-book/' + bookId + '/' + userCurrent.id, 'GET', null, function (rs) {
                    var id = rs.id;
                    callAjaxByJsonWithDataForm('/api/v1/feeling-of-book', 'PUT', formData, function (rs) {
                        $('#feelingBookForm .spinner-border').addClass('d-none');
                        $('.btn').attr('disabled', false);
                        alertSuccess("Update success");

                        var feelingItemE = $('.feeling-item[data-id="' + id + '"]');
                        feelingItemE.find('.bookReport-content').text(rs.bookReport);
                    });
                }, function (rs) {
                    callAjaxByJsonWithDataForm('/api/v1/feeling-of-book', 'POST', formData, function (rs) {
                        $('#feelingBookForm .spinner-border').addClass('d-none');
                        $('.btn').attr('disabled', false);
                        alertSuccess("Add success");

                        $('#submit-feeling').addClass('d-none');
                        $('#update-feeling').removeClass('d-none');
                        $('#delete-feeling').attr('data-id', rs.id);
                        $('#delete-feeling').removeClass('d-none');

                        var newFeeling = createFeeling(rs);
                        var feelingListE = $('.list-feeling');
                        feelingListE.prepend(newFeeling);
                    });
                });
            }
        });

        callAjaxByJsonWithData('/api/v1/feeling-of-book?bookId='+bookId, 'GET', null, function (feelings) {
            feelings.forEach((feeling) => {
                $('.list-feeling').append(createFeeling(feeling));
            });
        });
    });

    $(document).on('click', '#delete-feeling', function (e) {
        var id = $(this).data('id');
        $('#delete-feeling-confirm').attr('data-id', id);
    });

    $(document).on('click', '#delete-feeling-confirm', function (e){
        var id = $(this).data('id');
        $('#deleteFeelingModal .spinner-border').removeClass('d-none');

        callAjaxByJsonWithData("/api/v1/feeling-of-book?userId=" + userCurrent.id + "&bookId=" + bookId, "DELETE", null, function (rs) {
            $('#update-feeling').addClass('d-none');
            $('#delete-feeling').addClass('d-none');
            $('#submit-feeling').removeClass('d-none');

            $('#deleteFeelingModal .spinner-border').addClass('d-none');
            $("#deleteFeelingModal").modal("hide");
            $('#time-spent-reading').val('');
            $('#note').val('');
            resetFormFeeling('feelingBookForm');
            alertSuccess("Delete success");

            $('.feeling-item[data-id="' + id + '"]').remove();
        });
    });

    $(document).on('click', '.btn-create-comment', function (e) {
        var closestForm = $(this).closest('form');
        var inputE = closestForm.find('.content-comment');
        var inputVal = inputE.val();
        if(inputVal == ''){
            var errorE = closestForm.find('.message-validate-cmt');
            errorE.text('This fill is empty');
            errorE.css('color', 'red');
        } else{
            var id = $(this).data('id');

            var object = {
                content: inputVal,
                feelingBookId: id,
                parentId: null,
                userId: userCurrent.id
            }
            $(closestForm).find('.spinner-border').removeClass('d-none');

            callAjaxByJsonWithData('/api/v1/comment-feeling-book', 'POST', object, function (rs) {
                var newComment = createComment(rs);
                var commentListE = $('.comment-list[data-id="'+ id + '"]');
                commentListE.prepend(newComment);

                resetFormComment(closestForm);
                $(closestForm).find('.spinner-border').addClass('d-none');
            });
        }
    });

    $(document).on('click', '.remove-comment-btn', function (e) {
        var id = $(this).data('id');
        $('#delete-comment').attr('data-id', id);
    });

    $(document).on('click', '#delete-comment', function (e) {
        var id = $(this).attr('data-id');
        $('#deleteCommentModal .spinner-border').removeClass('d-none');
        callAjaxByJsonWithData("/api/v1/comment-feeling-book/" + id, "DELETE", null, function (rs) {
            $('#deleteCommentModal .spinner-border').addClass('d-none');
            $('#deleteCommentModal').modal('hide');
            $('.comment-container[data-id="' + id + '"]').remove();
        });
    });

    $(document).on('click', '.btn-edit', function (e) {
        var id = $(this).attr('data-id');
        var formE = $('.form-edit[data-id="' + id + '"]');
        if(formE.html() == ''){
            var swal = showAlertLoading();
            callAjaxByJsonWithData('/api/v1/comment-feeling-book/'+id, 'GET', null, function (rs){
                var formEdit = showFormEditComment(rs);
                formE.html(formEdit);
                swal.close();
            });
        }
    });

    $(document).on('click', '.btn-edit-comment', function (e) {
        var closestForm = $(this).closest('form');
        var inputE = closestForm.find('.content-comment');
        var inputVal = inputE.val();
        if(inputVal == ''){
            var errorE = closestForm.find('.message-validate-cmt');
            errorE.text('This fill is empty');
            errorE.css('color', 'red');
        } else{
            var id = $(this).data('id');

            var object = {
                content: inputVal,
                id: id
            }

            $(closestForm).find('.spinner-border').removeClass('d-none');
            callAjaxByJsonWithData('/api/v1/comment-feeling-book', 'PUT', object, function (rs) {
                $('.content-comment[data-id="' + id + '"]').text(rs.content);
                $(closestForm).remove();
                resetFormComment(closestForm);
            });
        }
    });

    $(document).on('click', '.btn-cancel', function (e) {
        var id = $(this).attr('data-id');
        $('.form-edit[data-id="' + id + '"]').html('');
    });
</script>
</body>
</html>