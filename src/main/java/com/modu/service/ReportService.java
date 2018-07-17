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
//        카테고리 리스트 불러오기
        List<Integer> cateList = reportDao.getCategory(groupNo);
        List<Object> outputList = new ArrayList<>();
        int count = 1;
//        카테고리 리스트를 가지고 월별로 쪼개서 데이터 가져오기
        for (Integer cateNo : cateList) {
            List<ReportVo> tmp = new ArrayList<>();
            System.out.println("카테고리번호 : " + cateNo);
            Map<String, Object> inputMap = new HashMap<>();
            inputMap.put("categoryNo", cateNo);
            inputMap.put("groupNo", groupNo);
//            해당 카테고리의 1~6월 정보 가져오기
            for (int i = 1; i <= 12; i++) {
                String startDay = year + "/" + i + "/01";
                String lastDay = getLastDay(Integer.parseInt(year), i);
                inputMap.put("startDay", startDay);
                inputMap.put("lastDay", lastDay);
                ReportVo reportVo = reportDao.getMonthlyAnnualList(inputMap);
//                null일 경우 RVO객체 만들어 넣기
                if (reportVo == null) {
                    ReportVo noData = new ReportVo();
                    noData.setCategoryNo(cateNo);
//                    카테고리번호의 카테고리이름 가져오기
                    noData.setCategoryName(reportDao.getCategoryName(cateNo));
                    tmp.add(noData);
                } else {
                    System.out.println(reportVo);
                    tmp.add(reportVo);
                }
            }

//            null체크(12달 모두 null인 카테고리 제외시키기)
            boolean flag = false;
            flag = tmpIsNull(tmp);
            if (flag == false) {
                System.out.println("리스트에 넣을 자료가 없음");
            } else {
                System.out.println("최종 리스트에 추가" + count);
                count++;
                outputList.add(tmp);
            }
        }
//        월별 총합계
        Map<String, Object> outputMap = new HashMap<>();
        List<String> annualSum = new ArrayList<>();
        System.out.println("총합계 구하기");
        for (int i = 1; i <= 12; i++) {
            Map<String, Object> inputMap = new HashMap<>();
            inputMap.put("groupNo", groupNo);
            String startDay = year + "/" + i + "/01";
            inputMap.put("startDay", startDay);
            inputMap.put("lastDay", getLastDay(Integer.parseInt(year), i));

            String tmpTotal = reportDao.getAnnualSum(inputMap);
            if (tmpTotal == null) {
                annualSum.add("0");
            } else {
                annualSum.add(tmpTotal);
            }
            System.out.println("가지고 나온 합계 값 : " + tmpTotal);
        }
//        월별 수입
        List<String> monthlyIncome = new ArrayList<>();
        for (int i=1; i<=12; i++){
            Map<String, Object> inputMap = new HashMap<>();
            inputMap.put("groupNo", groupNo);
            String startDay = year + "/" + i + "/01";
            inputMap.put("startDay", startDay);
            inputMap.put("lastDay", getLastDay(Integer.parseInt(year), i));

            String income = reportDao.getMonthlyIncome(inputMap);
            if (income == null) {
                monthlyIncome.add("0");
            } else {
                monthlyIncome.add(income);
            }
        }
//        월별 지출
        List<String> monthlySpend = new ArrayList<>();
        for (int i=1; i<=12; i++){
            Map<String, Object> inputMap = new HashMap<>();
            inputMap.put("groupNo", groupNo);
            String startDay = year + "/" + i + "/01";
            inputMap.put("startDay", startDay);
            inputMap.put("lastDay", getLastDay(Integer.parseInt(year), i));

            String spend = reportDao.getMonthlySpend(inputMap);
            if (spend == null) {
                monthlySpend.add("0");
            } else {
                monthlySpend.add(spend);
            }
        }

//        싸서 보내기
//        System.out.println(annualSum.toString());
//        System.out.println(outputList.toString());
        System.out.println(monthlyIncome.toString());
        System.out.println(monthlySpend.toString());
        outputMap.put("monthlyIncome",monthlyIncome);
        outputMap.put("monthlySpend",monthlySpend);
        outputMap.put("annualSum", annualSum);
        outputMap.put("outputList", outputList);
        return outputMap;
    }


    public boolean tmpIsNull(List<ReportVo> tmp) {
        int count = 0;
        for (ReportVo nullCheck : tmp) {
            int monthNo = nullCheck.getMonthNo();
            if (monthNo == 0) {
                count++;
            }
        }
        if (count == 12) {
            return false;
        } else {
            return true;
        }
    }

    public String getLastDay(int year, int month) {//마지막날 구하는 함수
        int day = 1;

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Calendar calendar = Calendar.getInstance();

        calendar.set(year, month - 1, day);
        int lastDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

        String lastDate = String.valueOf(year) + "/" + String.valueOf(month) + "/" + String.valueOf(lastDay);
        System.out.println("만들어진 마지막 날짜 : " + lastDate);
        return lastDate;
    }

    public Map<String,Object> monthlyReport(String groupNo, String year, String month) {
        //        월별 지출
        List<String> monthlySpend = new ArrayList<>();
        for (int i=1; i<=12; i++){
            Map<String, Object> inputMap = new HashMap<>();
            inputMap.put("groupNo", groupNo);
            String startDay = year + "/" + i + "/01";
            inputMap.put("startDay", startDay);
            inputMap.put("lastDay", getLastDay(Integer.parseInt(year), i));

            String spend = reportDao.getMonthlySpend(inputMap);
            if (spend == null) {
                monthlySpend.add("0");
            } else {
                monthlySpend.add(spend);
            }
        }
//        해당 월의 태그별 총 지출

        Map<String,Object> outputMap = new HashMap<>();
        outputMap.put("monthlySpend",monthlySpend);
        return outputMap;
    }
}
