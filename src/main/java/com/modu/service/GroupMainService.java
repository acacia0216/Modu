package com.modu.service;

import com.modu.dao.GroupMainDao;
import com.modu.vo.GroupMainVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class GroupMainService {

    @Autowired
    private GroupMainDao groupMainDao;

    public Map<String, Object> getGroupMain(int groupNo) {
        Map<String,Object> inputMap = new HashMap<>();
        inputMap.put("groupNo",groupNo);
        Calendar calendar = Calendar.getInstance();//달력 객체 생성
        Date today = new Date();//Date객체생성
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd");//포맷 생성
        String todate = simpleDateFormat.format(today);
        String splitDate[] = todate.split("/");//현재 날짜 스플릿
        calendar.set(Integer.parseInt(splitDate[0]),Integer.parseInt(splitDate[1])-1,Integer.parseInt(splitDate[2]));//년,월-1,일
        calendar.add(Calendar.DATE,+1);
        Date lastDay = calendar.getTime();//담기
        inputMap.put("lastDay",simpleDateFormat.format(lastDay));
        calendar.set(Integer.parseInt(splitDate[0]),Integer.parseInt(splitDate[1])-1,Integer.parseInt(splitDate[2]));//년,월-1,일
        calendar.add(Calendar.DATE,-5);//계산될 날짜(-5일)
        Date dayago = calendar.getTime();//담기
        inputMap.put("startDay",simpleDateFormat.format(dayago));

        List<GroupMainVo> newsList = groupMainDao.getNews(inputMap);
        System.out.println("뭐라고나오길래...."+newsList.toString());
        Map<String,Object> outputMap = new HashMap<>();
        outputMap.put("newsList",newsList);
        return outputMap;
    }
}
