package com.modu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modu.dao.GroupMainDao;
import com.modu.vo.AccountbookAddressVo;
import com.modu.vo.NewsVo;

@Service
public class GroupMainService {

    @Autowired
    private GroupMainDao groupMainDao;

    public List<NewsVo> getNewsList(int groupNo) {
        return groupMainDao.getNewsList(groupNo);
    }
    
    public AccountbookAddressVo searchInfo(int groupNo) {
    	System.out.println("!!" + groupNo);
        return groupMainDao.searchInfo(groupNo);
    }
}
