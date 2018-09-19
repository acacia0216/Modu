package com.modu.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.modu.service.ModuGroupService;
import com.modu.service.PlaceRecommendService;
import com.modu.vo.ModuGroupVo;
import com.modu.vo.ModuUserVo;
import com.modu.vo.PlaceRecommendVo;

@Controller
@RequestMapping(value="/placerecommend/{groupNo}")
public class PlaceRecommendController {
	
	@Autowired
    ModuGroupService groupService;
	@Autowired
    PlaceRecommendService placeRecommendService;

	@RequestMapping("")
	public String PlaceRecommend(@PathVariable int groupNo,HttpSession session, Model model) {
		if(session.getAttribute("authUser") == null) {
			return "/index";
		}else {
			//모임 카테고리
	        ModuUserVo userVo = (ModuUserVo) session.getAttribute("authUser");
	        List<ModuGroupVo> gList = groupService.selectGroup(userVo.getUserNo());
	        model.addAttribute("gList", gList);
	
	        //클릭한 모임  메인 보여주기
	        ModuGroupVo gvo = groupService.selectGroupImg(userVo.getGroupNo());
	        model.addAttribute("gvo", gvo);
	        
			return "/placerecommend/placeRecommend";
		}
	}
	
	@ResponseBody
	@RequestMapping( "/getplacerecommendlist")
	public List<PlaceRecommendVo> getPlaceRecommendList(@PathVariable int groupNo, @RequestParam("mode") String mode,
			@RequestParam("recommendType") String recommendType,@RequestParam("sortCol") String sortCol){
		return placeRecommendService.getRecommendList(groupNo,mode,recommendType,sortCol);
	}
	
}
