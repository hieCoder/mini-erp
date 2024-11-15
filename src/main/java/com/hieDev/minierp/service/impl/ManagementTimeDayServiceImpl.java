package com.hieDev.minierp.service.impl;

import com.hieDev.minierp.constant.QuoteConstant;
import com.hieDev.minierp.converter.*;
import com.hieDev.minierp.entity.*;
import com.hieDev.minierp.mapper.*;
import com.hieDev.minierp.model.dto.management_time.*;
import com.hieDev.minierp.model.request.managementtime.day.*;
import com.hieDev.minierp.model.response.managementtime.day.*;
import com.hieDev.minierp.utils.*;
import com.shsoftvina.erpshsoftvina.converter.*;
import com.shsoftvina.erpshsoftvina.entity.*;
import com.shsoftvina.erpshsoftvina.mapper.*;
import com.shsoftvina.erpshsoftvina.model.dto.management_time.*;
import com.hieDev.minierp.model.request.managementtime.WeeklyRequestReview;
import com.hieDev.minierp.model.request.managementtime.YearRequest;
import com.shsoftvina.erpshsoftvina.model.request.managementtime.day.*;
import com.hieDev.minierp.model.request.managementtime.calendar.CalendarDayRequest;
import com.hieDev.minierp.model.request.managementtime.calendar.CalendarMonthlyRequest;
import com.hieDev.minierp.model.request.managementtime.calendar.CalendarUpdateRequest;
import com.hieDev.minierp.model.request.managementtime.WeeklyRequest;
import com.hieDev.minierp.model.response.managementtime.WeeklyManagementTimeDayResponse;
import com.hieDev.minierp.model.response.managementtime.calendar.CalendarDayResponse;
import com.hieDev.minierp.model.response.managementtime.calendar.CalendarResponse;
import com.shsoftvina.erpshsoftvina.model.response.managementtime.day.*;
import com.hieDev.minierp.service.ManagementTimeDayService;
import com.shsoftvina.erpshsoftvina.utils.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
public class ManagementTimeDayServiceImpl implements ManagementTimeDayService {

    @Autowired
    private ManagementTimeDayMapper managementTimeDayMapper;

    @Autowired
    private ManagementTimeDayConvert managementTimeDayConvert;

    @Autowired
    private WeeklyManagementTimeDayMapper weeklyManagementTimeDayMapper;

    @Autowired
    private WeeklyManagementTimeDayConverter weeklyManagementTimeDayConverter;

    @Autowired
    private ApplicationUtils applicationUtils;

    @Autowired
    private MonthlyManagementTimeDayMapper monthlyManagementTimeDayMapper;

    @Autowired
    private MonthlyManagementTimeDayConverter monthlyManagementTimeDayConverter;

    @Autowired
    private ColorManagementTimeDayMapper colorManagementTimeDayMapper;

    @Autowired
    private ColorManagementTimeDayConvert colorManagementTimeDayConvert;

    @Autowired
    private QuoteManagementTimeDayMapper quoteManagementTimeDayMapper;

    @Autowired
    private QuoteMangementTimeDayConvert quoteMangementTimeDayConvert;

    @Autowired
    private YearManagementTimeDayMapper yearManagementTimeDayMapper;

    @Autowired
    private YearManagementTimeDayConverter yearManagementTimeDayConverter;

    private List<String> getSundaysOfTheMonth(String yyyyMMDD) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate date = LocalDate.parse(yyyyMMDD, formatter);
        List<String> sundays = new ArrayList<>();

        LocalDate firstDayOfMonth = date.withDayOfMonth(1);
        LocalDate firstDayOfNextMonth = firstDayOfMonth.plusMonths(1);

        LocalDate firstSunday = firstDayOfMonth.with(DayOfWeek.SUNDAY);
        if (firstSunday.isAfter(firstDayOfMonth)) {
            firstSunday = firstSunday.minusWeeks(1);
        }

        LocalDate currentSunday = firstSunday;
        while (currentSunday.isBefore(firstDayOfNextMonth)) {
            sundays.add(currentSunday.format(formatter));
            currentSunday = currentSunday.plusWeeks(1);
        }

        return sundays;
    }

    private int[] mergeAndCountDailyRoutine(List<Boolean[]> list) {
        if (list.isEmpty()) {
            return new int[0];
        }

        int[] resultArray = new int[list.get(0).length];

        for (Boolean[] boolArray : list) {
            for (int i = 0; i < boolArray.length; i++) {
                if (boolArray[i]) {
                    resultArray[i]++;
                }
            }
        }

        return resultArray;
    }

    private List<String> getMonthContainWeek(String day) {
        String firstDateOfWeek = FileUtils.getFirstDateOfWeek(day);
        String lastDateOfWeek = FileUtils.getLastDateOfWeek(day);

        List<String> containingMonths = new ArrayList<>();

        if (firstDateOfWeek.equals(lastDateOfWeek)) {
            containingMonths.add(firstDateOfWeek);
        } else {
            if (day.substring(0, 7).equals(firstDateOfWeek)) {
                containingMonths.add(firstDateOfWeek);
                containingMonths.add(lastDateOfWeek);
            } else {
                containingMonths.add(lastDateOfWeek);
                containingMonths.add(firstDateOfWeek);
            }
        }

        return containingMonths;
    }

    private ManagementTimeDay getManagementTimeDays(List<ManagementTimeDay> managementTimeDays, Date day) {
        Optional<ManagementTimeDay> result = managementTimeDays.stream()
                .filter(m -> DateUtils.formatDate(day).equals(DateUtils.formatDate(m.getDay())))
                .findFirst();
        return result.orElse(null);
    }

    private WeeklyManagementTimeDay getWeeklyManagementTimeDays(List<WeeklyManagementTimeDay> weeklyManagementTimeDays, Date startDay) {
        Optional<WeeklyManagementTimeDay> result = weeklyManagementTimeDays.stream()
                .filter(m -> DateUtils.formatDate(startDay).equals(m.getCode()))
                .findFirst();
        return result.orElse(null);
    }

    private MonthlyManagementTimeDay getMonthlyManagementTimeDays(List<MonthlyManagementTimeDay> monthlyManagementTimeDays, String code) {
        Optional<MonthlyManagementTimeDay> result = monthlyManagementTimeDays.stream()
                .filter(m -> code.equals(m.getCode()))
                .findFirst();
        return result.orElse(null);
    }

    private List<String> getDaysNotInMonth(String monthCode, List<String> days) {
        List<String> result = new ArrayList<>();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate firstDayOfMonth = LocalDate.parse(monthCode + "-01", formatter);
        LocalDate lastDayOfMonth = firstDayOfMonth.plusMonths(1).minusDays(1);

        LocalDate currentDate = firstDayOfMonth;
        while (!currentDate.isAfter(lastDayOfMonth)) {
            String currentDay = currentDate.format(formatter);
            if (!days.contains(currentDay)) {
                result.add(currentDay);
            }
            currentDate = currentDate.plusDays(1);
        }

        return result;
    }

    private List<String> getWeeksNotInMonth(String monthCode, List<String> weeklyCodes) {
        return getSundaysOfTheMonth(monthCode + "-01").stream()
                .filter(sunday -> !weeklyCodes.contains(sunday))
                .collect(Collectors.toList());
    }


    private String getYear(String day) {
        return day.substring(0, 4);
    }

    @Override
    public int updateCalendar(CalendarUpdateRequest req) {
        String userId = req.getUserId();
        CalendarMonthlyRequest monthlyReq = req.getMonthly();
        String monthlyCode = monthlyReq.getMonth();
        List<WeeklyRequest> weeklys = req.getWeeklys();
        List<CalendarDayRequest> days = req.getDays();
        YearRequest yearRequest = req.getYear();
        String yearCode = yearRequest.getYear();

        CompletableFuture<Void> asyncTaskDay = CompletableFuture.runAsync(() -> {
            List<ManagementTimeDay> insertListDay = new ArrayList<>();
            List<ManagementTimeDay> editListDay = new ArrayList<>();
            if (!days.isEmpty()) {
                List<String> dayList = days.stream().map(d -> DateUtils.formatDate(d.getDay())).collect(Collectors.toList());
                List<ManagementTimeDay> managementTimeDays = managementTimeDayMapper.findByListDay(userId, dayList);
                for (CalendarDayRequest d : days) {
                    ManagementTimeDay dayEntity = getManagementTimeDays(managementTimeDays, d.getDay());
                    if (dayEntity != null) {
                        ItemDto[] oneThingCalendar = JsonUtils.jsonToObject(dayEntity.getOneThingCalendar(), ItemDto[].class);
                        if (oneThingCalendar == null) {
                            oneThingCalendar = new ItemDto[d.getContent().length];
                            for (int i = 0; i < d.getContent().length; i++) {
                                oneThingCalendar[i] = new ItemDto();
                                oneThingCalendar[i].setTarget(d.getContent()[i]);
                                oneThingCalendar[i].setPerformance(false);
                            }
                        } else {
                            for (int i = 0; i < oneThingCalendar.length; i++) {
                                oneThingCalendar[i].setTarget(d.getContent()[i]);
                            }
                        }
                        dayEntity.setOneThingCalendar(JsonUtils.objectToJson(oneThingCalendar));
                        editListDay.add(dayEntity);
                    } else {
                        dayEntity = managementTimeDayConvert.toEntity(userId, d);
                        insertListDay.add(dayEntity);
                    }
                }
                if (!insertListDay.isEmpty()) {
                    CompletableFuture.runAsync(() -> {
                        managementTimeDayMapper.createListCalendarDay(insertListDay);
                    });
                }
                if (!editListDay.isEmpty()) {
                    CompletableFuture.runAsync(() -> {
                        managementTimeDayMapper.editListCalendarDay(editListDay);
                    });
                }
                CompletableFuture.runAsync(() -> {
                    managementTimeDayMapper.updateOneThingCalendarAllDayNull(userId, getDaysNotInMonth(monthlyCode, dayList));
                });
            } else {
                CompletableFuture.runAsync(() -> {
                    managementTimeDayMapper.updateOneThingCalendarAllDayNull(userId, getDaysNotInMonth(monthlyCode, new ArrayList<>()));
                });
            }
        });

        CompletableFuture<Void> asyncTaskWeekly = CompletableFuture.runAsync(() -> {
            List<WeeklyManagementTimeDay> insertListWeekly = new ArrayList<>();
            List<WeeklyManagementTimeDay> editListWeekly = new ArrayList<>();
            if (!weeklys.isEmpty()) {
                List<String> startDayList = weeklys.stream().map(d -> DateUtils.formatDate(d.getStartDay())).collect(Collectors.toList());
                List<WeeklyManagementTimeDay> weeklyManagementTimeDays = weeklyManagementTimeDayMapper.findByListCode(userId, startDayList);
                for (WeeklyRequest w : weeklys) {
                    WeeklyManagementTimeDay weeklyEntity = getWeeklyManagementTimeDays(weeklyManagementTimeDays, w.getStartDay());
                    if (weeklyEntity != null) {
                        weeklyEntity.setContent(JsonUtils.objectToJson(w.getWeeklys()));
                        editListWeekly.add(weeklyEntity);
                    } else {
                        weeklyEntity = weeklyManagementTimeDayConverter.toEntity(userId, w);
                        insertListWeekly.add(weeklyEntity);
                    }
                }
                if (!insertListWeekly.isEmpty()) {
                    CompletableFuture.runAsync(() -> {
                        weeklyManagementTimeDayMapper.createListWeekly(insertListWeekly);
                    });
                }
                if (!editListWeekly.isEmpty()) {
                    CompletableFuture.runAsync(() -> {
                        weeklyManagementTimeDayMapper.editListWeekly(editListWeekly);
                    });
                }
                CompletableFuture.runAsync(() -> {
                    weeklyManagementTimeDayMapper.updateContentAllWeeklyNull(userId, getWeeksNotInMonth(monthlyCode, startDayList));
                });
            } else {
                CompletableFuture.runAsync(() -> {
                    weeklyManagementTimeDayMapper.updateContentAllWeeklyNull(userId, getWeeksNotInMonth(monthlyCode, new ArrayList<>()));
                });
            }
        });

        CompletableFuture<Void> asyncTaskMonth = CompletableFuture.runAsync(() -> {
            MonthlyManagementTimeDay monthlyEntity = monthlyManagementTimeDayMapper.findByCode(userId, monthlyCode);
            if (monthlyEntity == null) {
                MonthlyManagementTimeDay monthlyE = monthlyManagementTimeDayConverter.toEntity(userId, monthlyReq);
                CompletableFuture.runAsync(() -> {
                    monthlyManagementTimeDayMapper.createMonthlyManagementTimeDay(monthlyE);
                });
            } else {
                monthlyEntity.setContent(JsonUtils.objectToJson(monthlyReq.getContent()));
               CompletableFuture.runAsync(() -> {
                    monthlyManagementTimeDayMapper.updateMonthlyManagementTimeDay(monthlyEntity);
                });
            }
        });

        CompletableFuture<Void> asyncTaskYear = CompletableFuture.runAsync(() -> {
            YearManagementTimeDay yearEntity = yearManagementTimeDayMapper.findByCode(userId, yearCode);
            if (yearEntity == null) {
                YearManagementTimeDay yearE = yearManagementTimeDayConverter.toEntity(userId, yearRequest);
                CompletableFuture.runAsync(() -> {
                    yearManagementTimeDayMapper.createYearManagementTimeDay(yearE);
                });
            } else {
                String oldTarget = yearEntity.getTarget();
                String newTarget = JsonUtils.objectToJson(yearRequest.getTarget());
                String[] newTargets = newTarget.split("\"target\":\"");
                for (int i = 1; i < newTargets.length; i++) {
                    newTargets[i] = newTargets[i].split("\"")[0];
                }

                String[] oldTargets = oldTarget.split("\"target\":\"");

                StringBuilder result = new StringBuilder(oldTargets[0]);
                for (int i = 1; i < oldTargets.length; i++) {
                    String remainingPart = oldTargets[i].substring(oldTargets[i].indexOf("\""));
                    result.append("\"target\":\"").append(newTargets[i]).append(remainingPart);
                }

                yearEntity.setTarget(result.toString());
                CompletableFuture.runAsync(() -> {
                    yearManagementTimeDayMapper.updateYearManagementTimeDay(yearEntity);
                });
            }
        });

        CompletableFuture<Void> asyncTaskQuote = CompletableFuture.runAsync(() -> {
            QuoteDto quotes = req.getQuotes();
            String[] quoteContent = quotes.getQuotes();
            String quoteImage = quotes.getImage();

            QuoteManagementTimeDay quote = quoteManagementTimeDayMapper.findByUserId(userId);
            if (quote == null) {
                QuoteManagementTimeDay quoteE = quoteMangementTimeDayConvert.toEntity(userId, quoteContent, quoteImage);
                CompletableFuture.runAsync(() -> {
                    quoteManagementTimeDayMapper.createQuote(quoteE);
                });
            } else {
                quote.setContent(JsonUtils.objectToJson(quotes.getQuotes()));
                if (!StringUtils.isBlank(quoteImage)) {
                    FileUtils.deleteImageFromServer(QuoteConstant.UPLOAD_FILE_DIR, quote.getImage());
                    quote.setImage(quoteImage);
                }
               CompletableFuture.runAsync(() -> {
                    quoteManagementTimeDayMapper.editQuote(quote);
                });

            }
        });

        CompletableFuture.allOf(asyncTaskDay, asyncTaskWeekly, asyncTaskMonth, asyncTaskYear, asyncTaskQuote);
        return 1;
    }

    @Override
    public CalendarResponse showCalendar(String userId, String startDate, String endDate) {

        applicationUtils.checkUserAllow(userId);

        CompletableFuture<MonthlyManagementTimeDay> monthlyFuture = CompletableFuture.supplyAsync(() ->
                monthlyManagementTimeDayMapper.findByCode(userId, startDate.substring(0, 7))
        );

        List<String> weeklyCode = getSundaysOfTheMonth(startDate);
        CompletableFuture<List<WeeklyManagementTimeDay>> weeklysFuture = CompletableFuture.supplyAsync(() ->
                weeklyManagementTimeDayMapper.findByListCode(userId, weeklyCode)
        );
        CompletableFuture<List<ManagementTimeDay>> daysFuture = CompletableFuture.supplyAsync(() ->
                managementTimeDayMapper.findByListCode(userId, weeklyCode)
        );
        CompletableFuture<YearManagementTimeDay> yearFuture = CompletableFuture.supplyAsync(() ->
                yearManagementTimeDayMapper.findByCode(userId, getYear(startDate))
        );

        CompletableFuture<Void> allOf = CompletableFuture.allOf(monthlyFuture, weeklysFuture, daysFuture, yearFuture);
        allOf.join();

        MonthlyContentDto[] monthlyContents = monthlyFuture.thenApply(monthly ->
                (monthly != null) ? JsonUtils.jsonToObject(monthly.getContent(), MonthlyContentDto[].class) : null
        ).join();


        return CalendarResponse.builder()
                .monthlyContents(monthlyContents)
                .days(managementTimeDayConvert.toListCalendarResponse(daysFuture.join()))
                .weeklys(weeklyManagementTimeDayConverter.toListResponse(weeklysFuture.join()))
                .year(yearManagementTimeDayConverter.toResponse(yearFuture.join()))
                .build();
    }

    @Override
    public DaysOfWeeklyResponse showListDayOfWeek(String userId, String currentDay) {

        applicationUtils.checkUserAllow(userId);

        CompletableFuture<List<CalendarDayResponse>> getPerformance = CompletableFuture.supplyAsync(() ->
                managementTimeDayConvert.toListCalendarResponse(managementTimeDayMapper.getPerformance(currentDay.substring(0, 7)))
        );

        CompletableFuture<List<MonthResponse>> monthlysFuture = CompletableFuture.supplyAsync(() -> {
            List<MonthResponse> monthlys = new ArrayList<>();
            List<String> monthContainWeek = getMonthContainWeek(currentDay);
            List<MonthlyManagementTimeDay> monthlyManagementTimeDays = monthlyManagementTimeDayMapper.findByListCode(userId, monthContainWeek);


            for (String month : monthContainWeek) {
                MonthlyManagementTimeDay monthlyManagementTimeDay = getMonthlyManagementTimeDays(monthlyManagementTimeDays, month);
                if (monthlyManagementTimeDay != null) {
                    MonthResponse monthResponse = new MonthResponse();
                    monthResponse.setMonth(month);
                    monthResponse.setMonthlyContents(JsonUtils.jsonToObject(monthlyManagementTimeDay.getContent(), MonthlyContentDto[].class));
                    monthResponse.setTargetCategory(JsonUtils.jsonToObject(monthlyManagementTimeDay.getTargetCategory(), MonthlyTagetCategoryDto[].class));
                    monthResponse.setGratitudeDiary(monthlyManagementTimeDay.getGratitudeDiary());
                    monthResponse.setCompliment(monthlyManagementTimeDay.getCompliment());
                    monthResponse.setReflectionAndImprovement(monthlyManagementTimeDay.getReflectionAndImprovement());
                    monthResponse.setTimeUsedMonthly(JsonUtils.jsonToObject(monthlyManagementTimeDay.getTimeUsedCategory(), TimeUsedMonthlyDto[].class));
                    String dailyRoutineJson = monthlyManagementTimeDay.getDailyRoutine();
                    if (!StringUtils.isBlank(dailyRoutineJson)) {
                        DailyRoutineResponse[] dailyRoutineResponses = JsonUtils.jsonToObject(dailyRoutineJson, DailyRoutineResponse[].class);
                        List<ManagementTimeDay> list = managementTimeDayMapper.findAllDailyRoutineOfMonth(userId, monthlyManagementTimeDay.getCode());
                        List<Boolean[]> listDailyRoutine = list.stream()
                                .filter(day -> day != null)
                                .map(day -> JsonUtils.jsonToObject(day.getDailyRoutine(), Boolean[].class))
                                .collect(Collectors.toList());
                        int[] countDailyRoutines = mergeAndCountDailyRoutine(listDailyRoutine);

                        if (countDailyRoutines.length > 0) {
                            for (int i = 0; i < dailyRoutineResponses.length; i++) {
                                dailyRoutineResponses[i].setPerformance(countDailyRoutines[i]);
                            }
                        }

                        monthResponse.setDailyRoutine(dailyRoutineResponses);
                    }
                    monthlys.add(monthResponse);
                } else {
                    MonthResponse monthResponse = MonthResponse.builder()
                            .month(month)
                            .build();
                    monthlys.add(monthResponse);
                }
            }

            if (monthlys.size() == 2 && monthlys.get(1).getMonth().equals(currentDay.substring(0, 7))) {
                Collections.swap(monthlys, 0, 1);
            }

            return monthlys;
        });
        String weeklyCode = ApplicationUtils.generateWeeklyCodeOfDay(DateUtils.parseDate(currentDay));
        WeeklyManagementTimeDay weeklyManagementTimeDay = weeklyManagementTimeDayMapper.findByCode(userId, weeklyCode);
        YearManagementTimeDay yearManagementTimeDay = yearManagementTimeDayMapper.findByCode(userId, getYear(currentDay));

        CompletableFuture<WeeklyManagementTimeDayResponse> weeklyFuture = CompletableFuture.supplyAsync(() -> {
            return WeeklyManagementTimeDayResponse.builder()
                    .weeklyId(weeklyManagementTimeDay != null ? weeklyManagementTimeDay.getId() : null)
                    .startDate(weeklyManagementTimeDay != null ? weeklyManagementTimeDay.getCode() : null)
                    .weeklys(weeklyManagementTimeDay != null ? JsonUtils.jsonToObject(weeklyManagementTimeDay.getContent(), WeeklyDto[].class) : null)
                    .build();
        });

        CompletableFuture<List<DayResponse>> daysFuture = CompletableFuture.supplyAsync(() -> {
            return managementTimeDayConvert.toListDayDetailResponse(managementTimeDayMapper.findByCode(userId, weeklyCode), weeklyCode);
        });

        CompletableFuture<QuoteResponse> quoteFuture = CompletableFuture.supplyAsync(() -> {
            return quoteMangementTimeDayConvert.toResponse(quoteManagementTimeDayMapper.findByUserId(userId));
        });

        CompletableFuture<YearResponse> yearFuture = CompletableFuture.supplyAsync(() -> {
            return yearManagementTimeDayConverter.toResponse(yearManagementTimeDay);
        });

        CompletableFuture<List<ColorResponse>> colorsFuture = CompletableFuture.supplyAsync(() ->
                yearManagementTimeDay != null ?
                        colorManagementTimeDayConvert.toListResponse(colorManagementTimeDayMapper.findAllByYearId(yearManagementTimeDay.getId())) :
                        new ArrayList<>()
        );

        CompletableFuture<Void> allOf = CompletableFuture.allOf(getPerformance, monthlysFuture, weeklyFuture, daysFuture, colorsFuture, quoteFuture, yearFuture);
        allOf.join();

        DaysOfWeeklyResponse daysOfWeeklyResponse = DaysOfWeeklyResponse.builder()
                .monthlys(monthlysFuture.join())
                .weeklys(weeklyFuture.join())
                .days(daysFuture.join())
                .colors(colorsFuture.join())
                .quotes(quoteFuture.join())
                .year(yearFuture.join())
                .getPerformace(getPerformance.join())
                .build();

        return daysOfWeeklyResponse;
    }

    @Override
    public int updateListDayOfWeek(DaysUpdateRequest daysUpdateRequest) {
        String userId = daysUpdateRequest.getUserId();
        List<WeeklyRequestReview> weeklysReview = daysUpdateRequest.getWeeklysReview();

        List<CompletableFuture<Void>> asyncTasks = new ArrayList<>();

        CompletableFuture<Void> asyncTaskMonth = CompletableFuture.runAsync(() -> {
            MonthlyRequest monthlyRequest = daysUpdateRequest.getMonthly();
            String monthlyCode = monthlyRequest.getMonth();
            MonthlyContentDto[] monthlyContent = monthlyRequest.getContent();
            DailyRoutineRequest[] dailyRoutine = monthlyRequest.getDailyRoutine();
            MonthlyTagetCategoryDto[] targetCategory = monthlyRequest.getTargetCategory();
            String monthlyGratitudeDiary = monthlyRequest.getGratitudeDiary();
            String monthlyCompliment = monthlyRequest.getCompliment();
            String monthlyReflectionAndImprovement = monthlyRequest.getReflectionAndImprovement();
            TimeUsedMonthlyDto[] timeUsedMonthly = monthlyRequest.getTimeUsedMonthly();
            MonthlyManagementTimeDay monthlyEntity = monthlyManagementTimeDayMapper.findByCode(userId, monthlyCode);
            if (monthlyEntity == null) {
                MonthlyManagementTimeDay monthlyE = monthlyManagementTimeDayConverter.toEntity(userId, monthlyCode,
                        JsonUtils.objectToJson(monthlyContent),
                        JsonUtils.objectToJson(dailyRoutine),
                        JsonUtils.objectToJson(targetCategory),
                        monthlyGratitudeDiary,
                        monthlyCompliment,
                        monthlyReflectionAndImprovement,
                        JsonUtils.objectToJson(timeUsedMonthly));
                CompletableFuture<Void> createMonthlyManagementTimeDayAsync = CompletableFuture.runAsync(() -> {
                    monthlyManagementTimeDayMapper.createMonthlyManagementTimeDay(monthlyE);
                });
                asyncTasks.add(createMonthlyManagementTimeDayAsync);
            } else {
                monthlyEntity.setContent(JsonUtils.objectToJson(monthlyContent));
                monthlyEntity.setDailyRoutine(JsonUtils.objectToJson(dailyRoutine));
                monthlyEntity.setTargetCategory(JsonUtils.objectToJson(targetCategory));
                monthlyEntity.setGratitudeDiary(monthlyGratitudeDiary);
                monthlyEntity.setCompliment(monthlyCompliment);
                monthlyEntity.setReflectionAndImprovement(monthlyReflectionAndImprovement);
                monthlyEntity.setTimeUsedCategory(JsonUtils.objectToJson(timeUsedMonthly));
                CompletableFuture<Void> updateMonthlyManagementTimeDayAsync = CompletableFuture.runAsync(() -> {
                    monthlyManagementTimeDayMapper.updateMonthlyManagementTimeDay(monthlyEntity);
                });
                asyncTasks.add(updateMonthlyManagementTimeDayAsync);
            }
        });

        CompletableFuture<Void> asyncTaskWeek = CompletableFuture.runAsync(() -> {
            WeeklyRequest weeklyRequest = daysUpdateRequest.getWeekly();
            String weeklyCode = DateUtils.formatDate(weeklyRequest.getStartDay());
            WeeklyDto[] weeklys = weeklyRequest.getWeeklys();
            String gratitudeDiary = weeklyRequest.getGratitudeDiary();
            String compliment = weeklyRequest.getCompliment();
            String reflectionAndImprovement = weeklyRequest.getReflectionAndImprovement();
            WeeklyManagementTimeDay weeklyEntity = weeklyManagementTimeDayMapper.findByCode(userId, weeklyCode);
            if (weeklyEntity == null) {
                WeeklyManagementTimeDay weeklyE = weeklyManagementTimeDayConverter.toEntity(userId, weeklyCode, JsonUtils.objectToJson(weeklys), gratitudeDiary, compliment, reflectionAndImprovement);
                CompletableFuture<Void> createWeeklyManagementTimeDayAsync = CompletableFuture.runAsync(() -> {
                    weeklyManagementTimeDayMapper.createWeeklyManagementTimeDay(weeklyE);
                });
                asyncTasks.add(createWeeklyManagementTimeDayAsync);
            } else {
                weeklyEntity.setContent(JsonUtils.objectToJson(weeklys));
                weeklyEntity.setGratitudeDiary(gratitudeDiary);
                weeklyEntity.setCompliment(compliment);
                weeklyEntity.setReflectionAndImprovement(reflectionAndImprovement);
                CompletableFuture<Void> updateWeeklyManagementTimeDayAsync = CompletableFuture.runAsync(() -> {
                    weeklyManagementTimeDayMapper.updateWeeklyManagementTimeDay(weeklyEntity);
                });
                asyncTasks.add(updateWeeklyManagementTimeDayAsync);
            }
        });

        CompletableFuture<Void> asyncTaskWeeklyReview = CompletableFuture.runAsync(() -> {
            List<WeeklyManagementTimeDay> insertListWeekly = new ArrayList<>();
            List<WeeklyManagementTimeDay> editListWeekly = new ArrayList<>();
            if (!weeklysReview.isEmpty()) {
                List<String> startDayList = weeklysReview.stream().map(d -> DateUtils.formatDate(d.getStartDay())).collect(Collectors.toList());
                List<WeeklyManagementTimeDay> weeklyManagementTimeDays = weeklyManagementTimeDayMapper.findByListCode(userId, startDayList);
                for (WeeklyRequestReview w : weeklysReview) {
                    WeeklyManagementTimeDay weeklyEntity = getWeeklyManagementTimeDays(weeklyManagementTimeDays, w.getStartDay());
                    if (weeklyEntity != null) {
                        weeklyEntity.setGratitudeDiary(w.getGratitudeDiary());
                        weeklyEntity.setCompliment(w.getCompliment());
                        weeklyEntity.setReflectionAndImprovement(w.getReflectionAndImprovement());
                        editListWeekly.add(weeklyEntity);
                    } else {
                        weeklyEntity = weeklyManagementTimeDayConverter.toEntityReview(userId, w);
                        insertListWeekly.add(weeklyEntity);
                    }
                }
                if (!insertListWeekly.isEmpty()) {
                    CompletableFuture.runAsync(() -> {
                        weeklyManagementTimeDayMapper.createListWeekly(insertListWeekly);
                    });
                }
                if (!editListWeekly.isEmpty()) {
                    CompletableFuture.runAsync(() -> {
                        weeklyManagementTimeDayMapper.editListWeekly(editListWeekly);
                    });
                }
            }
        });

        CompletableFuture<Void> asyncTaskDay = CompletableFuture.runAsync(() -> {
            DayRequest[] days = daysUpdateRequest.getDays();
            if (days.length != 0) {
                List<ManagementTimeDay> managementTimeDaysReq = managementTimeDayConvert.toListEntity(userId, days);
                List<String> dayList = Stream.of(days).map(d -> DateUtils.formatDate(d.getDay())).collect(Collectors.toList());
                List<ManagementTimeDay> managementTimeDaysDB = managementTimeDayMapper.findByListDay(userId, dayList);

                List<ManagementTimeDay> insertListDay = new ArrayList<>();
                List<ManagementTimeDay> editListDay = new ArrayList<>();

                for (ManagementTimeDay mReq : managementTimeDaysReq) {
                    ManagementTimeDay m = getManagementTimeDays(managementTimeDaysDB, mReq.getDay());
                    if (m == null) {
                        insertListDay.add(mReq);
                    } else {
                        mReq.setId(m.getId());
                        editListDay.add(mReq);
                    }
                }

                if (!insertListDay.isEmpty()) {
                    CompletableFuture<Void> createListDayDetailAsync = CompletableFuture.runAsync(() -> {
                        managementTimeDayMapper.createListDayDetail(insertListDay);
                    });
                    asyncTasks.add(createListDayDetailAsync);
                }
                if (!editListDay.isEmpty()) {
                    CompletableFuture<Void> editListDayDetailAsync = CompletableFuture.runAsync(() -> {
                        managementTimeDayMapper.editListDayDetail(editListDay);
                    });
                    asyncTasks.add(editListDayDetailAsync);
                }
            }
        });

        CompletableFuture<Void> asyncTaskQuote = CompletableFuture.runAsync(() -> {
            QuoteDto quotes = daysUpdateRequest.getQuotes();
            String[] quoteContent = quotes.getQuotes();
            String quoteImage = quotes.getImage();

            QuoteManagementTimeDay quote = quoteManagementTimeDayMapper.findByUserId(userId);
            if (quote == null) {
                QuoteManagementTimeDay quoteE = quoteMangementTimeDayConvert.toEntity(userId, quoteContent, quoteImage);
                CompletableFuture<Void> createQuoteManagementTimeDayAsync = CompletableFuture.runAsync(() -> {
                    quoteManagementTimeDayMapper.createQuote(quoteE);
                });
                asyncTasks.add(createQuoteManagementTimeDayAsync);
            } else {
                quote.setContent(JsonUtils.objectToJson(quotes.getQuotes()));
                if (!StringUtils.isBlank(quoteImage)) {
                    FileUtils.deleteImageFromServer(QuoteConstant.UPLOAD_FILE_DIR, quote.getImage());
                    quote.setImage(quoteImage);
                }
                CompletableFuture<Void> updateQuoteManagementTimeDayAsync = CompletableFuture.runAsync(() -> {
                    quoteManagementTimeDayMapper.editQuote(quote);
                });
                asyncTasks.add(updateQuoteManagementTimeDayAsync);
            }
        });

        CompletableFuture<Void> asyncTaskYear = CompletableFuture.runAsync(() -> {
            YearRequest yearRequest = daysUpdateRequest.getYear();
            String yearCode = yearRequest.getYear();
            YearTargetDto[] target = yearRequest.getTarget();
            String selfInspiration = yearRequest.getSelfInspiration();
            String[] color = yearRequest.getColor();
            YearManagementTimeDay yearE = yearManagementTimeDayMapper.findByCode(userId, yearCode);
            ColorRequest[] colorRequests = daysUpdateRequest.getColors();
            if (yearE == null) {
                YearManagementTimeDay yearManagementTimeDay = yearManagementTimeDayConverter.toEntity(userId, yearRequest);
                CompletableFuture<Void> createYearManagementTimeDayAsync = CompletableFuture.runAsync(() -> {
                    yearManagementTimeDayMapper.createYearManagementTimeDay(yearManagementTimeDay);
                    YearManagementTimeDay yearSaved = yearManagementTimeDayMapper.findByCode(userId, yearCode);
                    colorManagementTimeDayMapper.deleteAllByYearlyId(yearSaved.getId());
                    List<ColorManagementTimeDay> colorManagementTimeDays = colorManagementTimeDayConvert.toListEntity(yearSaved, colorRequests);
                    colorManagementTimeDayMapper.createColors(colorManagementTimeDays);
                });
                asyncTasks.add(createYearManagementTimeDayAsync);
            } else {
                yearE.setTarget(JsonUtils.objectToJson(target));
                yearE.setSelfInspiration(selfInspiration);
                yearE.setColor(JsonUtils.objectToJson(color));
                CompletableFuture<Void> updateYearManagementTimeDayAsync = CompletableFuture.runAsync(() -> {
                    yearManagementTimeDayMapper.updateYearManagementTimeDay(yearE);
                    colorManagementTimeDayMapper.deleteAllByYearlyId(yearE.getId());
                    List<ColorManagementTimeDay> colorManagementTimeDays = colorManagementTimeDayConvert.toListEntity(yearE, colorRequests);
                    colorManagementTimeDayMapper.createColors(colorManagementTimeDays);
                });
                asyncTasks.add(updateYearManagementTimeDayAsync);
            }
        });

        CompletableFuture<Void> allAsyncTasks = CompletableFuture.allOf(asyncTaskMonth, asyncTaskWeek, asyncTaskWeeklyReview, asyncTaskDay, asyncTaskQuote, asyncTaskYear);
        allAsyncTasks.thenRun(() -> {
            CompletableFuture<Void> allOfAsyncTasks = CompletableFuture.allOf(asyncTasks.toArray(new CompletableFuture[0]));
            allOfAsyncTasks.join();
        }).join();

        return 1;
    }

    @Override
    public int updateSpendingMonth(SpendingMonthRequest req) {
        String userId = req.getUserId();

        List<CompletableFuture<Void>> asyncTasks = new ArrayList<>();

        CompletableFuture<Void> asyncTaskMonth = CompletableFuture.runAsync(() -> {
            String monthlyCode = req.getMonth();
            Float spendingGoals = req.getSpendingGoals();
            MonthlyManagementTimeDay monthlyEntity = monthlyManagementTimeDayMapper.findByCode(userId, monthlyCode);
            if (monthlyEntity == null) {
                MonthlyManagementTimeDay monthlyE = monthlyManagementTimeDayConverter.toEntity(req);
                CompletableFuture<Void> createSpendingMonthlyManagementTimeDayAsync = CompletableFuture.runAsync(() -> {
                    monthlyManagementTimeDayMapper.createSpendingMonthlyManagementTimeDay(monthlyE);
                });
                asyncTasks.add(createSpendingMonthlyManagementTimeDayAsync);
            } else {
                monthlyEntity.setSpendingGoals(spendingGoals);
                CompletableFuture<Void> updateSpendingMonthlyManagementTimeDayAsync = CompletableFuture.runAsync(() -> {
                    monthlyManagementTimeDayMapper.updateSpendingMonthlyManagementTimeDay(monthlyEntity);
                });
                asyncTasks.add(updateSpendingMonthlyManagementTimeDayAsync);
            }
        });

        CompletableFuture<Void> asyncTaskDay = CompletableFuture.runAsync(() -> {
            SpendingMonthItemDto[] spendingDays = req.getDays();

            if (spendingDays.length > 0) {
                List<String> dayList = Arrays.stream(spendingDays)
                        .map(SpendingMonthItemDto::getDay)
                        .collect(Collectors.toList());
                List<ManagementTimeDay> managementTimeDaysDB = managementTimeDayMapper.findByListDay(userId, dayList);

                List<ManagementTimeDay> insertListDay = new ArrayList<>();
                List<ManagementTimeDay> editListDay = new ArrayList<>();

                for (SpendingMonthItemDto spendingDay : spendingDays) {
                    Date day = DateUtils.parseDate(spendingDay.getDay());
                    Float spending = spendingDay.getSpending();
                    ManagementTimeDay m = getManagementTimeDays(managementTimeDaysDB, day);
                    if (m == null) {
                        ManagementTimeDay newDay = managementTimeDayConvert.toEntity(userId, day, spending);
                        insertListDay.add(newDay);
                    } else {
                        m.setSpending(spending);
                        editListDay.add(m);
                    }
                }

                if (!insertListDay.isEmpty()) {
                    CompletableFuture<Void> createListDayDetailAsync = CompletableFuture.runAsync(() -> {
                        managementTimeDayMapper.createListDayDetail(insertListDay);
                    });
                    asyncTasks.add(createListDayDetailAsync);
                }
                if (!editListDay.isEmpty()) {
                    CompletableFuture<Void> editListDayDetailAsync = CompletableFuture.runAsync(() -> {
                        managementTimeDayMapper.editListDayDetail(editListDay);
                    });
                    asyncTasks.add(editListDayDetailAsync);
                }
            }
        });

        CompletableFuture<Void> allAsyncTasks = CompletableFuture.allOf(asyncTaskMonth, asyncTaskDay);
        allAsyncTasks.thenRun(() -> {
            CompletableFuture<Void> allOfAsyncTasks = CompletableFuture.allOf(asyncTasks.toArray(new CompletableFuture[0]));
            allOfAsyncTasks.join();
        }).join();

        return 1;
    }

    @Override
    public SpendingMonthResponse showSpendingMonth(String userId, String monthCode) {

        CompletableFuture<Float> spendingGoals = CompletableFuture.supplyAsync(() -> {
            MonthlyManagementTimeDay monthly = monthlyManagementTimeDayMapper.findByCode(userId, monthCode);
            return monthly != null ? monthly.getSpendingGoals() : null;
        });

        CompletableFuture<SpendingMonthItemDto[]> getSpendingMonthResponse = CompletableFuture.supplyAsync(() -> {
            List<ManagementTimeDay> days = managementTimeDayMapper.findSpendingByMonthCode(userId, monthCode);
            return managementTimeDayConvert.toArraySpendingResponse(days);
        });

        CompletableFuture<Void> allOf = CompletableFuture.allOf(spendingGoals, getSpendingMonthResponse);
        allOf.join();

        SpendingMonthResponse spendingMonthResponse = SpendingMonthResponse.builder()
                .spendingGoals(spendingGoals.join())
                .spending(getSpendingMonthResponse.join())
                .build();

        return spendingMonthResponse;
    }

    @Override
    public List<MonthResponse> monthOfYear(String userId, String year) {
        List<MonthlyManagementTimeDay> monthlyManagementTimeDays = monthlyManagementTimeDayMapper.findByYear(userId, year);
        return  monthlyManagementTimeDayConverter.toListEntity(monthlyManagementTimeDays);
    }
}