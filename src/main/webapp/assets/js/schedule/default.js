/* eslint-disable */
const CODE_TASK = ["REGISTERED","OPENED", "POSTPONED", "REOPENED", "CLOSED"]
function formatDate(date) {
  const year = date.getFullYear();
  const month = (date.getMonth() + 1).toString().padStart(2, '0');
  const day = date.getDate().toString().padStart(2, '0');
  return year + '-' + month + '-' + day;
}
function init() {
  cal.setCalendars(CalendarList);
  setRenderRangeText();
  setEventListener();

}

function getDataAction(target) {
  return target.dataset ? target.dataset.action : target.getAttribute('data-action');
}

function setDropdownCalendarType() {
  var calendarTypeName = document.getElementById('calendarTypeName');
  var calendarTypeIcon = document.getElementById('calendarTypeIcon');
  var options = cal.getOptions();
  var type = cal.getViewName();
  var iconClassName;

  if (type === 'day') {
    type = 'Daily';
    iconClassName = 'calendar-icon ic_view_day';
  } else if (type === 'week') {
    type = 'Weekly';
    iconClassName = 'calendar-icon ic_view_week';
  } else if (options.month.visibleWeeksCount === 2) {
    type = '2 weeks';
    iconClassName = 'calendar-icon ic_view_week';
  } else if (options.month.visibleWeeksCount === 3) {
    type = '3 weeks';
    iconClassName = 'calendar-icon ic_view_week';
  } else {
    type = 'Monthly';
    iconClassName = 'calendar-icon ic_view_month';
  }

  calendarTypeName.innerHTML = type;
  calendarTypeIcon.className = iconClassName;
}

function onClickMenu(e) {
  console.log(e)
  var target = $(e.target).closest('a[role="menuitem"]')[0];
  var action = getDataAction(target);
  var options = cal.getOptions();
  var viewName = '';

  switch (action) {
    case 'toggle-daily':
      viewName = 'day';
      break;
    case 'toggle-weekly':
      viewName = 'week';
      break;
    case 'toggle-monthly':
      options.month.visibleWeeksCount = 0;
      viewName = 'month';
      break;
    case 'toggle-weeks2':
      options.month.visibleWeeksCount = 2;
      viewName = 'month';
      break;
    case 'toggle-weeks3':
      options.month.visibleWeeksCount = 3;
      viewName = 'month';
      break;
    case 'toggle-narrow-weekend':
      options.month.narrowWeekend = !options.month.narrowWeekend;
      options.week.narrowWeekend = !options.week.narrowWeekend;
      viewName = cal.getViewName();

      target.querySelector('input').checked = options.month.narrowWeekend;
      break;
    case 'toggle-start-day-1':
      options.month.startDayOfWeek = options.month.startDayOfWeek ? 0 : 1;
      options.week.startDayOfWeek = options.week.startDayOfWeek ? 0 : 1;
      viewName = cal.getViewName();

      target.querySelector('input').checked = options.month.startDayOfWeek;
      break;
    case 'toggle-workweek':
      options.month.workweek = !options.month.workweek;
      options.week.workweek = !options.week.workweek;
      viewName = cal.getViewName();

      target.querySelector('input').checked = !options.month.workweek;
      break;
    default:
      break;
  }

  cal.setOptions(options, true);
  cal.changeView(viewName, true);

  setDropdownCalendarType();
  setRenderRangeText();
  setSchedules();
}

function onClickNavi(e) {
  var action = getDataAction(e.target);
  switch (action) {
    case 'move-prev':
      cal.prev();
      break;
    case 'move-next':
      cal.next();
      break;
    case 'move-today':
      cal.today();
      break;
    default:
      return;
  }
  setRenderRangeText();
}

function setRenderRangeText() {
  var renderRange = document.getElementById('renderRange');
  var options = cal.getOptions();
  var viewName = cal.getViewName();
  var html = [];
  if (viewName === 'day') {
    html.push(moment(cal.getDate().getTime()).format('YYYY.MM.DD'));
  } else if (viewName === 'month' &&
    (!options.month.visibleWeeksCount || options.month.visibleWeeksCount > 4)) {
    html.push(moment(cal.getDate().getTime()).format('YYYY.MM'));
  } else {
    html.push(moment(cal.getDateRangeStart().getTime()).format('YYYY.MM.DD'));
    html.push(' ~ ');
    html.push(moment(cal.getDateRangeEnd().getTime()).format(' MM.DD'));
  }
  renderRange.innerHTML = html.join('');
  setSchedules(renderRange.textContent);
}

function setSchedules(currentTime) {
  $("#menu-navi button").prop("disabled",true)
  let ScheduleListNew = []
  let apiData = currentTime.replaceAll(".","-")
  let idArr = window.location.href.split("/")
  let id = idArr[idArr.length-1]
  cal.clear();
  callAjaxByJsonWithData("/api/v1/schedules/" + id +"?monthly="+apiData,"GET",null,function (rs){
    if(rs){
      rs.list.forEach((item,index)=>{
        var schedule = new ScheduleInfo();
        schedule.id = item.id
        schedule.title = item.title
        schedule.start = new Date(item.startDate)
        schedule.end  = new Date(item.dueOrCloseDate.replace(/~/g, "").replace(/\s/g, ""))
        schedule.calendarId = item.statusTask.code
        schedule.category = "time"
        ScheduleListNew.push(schedule)
      })
      cal.createSchedules(ScheduleListNew)
      $("#menu-navi button").prop("disabled",false)
      refreshScheduleVisibility();
    }
  })
}


function refreshScheduleVisibility() {
  var calendarElements = Array.prototype.slice.call(document.querySelectorAll('#calendarList input'));

  CalendarList.forEach(function(calendar) {
    cal.toggleSchedules(calendar.id, !calendar.checked, false);
  });

  cal.render(true);

  calendarElements.forEach(function(input) {
    var span = input.nextElementSibling;
    span.style.backgroundColor = input.checked ? span.style.borderColor : 'transparent';
  });
}

resizeThrottled = tui.util.throttle(function() {
  cal.render();
}, 50);

function setEventListener() {
  $('.dropdown-menu a[role="menuitem"]').on('click', onClickMenu);
  $('#menu-navi').on('click', onClickNavi);
  window.addEventListener('resize', resizeThrottled);
}

cal.on({
  'beforeCreateSchedule': function(e) {
    e.guide.clearGuideElement();
  },
  'clickTimezonesCollapseBtn': function(timezonesCollapsed) {
    if (timezonesCollapsed) {
      cal.setTheme({
        'week.daygridLeft.width': '77px',
        'week.timegridLeft.width': '77px'
      });
    } else {
      cal.setTheme({
        'week.daygridLeft.width': '60px',
        'week.timegridLeft.width': '60px'
      });
    }

    return true;
  }
});

init();
$(function() {

  $(document).on("click", "span.tui-full-calendar-weekday-schedule-title", function (e) {
    let id = $(this).parent().attr("data-schedule-id")
    let code = $(this).parent().attr("data-calendar-id")
    if (CODE_TASK.includes(code)) {
      let html = '<button class="btn btn-sm btn-info mt-2 font-weight-bold linkToTask" data-id="' + id + '">Link to Task</button>'
      $("div.tui-full-calendar-section-detail > div.tui-full-calendar-popup-detail-item").after(html)
    }
  })

  $(document).on("click", "div.tui-full-calendar-month-more-list > div", function (e) {
    let id = $(this).attr("data-schedule-id")
    let code = $(this).attr("data-calendar-id")
    if (CODE_TASK.includes(code)) {
      let html = '<button class="btn btn-sm btn-info mt-2 font-weight-bold linkToTask" data-id="' + id + '">Link to Task</button>'
      $("div.tui-full-calendar-section-detail > div.tui-full-calendar-popup-detail-item").after(html)
    }
  })

  $(document).on("click", "div.tui-full-calendar-section-detail .linkToTask", function (e) {
      let id = $(this).attr("data-id")
      window.open("/tasks/" + id, '_blank');
  })

})