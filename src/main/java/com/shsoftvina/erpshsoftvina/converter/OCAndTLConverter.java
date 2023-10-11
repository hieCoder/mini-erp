package com.shsoftvina.erpshsoftvina.converter;

import com.shsoftvina.erpshsoftvina.entity.OCAndTL;
import com.shsoftvina.erpshsoftvina.model.response.oc_and_tl.SpecificWorkOfCategoryInOCAndTLResponse;
import com.shsoftvina.erpshsoftvina.model.response.oc_and_tl.OCAndTLOfOneDayResponse;
import com.shsoftvina.erpshsoftvina.utils.DateUtils;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class OCAndTLConverter {

    public List<OCAndTLOfOneDayResponse> toListOCAndTLShowResponse(List<OCAndTL> calendarList) {
        Map<String, OCAndTLOfOneDayResponse> responseMap = new HashMap<>();

        for (OCAndTL calendar : calendarList) {
            String day = DateUtils.formatDate(calendar.getDay());
            SpecificWorkOfCategoryInOCAndTLResponse specificWorkResponse = new SpecificWorkOfCategoryInOCAndTLResponse();
            specificWorkResponse.setId(calendar.getId());
            specificWorkResponse.setTarget(calendar.getTarget());
            specificWorkResponse.setPerformance(calendar.isPerformance());

            OCAndTLOfOneDayResponse dayResponse = responseMap.get(day);
            if (dayResponse == null) {
                dayResponse = new OCAndTLOfOneDayResponse();
                dayResponse.setDay(day);
                dayResponse.setCategorys(new HashMap<>());
                responseMap.put(day, dayResponse);
            }

            dayResponse.getCategorys().put(calendar.getCategory().toString(), specificWorkResponse);
        }

        return new ArrayList<>(responseMap.values());

    }
}
