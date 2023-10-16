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
    <title>To Do</title>
</head>

<body>

<div class="container mt-4 calendar-container">
    <h2 class="text-center">Calendar of September, 2023</h2>

    <table class="table table-bordered">
        <thead>
        <tr>
            <th scope="col" rowspan="2"></th>
            <th scope="col">Sun</th>
            <th scope="col">Mon</th>
            <th scope="col">Tue</th>
            <th scope="col">Wed</th>
            <th scope="col">Thu</th>
            <th scope="col">Fri</th>
            <th scope="col">Sat</th>
            <th scope="col" rowspan="2">Weekly To-do list</th>
        </tr>
        <tr>
            <th scope="col">1</th>
            <th scope="col">2</th>
            <th scope="col">3</th>
            <th scope="col">3</th>
            <th scope="col">4</th>
            <th scope="col">5</th>
            <th scope="col">6</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td class="day">Onething of the day</td>
            <td class="day">29</td>
            <td class="day">30</td>
            <td class="day">31</td>
            <td class="day">1</td>
            <td class="day">2</td>
            <td class="day">3</td>
            <td class="day">4</td>
            <td class="week" >Content</td>

        </tr>
        <tr>
            <td class="day">Self-development lecture</td>
            <td class="day">5</td>
            <td class="day">6</td>
            <td class="day">7</td>
            <td class="day">8</td>
            <td class="day">9</td>
            <td class="day">10</td>
            <td class="day">11</td>
            <td class="week" >Content</td>

        </tr>
        <tr>
            <td class="day">Daily evaluation</td>
            <td class="day">12</td>
            <td class="day">13</td>
            <td class="day">14</td>
            <td class="day">15</td>
            <td class="day">16</td>
            <td class="day">17</td>
            <td class="day">18</td>
            <td class="week" >Content</td>
        </tr>
        <tr>
            <td class="day">Work</td>
            <td class="day">19</td>
            <td class="day">20</td>
            <td class="day">21</td>
            <td class="day">22</td>
            <td class="day">23</td>
            <td class="day">24</td>
            <td class="day">25</td>
            <td class="week" >Content</td>
        </tr>
        <tr>
            <td class="day">Reading</td>
            <td class="day">26</td>
            <td class="day">27</td>
            <td class="day">28</td>
            <td class="day">29</td>
            <td class="day">30</td>
            <td class="day">1</td>
            <td class="day">2</td>
            <td class="week" >Content</td>
        </tr>
        </tbody>
    </table>


</div>
<style>
    td:nth-child(3) {
        width:  auto
    }


    tr td.day{
        width:120px
    }

    tr > td:first-child{
        width:150px
    }

    tr td.week{
        width:150px
    }
</style>
<script>

</script>
</body>
</html>
