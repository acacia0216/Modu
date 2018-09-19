package com.modu.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.modu.vo.PlaceRecommendVo;

@Repository
public class PlaceRecommendDao {

	@Autowired
	private SqlSession sqlSession;
	
	public List<PlaceRecommendVo> getRecommendList(Map<String,Object> recommendData) {
        return sqlSession.selectList("placeRecommend.getRecommendList",recommendData);
    }
	
	public PlaceRecommendVo getBestRecommendList(Map<String,Object> recommendData) {
        return sqlSession.selectOne("placeRecommend.getBestRecommendList",recommendData);
    }	
	
	public PlaceRecommendVo getBestRecommendInfo(int groupNo) {
        return sqlSession.selectOne("placeRecommend.getBestRecommendInfo",groupNo);
    }
	
	public PlaceRecommendVo getBestRecommend(Map<String,Object> recommendData) {
        return sqlSession.selectOne("placeRecommend.getBestRecommend",recommendData);
    }	
}
