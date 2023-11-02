package com.shsoftvina.erpshsoftvina.api;

import com.shsoftvina.erpshsoftvina.model.request.event.EventCreateRequest;
import com.shsoftvina.erpshsoftvina.model.request.event.EventEditRequest;
import com.shsoftvina.erpshsoftvina.model.response.event.EventDashBoardResponse;
import com.shsoftvina.erpshsoftvina.model.response.event.EventResponse;
import com.shsoftvina.erpshsoftvina.service.EventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("api/v1/events")
public class EventApi {
    @Autowired
    private EventService eventService;
    @GetMapping()
    public ResponseEntity<?> getAllEventsByMonth(@RequestParam("month") String month) {
        List<EventResponse> responseList = eventService.getAllEventsByMonth(month);
        return new ResponseEntity<>(responseList, HttpStatus.OK);
    }

    @GetMapping("/upcoming")
    public ResponseEntity<?> getUpcomingEvents(@RequestParam("day") String day) {
        List<EventDashBoardResponse> responseList = eventService.getUpcomingEvent(day);
//        DashBoardResponse dashBoardResponse =
        return new ResponseEntity<>(responseList, HttpStatus.OK);
    }

    @PostMapping()
    public ResponseEntity<String> createEvent(@Valid @RequestBody EventCreateRequest request, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        return ResponseEntity.ok(eventService.createEvent(request));
    }
    @PutMapping()
    public ResponseEntity<?> editEvent(@Valid @RequestBody EventEditRequest request, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        return ResponseEntity.ok(eventService.editEvent(request));
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteEvent(@PathVariable("id") String id) {
        return ResponseEntity.ok(eventService.deleteEvent(id));
    }
}
