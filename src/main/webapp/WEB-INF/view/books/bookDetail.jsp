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
                </div>
            </div>
            <div class="col-md-8">
                <!-- Phần 2: Feeling Book -->
                <div class="row">
                    <h3 class="mt-2 font-weight-bold">Your Feelings</h3>
                    <div class="col-md-12">
                        <div class="p-3 border">
                            <form>
                                <div class="form-group">
                                    <label for="feel1">Feel 1</label>
                                    <input type="text" class="form-control" id="feel1" name="feel1">
                                </div>
                                <div class="form-group">
                                    <label for="feel2">Feel 2</label>
                                    <input type="text" class="form-control" id="feel2" name="feel2">
                                </div>
                                <div class="form-group">
                                    <label for="feel3">Feel 3</label>
                                    <input type="text" class="form-control" id="feel3" name="feel3">
                                </div>
                                <button type="submit" class="btn btn-primary">Submit</button>
                            </form>
                        </div>
                    </div>
                    <h3 class="mt-2 font-weight-bold">Feelings Of Others</h3>
                    <div class="col-md-12 mt-2">
                        <div class="p-3 border">
                            <c:forEach var="feeling" items="${bookDetail.feelingOfBooks}">
                            <div class="p-3 border">
                                        <img src="${feeling.avatarUser}" class="img-fluid rounded-circle"
                                             alt="User Avatar" width="50px">
                                        <p class="text-muted">${feeling.fullnameUser}</p>
                            </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<%-------------------------------------------- CODE JAVASCRIPT--------------------------------------------%>

</body>
</html>