package com.modu.dao;

import com.modu.vo.ReportVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ReportDao {
    @Autowired
    SqlSession sqlSession;

    public int getRecentEvent(String groupNo) {
        return sqlSession.selectOne("report.getRecentEvent",groupNo);
    }

    public List<ReportVo> getMonthlyAnnualList(Map<String,Object> inputMap) {
        System.out.println("연간보고서 긁기");
        return sqlSession.selectList("report.getMonthlyAnnualList",inputMap);
    }

    public List<ReportVo> getCategory(int groupNo) {
        return sqlSession.selectList("report.getCategoryList",groupNo);
    }
}
