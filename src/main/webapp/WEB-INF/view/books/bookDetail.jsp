<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="container">
    <form id="formBookDetail">
        <div class="row">
            <!-- Phần 1: Hình ảnh avatar và tên người dùng -->
            <div class="col-md-4">
                <div class="text-center">
                    <img src="${bookDetail.book.image}" class="img-fluid" alt="User Avatar" width="200">
                    <h4 class="mt-2 font-weight-bold">${bookDetail.book.title}</h4>
                    <p class="text-muted">Author: ${bookDetail.book.author}</p>
                    <a href="${bookDetail.book.link}" class="text-decoration-none">Link To Book</a>
                </div>
            </div>
            <div class="col-md-8">
                <!-- Phần 2: Feeling Book -->
                <div class="row">
                    <h3 class="mt-2 font-weight-bold">Your Feelings</h3>
                    <div class="col-md-12">
                        <div class="p-3 border">
                            <form id="addFeelingBook">
                                <div class="form-group">
                                    <label for="quotes1">Feel 1:</label>
                                    <input type="text" class="form-control" id="quotes1" name="quotes1">
                                </div>
                                <div class="form-group">
                                    <label for="quotes2">Feel 2:</label>
                                    <input type="text" class="form-control" id="quotes2" name="quotes2">
                                </div>
                                <div class="form-group">
                                    <label for="quotes3">Feel 3:</label>
                                    <input type="text" class="form-control" id="quotes3" name="quotes3">
                                </div>
                                <button value="${bookDetail.book.id}" type="submit" class="btn btn-primary" id="submit">Submit</button>
                            </form>
                        </div>
                    </div>
                    <h3 class="mt-2 font-weight-bold">Feelings Of Others</h3>
                    <div class="col-md-12 mt-2">
                        <div class="p-3 border">
                            <c:forEach var="feeling" items="${bookDetail.feelingOfBooks}">
                                <div class="p-3 ">
                                    <div class="row border">
                                        <div class="col-md-2 border-right text-center justify-content-center">
                                            <img src="${feeling.avatarUser}" class="img-fluid rounded-circle"
                                                 alt="User Avatar" width="50px"> <br>
                                            <p class="text-muted">${feeling.fullnameUser}</p>
                                        </div>
                                        <div class="col-md-10">
                                            <p>- ${feeling}</p>
                                            <p>Phần 2 - Thẻ p 2</p>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<!-- Modal Notification  -->
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

<%--Handle when user click button submit--%>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        document.getElementById('submit').addEventListener('click', function (e) {
            var quotes1 = document.getElementById('quotes1').value;
            var quotes2 = document.getElementById('quotes2').value;
            var quotes3 = document.getElementById('quotes3').value;

            var data = {
                userId: userCurrent.id,
                quote: quotes1 + '---' + quotes2 + '---' + quotes3,
                bookId: this.value
            };
            $('#submit').after(createLoadingHtml());
            callAjaxByJsonWithData('/api/v1/feeling-of-book', 'POST', data, function () {
                sessionStorage.setItem('result', 'addFeelSuccess');
                location.reload();
            }, 'addFeelingBook')
        });
    });

    // Notification
    document.addEventListener('DOMContentLoaded', function () {
        const result = sessionStorage.getItem('result');
        if (result) {
            let message;
            switch (result) {
                case 'addFeelSuccess':
                    message = 'Add Feel Success';
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
</body>
</html>