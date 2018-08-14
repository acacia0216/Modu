package com.modu.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.buf.UEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.modu.service.MembershipService;
import com.modu.service.ModuGroupService;
import com.modu.vo.MembershipVo;
import com.modu.vo.ModuGroupVo;
import com.modu.vo.ModuUserVo;
import com.modu.vo.UserGroupVo;

@Controller
@RequestMapping(value="/membershipfee/{groupNo}")
public class MembershipController {

	@Autowired
	private ModuGroupService groupService;
	
	@Autowired
	private MembershipService membershipService;

	@RequestMapping("")
	public String membershipFeeStart(HttpSession session, Model model, @PathVariable("groupNo") int groupNo) {
		System.out.println("/회비설정 전 첫화면");

		// 모임 카테고리
		ModuUserVo uservo = (ModuUserVo) session.getAttribute("authUser");
		List<ModuGroupVo> gList = groupService.selectGroup(uservo.getUserNo());
		model.addAttribute("gList", gList);

		// 클릭한 모임 회비설정 보여주기
		ModuGroupVo gvo = groupService.selectGroupImg(groupNo);
		model.addAttribute("gvo", gvo);

		return "/membership/membershipFeeStart";
	}

	@RequestMapping("/membershipsetting")
	public String membershipSetting(HttpSession session, Model model, @PathVariable("groupNo") int groupNo) {
		System.out.println("/회비 설정하기");

		// 모임 카테고리
		ModuUserVo uservo = (ModuUserVo) session.getAttribute("authUser");
		List<ModuGroupVo> gList = groupService.selectGroup(uservo.getUserNo());
		model.addAttribute("gList", gList);

		// 클릭한 모임 회비설정 보여주기
		ModuGroupVo gvo = groupService.selectGroupImg(groupNo);
		model.addAttribute("gvo", gvo);
		
		// 회원명단 보여주기 
		List<UserGroupVo> selectUserList = groupService.selectUserList(uservo.getGroupNo());
		model.addAttribute("selectUserList",selectUserList);
		

		return "/membership/membershipSetting";
	}

	@RequestMapping("/feemanage")
	public String feemanage(HttpSession session, Model model, @PathVariable("groupNo") int groupNo) {
		System.out.println("회비관리페이지");

		// 모임 카테고리
		ModuUserVo uservo = (ModuUserVo) session.getAttribute("authUser");
		List<ModuGroupVo> gList = groupService.selectGroup(uservo.getUserNo());
		model.addAttribute("gList", gList);

		// 클릭한 모임 회비관리 보여주기
		ModuGroupVo gvo = groupService.selectGroupImg(groupNo);
		model.addAttribute("gvo", gvo);
		
		//회비관리 기본정보 보여주기
		ModuGroupVo gMembershipfee = membershipService.selectdefault(groupNo);
		model.addAttribute("gMembershipfee",gMembershipfee);	
		
		// 회원명단 보여주기 
		List<UserGroupVo> selectUserList = groupService.selectUserList(uservo.getGroupNo());
		model.addAttribute("selectUserList",selectUserList);

		return "/membership/feeManage";
	}
	
	@RequestMapping("/setting")
	public String setting(HttpSession session,ModuGroupVo groupvo, UserGroupVo usergroupvo,Model model, @PathVariable("groupNo") int groupNo ) {
		
		 //잘 들어왔는지 확인하자
		 System.out.println(groupvo.toString());
		 System.out.println(usergroupvo.toString());
		 
		// 모임 카테고리
		ModuUserVo uservo = (ModuUserVo) session.getAttribute("authUser");
		List<ModuGroupVo> gList = groupService.selectGroup(uservo.getUserNo());
		model.addAttribute("gList", gList);
		
		// 클릭한 모임 회비관리 보여주기
		ModuGroupVo gvo = groupService.selectGroupImg(groupNo);
		model.addAttribute("gvo", gvo);
		 
		 //입력한 기본정보 보여주기
		 ModuGroupVo gMembershipfee = membershipService.selectMembership(groupvo,usergroupvo);
		 model.addAttribute("gMembershipfee",gMembershipfee);
		 
		 //회원명단, 회비 리스트 
		 List<UserGroupVo> selectUserList = groupService.selectUserList(groupNo);
		 model.addAttribute("selectUserList",selectUserList);
		 
		// List<MembershipVo> membershipList = membershipService.selectMembershipList(groupNo);
	    // model.addAttribute("membershipList",membershipList);
		 
		return "/membership/feeManage";
	}
	
	
	

}
