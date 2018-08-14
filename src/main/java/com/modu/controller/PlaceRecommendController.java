package com.modu.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.modu.service.ModuGroupService;
import com.modu.vo.ModuGroupVo;
import com.modu.vo.ModuUserVo;

@Controller
public class PlaceRecommendController {
	@Autowired
    ModuGroupService groupService;

	@RequestMapping(value="/placerecommend/{groupNo}",method=RequestMethod.GET)
	public String PlaceRecommend(@PathVariable int groupNo,HttpSession session, Model model) {
		System.out.println("in");
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
