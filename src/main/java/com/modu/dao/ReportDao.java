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

    public ReportVo getMonthlyAnnualList(Map<String,Object> inputMap) {
        System.out.println("연간보고서 긁기");
        return sqlSession.selectOne("report.getMonthlyAnnualList",inputMap);
    }

    public List<Integer> getCategory(int groupNo) {
        return sqlSession.selectList("report.getCategoryList",groupNo);
    }

    public String getCategoryName(Integer cateNo) {
        return sqlSession.selectOne("report.getCategoryName",cateNo);
    }

    public String getAnnualSum(Map<String, Object> inputMap) {
        return sqlSession.selectOne("report.getAnnualSum",inputMap);
    }

    public String getMonthlyIncome(Map<String, Object> inputMap) {
        return sqlSession.selectOne("report.getMonthlyIncome",inputMap);
    }

    public String getMonthlySpend(Map<String, Object> inputMap) {
        return sqlSession.selectOne("report.getMonthlySpend",inputMap);
    }
}
