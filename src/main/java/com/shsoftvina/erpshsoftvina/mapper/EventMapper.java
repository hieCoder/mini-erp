package com.shsoftvina.erpshsoftvina.mapper;

import com.shsoftvina.erpshsoftvina.entity.Event;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface EventMapper {
    List<Event> getAllEventsByMonth(@Param("monthly") String month);

    void deleteEvent(@Param("id") String id);

    void createEvent(Event event);

    void editEvent(Event event);
}
