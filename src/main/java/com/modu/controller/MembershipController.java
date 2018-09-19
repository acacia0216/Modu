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

import com.modu.service.MembershipService;
import com.modu.service.ModuGroupService;
import com.modu.vo.MembershipVo;
import com.modu.vo.ModuGroupVo;
import com.modu.vo.ModuUserVo;

@Controller
@RequestMapping(value="/membershipfee/{groupNo}")
public class MembershipController {

	@Autowired
	private ModuGroupService groupService;
	
	@Autowired
	private MembershipService membershipService;

	@RequestMapping("/feemanage")
	public String feemanage(HttpSession session, Model model, @PathVariable("groupNo") int groupNo) {
		if(session.getAttribute("authUser") == null) {
			return "/index";
		}else {
			System.out.println("회비관리페이지");
			String url = "/membership/membershipFeeStart";
			List<MembershipVo> membershipList = membershipService.getMemberfeeCardList(groupNo);
			if(!membershipList.isEmpty()) {
				url="/membership/feeManage";
			}
	
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

			return url;
		}
	}
	
	//계좌설정 고정 
	@ResponseBody
	@RequestMapping("/accountSettting")
	public ModuGroupVo accountSettting(@PathVariable("groupNo")int groupNo, ModuGroupVo groupvo ) {
		
		groupvo.setGroupNo(groupNo);
		ModuGroupVo accountGvo = membershipService.accountSettting(groupvo);
		return accountGvo;
	}
	
	@ResponseBody
	@RequestMapping("/getmemberfeelist")
	public List<MembershipVo> getMemberfeeList(@PathVariable("groupNo") int groupNo, @RequestParam("feeGroupName") String feeGroupName) {	 
		return membershipService.getMemberfeeList(groupNo,feeGroupName);
	}
	
	@ResponseBody
	@RequestMapping("/getmemberfeecardlist")
	public List<MembershipVo> getMemberfeeCardList(@PathVariable("groupNo") int groupNo) {	 
		return membershipService.getMemberfeeCardList(groupNo);
	}
	
	@ResponseBody
	@RequestMapping("/getinsertmemberfeelist")
	public List<MembershipVo> getInsertMemberfeeList(@PathVariable("groupNo") int groupNo, @RequestParam("mode") String mode) {	 
		return membershipService.getInsertMemberfeeList(groupNo,mode);
	}
	
	@ResponseBody
	@RequestMapping("/insertmemberfee")
	public String insertMemberfee(@PathVariable("groupNo") int groupNo, @RequestParam("data") String data, @RequestParam("feeGroupName") String feeGroupName,
			@RequestParam("mode") String mode,@RequestParam("paymentDate") String paymentDate) {
		return membershipService.insertMemberfee(feeGroupName,data,groupNo,mode,paymentDate);
	}
	
	@ResponseBody
	@RequestMapping("/deletememberfee")
	public void deleteMemberfee(@PathVariable("groupNo") int groupNo, @RequestParam("feeGroupName") String feeGroupName) {
		membershipService.deleteMemberfee(groupNo,feeGroupName);
	}

	@ResponseBody
	@RequestMapping("/rcvmemberfee")
	public void rcvMemberfee(@PathVariable("groupNo") int groupNo, @RequestParam("paymentFee") String paymentFee, @RequestParam("memberfeeNo") String memberfeeNo) {
		membershipService.rcvMemberfee(groupNo,paymentFee,memberfeeNo);
	}
	
}
