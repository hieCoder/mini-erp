<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 9/25/2023
  Time: 11:46 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    session.setAttribute("pathMain", "/todo/");
%>
<html>
<head>
    <title>To Do Detail</title>
</head>
<body>
<div class="container mt-4 calendar-container">
    <h1>Management Time Day</h1>
    <div class="row">
        <div class="col-md-6">
            <h3>One Thing Calendar</h3>
            <h5>Daily Important</h5>
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Category</th>
                    <th>Target</th>
                    <th>Performance</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Single Most Important Thing</td>
                    <td><input class="form-control" type="text" value="My target"></td>
                    <td><input class="form-control" type="checkbox" checked></td>
                </tr>
                <tr>
                    <td>Lecture</td>
                    <td><input class="form-control" type="text" value="My target"></td>
                    <td><input class="form-control" type="checkbox" checked></td>
                </tr>
                <tr>
                    <td>Daily Evaluation</td>
                    <td><input class="form-control" type="text" value="My target"></td>
                    <td><input class="form-control" type="checkbox" checked></td>
                </tr>
                <tr>
                    <td>Work</td>
                    <td><input class="form-control" type="text" value="My target"></td>
                    <td><input class="form-control" type="checkbox" checked></td>
                </tr>
                <tr>
                    <td>Reading</td>
                    <td><input class="form-control" type="text" value="My target"></td>
                    <td><input class="form-control" type="checkbox" checked></td>
                </tr>
                </tbody>
            </table>
            <h3>Gratitude Diary</h3>
            <ul class="list-group mb-2">
                <li class="list-group-item"><textarea class="form-control">1. I am so happy and grateful that I was able to solve a new problem through today’s work</textarea></li>
                <li class="list-group-item"><textarea class="form-control">2. I am grateful for the birdsong I heard on my way to work today.</textarea></li>
                <li class="list-group-item"><textarea class="form-control">3. I am grateful that I was able to talk and eat a delicious dinner with my friends today</textarea></li>
                <!-- Lặp lại cho các mục khác trong Gratitude Diary -->
            </ul>
            <h3>Affirmation:</h3>
            <textarea class="form-control">I will become a Java master. I will always be happy and live as the way I want.</textarea>
        </div>
        <div class="col-md-6">
            <h3>To-Do List</h3>
            <h5>Six to Twelve PM</h5>
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Target</th>
                    <th>Performance</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><input class="form-control" type="text" value="My target1"></td>
                    <td><input class="form-control" type="checkbox"></td>
                </tr>
                <tr>
                    <td><input class="form-control" type="text" value="My target2"></td>
                    <td><input class="form-control" type="checkbox" checked></td>
                </tr>
                <!-- Lặp lại cho các mục khác trong Six to Twelve PM -->
                </tbody>
            </table>
            <h5>Twelve to Six PM</h5>
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Target</th>
                    <th>Performance</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><input class="form-control" type="text" value="My target1"></td>
                    <td><input class="form-control" type="checkbox"></td>
                </tr>
                <tr>
                    <td><input class="form-control" type="text" value="My target2"></td>
                    <td><input class="form-control" type="checkbox" checked></td>
                </tr>
                <!-- Lặp lại cho các mục khác trong Twelve to Six PM -->
                </tbody>
            </table>
            <h5>Six to Twelve AM</h5>
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Target</th>
                    <th>Performance</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><input class="form-control" type="text" value="My target1"></td>
                    <td><input class="form-control" type="checkbox"></td>
                </tr>
                <tr>
                    <td><input class="form-control" type="text" value="My target2"></td>
                    <td><input class="form-control" type="checkbox" checked></td>
                </tr>
                <!-- Lặp lại cho các mục khác trong Six to Twelve AM -->
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 mt-4 text-center">
            <button class="btn btn-primary mr-2" id="backButton" onclick="window.history.back();">Back</button>
            <button class="btn btn-success ml-2" id="updateButton">Update</button>
        </div>
    </div>
</div>
<script>

</script>
</body>
</html>
