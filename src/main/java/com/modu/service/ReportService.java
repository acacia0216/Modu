package com.modu.service;

import com.modu.dao.ReportDao;
import com.modu.vo.ModuUserVo;
import com.modu.vo.ReportVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class ReportService {
    @Autowired
    ReportDao reportDao;

    public int getRecentEvent(String groupNo) {
        return reportDao.getRecentEvent(groupNo);
    }

    public Map<String, Object> annualReport(int groupNo, String year) {
        System.out.println("연간보고서 월별로 긁어오자");
        List<Object> list = new ArrayList<>();
        List<ReportVo> categoryList = reportDao.getCategory(groupNo);
        for (int i = 1; i <= 12; i++) {
            Map<String, Object> inputMap = new HashMap<>();
            String startDay = year + "/" + String.valueOf(i) + "/01";
            String lastDay = getLastDay(Integer.parseInt(year), i);
            inputMap.put("groupNo", groupNo);
            inputMap.put("startDay", startDay);
            inputMap.put("lastDay", lastDay);
            List<ReportVo> tmp = reportDao.getMonthlyAnnualList(inputMap);

            list.add(tmp);
        }
        System.out.println(list);
        Map<String, Object> outputMap = new HashMap<>();
        outputMap.put("categoryList", categoryList);
        outputMap.put("list", list);
        System.out.println(categoryList);
        return outputMap;
    }

    public String getLastDay(int year, int month) {//마지막날 구하는 함수
        int day = 1;

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Calendar calendar = Calendar.getInstance();

        calendar.set(year, month - 1, day);
        int lastDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

        String lastDate = String.valueOf(year) + "/" + String.valueOf(month) + "/" + String.valueOf(lastDay);
        return lastDate;
    }
}
