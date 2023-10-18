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
    <table class="table table-bordered" id="managementTimeTable">

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
    let monthNow = "09"
    let dayOfWeek = [
        "Sun",
        "Mon",
        "Tue",
        "Wed",
        "Thu",
        "Fri",
        "Sat"
    ]
    let dayOfMonth = []
    for (let i = 1; i <= 30; i++) {
            dayOfMonth.push(i);
        }
        let jsonData = [
            {
                "id": "582e1379-0f25-472f-bbb7-39977a32c732",
                "day": "2022-11-20",
                "data": {
                    "oneThingCalendar": {
                        "theSingleMostImportantThing": {
                            "target": "11",
                            "performance": false
                        },
                        "lecture": {
                            "target": "22",
                            "performance": false
                        },
                        "dailyEvaluation": {
                            "target": "33",
                            "performance": false
                        },
                        "work": {
                            "target": "44",
                            "performance": false
                        },
                        "reading": {
                            "target": "55",
                            "performance": false
                        }
                    },
                    "toDoList": {
                        "sixToTwelvePm": [
                            {
                                "target": "21",
                                "performance": false
                            },
                            {
                                "target": "22",
                                "performance": false
                            },
                            {
                                "target": "323",
                                "performance": false
                            },
                            {
                                "target": "12313",
                                "performance": false
                            }
                        ],
                        "twelveToSixPm": [
                            {
                                "target": "34534",
                                "performance": false
                            },
                            {
                                "target": "3453",
                                "performance": false
                            },
                            {
                                "target": "34534",
                                "performance": false
                            },
                            {
                                "target": "34534",
                                "performance": false
                            }
                        ],
                        "sixToTwelveAm": [
                            {
                                "target": "12q",
                                "performance": false
                            },
                            {
                                "target": "q2",
                                "performance": false
                            },
                            {
                                "target": "2e",
                                "performance": false
                            },
                            {
                                "target": "ft6",
                                "performance": false
                            }
                        ]
                    },
                    "gratitudeDiary": [
                        "1",
                        "2",
                        "3"
                    ],
                    "affirmation": "1212221213"
                }
            },
            {
                "id": "d61ef8fa-65ad-4ef1-897f-8292f05b894a",
                "day": "2022-11-15",
                "data": {
                    "oneThingCalendar": {
                        "theSingleMostImportantThing": {
                            "target": "1hello canh",
                            "performance": false
                        },
                        "lecture": {
                            "target": "2",
                            "performance": false
                        },
                        "dailyEvaluation": {
                            "target": "3",
                            "performance": false
                        },
                        "work": {
                            "target": "4",
                            "performance": false
                        },
                        "reading": {
                            "target": "5",
                            "performance": true
                        }
                    },
                    "toDoList": {
                        "sixToTwelvePm": [
                            {
                                "target": "6",
                                "performance": false
                            },
                            {
                                "target": "7",
                                "performance": false
                            },
                            {
                                "target": "8",
                                "performance": false
                            }
                        ],
                        "twelveToSixPm": [
                            {
                                "target": "xin chao canh",
                                "performance": true
                            },
                            {
                                "target": "10",
                                "performance": false
                            }
                        ],
                        "sixToTwelveAm": [
                            {
                                "target": "11",
                                "performance": false
                            },
                            {
                                "target": "23",
                                "performance": false
                            },
                            {
                                "target": "14",
                                "performance": false
                            }
                        ]
                    },
                    "gratitudeDiary": [
                        "111111111111111111ugh today’s work",
                        "111111111111111l for the birdsong I heard on my way to work today.",
                        "1111111111111"
                    ],
                    "affirmation": "11111"
                }
            }
        ]
    let generate = (start, end) =>{
        let html =""
        for(let i=0; i<4;i++){
            let xhtml = '</th>'
                +' <th scope="col">'
                +' <div class="text-center">1</div>'
                +' </th>'
                +'  <th scope="col">'
                +' <div class="text-center">1</div>'
                +' </th>'
                +' <th scope="col">'
                +'<div class="text-center">1</div>'
                +'</th>'
                +'<th scope="col">'
                +'<div class="text-center">1</div>'
                +' </th>'
                +'<th scope="col">'
                +'<div class="text-center">1</div>'
                +'</th>'
                +'<th scope="col">'
                +'<div class="text-center">1</div>'
                +'</th>'
                +'<th scope="col">'
                +'<div class="text-center">1</div>'
                +'</th>'
                +'<th scope="col">Weekly</th>'
                +'</tr>'

            if(i==0){
                xhtml= '</th>'
                for(let i = 0; i< dayOfWeek.length; i++){
                    xhtml+= ' <th scope="col">'
                            +' <div class="text-center" style="border-bottom: #cccccc 1px solid">'+ dayOfWeek[i] +'</div>'
                            +' <div class="text-center"></div>'
                            +' </th>'
                }

                xhtml+= '<th scope="col">Weekly</th>'+'</tr>'
            }
            html+= '<table>'
                        +'<thead>'
                        +'<tr>'
                        +' <th scope="col" ></th>'
                                + xhtml
                        +'</thead>'
                        +'<tbody>'
                        +'<tr>'
                        +'<td class="day">Onething of the day</td>'
                            +'<td class="day">29</td>'
                            +'<td class="day">30</td>'
                            +'<td class="day">31</td>'
                            +'<td class="day">1</td>'
                            +'<td class="day">2</td>'
                            +'<td class="day">3</td>'
                            +'<td class="day">4</td>'
                            +'<td class="day" rowspan="6">4</td>'
                            +'</tr>'
                        +'<tr>'
                        +'<td class="day">Self-development lecture</td>'
                            +'<td class="day">5</td>'
                            +'<td class="day">6</td>'
                            +'<td class="day">7</td>'
                            +'<td class="day">8</td>'
                            +'<td class="day">9</td>'
                            +'<td class="day">10</td>'
                            +' <td class="day">11</td>'
                           +'</tr>'
                        +'<tr>'
                        +' <td class="day">Daily evaluation</td>'
                           +'<td class="day">12</td>'
                            +'<td class="day">13</td>'
                            +'<td class="day">14</td>'
                            +'<td class="day">15</td>'
                            +'<td class="day">16</td>'
                            +'<td class="day">17</td>'
                            +'<td class="day">18</td>'
                            +' </tr>'
                       +'<tr>'
                        +'<td class="day">Work</td>'
                            +'<td class="day">19</td>'
                            +'<td class="day">20</td>'
                            +'<td class="day">21</td>'
                            +'<td class="day">22</td>'
                            +'<td class="day">23</td>'
                            +'<td class="day">24</td>'
                            +'<td class="day">25</td>'
                            +'</tr>'
                        +'<tr>'
                        +'<td class="day">Reading</td>'
                            +'<td class="day">26</td>'
                            +'<td class="day">27</td>'
                            +'<td class="day">28</td>'
                            +'<td class="day">29</td>'
                            +'<td class="day">30</td>'
                            +'<td class="day">1</td>'
                            +'<td class="day">2</td>'
                            +' </tr>'
                       +'</tbody>'
                +'</table>'
        }
        $("#managementTimeTable").html(html)
    }
</script>
</body>
</html>
