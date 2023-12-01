<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Book detail</title>
    <!-- Sweet Alert css-->
    <link href="/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css"/>
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
                        <img src="${bookDetail.book.image}" class="img-fluid" alt="User Avatar" width="200">
                        <h4 class="mt-2 font-weight-bold">${bookDetail.book.title}</h4>
                        <p class="text-muted">Author: ${bookDetail.book.author}</p>
                        <a href="${bookDetail.book.link}" class="cursor-pointer" target="_blank">Link To Book</a>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="row">
                        <div class="col-md-12">
                            <form class="feeling" id="feelingBook">
                                <div class="form-group">
                                    <div class="row align-items-center">
                                        <div class="col-auto pe-0">
                                            <i class="ri-message-2-line fs-4"></i>
                                        </div>
                                        <div class="col ps-2 fs-5">
                                            Feel about the book?
                                        </div>
                                    </div>
                                    <textarea class="form-control data" name="feeling"
                                              id="feelingArea" placeholder="Enter here..."></textarea>
                                </div>
                                <div class="form-group mt-2">
                                    <div class="row align-items-center">
                                        <div class="col-auto pe-0">
                                            <i class="ri-pencil-ruler-line fs-4"> </i>
                                        </div>
                                        <div class="col ps-2 fs-5">
                                            Lessons Learned ?
                                        </div>
                                    </div>
                                    <textarea class="form-control data" name="lesson"
                                              id="lessonArea" placeholder="Enter here..."></textarea>

                                </div>
                                <div class="form-group mt-2">
                                    <div class="row align-items-center">
                                        <div class="col-auto pe-0">
                                            <i class="ri-double-quotes-l fs-4"></i>
                                        </div>
                                        <div class="col ps-2 fs-5">
                                            Quotes?
                                        </div>
                                    </div>
                                    <textarea class="form-control data" name="quote" id="quoteArea"
                                              placeholder="Enter here..."></textarea>
                                </div>
                                <div class="form-group mt-2">
                                    <div class="row align-items-center">
                                        <div class="col-auto pe-0">
                                            <i class="ri-user-location-line fs-4"></i>
                                        </div>
                                        <div class="col ps-2 fs-5">
                                            Action?
                                        </div>
                                    </div>
                                    <textarea class="form-control data" name="action"
                                              id="actionArea" placeholder="Enter here..."></textarea>
                                </div>
                                <div class="form-group mb-2 mt-2">
                                    <button type="submit" class="btn btn-primary" id="submit" disabled>
                                        Submit
                                    </button>
                                    <button type="submit" class="btn btn-primary d-none"
                                            id="update">
                                        Update
                                    </button>
                                    <button type="button" class="btn btn-danger d-none" data-toggle="modal"
                                            data-target="#deleteFeelingModal" id="delete">Delete
                                    </button>
                                    <a href="/books">
                                        <button type="button" class="btn btn-secondary">Back
                                        </button>
                                    </a>
                                </div>
                            </form>
                        </div>
                        <h3 class="mt-2 font-weight-bold">Feelings Of Others</h3>
                        <div class="text-center loading-feeling">
                            <div class="spinner-border text-primary" role="status">
                                <span class="sr-only">Loading...</span>
                            </div>
                        </div>
                        <div class="col-md-12 d-none" id="othersSession">
                            <div data-simplebar style="max-height: 350px">
                                <c:forEach var="feeling" items="${bookDetail.feelingOfBooks}" varStatus="loopStatus">
                                    <div class="card mt-2 border">
                                        <div class="card-header align-items-center d-flex p-0">
                                            <div class="flex-grow-1 oveflow-hidden m-2">
                                                <div class="d-flex mb-2 align-items-center">
                                                    <div class="flex-shrink-0">
                                                        <img src="${feeling.avatarUser}" alt=""
                                                             class="avatar-sm rounded-circle"/>
                                                    </div>
                                                    <div class="flex-grow-1 ms-3">
                                                        <h5 class="list-title fs-15 mb-1">${feeling.fullnameUser}</h5>
                                                        <p class="list-text mb-0 fs-12">${feeling.createdDate}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <h5 >
                                                        - Feel about the book: ${feeling.feeling}
                                                    </h5>
                                                </div>
                                                <div class="col-md-6">
                                                    <h5>
                                                        - Lesson: ${feeling.lesson}
                                                    </h5>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <h5>
                                                        - Quotes: ${feeling.quote}
                                                    </h5>
                                                </div>
                                                <div class="col-md-6">
                                                    <h5>
                                                        - Action: ${feeling.action}
                                                    </h5>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
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

<!-- Sweet Alerts js -->
<script src="/assets/libs/sweetalert2/sweetalert2.min.js"></script>
<script>
    // Loading Primary
    function addLoadingPrimary(element) {
        element.classList.add("btn-load");
        var content = element.textContent;
        element.innerHTML = `
            <span class="d-flex align-items-center">
                <span class="spinner-border flex-shrink-0" role="status">
                    <span class="visually-hidden">Loading...</span>
                </span>
                <span class="flex-grow-1 ms-2 loading-primary">

                </span>
            </span>
        `;

        document.querySelector('.loading-primary').textContent = content;
    }

    $(document).ready(function () {
        var feeling = document.getElementById('feelingArea');
        var lesson = document.getElementById('lessonArea');
        var quote = document.getElementById('quoteArea');
        var action = document.getElementById('actionArea');
        callAjaxByJsonWithData('/api/v1/feeling-of-book/' + '${bookDetail.book.id}' + '/' + userCurrent.id, 'GET', null, function (rs) {
            feeling.value = rs.feeling;
            lesson.value = rs.lesson;
            quote.value = rs.quote;
            action.value = rs.action;

            $('#submit').addClass('d-none');
            $('#update').removeClass('d-none');
            $('#delete').removeClass('d-none');
            $('#othersSession').removeClass('d-none');
            $('.loading-feeling').remove();

            // Update Feeling
            Validator({
                form: '#feelingBook',
                errorSelector: '.form-message',
                rules: [],
                onSubmit: function (formData) {
                    addLoadingPrimary(document.getElementById('update'));
                    $('.btn').attr('disabled', true);

                    formData.append('id', rs.id);
                    callAjaxByJsonWithDataForm('/api/v1/feeling-of-book', 'PUT', formData, function (rs) {
                        sessionStorage.setItem('result', 'updateSuccess');
                        location.reload();
                    });
                }
            });

            // Delete Feeling
            $('#delete').click(function () {
                Swal.fire({
                    title: "Are you sure?",
                    text: "You won't be able to revert this!",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
                    cancelButtonClass: 'btn btn-danger w-xs mt-2',
                    confirmButtonText: "Yes, delete it!",
                    buttonsStyling: false,
                    showCloseButton: true
                }).then(function (result) {
                    if (result.value) {
                        showAlertLoading();
                        var bookId = '${bookDetail.book.id}';
                        var userId = userCurrent.id;
                        callAjaxByJsonWithData("/api/v1/feeling-of-book?userId=" + userId + "&bookId=" + bookId, "DELETE", null, function (rs) {
                            sessionStorage.setItem('result', 'delSuccess');
                            location.reload();
                        });
                    }
                });
            });
        }, function (rs) {
            $('#submit').removeClass('d-none');
            $('#update').addClass('d-none');
            $('#othersSession').removeClass('d-none');
            $('.loading-feeling').remove();

            var textarea = document.querySelectorAll('.data');
            textarea.forEach(function (input) {
                input.addEventListener('input', function () {
                    if (input.value.trim() !== '') {
                        document.getElementById('submit').removeAttribute('disabled');
                    } else document.getElementById('submit').setAttribute('disabled', 'disabled');
                })
            })

            Validator({
                form: '#feelingBook',
                errorSelector: '.form-message',
                rules: [],
                onSubmit: function (formData) {
                    addLoadingPrimary(document.getElementById('submit'));
                    $('.btn').attr('disabled', true);

                    formData.append('userId', userCurrent.id);
                    formData.append('bookId', '${bookDetail.book.id}');
                    callAjaxByJsonWithDataForm('/api/v1/feeling-of-book', 'POST', formData, function (rs) {
                        sessionStorage.setItem('result', 'addSuccess');
                        location.reload();
                    });
                }
            });
        });
    });
</script>

<%--Notification--%>
<script>
    $(document).ready(function () {
        var result = sessionStorage.getItem('result');
        var title;
        switch (result) {
            case 'addSuccess':
                title = 'Add Success!'
                break;
            case 'updateSuccess':
                title = 'Update Success!'
                break;
            case 'delSuccess':
                title = 'Delete Success!'
                break;
        }
        if (result) {
            Swal.fire(
                {
                    title: title,
                    icon: 'success',
                    confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
                    buttonsStyling: false,
                    showCloseButton: true
                }
            )
            sessionStorage.clear();
        }
    });
</script>
</body>
</html>