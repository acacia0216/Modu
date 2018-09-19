package com.modu.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.modu.service.GroupMainService;
import com.modu.service.ModuGroupService;
import com.modu.vo.AccountbookAddressVo;
import com.modu.vo.ModuGroupVo;
import com.modu.vo.ModuUserVo;
import com.modu.vo.NewsVo;

@Controller
@RequestMapping(value="/groupmain")
public class GroupMainController {

	@Autowired
	private ModuGroupService groupService;
    @Autowired
    private GroupMainService groupMainService;

    @RequestMapping("/{groupNo}")
    public String GroupMain(Model model, HttpSession session,@PathVariable int groupNo){
        System.out.println("모임메인");

        //모임 카테고리
        ModuUserVo userVo =  (ModuUserVo) session.getAttribute("authUser");
        List<ModuGroupVo> gList  = groupService.selectGroup(userVo.getUserNo());
        model.addAttribute("gList",gList);

        //클릭한 모임  메인 보여주기
        ModuGroupVo gvo = groupService.selectGroupImg(groupNo);
        model.addAttribute("gvo",gvo);
        userVo.setGroupNo(gvo.getGroupNo());
        session.setAttribute("authUser",userVo);

        List<NewsVo> newsList = groupMainService.getNewsList(groupNo);
        model.addAttribute("newsList",newsList);

        return "/group/groupMain";
    }

    @RequestMapping("/groupSearch")
	public String Search(@RequestParam("gSearch")String gSearch,Model model,HttpSession session) {
		ModuUserVo uservo =  (ModuUserVo) session.getAttribute("authUser");

		if(uservo != null) {
			List<ModuGroupVo> gList  = groupService.selectGroup(uservo.getUserNo());
			model.addAttribute("gList",gList);
		}

		List<ModuGroupVo> searchList = groupService.searchGroup(gSearch,uservo.getUserNo());
		model.addAttribute("searchList",searchList);

		return"/group/groupSearch";
	}
    
    @ResponseBody
    @RequestMapping("/{groupNo}/searchinfo")
	public AccountbookAddressVo searchinfo(@PathVariable int groupNo) {  
		return groupMainService.searchInfo(groupNo);
	}
}
