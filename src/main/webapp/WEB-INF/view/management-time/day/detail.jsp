
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    session.setAttribute("pathMain", "/todo/");
%>
<c:set var="data" value="${dayResponse.data}" />
<c:set var="oneThingCalendar" value="${data.oneThingCalendar}" />
<c:set var="toDoList" value="${data.toDoList}" />
<c:set var="showButtonResult" value='${dayResponse!=null ? "" : "disabled"}'/>
<c:set var="infoButtonResult" value='${dayResponse!=null ? "Update" : "Create"}'/>

<html>
<head>
    <title>Detail of day</title>
</head>
<body>
<div class="container mt-4 calendar-container" data-date="${day}" data-id="${dayResponse.id}">
    <h1>Management Time Day</h1>
    <h5 class="font-italic font-bold text-center">${dayResponse != null ? dayResponse.day : day}</h5>
    <div class="row">
        <div class="col-md-6">
            <h3>One Thing Calendar</h3>
            <h5>Daily Important</h5>
            <table class="table table-bordered oneThingCalendar">
                <thead>
                <tr>
                    <th>Category</th>
                    <th>Target</th>
                    <th>Performance</th>
                </tr>
                </thead>
                <tbody>
                <c:set var="theSingleMostImportantThing" value="${oneThingCalendar.theSingleMostImportantThing}" />
                <tr name="theSingleMostImportantThing">
                    <td>Single Most Important Thing</td>
                    <td><input class="form-control" type="text" value="${theSingleMostImportantThing.target}"></td>
                    <td><input class="form-control small-checkbox" type="checkbox" ${theSingleMostImportantThing.performance ? 'checked' : ''}></td>
                </tr>
                <c:set var="lecture" value="${oneThingCalendar.lecture}" />
                <tr name="lecture">
                    <td>Lecture</td>
                    <td><input class="form-control" type="text" value="${lecture.target}"></td>
                    <td><input class="form-control small-checkbox" type="checkbox" ${lecture.performance ? 'checked' : ''}></td>
                </tr>
                <c:set var="dailyEvaluation" value="${oneThingCalendar.dailyEvaluation}" />
                <tr name="dailyEvaluation">
                    <td>Daily Evaluation</td>
                    <td><input class="form-control" type="text" value="${dailyEvaluation.target}"></td>
                    <td><input class="form-control small-checkbox" type="checkbox" ${dailyEvaluation.performance ? 'checked' : ''}></td>
                </tr>
                <c:set var="work" value="${oneThingCalendar.work}" />
                <tr name="work">
                    <td>Work</td>
                    <td><input class="form-control" type="text" value="${work.target}"></td>
                    <td><input class="form-control small-checkbox" type="checkbox" ${work.performance ? 'checked' : ''}></td>
                </tr>
                <c:set var="reading" value="${oneThingCalendar.reading}" />
                <tr name="reading">
                    <td>Reading</td>
                    <td><input class="form-control" type="text" value="${reading.target}"></td>
                    <td><input class="form-control small-checkbox" type="checkbox" ${reading.performance ? 'checked' : ''}></td>
                </tr>
                </tbody>
            </table>
            <h3>Gratitude Diary</h3>
            <ul class="list-group mb-2" name="gratitudeDiary">
                <c:forEach items="${data.gratitudeDiary}" var="entry" varStatus="loop">
                    <li class="list-group-item"><textarea class="form-control">${entry}</textarea></li>
                </c:forEach>
                <c:if test="${3-data.gratitudeDiary.size()>0}">
                    <c:forEach begin="1" end="${3-data.gratitudeDiary.size()}" varStatus="loop">
                        <li class="list-group-item"><textarea class="form-control"></textarea></li>
                    </c:forEach>
                </c:if>
            </ul>
            <h3>Affirmation:</h3>
            <textarea class="form-control affirmation">${data.affirmation}</textarea>
        </div>
        <div class="col-md-6">
            <h3>To-Do List</h3>
            <h5>Six to Twelve PM
                <button class="btn btn-sm btn-primary showDetail" data-name="sixToTwelvePm" ${showButtonResult}>Show Detail</button>
            </h5>
            <table class="table table-bordered sixToTwelvePm">
                <thead>
                <tr>
                    <th>Target</th>
                    <th>Performance</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${toDoList.sixToTwelvePm}" var="entry" varStatus="loop">
                    <tr>
                        <td><input class="form-control" type="text" value="${entry.target}"></td>
                        <td><input class="form-control small-checkbox" type="checkbox" ${entry.performance ? 'checked' : ''}></td>
                    </tr>
                </c:forEach>
                <c:if test="${4-toDoList.sixToTwelvePm.size()>0}">
                    <c:forEach begin="1" end="${4-toDoList.sixToTwelvePm.size()}" varStatus="loop">
                        <tr>
                            <td><input class="form-control" type="text" value=""></td>
                            <td><input class="form-control small-checkbox" type="checkbox"></td>
                        </tr>
                    </c:forEach>
                </c:if>
                </tbody>
            </table>
            <h5>Twelve to Six PM
                <button class="btn btn-sm btn-primary showDetail" data-name="twelveToSixPm" ${showButtonResult}>Show Detail</button>
            </h5>
            <table class="table table-bordered twelveToSixPm">
                <thead>
                <tr>
                    <th>Target</th>
                    <th>Performance</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${toDoList.twelveToSixPm}" var="entry" varStatus="loop">
                    <tr>
                        <td><input class="form-control" type="text" value="${entry.target}"></td>
                        <td><input class="form-control small-checkbox" type="checkbox" ${entry.performance ? 'checked' : ''}></td>
                    </tr>
                </c:forEach>
                <c:if test="${4-toDoList.twelveToSixPm.size()>0}">
                    <c:forEach begin="1" end="${4-toDoList.twelveToSixPm.size()}" varStatus="loop">
                        <tr>
                            <td><input class="form-control" type="text" value=""></td>
                            <td><input class="form-control small-checkbox" type="checkbox"></td>
                        </tr>
                    </c:forEach>
                </c:if>
                </tbody>
            </table>
            <h5>Six to Twelve AM
                <button class="btn btn-sm btn-primary showDetail" data-name="sixToTwelveAm" ${showButtonResult}>Show Detail</button>
            </h5>
            <table class="table table-bordered sixToTwelveAm">
                <thead>
                <tr>
                    <th>Target</th>
                    <th>Performance</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${toDoList.sixToTwelveAm}" var="entry" varStatus="loop">
                    <tr>
                        <td><input class="form-control" type="text" value="${entry.target}"></td>
                        <td><input class="form-control small-checkbox" type="checkbox" ${entry.performance ? 'checked' : ''}></td>
                    </tr>
                </c:forEach>
                <c:if test="${4-toDoList.sixToTwelveAm.size()>0}">
                    <c:forEach begin="1" end="${4-toDoList.sixToTwelveAm.size()}" varStatus="loop">
                        <tr>
                            <td><input class="form-control" type="text" value=""></td>
                            <td><input class="form-control small-checkbox" type="checkbox"></td>
                        </tr>
                    </c:forEach>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 mt-4 text-center">
            <button class="btn btn-primary mr-2" id="backButton" onclick="window.history.back();">Back</button>
            <button class="btn btn-success ml-2" id="updateButton">${infoButtonResult}</button>
        </div>
    </div>
</div>
<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="margin-top: 50%;">
            <div class="modal-header">
                <h5 class="modal-title" id="successModalLabel">Message</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="detailModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="margin-top: 30%;">
            <div class="modal-header">
                <h5 class="modal-title" id="detailModalLabel"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th class="align-middle">Q</th>
                        <th class="align-middle">Time Slot</th>
                        <th class="align-middle">Target</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="showDetailSubmit">Save changes</button>
            </div>
        </div>
    </div>
</div>
<style>
    .small-checkbox {
        font-size: 0.4rem
    }
    textarea.form-control{
        min-height: 95px
    }
    textarea.affirmation{
        min-height: 155px
    }
</style>
<script>
        let qresult = (name)=>{
            let array = {
                sixToTwelvePm: "6~12pm",
                twelveToSixPm: "12~6pm",
                sixToTwelveAm: "6pm~12am",
            }
            return array[name]
        }
        let interval = (name) =>{
            let intervalResult = []
            if(name == "sixToTwelvePm"){
                for (var i = 6; i < 12; i++) {
                    if (i === 11) {
                        intervalResult.push(i + "~" + (i + 1) + "pm");
                    } else {
                        intervalResult.push(i + "~" + (i + 1) + "am");
                    }
                }
            }else if(name == "twelveToSixPm"){
                for (var i = 0; i <= 5; i++) {
                    if (i === 0) {
                        intervalResult.push(12 + "~" + (i+1) + "pm");
                    } else {
                        intervalResult.push(i + "~" + (i + 1) + "pm");
                    }
                }
            }else{
                for (var i = 6; i < 12; i++) {
                    if (i == 11) {
                        intervalResult.push(i + "~" + (i + 1) + "am");
                    } else {
                        intervalResult.push(i + "~" + (i + 1) + "pm");
                    }
                }
            }
            return intervalResult
        }
        let getCodeTime = (code)=>{
            let arr = {
                sixToTwelvePm: M_SIX_TO_TWELVE_PM,
                twelveToSixPm: M_TWELVE_TO_SIX_PM,
                sixToTwelveAm: M_SIX_TO_TWELVE_AM,
            }
            return arr[code]
        }
    var dot = createLoadingHtml();
        $("#showDetailSubmit").click(function (){
            var dayId = $("div.calendar-container").attr("data-id")
            var codeData = $("#detailModal").attr("data-code")
            var code = getCodeTime(codeData)
            var targetArr = []
            $("#detailModal tr input.inputTarget").each(function() {
                let target = $(this).val()
                targetArr.push(target)
            })
            var data = {
                dayId: dayId,
                code: code,
                data:targetArr
            }
            callAjaxByJsonWithData('/')
        })
    $("button.showDetail").click(function (){
        var modal = $("#detailModal")
        var name = $(this).attr("data-name")
        var nameDisplay = $(this).parent().text()
        $("button").each(function (){
            $(this).prop("disabled",true)
        })
        $(this).after(dot)
        modal.attr("data-code",name )
        $("#detailModalLabel").text(nameDisplay)
        let arrayTime = interval(name)
        let html = ""
        if(arrayTime){
            arrayTime.forEach((e, index)=>{
                let xhtml = (index==0) ? '<td rowspan="6" class="align-middle text-center">'+ qresult(name) +'</td>' : ""
                html+=
                    '<tr>'+
                         xhtml+
                        '<td class="align-middle">'+ e +'</td>'+
                        '<td><input type="text" class="form-control inputTarget" placeholder="Input target..."></td>'+
                    '</tr>'
            })
        }
        $("#detailModal tbody").html(html)
        modal.modal("show")
        $("button").each(function (){
            $(this).prop("disabled",false)
        })
        $('div.custom-spinner').parent().remove();
    })

    $("#updateButton").click(function() {
        $("button").each(function (){
            $(this).prop("disabled",true)
        })
        $("#updateButton").after(dot)
        var id = "${dayResponse.id}"
        var oneThingCalendar = {};
        $(".oneThingCalendar tr").each(function() {
            let name = $(this).attr("name")
            let target = $(this).find('input[type="text"]').val()
            let performance = $(this).find('input[type="checkbox"]').prop('checked')
            if(name && target != ""){
                oneThingCalendar[name] = {
                    target: target,
                    performance: performance
                }
            }
        })
        var sixToTwelvePm = []
        var twelveToSixPm = []
        var sixToTwelveAm = []

        $("table.sixToTwelvePm tr").each(function() {
            let target = $(this).find('input[type="text"]').val()
            let performance = $(this).find('input[type="checkbox"]').prop('checked')
            if(target && target != ""){
                  let newObject = {
                        target: target,
                      performance: performance
                    }
                sixToTwelvePm.push(newObject)
            }
        })

        $("table.twelveToSixPm tr").each(function() {
            let target = $(this).find('input[type="text"]').val()
            let performance = $(this).find('input[type="checkbox"]').prop('checked')
            if(target && target != ""){
                let newObject = {
                    target: target,
                    performance: performance
                }
                twelveToSixPm.push(newObject)
            }
        })

        $("table.sixToTwelveAm tr").each(function() {
            let target = $(this).find('input[type="text"]').val()
            let performance = $(this).find('input[type="checkbox"]').prop('checked')
            if(target && target != ""){
                let newObject = {
                    target: target,
                    performance: performance
                }
                sixToTwelveAm.push(newObject)
            }
        })

        var toDoList = {
            sixToTwelvePm: sixToTwelvePm,
            twelveToSixPm: twelveToSixPm,
            sixToTwelveAm: sixToTwelveAm,
        }

        var gratitudeDiary = []
        $('ul[name="gratitudeDiary"] textarea').each(function (){
            let text = $(this).val()
            if(text && text!=""){
                gratitudeDiary.push(text)
            }
        })
        var affirmation = $("textarea.affirmation").val()
        var dataInfor = {
            oneThingCalendar: oneThingCalendar,
            toDoList: toDoList,
            gratitudeDiary: gratitudeDiary,
            affirmation: affirmation
        }
        let rsSuccess = (text) =>{
            $("button").each(function () {
                $(this).prop("disabled", false)
            })
            $('div.custom-spinner').parent().remove();
            var modal = '<strong class="btn-success rounded-circle p-2">Success!</strong>  '+text+' successfully.'
            $("#successModal div.modal-body").html(modal)
            $("#successModal").modal("show");
        }

        let rsUnSuccess = () =>{
            $("button").each(function () {
                $(this).prop("disabled", false)
            })
            $('div.custom-spinner').parent().remove();
            var modal = `<strong class="btn-danger rounded-circle p-2">Unsuccessful!</strong>  Updated unsuccessfully.
                            `
            $("#successModal div.modal-body").html(modal)
            $("#successModal").modal("show");
        }
        var apiUrlManagementTimeDayApi = "/api/v1/management-time/day"
        if("${day}" != ""){
            dataCreate = {
                day: "${day}",
                userId: userCurrent.id,
                data: dataInfor
            }
            console.log(dataCreate)
            callAjaxByJsonWithData(apiUrlManagementTimeDayApi, 'POST', dataCreate, function (rs) {
                if(rs!=null){
                    rsSuccess("Create")
                    $("#updateButton").text("Update")
                    $("button.showDetail").prop("disabled",false)
                    $("div.calendar-container").attr("data-id", rs.id)
                    return
                }
                rsUnSuccess()
            })
        }else if(id != "") {
            var dataUpdate = {
                id: id,
                userId: userCurrent.id,
                data: dataInfor
            };
            callAjaxByJsonWithData(apiUrlManagementTimeDayApi, 'PUT', dataUpdate, function (rs) {
                if (rs != null) {
                    rsSuccess("Update")
                    return
                }
                rsUnSuccess()
            })
        }
    })
</script>
</body>
</html>
