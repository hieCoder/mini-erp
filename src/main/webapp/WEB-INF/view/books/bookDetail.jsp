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
                    <div class="text-center">
                        <img class="img-fluid image-book" alt="User Avatar" width="200">
                        <h4 class="mt-2 font-weight-bold title-book"></h4>
                        <p class="text-muted"><span class="author-book"></span></p>
                        <a class="cursor-pointer link-book" target="_blank">Link To Book</a>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="row">
                        <div class="col-md-12">
                            <h1 class="font-weight-bold mb-4">Your Feeling</h1>
                            <form id="feelingBookForm">
                                <div class="form-group mt-3">
                                    <div class="row align-items-center">
                                        <div class="col-auto pe-0"><i class="ri-message-2-line fs-4"></i></div>
                                        <div class="col ps-2 fs-5">Feel about the book?</div>
                                    </div>
                                    <textarea class="form-control data" name="feeling" id="feelingArea" placeholder="Enter here..."></textarea>
                                    <small class="form-message"></small>
                                </div>
                                <div class="form-group mt-3">
                                    <div class="row align-items-center">
                                        <div class="col-auto pe-0"><i class="ri-pencil-ruler-line fs-4"> </i></div>
                                        <div class="col ps-2 fs-5">Lessons Learned ?</div>
                                    </div>
                                    <textarea class="form-control data" name="lesson" id="lessonArea" placeholder="Enter here..."></textarea>
                                    <small class="form-message"></small>
                                </div>
                                <div class="form-group mt-3">
                                    <div class="row align-items-center">
                                        <div class="col-auto pe-0"><i class="ri-double-quotes-l fs-4"></i></div>
                                        <div class="col ps-2 fs-5">Quotes?</div>
                                    </div>
                                    <textarea class="form-control data" name="quote" id="quoteArea" placeholder="Enter here..."></textarea>
                                    <small class="form-message"></small>
                                </div>
                                <div class="form-group mt-3">
                                    <div class="row align-items-center">
                                        <div class="col-auto pe-0"><i class="ri-user-location-line fs-4"></i></div>
                                        <div class="col ps-2 fs-5">Action?</div>
                                    </div>
                                    <textarea class="form-control data" name="action" id="actionArea" placeholder="Enter here..."></textarea>
                                    <small class="form-message"></small>
                                </div>
                                <div class="form-group mt-3">
                                    <button id="submit-feeling" type="submit" class="btn btn-primary btn-load d-none">
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
                            <h1 class="font-weight-bold mt-5">Feelings Of Others</h1>
                            <div class="list-feeling mt-4">
<%--                                <div class="card border">--%>
<%--                                    <div class="card-header align-items-center d-flex p-0">--%>
<%--                                        <div class="flex-grow-1 oveflow-hidden m-2">--%>
<%--                                            <div class="d-flex mb-2 align-items-center">--%>
<%--                                                <div class="flex-shrink-0">--%>
<%--                                                    <img src="${feeling.avatarUser}" alt=""--%>
<%--                                                         class="avatar-sm rounded-circle"/>--%>
<%--                                                </div>--%>
<%--                                                <div class="flex-grow-1 ms-3">--%>
<%--                                                    <h5 class="list-title fs-15 mb-1">feeling.fullnameUser</h5>--%>
<%--                                                    <p class="list-text mb-0 fs-12">feeling.createdDate</p>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                    <div class="card-body">--%>
<%--                                        <div class="row">--%>
<%--                                            <div class="col-md-6">--%>
<%--                                                <div class="form-group mt-3">--%>
<%--                                                    <div class="row align-items-center">--%>
<%--                                                        <div class="col-auto pe-0"><i class="ri-message-2-line fs-4"></i></div>--%>
<%--                                                        <div class="col ps-2 fs-5">Feel about the book:</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="p-2">Feel about the book</div>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                            <div class="col-md-6">--%>
<%--                                                <div class="form-group mt-3">--%>
<%--                                                    <div class="row align-items-center">--%>
<%--                                                        <div class="col-auto pe-0"><i class="ri-pencil-ruler-line fs-4"> </i></div>--%>
<%--                                                        <div class="col ps-2 fs-5">Lessons Learned:</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="p-2">Feel about the book a</div>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                            <div class="col-md-6">--%>
<%--                                                <div class="form-group mt-3">--%>
<%--                                                    <div class="row align-items-center">--%>
<%--                                                        <div class="col-auto pe-0"><i class="ri-double-quotes-l fs-4"></i></div>--%>
<%--                                                        <div class="col ps-2 fs-5">Quotes:</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="p-2">Feel about the book a</div>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                            <div class="col-md-6">--%>
<%--                                                <div class="form-group mt-3">--%>
<%--                                                    <div class="row align-items-center">--%>
<%--                                                        <div class="col-auto pe-0"><i class="ri-user-location-line fs-4"></i></div>--%>
<%--                                                        <div class="col ps-2 fs-5">Action:</div>--%>
<%--                                                    </div>--%>
<%--                                                    <div class="p-2">Feel about the book a</div>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                    <div class="card-footer">--%>
<%--                                        <div class="create-comment">--%>
<%--                                            <form>--%>
<%--                                                <div class="form-group d-flex">--%>
<%--                                                    <input type="text" name="title" class="title-post-comment form-control" placeholder="Your comment">--%>
<%--                                                    <button type="submit" class="btn btn-success btn-load ms-1">--%>
<%--                                                        <span class="d-flex align-items-center">--%>
<%--                                                            <span class="spinner-border flex-shrink-0 d-none" style="margin-right: 5px;"></span>--%>
<%--                                                            <span class="flex-grow-1">Comment</span>--%>
<%--                                                        </span>--%>
<%--                                                    </button>--%>
<%--                                                </div>--%>
<%--                                            </form>--%>
<%--                                        </div>--%>
<%--                                        <div class="d-flex mt-4 comment-container" data-id="231201083140">--%>
<%--                                            <div class="flex-shrink-0">--%>
<%--                                                <img src="/upload/user/avatar-default.jpg" alt="" class="avatar-xs rounded-circle">--%>
<%--                                            </div>--%>
<%--                                            <div class="flex-grow-1 ms-3">--%>
<%--                                                <h5 class="fs-13"><a href="pages-profile.html">canh22</a> <small class="text-muted">01/12/2023 08:31:40</small></h5>--%>
<%--                                                <p class="mb-2">1</p>--%>
<%--                                                <div class="text-muted mb-1"><div class="ql-editor p-0" data-gramm="false" contenteditable="false"><p>1</p></div></div><div class="row mb-1"></div><a href="javascript: void(0);" class="badge text-muted bg-light btn-reply" data-id="231201083140" style="margin-right: 3px; font-size: 10px;"><i class="mdi mdi-reply"></i> Reply</a><a style="font-size: 10px;" href="javascript: void(0);" data-id="231201083140" class="badge text-muted bg-light btn-edit"><i class="mdi mdi-edit"></i> Edit</a>--%>
<%--                                                <a style="font-size: 10px;" href="#deleteCommentModal" data-bs-toggle="modal" data-id="231201083140" class="badge text-muted bg-light remove-comment-btn"><i class="mdi mdi-delete"></i> Delete</a><div class="form-reply mt-3" data-id="231201083140"></div><div class="form-edit mt-3" data-id="231201083140"></div>--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
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

<script src="/assets/custom/js/book/book-detail.js"></script>
<script>
    var bookId = '${bookId}';

    $(document).ready(function () {
       callAjaxByJsonWithData('/api/v1/books/'+bookId, 'GET', null, function (rs) {
           var book = rs;
           $('.image-book').attr('src', book.image);
           $('.title-book').text(book.title);
           $('.author-book').text(book.author);
           $('.link-book').attr('href', book.link);
       });

        callAjaxByJsonWithData('/api/v1/feeling-of-book/' + bookId + '/' + userCurrent.id, 'GET', null, function (rs) {
            $('#feelingArea').val(rs.feeling);
            $('#lessonArea').val(rs.lesson);
            $('#quoteArea').val(rs.quote);
            $('#actionArea').val(rs.action);

            $('#submit-feeling').addClass('d-none');
            $('#update-feeling').removeClass('d-none');
            $('#delete-feeling').removeClass('d-none');

        }, function (rs) {
            $('#submit-feeling').removeClass('d-none');
            $('#update-feeling').addClass('d-none');
        });

        Validator({
            form: '#feelingBookForm',
            errorSelector: '.form-message',
            rules: [
                Validator.isRequired('#feelingArea'),
                Validator.isRequired('#lessonArea'),
                Validator.isRequired('#quoteArea'),
                Validator.isRequired('#actionArea')
            ],
            onSubmit: function (formData) {
                formData.append('userId', userCurrent.id);
                formData.append('bookId', bookId);

                $('#feelingBookForm .spinner-border').removeClass('d-none');
                $('.btn').attr('disabled', true);

                callAjaxByJsonWithData('/api/v1/feeling-of-book/' + bookId + '/' + userCurrent.id, 'GET', null, function (rs) {
                    callAjaxByJsonWithDataForm('/api/v1/feeling-of-book', 'PUT', formData, function (rs) {
                        $('#feelingBookForm .spinner-border').addClass('d-none');
                        $('.btn').attr('disabled', false);
                        alertSuccess("Update success");
                    });
                }, function (rs) {
                    callAjaxByJsonWithDataForm('/api/v1/feeling-of-book', 'POST', formData, function (rs) {
                        $('#feelingBookForm .spinner-border').addClass('d-none');
                        $('.btn').attr('disabled', false);
                        alertSuccess("Add success");

                        $('#submit-feeling').addClass('d-none');
                        $('#update-feeling').removeClass('d-none');
                        $('#delete-feeling').removeClass('d-none');
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

    $(document).on('click', '#delete-feeling-confirm', function (e){
        callAjaxByJsonWithData("/api/v1/feeling-of-book?userId=" + userCurrent.id + "&bookId=" + bookId, "DELETE", null, function (rs) {
            $('#update-feeling').addClass('d-none');
            $('#delete-feeling').addClass('d-none');
            $('#submit-feeling').removeClass('d-none');
            $("#deleteFeelingModal").modal("hide");
            resetFormFeeling('feelingBookForm');
            alertSuccess("Delete success");
        });
    });


</script>
</body>
</html>