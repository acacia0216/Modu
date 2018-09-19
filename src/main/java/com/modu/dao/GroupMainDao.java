package com.modu.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.modu.vo.AccountbookAddressVo;
import com.modu.vo.NewsVo;

@Repository
public class GroupMainDao {

    @Autowired
    private SqlSession sqlSession;

    public List<NewsVo> getNewsList(int groupNo) {
        return sqlSession.selectList("groupMain.getNewsList",groupNo);
    }
    
    public AccountbookAddressVo searchInfo(int groupNo) {
        return sqlSession.selectOne("groupMain.searchInfo",groupNo);
    }
}
