package com.modu.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modu.dao.PlaceRecommendDao;
import com.modu.vo.PlaceRecommendVo;

@Service
public class PlaceRecommendService {

	@Autowired
    private PlaceRecommendDao placeRecommendDao;
	
	public List<PlaceRecommendVo> getRecommendList(int groupNo,String mode,String recommendType,String sortCol) {
		
		List<PlaceRecommendVo> placeRecommedList = new ArrayList<PlaceRecommendVo>();
		Map<String,Object> recommendData = new HashMap<String,Object>();
		recommendData.put("groupNo", groupNo);
		recommendData.put("recommendType", recommendType);
		recommendData.put("sortCol", sortCol);
		recommendData.put("mode", mode);
		
		placeRecommedList = placeRecommendDao.getRecommendList(recommendData);

		PlaceRecommendVo placeRecommedVo = placeRecommendDao.getBestRecommendInfo(groupNo);
		
		recommendData.put("maxpointx", placeRecommedVo.getMaxpointx());
		recommendData.put("maxpointy", placeRecommedVo.getMaxpointy());
		recommendData.put("avgpersonnel", placeRecommedVo.getAvgpersonnel());
		recommendData.put("avgspend", placeRecommedVo.getAvgspend());
		System.out.println(recommendData);
		 
		placeRecommedList.add(placeRecommendDao.getBestRecommend(recommendData));
		
        return placeRecommedList;
    }

}
