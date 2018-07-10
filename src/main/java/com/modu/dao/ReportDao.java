package com.modu.dao;

import com.modu.vo.ModuUserVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReportDao {
    @Autowired
    SqlSession sqlSession;

    public int getRecentEvent(String groupNo) {
        return sqlSession.selectOne("report.getRecentEvent",groupNo);
    }
}
