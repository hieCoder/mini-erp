<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <style>
    .calendar{
      display: grid;
      grid-template-columns: repeat(8, 1fr);
      text-align: center;
    }
    .seven_day {
      display: grid;
      grid-template-columns: repeat(8, 1fr);
      text-align: center;
    }
    .calendar .day {
      border: 1px solid #ccc;
      padding: 5px;
    }
    .seven_day .day {
      border: 1px solid #ccc;
      padding: 5px;
    }
  </style>
</head>
<body>
<div id="currentMonthYear"></div>
<div class="seven_day">
  <div class="day"></div>
  <div class="day">Sun</div>
  <div class="day">Mon</div>
  <div class="day">Tue</div>
  <div class="day">Wed</div>
  <div class="day">Thu</div>
  <div class="day">Fri</div>
  <div class="day">Sat</div>
  <!-- JavaScript will populate the days -->
</div>
<div class="calendar">
  <!-- JavaScript will populate the days -->
</div>
<table id="todoTable">
  <thead>
  <tr>
    <th></th>
    <th>Sun</th>
    <th>Mon</th>
    <th>Tue</th>
    <th>Wed</th>
    <th>Thu</th>
    <th>Fri</th>
    <th>Sat</th>
  </tr>
  </thead>
  <tbody>
  <!-- Rows for 5 to-dos for each day -->
  <tr>
    <td></td>
    <td class="day"></td>
    <td class="day"></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  </tbody>
</table>
<button id="prevMonth">Previous Month</button>
<button id="nextMonth">Next Month</button>
<script>
  const eventData = {
    events: [
      { date: "2023-11-10", event: "Meeting 1" },
      { date: "2023-11-15", event: "Meeting 2" },
      // Thêm các sự kiện khác ở đây
    ]
  };
  const calendar = document.querySelector('.calendar');
  const currentMonthYear = document.getElementById('currentMonthYear');
  const prevMonthBtn = document.getElementById('prevMonth');
  const nextMonthBtn = document.getElementById('nextMonth');

  // Get the current date
  let currentDate = new Date();

  function populateCalendar(year, month) {
    // Clear the calendar
    calendar.innerHTML = '';

    // Set the date to the 1st day of the specified month
    currentDate = new Date(year, month, 1);

    // Update the display for the current month and year
    const options = { year: 'numeric', month: 'long' };
    currentMonthYear.textContent = currentDate.toLocaleDateString('en-US', options);

    // Calculate the starting day (Sunday to Saturday: 0 to 6)
    const startDay = currentDate.getDay();

    // Get the number of days in the specified month
    const daysInMonth = new Date(year, month + 1, 0).getDate();

    // Calculate the last day of the previous month
    const lastDayOfPreviousMonth = getLastDayOfPreviousMonth(year, month);

    // Create a map to store events by date
    const eventsByDate = {};
    for (const event of eventData.events) {
      const eventDate = new Date(event.date);
      const eventDay = eventDate.getDate();
      eventsByDate[eventDay] = event.event;
    }

    // Populate the calendar
    for (let i = 0; i < 28; i++) {
      const day = document.createElement('div');
      day.classList.add('day');

      if (i < startDay) {
        // Display the last days of the previous month
        day.textContent = lastDayOfPreviousMonth - startDay + i + 1;
      } else if (i >= startDay && i - startDay < daysInMonth) {
        // Display the current month's days
        const currentDay = i - startDay + 1;
        day.textContent = currentDay;

        // Check if there's an event for this day
        if (eventsByDate[currentDay]) {
          const eventText = document.createElement('div');
          eventText.classList.add('event');
          eventText.textContent = eventsByDate[currentDay];
          day.appendChild(eventText);
        }
      }
      calendar.appendChild(day);
    }
  }

  populateCalendar(currentDate.getFullYear(), currentDate.getMonth());

  prevMonthBtn.addEventListener('click', () => {
    currentDate.setMonth(currentDate.getMonth() - 1);
    populateCalendar(currentDate.getFullYear(), currentDate.getMonth());
  });

  nextMonthBtn.addEventListener('click', () => {
    currentDate.setMonth(currentDate.getMonth() + 1);
    populateCalendar(currentDate.getFullYear(), currentDate.getMonth());
  });


  function getLastDayOfPreviousMonth(year, month) {
    if (month === 0) {
      year--;
      month = 11;
    } else {
      month--;
    }
    return new Date(year, month + 1, 0).getDate();
  }
</script>
</body>
</html>
