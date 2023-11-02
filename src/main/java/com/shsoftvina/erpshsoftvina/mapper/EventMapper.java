package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Event;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface EventMapper {
    List<Event> getAllEventsByMonth(@Param("month") String month);

    Event findById(@Param("id") String id);

    void deleteEvent(@Param("id") String id);

    void createEvent(Event event);

    int editEvent(Event event);
}
