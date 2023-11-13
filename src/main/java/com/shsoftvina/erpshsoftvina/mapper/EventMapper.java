package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Event;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.time.LocalDate;
import java.util.List;

@Mapper
public interface EventMapper {
    List<Event> getAllEventsByMonth(@Param("prevMonth") LocalDate prevMonth, @Param("nextMonth") LocalDate nextMonth);

    Event findById(@Param("id") String id);

    void deleteEvent(@Param("id") String id);

    void createEvent(Event event);

    int editEvent(Event event);

    List<Event> getUpcomingEvents(@Param("day") String day, RowBounds rowBounds);

    long getTotalRecordCountUpcoming(@Param("day") String day);

    List<Event> getEventNotification(@Param("limit") Integer limit);
}
