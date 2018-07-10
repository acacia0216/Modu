package com.modu.service;

import com.modu.dao.ReportDao;
import com.modu.vo.ModuUserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReportService {
    @Autowired
    ReportDao reportDao;

    public int getRecentEvent(String groupNo) {
        return reportDao.getRecentEvent(groupNo);
    }
}
